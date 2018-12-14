Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E45AD20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 09:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbeLNJzP (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 04:55:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:41848 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726494AbeLNJzP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 04:55:15 -0500
Received: (qmail 25234 invoked by uid 109); 14 Dec 2018 09:55:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Dec 2018 09:55:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2279 invoked by uid 111); 14 Dec 2018 09:54:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 14 Dec 2018 04:54:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Dec 2018 04:55:12 -0500
Date:   Fri, 14 Dec 2018 04:55:12 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 1/3] serve: pass "config context" through to individual
 commands
Message-ID: <20181214095512.GA13465@sigill.intra.peff.net>
References: <20181211104236.GA6899@sigill.intra.peff.net>
 <20181211104342.GA7233@sigill.intra.peff.net>
 <20181214083621.GA7121@google.com>
 <20181214085507.GD11777@sigill.intra.peff.net>
 <20181214092820.GB7121@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181214092820.GB7121@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 14, 2018 at 01:28:20AM -0800, Jonathan Nieder wrote:

> > Certainly if that information was carried from the client request it
> > would work fine, and ls-refs would have enough to know which config to
> > respect. But I could not find any documentation on this, nor discussion
> > of plans for a v2 push.
> 
> Interesting.  The last discussion of push v2 plans was in
> https://public-inbox.org/git/20180717210915.139521-1-bmwill@google.com/.
> Expect to hear more soon.

The words "ls-refs" and "advertisement" are notably absent from that
thread. ;)

> > I'm conceptually OK with that, but if that is the plan for going
> > forward, it was not at all obvious to me (and it does feel rather
> > implicit).
> 
> Don't get me wrong: I haven't wrapped my head around config context
> and how it fits into the broader picture yet, but it may be a very
> good thing to have.  So please consider this comment to be about the
> commit message only.

If we're OK with accepting that the client will pass along the
fetch/push context for each individual command, then I don't think we
would ever need this. It is literally about relaying the fact of "the
original request was via upload-pack". If the commands already know the
context the client is interested in from another method, then I don't
think they should ever need to care about that fact.

> Based on the motivation you're describing here, I think treating it as
> uploadpack and adding a NEEDSWORK comment would be a good way forward.
> If we're moving toward a world with more protocol commands that don't
> fit in the upload-pack / receive-pack categories, then we need to
> figure out in more detail what that world looks like:
> 
> - do we keep on adding new endpoints, in the same spirit as
>   upload-archive?  If so, what endpoint should a client use to get
>   capabilities before it decides which endpoint to use?
> 
> - do we merge everything in "git serve" except where a specific
>   endpoint is needed for protocol v0 compatibility?  That would lose
>   the ability to distinguish fetches from pushes without looking at
>   the body of requests (which is useful to some people for monitoring,
>   blocking, etc) --- do we consider that to be an acceptable loss?
> 
> - once we've decided what the future should look like, how does the
>   transition to that future look?

I agree those are all interesting open questions. I didn't want to solve
any of them now, but just fix this (IMHO pretty serious) regression. I
was mostly trying to do so without making any assumptions about where
we'd go in the future (and even NEEDSWORK feels a little funny; it's not
clear to me whether that work is going to be needed or not).

> > Without this information, in patch 3 ls-refs cannot know to look at
> > uploadpack.hiderefs, unless it makes the implicit assumption that it is
> > always serving a fetch.
> 
> I think that's a reasonable assumption to make, especially if made
> explicit using a simple comment. :)

The big danger is that somebody does implement a "push" command and
forgets to touch ls-refs. That would be wrong and buggy for more reasons
than this (as you noted earlier, it should handle .have refs somehow).
But what worries me is that the failure mode for the bug is to start
exposing refs which are meant to be hidden. Which to me is a little more
serious than "the new functionality doesn't work".

So I guess I considered it to mostly be defensive (and I'd be fine if it
was later ripped out when a more elegant approach becomes obvious).

That said, I'm not totally opposed to the implicit thing if that's where
we all think the protocol code should be headed. The patch is certainly
smaller. The whole series could be replaced with this:

-- >8 --
Subject: [PATCH] upload-pack: support hidden refs with protocol v2

In the v2 protocol, upload-pack's advertisement has been moved to the
"ls-refs" command. That command does not respect hidden-ref config (like
transfer.hiderefs) at all, and advertises everything.

While there are some features that are not supported in v2 (e.g., v2
always allows fetching any sha1 without respect to advertisements), the
lack of this feature is not documented and is likely just a bug. Let's
make it work, as otherwise upgrading a server to a v2-capable git will
start exposing these refs that the repository admin has asked to remain
hidden.

Note that we assume we're operating on behalf of a fetch here, since
that's the only thing implemented in v2 at this point. See the in-code
comment.

Signed-off-by: Jeff King <peff@peff.net>
---
 ls-refs.c            | 16 ++++++++++++++++
 t/t5512-ls-remote.sh |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/ls-refs.c b/ls-refs.c
index a06f12eca8..9c9a7c647f 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -5,6 +5,7 @@
 #include "argv-array.h"
 #include "ls-refs.h"
 #include "pkt-line.h"
+#include "config.h"
 
 /*
  * Check if one of the prefixes is a prefix of the ref.
@@ -40,6 +41,9 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	const char *refname_nons = strip_namespace(refname);
 	struct strbuf refline = STRBUF_INIT;
 
+	if (ref_is_hidden(refname_nons, refname))
+		return 0;
+
 	if (!ref_match(&data->prefixes, refname))
 		return 0;
 
@@ -69,6 +73,16 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
+static int ls_refs_config(const char *var, const char *value, void *data)
+{
+	/*
+	 * We only serve fetches over v2 for now, so respect only "uploadpack"
+	 * config. This may need to eventually be expanded to "receive", but we
+	 * don't yet know how that information will be passed to ls-refs.
+	 */
+	return parse_hide_refs_config(var, value, "uploadpack");
+}
+
 int ls_refs(struct repository *r, struct argv_array *keys,
 	    struct packet_reader *request)
 {
@@ -76,6 +90,8 @@ int ls_refs(struct repository *r, struct argv_array *keys,
 
 	memset(&data, 0, sizeof(data));
 
+	git_config(ls_refs_config, NULL);
+
 	while (packet_reader_read(request) != PACKET_READ_FLUSH) {
 		const char *arg = request->line;
 		const char *out;
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 32e722db2e..ca69636fd5 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -204,6 +204,12 @@ test_expect_success 'overrides work between mixed transfer/upload-pack hideRefs'
 	grep refs/tags/magic actual
 '
 
+test_expect_success 'protocol v2 supports hiderefs' '
+	test_config uploadpack.hiderefs refs/tags &&
+	git -c protocol.version=2 ls-remote . >actual &&
+	! grep refs/tags actual
+'
+
 test_expect_success 'ls-remote --symref' '
 	git fetch origin &&
 	cat >expect <<-EOF &&
-- 
2.20.0.738.gdb22cab611

