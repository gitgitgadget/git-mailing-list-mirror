Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E51231FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 20:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbdBHU7p (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 15:59:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:51780 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbdBHU7n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 15:59:43 -0500
Received: (qmail 28389 invoked by uid 109); 8 Feb 2017 20:53:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 20:53:02 +0000
Received: (qmail 6189 invoked by uid 111); 8 Feb 2017 20:53:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 15:53:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2017 15:53:00 -0500
Date:   Wed, 8 Feb 2017 15:53:00 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/11] for_each_alternate_ref: replace transport code with
 for-each-ref
Message-ID: <20170208205300.fnikvvntmculxfqy@sigill.intra.peff.net>
References: <20170208205219.twgm5rggovqbepte@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170208205219.twgm5rggovqbepte@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current method for getting the refs from an alternate is
to run upload-pack in the alternate and parse its output
using the normal transport code.  This works and is
reasonably short, but it has a very bad memory footprint
when there are a lot of refs in the alternate. There are two
problems:

  1. It reads in all of the refs before passing any back to
     us. Which means that our peak memory usage has to store
     every ref (including duplicates for peeled variants),
     even if our callback could determine that some are not
     interesting (e.g., because they point to the same sha1
     as another ref).

  2. It allocates a "struct ref" for each one. Among other
     things, this contains 3 separate 20-byte oids, along
     with the name and various pointers.  That can add up,
     especially if the callback is only interested in the
     sha1 (which it can store in a sha1_array as just 20
     bytes).

On a particularly pathological case, where the alternate had
over 80 million refs pointing to only around 60,000 unique
objects, the peak heap usage of "git clone --reference" grew
to over 25GB.

This patch instead calls git-for-each-ref in the alternate
repository, and passes each line to the callback as we read
it. That drops the peak heap of the same command to 50MB.

I considered and rejected a few alternatives.

We could read all of the refs in the alternate using our own
ref code, just as we do with submodules.  However, as memory
footprint is one of the concerns here, we want to avoid
loading those refs into our own memory as a whole.

It's possible that this will be a better technique in the
future when the ref code can more easily iterate without
loading all of packed-refs into memory.

Another option is to keep calling upload-pack, and just
parse its output ourselves in a streaming fashion. Besides
for-each-ref being simpler (we get to define the format
ourselves, and don't have to deal with speaking the git
protocol), it's more flexible for possible future changes.

For instance, it might be useful for the caller to be able
to limit the set of "interesting" alternate refs.  The
motivating example is one where many "forks" of a particular
repository share object storage, and the shared storage has
refs for each fork (which is why so many of the refs are
duplicates; each fork has the same tags).  A plausible
future optimization would be to ask for the alternate refs
for just _one_ fork (if you had some out-of-band way of
knowing which was the most interesting or important for the
current operation).

Similarly, no callbacks actually care about the symref value
of alternate refs, and as before, this patch ignores them
entirely.  However, if we wanted to add them, for-each-ref's
"%(symref)" is going to be more flexible than upload-pack,
because the latter only handles the HEAD symref due to
historical constraints.

There is one potential downside, though: unlike upload-pack,
our for-each-ref command doesn't report the peeled value of
refs. The existing code calls the alternate_ref_fn callback
twice for tags: once for the tag, and once for the peeled
value with the refname set to "ref^{}".

For the callers in fetch-pack, this doesn't matter at all.
We immediately peel each tag down to a commit either way (so
there's a slight improvement, as do not bother passing the
redundant data over the pipe). For the caller in
receive-pack, it means we will not advertise the peeled
values of tags in our alternate. However, we also don't
advertise peeled values for our _own_ tags, so this is
actually making things more consistent.

It's unclear whether receive-pack advertising peeled values
is a win or not. On one hand, giving more information to the
other side may let it omit some objects from the push. On
the other hand, for tags which both sides have, they simply
bloat the advertisement. The upload-pack advertisement of
git.git is about 30% larger than the receive-pack
advertisement due to its peeled information.

This patch omits the peeled information from
for_each_alternate_ref entirely, and leaves it up to the
caller whether they want to dig up the information.

Signed-off-by: Jeff King <peff@peff.net>
---
 transport.c | 48 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/transport.c b/transport.c
index c87147046..48864b3a9 100644
--- a/transport.c
+++ b/transport.c
@@ -1206,6 +1206,42 @@ char *transport_anonymize_url(const char *url)
 	return xstrdup(url);
 }
 
+static void read_alternate_refs(const char *path,
+				alternate_ref_fn *cb,
+				void *data)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct strbuf line = STRBUF_INIT;
+	FILE *fh;
+
+	cmd.git_cmd = 1;
+	argv_array_pushf(&cmd.args, "--git-dir=%s", path);
+	argv_array_push(&cmd.args, "for-each-ref");
+	argv_array_push(&cmd.args, "--format=%(objectname) %(refname)");
+	cmd.env = local_repo_env;
+	cmd.out = -1;
+
+	if (start_command(&cmd))
+		return;
+
+	fh = xfdopen(cmd.out, "r");
+	while (strbuf_getline_lf(&line, fh) != EOF) {
+		struct object_id oid;
+
+		if (get_oid_hex(line.buf, &oid) ||
+		    line.buf[GIT_SHA1_HEXSZ] != ' ') {
+			warning("invalid line while parsing alternate refs: %s",
+				line.buf);
+			break;
+		}
+
+		cb(line.buf + GIT_SHA1_HEXSZ + 1, &oid, data);
+	}
+
+	fclose(fh);
+	finish_command(&cmd);
+}
+
 struct alternate_refs_data {
 	alternate_ref_fn *fn;
 	void *data;
@@ -1216,9 +1252,6 @@ static int refs_from_alternate_cb(struct alternate_object_database *e,
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t base_len;
-	struct remote *remote;
-	struct transport *transport;
-	const struct ref *extra;
 	struct alternate_refs_data *cb = data;
 
 	if (!strbuf_realpath(&path, e->path, 0))
@@ -1233,13 +1266,8 @@ static int refs_from_alternate_cb(struct alternate_object_database *e,
 		goto out;
 	strbuf_setlen(&path, base_len);
 
-	remote = remote_get(path.buf);
-	transport = transport_get(remote, path.buf);
-	for (extra = transport_get_remote_refs(transport);
-	     extra;
-	     extra = extra->next)
-		cb->fn(extra->name, &extra->old_oid, cb->data);
-	transport_disconnect(transport);
+	read_alternate_refs(path.buf, cb->fn, cb->data);
+
 out:
 	strbuf_release(&path);
 	return 0;
-- 
2.12.0.rc0.371.ga6cf8653b

