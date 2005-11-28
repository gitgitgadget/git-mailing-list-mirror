From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] mailinfo: allow -u to fall back on latin1 to utf8 conversion.
Date: Sun, 27 Nov 2005 16:39:13 -0800
Message-ID: <7v7jat61xq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org>
	<20051118205513.GA3168@vrfy.org>
	<Pine.LNX.4.64.0511181314470.13959@g5.osdl.org>
	<Pine.LNX.4.64.0511181338460.13959@g5.osdl.org>
	<437E51EB.7050100@zytor.com>
	<Pine.LNX.4.64.0511181520390.13959@g5.osdl.org>
	<7vek5deam6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511181653191.13959@g5.osdl.org>
	<7v7jb57wud.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511190950161.13959@g5.osdl.org>
	<20051127025249.GA12286@vrfy.org>
	<7vfypioi83.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511262006350.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 01:40:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgX3E-0007TM-02
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 01:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbVK1AjU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 19:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVK1AjU
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 19:39:20 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:53749 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751198AbVK1AjU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2005 19:39:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128003808.XWSS17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 27 Nov 2005 19:38:08 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12839>

When the message body does not identify what encoding it is in,
-u assumes it is in latin-1 and converts it to utf8, which is
the recommended encoding for git commit log messages.

With -u=<encoding>, the conversion is made into the specified
one, instead of utf8, to allow project-local policies.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This says [2/3] but does not use the first one in the series,
   to keep mailinfo less dependent on git.  [3/3] integrates it
   to git a bit further by using the configuration file.

 mailinfo.c |   59 +++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 35 insertions(+), 24 deletions(-)

applies-to: dfac5ab58034e7129ba0d8096ca2bb6857df2242
650e4be59b9f385f56e5829d97d09e8440f174b8
diff --git a/mailinfo.c b/mailinfo.c
index cb853df..6d8c933 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -16,7 +16,7 @@ extern char *gitstrcasestr(const char *h
 static FILE *cmitmsg, *patchfile;
 
 static int keep_subject = 0;
-static int metainfo_utf8 = 0;
+static char *metainfo_charset = NULL;
 static char line[1000];
 static char date[1000];
 static char name[1000];
@@ -441,29 +441,38 @@ static int decode_b_segment(char *in, ch
 
 static void convert_to_utf8(char *line, char *charset)
 {
-	if (*charset) {
-		char *in, *out;
-		size_t insize, outsize, nrc;
-		char outbuf[4096]; /* cheat */
-		iconv_t conv = iconv_open("utf-8", charset);
-
-		if (conv == (iconv_t) -1) {
-			fprintf(stderr, "cannot convert from %s to utf-8\n",
-				charset);
+	char *in, *out;
+	size_t insize, outsize, nrc;
+	char outbuf[4096]; /* cheat */
+	static char latin_one[] = "latin-1";
+	char *input_charset = *charset ? charset : latin_one;
+	iconv_t conv = iconv_open(metainfo_charset, input_charset);
+
+	if (conv == (iconv_t) -1) {
+		static int warned_latin1_once = 0;
+		if (input_charset != latin_one) {
+			fprintf(stderr, "cannot convert from %s to %s\n",
+				input_charset, metainfo_charset);
 			*charset = 0;
-			return;
 		}
-		in = line;
-		insize = strlen(in);
-		out = outbuf;
-		outsize = sizeof(outbuf);
-		nrc = iconv(conv, &in, &insize, &out, &outsize);
-		iconv_close(conv);
-		if (nrc == (size_t) -1)
-			return;
-		*out = 0;
-		strcpy(line, outbuf);
+		else if (!warned_latin1_once) {
+			warned_latin1_once = 1;
+			fprintf(stderr, "tried to convert from %s to %s, "
+				"but your iconv does not work with it.\n",
+				input_charset, metainfo_charset);
+		}
+		return;
 	}
+	in = line;
+	insize = strlen(in);
+	out = outbuf;
+	outsize = sizeof(outbuf);
+	nrc = iconv(conv, &in, &insize, &out, &outsize);
+	iconv_close(conv);
+	if (nrc == (size_t) -1)
+		return;
+	*out = 0;
+	strcpy(line, outbuf);
 }
 
 static void decode_header_bq(char *it)
@@ -511,7 +520,7 @@ static void decode_header_bq(char *it)
 		}
 		if (sz < 0)
 			return;
-		if (metainfo_utf8)
+		if (metainfo_charset)
 			convert_to_utf8(piecebuf, charset_q);
 		strcpy(out, piecebuf);
 		out += strlen(out);
@@ -590,7 +599,7 @@ static int handle_commit_msg(void)
 		 * normalize the log message to UTF-8.
 		 */
 		decode_transfer_encoding(line);
-		if (metainfo_utf8)
+		if (metainfo_charset)
 			convert_to_utf8(line, charset);
 		fputs(line, cmitmsg);
 	} while (fgets(line, sizeof(line), stdin) != NULL);
@@ -720,7 +729,9 @@ int main(int argc, char **argv)
 		if (!strcmp(argv[1], "-k"))
 			keep_subject = 1;
 		else if (!strcmp(argv[1], "-u"))
-			metainfo_utf8 = 1;
+			metainfo_charset = "utf-8";
+		else if (!strncmp(argv[1], "-u=", 3))
+			metainfo_charset = argv[1] + 3;
 		else
 			usage();
 		argc--; argv++;
---
0.99.9.GIT
