From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] vcs-svn: allow import of > 4GiB files
Date: Thu, 2 Feb 2012 05:03:16 -0600
Message-ID: <20120202110316.GK3823@burratino>
References: <4F28378F.6080108@ramsay1.demon.co.uk>
 <20120131192053.GC12443@burratino>
 <7vipjpzxav.fsf@alter.siamese.dyndns.org>
 <20120202104128.GG3823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	David Barr <davidbarr@google.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 12:03:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsuS3-0001Xt-Qr
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 12:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290Ab2BBLDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 06:03:35 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55284 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066Ab2BBLDe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 06:03:34 -0500
Received: by iacb35 with SMTP id b35so2987159iac.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 03:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ONMaLTGdQrA6Gk6sCCd+uvRtK4OUv79KweCulwgx938=;
        b=U0EPAPoKdVd3vpCIBo+vr8ed2v9ut38cL1vqDplEtbSbG3iyYvcI9SVyQ4n4qMy9Dm
         9sETPticPN6wj+ug+xID5P+1vDncr6AJIPfH7SblYXKX6SKgPeL+xQnqrFLwVkrq0VAl
         KIpa6M8GWDPa3joNw7h3jya2oWflIVKrToOM0=
Received: by 10.43.46.196 with SMTP id up4mr2076461icb.23.1328180613886;
        Thu, 02 Feb 2012 03:03:33 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id d15sm4345114ibf.7.2012.02.02.03.03.33
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 03:03:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120202104128.GG3823@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189624>

There is no reason in principle that an svn-format dump would not be
able to represent a file whose length does not fit in a 32-bit
integer.  Use off_t consistently to represent file lengths (in place
of using uint32_t in some contexts) so we can handle that.

Most svn-fe code is already ready to do that without this patch and
passes values of type off_t around.  The type mismatch from stragglers
was noticed with gcc -Wtype-limits.

While at it, tighten the parsing of the Text-content-length field to
make sure it is a number and does not overflow, and tighten other
overflow checks as that value is passed around and manipulated.

Inspired-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/fast_export.c |   15 +++++++++------
 vcs-svn/fast_export.h |    4 ++--
 vcs-svn/svndump.c     |   21 +++++++++++++++------
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 19d7c34c..b823b851 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -227,15 +227,18 @@ static long apply_delta(off_t len, struct line_buffer *input,
 	return ret;
 }
 
-void fast_export_data(uint32_t mode, uint32_t len, struct line_buffer *input)
+void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input)
 {
+	assert(len >= 0);
 	if (mode == REPO_MODE_LNK) {
 		/* svn symlink blobs start with "link " */
+		if (len < 5)
+			die("invalid dump: symlink too short for \"link\" prefix");
 		len -= 5;
 		if (buffer_skip_bytes(input, 5) != 5)
 			die_short_read(input);
 	}
-	printf("data %"PRIu32"\n", len);
+	printf("data %"PRIuMAX"\n", (uintmax_t) len);
 	if (buffer_copy_bytes(input, len) != len)
 		die_short_read(input);
 	fputc('\n', stdout);
@@ -297,12 +300,12 @@ int fast_export_ls(const char *path, uint32_t *mode, struct strbuf *dataref)
 
 void fast_export_blob_delta(uint32_t mode,
 				uint32_t old_mode, const char *old_data,
-				uint32_t len, struct line_buffer *input)
+				off_t len, struct line_buffer *input)
 {
 	long postimage_len;
-	if (len > maximum_signed_value_of_type(off_t))
-		die("enormous delta");
-	postimage_len = apply_delta((off_t) len, input, old_data, old_mode);
+
+	assert(len >= 0);
+	postimage_len = apply_delta(len, input, old_data, old_mode);
 	if (mode == REPO_MODE_LNK) {
 		buffer_skip_bytes(&postimage, strlen("link "));
 		postimage_len -= strlen("link ");
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index 43d05b65..aa629f54 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -14,10 +14,10 @@ void fast_export_begin_commit(uint32_t revision, const char *author,
 			const struct strbuf *log, const char *uuid,
 			const char *url, unsigned long timestamp);
 void fast_export_end_commit(uint32_t revision);
-void fast_export_data(uint32_t mode, uint32_t len, struct line_buffer *input);
+void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input);
 void fast_export_blob_delta(uint32_t mode,
 			uint32_t old_mode, const char *old_data,
-			uint32_t len, struct line_buffer *input);
+			off_t len, struct line_buffer *input);
 
 /* If there is no such file at that rev, returns -1, errno == ENOENT. */
 int fast_export_ls_rev(uint32_t rev, const char *path,
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index ca63760f..644fdc71 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -40,7 +40,8 @@
 static struct line_buffer input = LINE_BUFFER_INIT;
 
 static struct {
-	uint32_t action, propLength, textLength, srcRev, type;
+	uint32_t action, propLength, srcRev, type;
+	off_t text_length;
 	struct strbuf src, dst;
 	uint32_t text_delta, prop_delta;
 } node_ctx;
@@ -61,7 +62,7 @@ static void reset_node_ctx(char *fname)
 	node_ctx.type = 0;
 	node_ctx.action = NODEACT_UNKNOWN;
 	node_ctx.propLength = LENGTH_UNKNOWN;
-	node_ctx.textLength = LENGTH_UNKNOWN;
+	node_ctx.text_length = -1;
 	strbuf_reset(&node_ctx.src);
 	node_ctx.srcRev = 0;
 	strbuf_reset(&node_ctx.dst);
@@ -209,7 +210,7 @@ static void handle_node(void)
 {
 	const uint32_t type = node_ctx.type;
 	const int have_props = node_ctx.propLength != LENGTH_UNKNOWN;
-	const int have_text = node_ctx.textLength != LENGTH_UNKNOWN;
+	const int have_text = node_ctx.text_length != -1;
 	/*
 	 * Old text for this node:
 	 *  NULL	- directory or bug
@@ -291,12 +292,12 @@ static void handle_node(void)
 	}
 	if (!node_ctx.text_delta) {
 		fast_export_modify(node_ctx.dst.buf, node_ctx.type, "inline");
-		fast_export_data(node_ctx.type, node_ctx.textLength, &input);
+		fast_export_data(node_ctx.type, node_ctx.text_length, &input);
 		return;
 	}
 	fast_export_modify(node_ctx.dst.buf, node_ctx.type, "inline");
 	fast_export_blob_delta(node_ctx.type, old_mode, old_data,
-				node_ctx.textLength, &input);
+				node_ctx.text_length, &input);
 }
 
 static void begin_revision(void)
@@ -409,7 +410,15 @@ void svndump_read(const char *url)
 			break;
 		case sizeof("Text-content-length"):
 			if (!constcmp(t, "Text-content-length")) {
-				node_ctx.textLength = atoi(val);
+				char *end;
+				uintmax_t textlen;
+
+				textlen = strtoumax(val, &end, 10);
+				if (!isdigit(*val) || *end)
+					die("invalid dump: non-numeric length %s", val);
+				if (textlen > maximum_signed_value_of_type(off_t))
+					die("unrepresentable length in dump: %s", val);
+				node_ctx.text_length = (off_t) textlen;
 				break;
 			}
 			if (constcmp(t, "Prop-content-length"))
-- 
1.7.9
