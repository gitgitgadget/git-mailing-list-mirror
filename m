Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C048F207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 20:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbcJCUe0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:34:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:51429 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752098AbcJCUeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:34:25 -0400
Received: (qmail 17237 invoked by uid 109); 3 Oct 2016 20:34:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 20:34:20 +0000
Received: (qmail 29700 invoked by uid 111); 3 Oct 2016 20:34:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 16:34:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 16:34:17 -0400
Date:   Mon, 3 Oct 2016 16:34:17 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 07/18] link_alt_odb_entry: handle normalize_path errors
Message-ID: <20161003203417.izcgwt4yz3yspdnm@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we add a new alternate to the list, we try to normalize
out any redundant "..", etc. However, we do not look at the
return value of normalize_path_copy(), and will happily
continue with a path that could not be normalized. Worse,
the normalizing process is done in-place, so we are left
with whatever half-finished working state the normalizing
function was in.

Fortunately, this cannot cause us to read past the end of
our buffer, as that working state will always leave the
NUL from the original path in place. And we do tend to
notice problems when we check is_directory() on the path.
But you can see the nonsense that we feed to is_directory
with an entry like:

  this/../../is/../../way/../../too/../../deep/../../to/../../resolve

in your objects/info/alternates, which yields:

  error: object directory
  /to/e/deep/too/way//ects/this/../../is/../../way/../../too/../../deep/../../to/../../resolve
  does not exist; check .git/objects/info/alternates.

We can easily fix this just by checking the return value.
But that makes it hard to generate a good error message,
since we're normalizing in-place and our input value has
been overwritten by cruft.

Instead, let's provide a strbuf helper that does an in-place
normalize, but restores the original contents on error. This
uses a second buffer under the hood, which is slightly less
efficient, but this is not a performance-critical code path.

The strbuf helper can also properly set the "len" parameter
of the strbuf before returning. Just doing:

  normalize_path_copy(buf.buf, buf.buf);

will shorten the string, but leave buf.len at the original
length. That may be confusing to later code which uses the
strbuf.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 11 +++++++++--
 strbuf.c    | 20 ++++++++++++++++++++
 strbuf.h    |  8 ++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index b9c1fa3..68571bd 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -263,7 +263,12 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	}
 	strbuf_addstr(&pathbuf, entry);
 
-	normalize_path_copy(pathbuf.buf, pathbuf.buf);
+	if (strbuf_normalize_path(&pathbuf) < 0) {
+		error("unable to normalize alternate object path: %s",
+		      pathbuf.buf);
+		strbuf_release(&pathbuf);
+		return -1;
+	}
 
 	pfxlen = strlen(pathbuf.buf);
 
@@ -335,7 +340,9 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
 	}
 
 	strbuf_add_absolute_path(&objdirbuf, get_object_directory());
-	normalize_path_copy(objdirbuf.buf, objdirbuf.buf);
+	if (strbuf_normalize_path(&objdirbuf) < 0)
+		die("unable to normalize object directory: %s",
+		    objdirbuf.buf);
 
 	alt_copy = xmemdupz(alt, len);
 	string_list_split_in_place(&entries, alt_copy, sep, -1);
diff --git a/strbuf.c b/strbuf.c
index b839be4..8fec657 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -870,3 +870,23 @@ void strbuf_stripspace(struct strbuf *sb, int skip_comments)
 
 	strbuf_setlen(sb, j);
 }
+
+int strbuf_normalize_path(struct strbuf *src)
+{
+	struct strbuf dst = STRBUF_INIT;
+
+	strbuf_grow(&dst, src->len);
+	if (normalize_path_copy(dst.buf, src->buf) < 0) {
+		strbuf_release(&dst);
+		return -1;
+	}
+
+	/*
+	 * normalize_path does not tell us the new length, so we have to
+	 * compute it by looking for the new NUL it placed
+	 */
+	strbuf_setlen(&dst, strlen(dst.buf));
+	strbuf_swap(src, &dst);
+	strbuf_release(&dst);
+	return 0;
+}
diff --git a/strbuf.h b/strbuf.h
index ba8d5f1..2262b12 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -443,6 +443,14 @@ extern int strbuf_getcwd(struct strbuf *sb);
  */
 extern void strbuf_add_absolute_path(struct strbuf *sb, const char *path);
 
+
+/**
+ * Normalize in-place the path contained in the strbuf. See
+ * normalize_path_copy() for details. If an error occurs, the contents of "sb"
+ * are left untouched, and -1 is returned.
+ */
+extern int strbuf_normalize_path(struct strbuf *sb);
+
 /**
  * Strip whitespace from a buffer. The second parameter controls if
  * comments are considered contents to be removed or not.
-- 
2.10.0.618.g82cc264

