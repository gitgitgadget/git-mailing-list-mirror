Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97E141FBB0
	for <e@80x24.org>; Mon, 24 Oct 2016 13:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965153AbcJXN3h (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 09:29:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:33418 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965100AbcJXN3g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 09:29:36 -0400
Received: (qmail 6355 invoked by uid 109); 24 Oct 2016 13:29:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Oct 2016 13:29:35 +0000
Received: (qmail 24096 invoked by uid 111); 24 Oct 2016 13:29:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Oct 2016 09:29:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Oct 2016 09:29:33 -0400
Date:   Mon, 24 Oct 2016 09:29:33 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [RFH] limiting ref advertisements
Message-ID: <20161024132932.i42rqn2vlpocqmkq@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm looking into the oft-discussed idea of reducing the size of ref
advertisements by having the client say "these are the refs I'm
interested in". Let's set aside the protocol complexities for a
moment and imagine we magically have some way to communicate a set of
patterns to the server.

What should those patterns look like?

I had hoped that we could keep most of the pattern logic on the
client-side. Otherwise we risk incompatibilities between how the client
and server interpret a pattern. I had also hoped we could do some kind
of prefix-matching, which would let the server look only at the
interesting bits of the ref tree (so if you don't care about
refs/changes, and the server has some ref storage that is hierarchical,
they can literally get away without opening that sub-tree).

The patch at the end of this email is what I came up with in that
direction. It obviously won't compile without the twenty other patches
implementing transport->advertise_prefixes, but it gives you a sense of
what I'm talking about.

Unfortunately it doesn't work in all cases, because refspec sources may
be unqualified. If I ask for:

  git fetch $remote master:foo

then we have to actually dwim-resolve "master" from the complete list of
refs we get from the remote.  It could be "refs/heads/master",
"refs/tags/master", etc. Worse, it could be "refs/master". In that case,
at least, I think we are OK because we avoid advertising refs directly
below "refs/" in the first place. But if you have a slash, like:

  git fetch $remote jk/foo

then that _could_ be "refs/jk/foo". Likewise, we cannot even optimize
the common case of a fully-qualified ref, like "refs/heads/foo". If it
exists, we obviously want to use that. But if it doesn't, then it
could be refs/something-else/refs/heads/foo. That's unlikely, but it
_does_ work now, and optimizing the advertisement would break it.

So it seems like left-anchoring the refspecs can never be fully correct.
We can communicate "master" to the server, who can then look at every
ref it would advertise and ask "could this be called master"? But it
will be setting in stone the set of "could this be" patterns. Granted,
those haven't changed much over the history of git, but it seems awfully
fragile.

In an ideal world the client and server would negotiate to come to some
agreement on the patterns being used. But as we are bolting this onto
the existing protocol, I was really trying to do it without introducing
an extra capabilities phase or extra round-trips. I.e., something like
David Turner's "stick the refspec in the HTTP query parameters" trick,
but working everywhere[1].

Clever ideas?

-Peff

[1] I do have working patches to pass these "early capabilities"
    everywhere, but they're still somewhat rough. I got it to the point
    where I could flip the default to "on" to see what breaks. That's
    not something we'd want to do for real, but is good for running the
    test suite to uncover issues like this one.

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7c10d70092..3a2585ffd7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -302,6 +302,33 @@ static void find_non_local_tags(struct transport *transport,
 	string_list_clear(&remote_refs, 0);
 }
 
+static void add_advertise_prefixes(struct transport *transport,
+				   const struct refspec *refs, int nr)
+{
+	struct argv_array *list = &transport->advertise_prefixes;
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		const struct refspec *rs = &refs[i];
+		size_t len;
+
+		if (!rs->pattern)
+			argv_array_push(list, rs->src);
+		else if (strip_suffix(rs->src, "/*", &len))
+			argv_array_pushf(list, "%.*s", (int)len, rs->src);
+		else {
+			/*
+			 * This refspec is too complex for us to communicate;
+			 * not only do we skip it, but we must avoid
+			 * communicating any prefixes, since we need to see
+			 * all refs.
+			 */
+			transport->ignore_advertise_prefixes = 1;
+			return;
+		}
+	}
+}
+
 static struct ref *get_ref_map(struct transport *transport,
 			       struct refspec *refspecs, int refspec_count,
 			       int tags, int *autotags)
@@ -314,12 +341,18 @@ static struct ref *get_ref_map(struct transport *transport,
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
 
-	const struct ref *remote_refs = transport_get_remote_refs(transport);
+	const struct ref *remote_refs;
+
+	if (tags == TAGS_SET || (tags == TAGS_DEFAULT && *autotags))
+		add_advertise_prefixes(transport, tag_refspec, 1);
 
 	if (refspec_count) {
 		struct refspec *fetch_refspec;
 		int fetch_refspec_nr;
 
+		add_advertise_prefixes(transport, refspecs, refspec_count);
+		remote_refs = transport_get_remote_refs(transport);
+
 		for (i = 0; i < refspec_count; i++) {
 			get_fetch_map(remote_refs, &refspecs[i], &tail, 0);
 			if (refspecs[i].dst && refspecs[i].dst[0])
@@ -373,6 +406,17 @@ static struct ref *get_ref_map(struct transport *transport,
 		    (remote->fetch_refspec_nr ||
 		     /* Note: has_merge implies non-NULL branch->remote_name */
 		     (has_merge && !strcmp(branch->remote_name, remote->name)))) {
+
+			add_advertise_prefixes(transport, remote->fetch,
+					       remote->fetch_refspec_nr);
+			if (has_merge && !strcmp(branch->remote_name, remote->name)) {
+				int i;
+				for (i = 0; i < branch->merge_nr; i++)
+					add_advertise_prefixes(transport, branch->merge[i], 1);
+			}
+
+			remote_refs = transport_get_remote_refs(transport);
+
 			for (i = 0; i < remote->fetch_refspec_nr; i++) {
 				get_fetch_map(remote_refs, &remote->fetch[i], &tail, 0);
 				if (remote->fetch[i].dst &&
@@ -393,6 +437,8 @@ static struct ref *get_ref_map(struct transport *transport,
 			    !strcmp(branch->remote_name, remote->name))
 				add_merge_config(&ref_map, remote_refs, branch, &tail);
 		} else {
+			argv_array_push(&transport->advertise_prefixes, "HEAD");
+			remote_refs = transport_get_remote_refs(transport);
 			ref_map = get_remote_ref(remote_refs, "HEAD");
 			if (!ref_map)
 				die(_("Couldn't find remote ref HEAD"));
