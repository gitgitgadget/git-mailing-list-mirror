From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 1/2] separate quoting and relative path generation
Date: Thu, 3 Jun 2010 15:36:31 +0200
Message-ID: <20100603133631.GA31565@localhost>
References: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 15:37:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKAbv-0003gm-Fm
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 15:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643Ab0FCNhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 09:37:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46502 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab0FCNhU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 09:37:20 -0400
Received: by fxm8 with SMTP id 8so94884fxm.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 06:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Hf+h2QPSGbBPDyo1PGS3b5dcyBeSvZErSGcwTPZlfk4=;
        b=Bbo6fZvRlBvqaS+NZqFxQH23xcpOa8RodBLK3275KeHHDKQlSlWWf4qbzcJeJ6ApFq
         ce+It+5Q4zUGM4uIU8C42di+nIBcBx3NVvURYfE9VkWMndde7P3dcGwUqDiSBrHo09aD
         Kn88XHQZujb9qUiYjIQx3SyjPNrpQpfREljHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=LLpEfEs+KKT7j8eROI+RVbixBwKUG+WeT1Fn+GjDbLRWlRQYbn1ZD4ZjalxSRTAAWH
         nDZbaUdVi5ujCGCEKpIt9+1ElA2xriiysam9YAbvReRWiVnP1IVNJx4+9PSVqp9fsqKJ
         WdZovogV4HzKxxsHBAgMzkQZLWSvdI0nUXdng=
Received: by 10.223.92.136 with SMTP id r8mr10282235fam.40.1275572238267;
        Thu, 03 Jun 2010 06:37:18 -0700 (PDT)
Received: from darc.lan (p549A3E4B.dip.t-dialin.net [84.154.62.75])
        by mx.google.com with ESMTPS id 15sm206142fad.10.2010.06.03.06.37.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 06:37:17 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OKAb1-0003XM-Ve; Thu, 03 Jun 2010 15:36:32 +0200
Content-Disposition: inline
In-Reply-To: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148315>

This is in preparation of relative path support for ls-files, which
quotes a path only if the line terminator is not the NUL character.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Wed, Jun 02, 2010 at 04:36:56PM -0700, Junio C Hamano wrote:

> * cb/ls-files-cdup (2010-05-26) 1 commit
>  - ls-files: allow relative pathspec
> 
> Doesn't write_name() quote twice when prefix_offset is non-zero?

Yes. Fixed in the following two patches.

 quote.c |   69 +++++++++++++++++++++++++++++++++++++++++---------------------
 quote.h |    8 ++++++-
 2 files changed, 52 insertions(+), 25 deletions(-)

diff --git a/quote.c b/quote.c
index fc93435..2ae2c1f 100644
--- a/quote.c
+++ b/quote.c
@@ -295,42 +295,63 @@ void write_name_quotedpfx(const char *pfx, size_t pfxlen,
 	fputc(terminator, fp);
 }
 
-/* quote path as relative to the given prefix */
-char *quote_path_relative(const char *in, int len,
-			  struct strbuf *out, const char *prefix)
+void write_name_quoted_relative(const char *name, size_t len,
+				const char *prefix, size_t prefix_len,
+				FILE *fp, int terminator)
 {
-	int needquote;
+	struct strbuf sb = STRBUF_INIT;
 
+	char *path = path_relative(name, len, &sb, prefix, prefix_len);
+	write_name_quoted(path, fp, terminator);
+
+	strbuf_release(&sb);
+}
+
+/* give path as relative to prefix */
+char *path_relative(const char *in, int len,
+		    struct strbuf *out, const char *prefix, int prefix_len)
+{
 	if (len < 0)
 		len = strlen(in);
+	if (prefix && prefix_len < 0)
+		prefix_len = strlen(prefix);
 
-	/* "../" prefix itself does not need quoting, but "in" might. */
-	needquote = next_quote_pos(in, len) < len;
 	strbuf_setlen(out, 0);
 	strbuf_grow(out, len);
 
-	if (needquote)
-		strbuf_addch(out, '"');
-	if (prefix) {
-		int off = 0;
-		while (prefix[off] && off < len && prefix[off] == in[off])
-			if (prefix[off] == '/') {
-				prefix += off + 1;
-				in += off + 1;
-				len -= off + 1;
-				off = 0;
-			} else
-				off++;
-
-		for (; *prefix; prefix++)
-			if (*prefix == '/')
+	if (prefix_len > 0) {
+		int off = 0, i = 0;
+		while (i < prefix_len && i < len && prefix[i] == in[i]) {
+			if (prefix[i] == '/')
+				off = i + 1;
+			i++;
+		}
+		in += off;
+		len -= off;
+
+		while (i < prefix_len) {
+			if (prefix[i] == '/')
 				strbuf_addstr(out, "../");
+			i++;
+		}
 	}
+	strbuf_add(out, in, len);
+
+	return out->buf;
+}
+
+/* quote path as relative to the given prefix */
+char *quote_path_relative(const char *in, int len,
+			  struct strbuf *out, const char *prefix)
+{
+	char *rel;
+	size_t rel_len;
 
-	quote_c_style_counted (in, len, out, NULL, 1);
+	path_relative(in, len, out, prefix, -1);
+	rel = strbuf_detach(out, &rel_len);
+	quote_c_style_counted(rel, rel_len, out, NULL, 0);
+	free(rel);
 
-	if (needquote)
-		strbuf_addch(out, '"');
 	if (!out->len)
 		strbuf_addstr(out, "./");
 
diff --git a/quote.h b/quote.h
index f83eb23..e9e0221 100644
--- a/quote.h
+++ b/quote.h
@@ -54,9 +54,15 @@ extern void quote_two_c_style(struct strbuf *, const char *, const char *, int);
 extern void write_name_quoted(const char *name, FILE *, int terminator);
 extern void write_name_quotedpfx(const char *pfx, size_t pfxlen,
                                  const char *name, FILE *, int terminator);
+extern void write_name_quoted_relative(const char *name, size_t len,
+		const char *prefix, size_t prefix_len,
+		FILE *fp, int terminator);
 
+/* give path as relative to prefix */
+extern char *path_relative(const char *in, int len,
+		struct strbuf *out, const char *prefix, int prefix_len);
 /* quote path as relative to the given prefix */
-char *quote_path_relative(const char *in, int len,
+extern char *quote_path_relative(const char *in, int len,
 			  struct strbuf *out, const char *prefix);
 
 /* quoting as a string literal for other languages */
-- 
1.7.1.2.g2a651
