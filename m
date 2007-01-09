From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] Re: git-mailinfo '-u' argument should be default.
Date: Tue, 09 Jan 2007 22:03:25 +0800
Message-ID: <1168351405.14763.347.camel@shinybook.infradead.org>
References: <1147452362.2794.452.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Dave Jones <davej@redhat.com>, Junio C Hamano <junkio@cox.net>,
	chrisw@redhat.com
X-From: git-owner@vger.kernel.org Tue Jan 09 15:03:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4HZG-0003SH-9L
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 15:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbXAIODG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 09:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbXAIODG
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 09:03:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57016 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096AbXAIODE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 09:03:04 -0500
Received: from [222.72.90.51] (helo=[192.168.0.4])
	by pentafluge.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1H4HZ5-0004K6-CZ; Tue, 09 Jan 2007 14:03:01 +0000
To: git@vger.kernel.org
In-Reply-To: <1147452362.2794.452.camel@pmac.infradead.org>
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36359>

On Fri, 2006-05-12 at 17:46 +0100, David Woodhouse wrote:
> If you apply a patch with 'git-am', it takes the raw content of the
> From: header, in whatever character set that happens to be, and puts
> that content, untagged, into the commit object. 
> 
> That is almost _never_ the right thing to do, surely? Raw data in
> untagged character sets is marginally better than line noise.
> 
> We should default to the '-u' behaviour, which converts to the character
> set which the git repo is stored in. It's not just for converting to
> UTF-8, although it looks like it was in the past. Now, however, it
> converts to the character set defined in the configuration. So even if
> it's a Luddite who for some reason is sticking with an obsolete
> character set, it gets that right.

This patch:
 1. Fixes the default not to throw away the MIME information.
 2. Adds a '-n' option with the old behaviour, although I can't
    actually imagine why someone might find that desirable.
 3. Aborts if the conversion fails, allowing the user to fix it 
    rather than silently corrupting the input. There's always the
    new '-n' option if the user _really_ wants it corrupted. :)

diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index ea0a065..97b6c5b 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -8,7 +8,7 @@ git-mailinfo - Extracts patch from a single e-mail message
 
 SYNOPSIS
 --------
-'git-mailinfo' [-k] [-u | --encoding=<encoding>] <msg> <patch>
+'git-mailinfo' [-k] [-n | --encoding=<encoding>] <msg> <patch>
 
 
 DESCRIPTION
@@ -34,19 +34,20 @@ OPTIONS
 
 -u::
 	By default, the commit log message, author name and
-	author email are taken from the e-mail without any
-	charset conversion, after minimally decoding MIME
-	transfer encoding.  This flag causes the resulting
-	commit to be encoded in the encoding specified by
-	i18n.commitencoding configuration (defaults to utf-8) by
-	transliterating them. 
+	author email are transliterated if necessary in order 
+	to store them in the correct encoding as specified by
+	the i18n.commitencoding configuration option (which
+	defaults to UTF-8). This flag disables such character
+	set conversion; performing basic MIME transfer decoding
+	but then intentionally discarding the character set
+	information and using the raw byte sequences.
 	Note that the patch is always used as is without charset
-	conversion, even with this flag.
+	conversion, even without this flag.
 
 --encoding=<encoding>::
-	Similar to -u but if the local convention is different
-	from what is specified by i18n.commitencoding, this flag
-	can be used to override it.
+	If the i18n.commitencoding configuration option is set
+	set incorrectly (or unset when the UTF-8 default is not
+	desired), this flag can be used to override it.
 
 <msg>::
 	The commit log message extracted from e-mail, usually
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index a67f3eb..02bd183 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -518,8 +518,7 @@ static void convert_to_utf8(char *line, char *charset)
 	if (!out) {
 		fprintf(stderr, "cannot convert from %s to %s\n",
 			input_charset, metainfo_charset);
-		*charset = 0;
-		return;
+		exit(1);
 	}
 	strcpy(line, out);
 	free(out);
@@ -793,7 +792,7 @@ int mailinfo(FILE *in, FILE *out, int ks, const char *encoding,
 }
 
 static const char mailinfo_usage[] =
-	"git-mailinfo [-k] [-u | --encoding=<encoding>] msg patch <mail >info";
+	"git-mailinfo [-k] [-n | --encoding=<encoding>] msg patch <mail >info";
 
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
@@ -802,12 +801,16 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	 */
 	git_config(git_default_config);
 
+	metainfo_charset = (git_commit_encoding
+			    ? git_commit_encoding : "utf-8");
+
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "-k"))
 			keep_subject = 1;
-		else if (!strcmp(argv[1], "-u"))
-			metainfo_charset = (git_commit_encoding
-					    ? git_commit_encoding : "utf-8");
+		else if (!strcmp(argv[1], "-u")) 
+			; /* this is now default behaviour */
+		else if (!strcmp(argv[1], "-n")) 
+			metainfo_charset = NULL;
 		else if (!strncmp(argv[1], "--encoding=", 11))
 			metainfo_charset = argv[1] + 11;
 		else

-- 
dwmw2
