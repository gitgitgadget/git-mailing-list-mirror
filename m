From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Temporary fix for stack smashing in mailinfo
Date: Thu, 30 Aug 2007 23:48:24 +0200
Message-ID: <20070830214824.GC15405@steel.home>
References: <1188502009.29782.874.camel@hurina>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Timo Sirainen <tss@iki.fi>
X-From: git-owner@vger.kernel.org Thu Aug 30 23:48:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQrsN-0007bN-01
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 23:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760862AbXH3Vs1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 17:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760808AbXH3Vs1
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 17:48:27 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:61736 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758538AbXH3Vs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 17:48:26 -0400
Received: from tigra.home (Fc93c.f.strato-dslnet.de [195.4.201.60])
	by post.webmailer.de (klopstock mo10) (RZmta 12.1)
	with ESMTP id 903422j7UJNWzn ; Thu, 30 Aug 2007 23:48:24 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 90FC2277BD;
	Thu, 30 Aug 2007 23:48:24 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 73D5DBE2A; Thu, 30 Aug 2007 23:48:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1188502009.29782.874.camel@hurina>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAPiog==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57076>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Timo Sirainen, Thu, Aug 30, 2007 21:26:49 +0200:
> Attached once again beginnings of safer string handling functions, which
> should be easy to use to replace the existing string handling code. ...

Lots of code. And the bug you mentioned still not fixed.
No gain for anyone. You are right, but you are also useless.

Junio, I cannot have time to fix the code nice and proper, but as
heavy user of git-am just have to have it fixed at least a like this.
And this is ugly (and definitely incomplete), everyone be warned.

Checked with valgrind, looks good (except for iconv_open reading past
one of its arguments):

==22856== Invalid read of size 4
...
==22856==  Address 0x42D3D9C is 52 bytes inside a block of size 53 alloc'd
==22856==    at 0x4021620: malloc (vg_replace_malloc.c:149)
==22856==    by 0x41AD12F: (within /lib/tls/i686/cmov/libc-2.5.so)
==22856==    by 0x41AC56A: (within /lib/tls/i686/cmov/libc-2.5.so)
==22856==    by 0x41ACC63: (within /lib/tls/i686/cmov/libc-2.5.so)
==22856==    by 0x41A552B: (within /lib/tls/i686/cmov/libc-2.5.so)
==22856==    by 0x41A4093: (within /lib/tls/i686/cmov/libc-2.5.so)
==22856==    by 0x41A3CF9: iconv_open (in /lib/tls/i686/cmov/libc-2.5.so)
==22856==    by 0x80BEFFE: reencode_string (utf8.c:317)
==22856==    by 0x806A9D4: convert_to_utf8 (builtin-mailinfo.c:543)
==22856==    by 0x806AB8F: decode_header (builtin-mailinfo.c:600)
==22856==    by 0x806AF57: check_header (builtin-mailinfo.c:308)
==22856==    by 0x806B70B: cmd_mailinfo (builtin-mailinfo.c:936)

 builtin-mailinfo.c |   79 +++++++++++++++++++++++++++++----------------------
 1 files changed, 45 insertions(+), 34 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index b558754..57699eb 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -287,12 +287,12 @@ static void cleanup_space(char *buf)
 	}
 }
 
-static void decode_header(char *it);
+static void decode_header(char *it, unsigned itsize);
 static char *header[MAX_HDR_PARSED] = {
 	"From","Subject","Date",
 };
 
-static int check_header(char *line, char **hdr_data, int overwrite)
+static int check_header(char *line, unsigned linesize, char **hdr_data, int overwrite)
 {
 	int i;
 
@@ -305,7 +305,7 @@ static int check_header(char *line, char **hdr_data, int overwrite)
 			/* Unwrap inline B and Q encoding, and optionally
 			 * normalize the meta information to utf8.
 			 */
-			decode_header(line + len + 2);
+			decode_header(line + len + 2, linesize - len - 2);
 			hdr_data[i] = xmalloc(1000 * sizeof(char));
 			if (! handle_header(line, hdr_data[i], len + 2)) {
 				return 1;
@@ -316,14 +316,14 @@ static int check_header(char *line, char **hdr_data, int overwrite)
 	/* Content stuff */
 	if (!strncasecmp(line, "Content-Type", 12) &&
 		line[12] == ':' && isspace(line[12 + 1])) {
-		decode_header(line + 12 + 2);
+		decode_header(line + 12 + 2, linesize - 12 - 2);
 		if (! handle_content_type(line)) {
 			return 1;
 		}
 	}
 	if (!strncasecmp(line, "Content-Transfer-Encoding", 25) &&
 		line[25] == ':' && isspace(line[25 + 1])) {
-		decode_header(line + 25 + 2);
+		decode_header(line + 25 + 2, linesize - 25 - 2);
 		if (! handle_content_transfer_encoding(line)) {
 			return 1;
 		}
@@ -432,10 +432,15 @@ static int read_one_header_line(char *line, int sz, FILE *in)
 	return 1;
 }
 
-static int decode_q_segment(char *in, char *ot, char *ep, int rfc2047)
+static int decode_q_segment(char *in, char *ot, unsigned otsize, char *ep, int rfc2047)
 {
+	char *otend = ot + otsize;
 	int c;
 	while ((c = *in++) != 0 && (in <= ep)) {
+		if (ot == otend) {
+			*--ot = '\0';
+			return -1;
+		}
 		if (c == '=') {
 			int d = *in++;
 			if (d == '\n' || !d)
@@ -451,12 +456,17 @@ static int decode_q_segment(char *in, char *ot, char *ep, int rfc2047)
 	return 0;
 }
 
-static int decode_b_segment(char *in, char *ot, char *ep)
+static int decode_b_segment(char *in, char *ot, unsigned otsize, char *ep)
 {
 	/* Decode in..ep, possibly in-place to ot */
 	int c, pos = 0, acc = 0;
+	char *otend = ot + otsize;
 
 	while ((c = *in++) != 0 && (in <= ep)) {
+		if (ot == otend) {
+			*--ot = '\0';
+			return -1;
+		}
 		if (c == '+')
 			c = 62;
 		else if (c == '/')
@@ -518,7 +528,7 @@ static const char *guess_charset(const char *line, const char *target_charset)
 	return "latin1";
 }
 
-static void convert_to_utf8(char *line, const char *charset)
+static void convert_to_utf8(char *line, unsigned linesize, const char *charset)
 {
 	char *out;
 
@@ -534,11 +544,11 @@ static void convert_to_utf8(char *line, const char *charset)
 	if (!out)
 		die("cannot convert from %s to %s\n",
 		    charset, metainfo_charset);
-	strcpy(line, out);
+	strlcpy(line, out, linesize);
 	free(out);
 }
 
-static int decode_header_bq(char *it)
+static int decode_header_bq(char *it, unsigned itsize)
 {
 	char *in, *out, *ep, *cp, *sp;
 	char outbuf[1000];
@@ -578,56 +588,56 @@ static int decode_header_bq(char *it)
 		default:
 			return rfc2047; /* no munging */
 		case 'b':
-			sz = decode_b_segment(cp + 3, piecebuf, ep);
+			sz = decode_b_segment(cp + 3, piecebuf, sizeof(piecebuf), ep);
 			break;
 		case 'q':
-			sz = decode_q_segment(cp + 3, piecebuf, ep, 1);
+			sz = decode_q_segment(cp + 3, piecebuf, sizeof(piecebuf), ep, 1);
 			break;
 		}
 		if (sz < 0)
 			return rfc2047;
 		if (metainfo_charset)
-			convert_to_utf8(piecebuf, charset_q);
+			convert_to_utf8(piecebuf, sizeof(piecebuf), charset_q);
 		strcpy(out, piecebuf);
 		out += strlen(out);
 		in = ep + 2;
 	}
 	strcpy(out, in);
-	strcpy(it, outbuf);
+	strlcpy(it, outbuf, itsize);
 	return rfc2047;
 }
 
-static void decode_header(char *it)
+static void decode_header(char *it, unsigned itsize)
 {
 
-	if (decode_header_bq(it))
+	if (decode_header_bq(it, itsize))
 		return;
 	/* otherwise "it" is a straight copy of the input.
 	 * This can be binary guck but there is no charset specified.
 	 */
 	if (metainfo_charset)
-		convert_to_utf8(it, "");
+		convert_to_utf8(it, itsize, "");
 }
 
-static void decode_transfer_encoding(char *line)
+static void decode_transfer_encoding(char *line, unsigned linesize)
 {
 	char *ep;
 
 	switch (transfer_encoding) {
 	case TE_QP:
 		ep = line + strlen(line);
-		decode_q_segment(line, line, ep, 0);
+		decode_q_segment(line, line, linesize, ep, 0);
 		break;
 	case TE_BASE64:
 		ep = line + strlen(line);
-		decode_b_segment(line, line, ep);
+		decode_b_segment(line, line, linesize, ep);
 		break;
 	case TE_DONTCARE:
 		break;
 	}
 }
 
-static int handle_filter(char *line);
+static int handle_filter(char *line, unsigned linesize);
 
 static int find_boundary(void)
 {
@@ -655,7 +665,7 @@ again:
 					"can't recover\n");
 			exit(1);
 		}
-		handle_filter(newline);
+		handle_filter(newline, sizeof(newline));
 
 		/* skip to the next boundary */
 		if (!find_boundary())
@@ -670,7 +680,7 @@ again:
 
 	/* slurp in this section's info */
 	while (read_one_header_line(line, sizeof(line), fin))
-		check_header(line, p_hdr_data, 0);
+		check_header(line, sizeof(line), p_hdr_data, 0);
 
 	/* eat the blank line after section info */
 	return (fgets(line, sizeof(line), fin) != NULL);
@@ -709,9 +719,10 @@ static inline int patchbreak(const char *line)
 }
 
 
-static int handle_commit_msg(char *line)
+static int handle_commit_msg(char *line, unsigned linesize)
 {
 	static int still_looking = 1;
+	char *endline = line + linesize;
 
 	if (!cmitmsg)
 		return 0;
@@ -726,13 +737,13 @@ static int handle_commit_msg(char *line)
 			if (!*cp)
 				return 0;
 		}
-		if ((still_looking = check_header(cp, s_hdr_data, 0)) != 0)
+		if ((still_looking = check_header(cp, endline - cp, s_hdr_data, 0)) != 0)
 			return 0;
 	}
 
 	/* normalize the log message to UTF-8. */
 	if (metainfo_charset)
-		convert_to_utf8(line, charset);
+		convert_to_utf8(line, endline - line, charset);
 
 	if (patchbreak(line)) {
 		fclose(cmitmsg);
@@ -751,7 +762,7 @@ static int handle_patch(char *line)
 	return 0;
 }
 
-static int handle_filter(char *line)
+static int handle_filter(char *line, unsigned linesize)
 {
 	static int filter = 0;
 
@@ -760,7 +771,7 @@ static int handle_filter(char *line)
 	 */
 	switch (filter) {
 	case 0:
-		if (!handle_commit_msg(line))
+		if (!handle_commit_msg(line, linesize))
 			break;
 		filter++;
 	case 1:
@@ -792,14 +803,14 @@ static void handle_body(void)
 			/* flush any leftover */
 			if ((transfer_encoding == TE_BASE64)  &&
 			    (np != newline)) {
-				handle_filter(newline);
+				handle_filter(newline, sizeof(newline));
 			}
 			if (!handle_boundary())
 				return;
 		}
 
 		/* Unwrap transfer encoding */
-		decode_transfer_encoding(line);
+		decode_transfer_encoding(line, sizeof(line));
 
 		switch (transfer_encoding) {
 		case TE_BASE64:
@@ -808,7 +819,7 @@ static void handle_body(void)
 
 			/* binary data most likely doesn't have newlines */
 			if (message_type != TYPE_TEXT) {
-				rc = handle_filter(line);
+				rc = handle_filter(line, sizeof(newline));
 				break;
 			}
 
@@ -825,7 +836,7 @@ static void handle_body(void)
 					/* should be sitting on a new line */
 					*(++np) = 0;
 					op++;
-					rc = handle_filter(newline);
+					rc = handle_filter(newline, sizeof(newline));
 					np = newline;
 				}
 			} while (*op != 0);
@@ -835,7 +846,7 @@ static void handle_body(void)
 			break;
 		}
 		default:
-			rc = handle_filter(line);
+			rc = handle_filter(line, sizeof(newline));
 		}
 		if (rc)
 			/* nothing left to filter */
@@ -922,7 +933,7 @@ static int mailinfo(FILE *in, FILE *out, int ks, const char *encoding,
 
 	/* process the email header */
 	while (read_one_header_line(line, sizeof(line), fin))
-		check_header(line, p_hdr_data, 1);
+		check_header(line, sizeof(line), p_hdr_data, 1);
 
 	handle_body();
 	handle_info();
-- 
1.5.3.rc7.26.g5f7e4
