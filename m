Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 378091FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 04:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750883AbdJFEyo (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 00:54:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:34760 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750781AbdJFEyn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 00:54:43 -0400
Received: (qmail 7862 invoked by uid 109); 6 Oct 2017 04:54:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 04:54:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2633 invoked by uid 111); 6 Oct 2017 04:54:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 00:54:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Oct 2017 00:54:40 -0400
Date:   Fri, 6 Oct 2017 00:54:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        t.gummerer@gmail.com, jrnieder@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1 1/2] entry.c: update cache entry only for existing
 files
Message-ID: <20171006045440.2imc2c7hvu5d3hdk@sigill.intra.peff.net>
References: <20171005104407.65948-1-lars.schneider@autodesk.com>
 <20171005104407.65948-2-lars.schneider@autodesk.com>
 <xmqqk2097sge.fsf@gitster.mtv.corp.google.com>
 <20171005112658.p7hohhtkdkcapwe6@sigill.intra.peff.net>
 <xmqqefqh6vxf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqefqh6vxf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 06, 2017 at 08:01:48AM +0900, Junio C Hamano wrote:

> > But
> > I think we'd want to protect the read_blob_entry() call at the top of
> > the case with a check for dco->state == CE_RETRY.
> 
> Yeah, I think that makes more sense.
> 
> A patch may look like this on top of these two patches, but I'd
> prefer to see Lars's eyeballing and possibly wrapping it up in an
> applicable patch after taking the authorship.

Yeah, agreed.

> I considered initializing new to NULL and size to 0 but decided
> against it, as that would lose the justification to have an if
> statement that marks that "dco->state == CE_RETRY" is a special
> case.  I think explicit if() with clearing these two variables makes
> it clearer to show what is going on.

Also agreed.

> By the way, the S_IFLNK handling seems iffy with or without this
> change (or for that matter, I suspect this iffy-ness existed before
> Lars's delayed filtering change).  On a platform without symlinks,
> we do the same as S_IFREG, but obviously we do not want any content
> conversion that happens to the regular files in such a case.  So we
> may further want to fix that, but I left it outside the scope of
> fixing the leak of NULL and optimizing the blob reading out.

I think the current code is correct because the conversion all happens
in the S_IFREG if-block. We just fall-through down to the actual write
phase for the symlink case.

That said, I found the fall-through here confusing as hell. I actually
think it would be a lot clearer with a goto, which is saying something.
Here's the "diff -w" of what I mean, for readability (the real patch is
at the bottom for reference, but it adjusts the indentation quite a
bit).

diff --git a/entry.c b/entry.c
index 1c7e3c11d5..d28b42d82d 100644
--- a/entry.c
+++ b/entry.c
@@ -261,6 +261,7 @@ static int write_entry(struct cache_entry *ce,
 	size_t newsize = 0;
 	struct stat st;
 	const struct submodule *sub;
+	struct delayed_checkout *dco = state->delayed_checkout;
 
 	if (ce_mode_s_ifmt == S_IFREG) {
 		struct stream_filter *filter = get_stream_filter(ce->name,
@@ -273,33 +274,39 @@ static int write_entry(struct cache_entry *ce,
 	}
 
 	switch (ce_mode_s_ifmt) {
-	case S_IFREG:
 	case S_IFLNK:
 		new = read_blob_entry(ce, &size);
 		if (!new)
 			return error("unable to read sha1 file of %s (%s)",
 				path, oid_to_hex(&ce->oid));
 
-		if (ce_mode_s_ifmt == S_IFLNK && has_symlinks && !to_tempfile) {
+		/* fallback to handling it like a regular file if we must */
+		if (!has_symlinks || to_tempfile)
+			goto write_out_file;
+
 		ret = symlink(new, path);
 		free(new);
 		if (ret)
 			return error_errno("unable to create symlink %s",
 					   path);
 		break;
-		}
 
+	case S_IFREG:
 		/*
 		 * Convert from git internal format to working tree format
 		 */
-		if (ce_mode_s_ifmt == S_IFREG) {
-			struct delayed_checkout *dco = state->delayed_checkout;
-			if (dco && dco->state != CE_NO_DELAY) {
-				/* Do not send the blob in case of a retry. */
-				if (dco->state == CE_RETRY) {
+
+		if (dco && dco->state == CE_RETRY) {
 			new = NULL;
 			size = 0;
+		} else {
+			new = read_blob_entry(ce, &size);
+			if (!new)
+				return error ("unable to read sha1 file of %s (%s)",
+					      path, oid_to_hex(&ce->oid));
 		}
+
+		if (dco && dco->state != CE_NO_DELAY) {
 			ret = async_convert_to_working_tree(
 							    ce->name, new, size, &buf, dco);
 			if (ret && string_list_has_string(&dco->paths, ce->name)) {
@@ -320,8 +327,8 @@ static int write_entry(struct cache_entry *ce,
 		 * point. If the error would have been fatal (e.g.
 		 * filter is required), then we would have died already.
 		 */
-		}
 
+write_out_file:
 		fd = open_output_fd(path, ce, to_tempfile);
 		if (fd < 0) {
 			free(new);

The "structured" way, of course, would be to put everything under
write_out_file into a helper function and just call it from both places
rather than relying on a spaghetti of gotos and switch-breaks.

I'm OK with whatever structure we end up with, as long as it fixes the
leak (and ideally the pessimization).

Anyway, here's the real patch in case anybody wants to apply it and play
with it further.

-- >8 --
diff --git a/entry.c b/entry.c
index 1c7e3c11d5..d28b42d82d 100644
--- a/entry.c
+++ b/entry.c
@@ -261,6 +261,7 @@ static int write_entry(struct cache_entry *ce,
 	size_t newsize = 0;
 	struct stat st;
 	const struct submodule *sub;
+	struct delayed_checkout *dco = state->delayed_checkout;
 
 	if (ce_mode_s_ifmt == S_IFREG) {
 		struct stream_filter *filter = get_stream_filter(ce->name,
@@ -273,55 +274,61 @@ static int write_entry(struct cache_entry *ce,
 	}
 
 	switch (ce_mode_s_ifmt) {
-	case S_IFREG:
 	case S_IFLNK:
 		new = read_blob_entry(ce, &size);
 		if (!new)
 			return error("unable to read sha1 file of %s (%s)",
 				path, oid_to_hex(&ce->oid));
 
-		if (ce_mode_s_ifmt == S_IFLNK && has_symlinks && !to_tempfile) {
-			ret = symlink(new, path);
-			free(new);
-			if (ret)
-				return error_errno("unable to create symlink %s",
-						   path);
-			break;
-		}
+		/* fallback to handling it like a regular file if we must */
+		if (!has_symlinks || to_tempfile)
+			goto write_out_file;
 
+		ret = symlink(new, path);
+		free(new);
+		if (ret)
+			return error_errno("unable to create symlink %s",
+					   path);
+		break;
+
+	case S_IFREG:
 		/*
 		 * Convert from git internal format to working tree format
 		 */
-		if (ce_mode_s_ifmt == S_IFREG) {
-			struct delayed_checkout *dco = state->delayed_checkout;
-			if (dco && dco->state != CE_NO_DELAY) {
-				/* Do not send the blob in case of a retry. */
-				if (dco->state == CE_RETRY) {
-					new = NULL;
-					size = 0;
-				}
-				ret = async_convert_to_working_tree(
-					ce->name, new, size, &buf, dco);
-				if (ret && string_list_has_string(&dco->paths, ce->name)) {
-					free(new);
-					goto finish;
-				}
-			} else
-				ret = convert_to_working_tree(
-					ce->name, new, size, &buf);
 
-			if (ret) {
+		if (dco && dco->state == CE_RETRY) {
+			new = NULL;
+			size = 0;
+		} else {
+			new = read_blob_entry(ce, &size);
+			if (!new)
+				return error ("unable to read sha1 file of %s (%s)",
+					      path, oid_to_hex(&ce->oid));
+		}
+
+		if (dco && dco->state != CE_NO_DELAY) {
+			ret = async_convert_to_working_tree(
+							    ce->name, new, size, &buf, dco);
+			if (ret && string_list_has_string(&dco->paths, ce->name)) {
 				free(new);
-				new = strbuf_detach(&buf, &newsize);
-				size = newsize;
+				goto finish;
 			}
-			/*
-			 * No "else" here as errors from convert are OK at this
-			 * point. If the error would have been fatal (e.g.
-			 * filter is required), then we would have died already.
-			 */
+		} else
+			ret = convert_to_working_tree(
+						      ce->name, new, size, &buf);
+
+		if (ret) {
+			free(new);
+			new = strbuf_detach(&buf, &newsize);
+			size = newsize;
 		}
+		/*
+		 * No "else" here as errors from convert are OK at this
+		 * point. If the error would have been fatal (e.g.
+		 * filter is required), then we would have died already.
+		 */
 
+write_out_file:
 		fd = open_output_fd(path, ce, to_tempfile);
 		if (fd < 0) {
 			free(new);
