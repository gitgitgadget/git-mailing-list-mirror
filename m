From: Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH 1/2] [RFC] add --recode-patch option to git-mailinfo
Date: Sun,  6 Jun 2010 19:59:42 +0800
Message-ID: <1275825583-23913-1-git-send-email-r0bertz@gentoo.org>
Cc: Zhang Le <r0bertz@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 06 14:01:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLEXG-00053C-0V
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 14:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881Ab0FFMA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 08:00:56 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:39817 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647Ab0FFMAz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 08:00:55 -0400
Received: by pxi8 with SMTP id 8so803666pxi.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 05:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=0AslyUfFLz75T0eN4UiT4PV6QvRBI1msQkA3yjfRzgM=;
        b=H5xGZTOcdAov9W9PGRUnwt1gh8opTpvbis1TZaMV+rcLpoarU7rKAKU/s2brEX2FPd
         UuWRyxntZBiA50uzpLqInNzykSkegBKedoZYTCs/kbwQMui1GjPi05qrY4EQ8t5RJyur
         nZwjQ7YRqCU/hymfSVeYy3VbvL0SAXdm6syc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=jPAwp+LsN5RMvvCoLgpOmu6oMldpjT0Cor22fVbSBpq+r5Mb/nnFCQ1x25WrZrolm6
         Qeww5FCS1uBTqpZsA745yhE3w9lFSUH5jpAXwC1JcV0qTxqLhtlkMqbeYz3PH/BgT/Ll
         YxDnIHh5RYztc4ZvH1L/qj/tAaf10mUA819gs=
Received: by 10.114.253.9 with SMTP id a9mr10509320wai.72.1275825654839;
        Sun, 06 Jun 2010 05:00:54 -0700 (PDT)
Received: from localhost ([119.122.45.205])
        by mx.google.com with ESMTPS id c22sm28264860wam.6.2010.06.06.05.00.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jun 2010 05:00:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148518>

I have a translation project which uses UTF-8 as charset.
So the patch must be encoded in UTF-8, not just the commit msg etc.
And we use google group as our mailing list.

Recently, due to unknown reason, mails saved from gmail are encoded using GB2312.
This never happened before. I guess google has did something.
But I haven't found how to change this behavior.

So I took another way, i.e. add this option to git-mailinfo.
I hope this could benefit others as well.

Signed-off-by: Zhang Le <r0bertz@gentoo.org>
---
 builtin/mailinfo.c  |    8 +++++++-
 man1/git-mailinfo.1 |    7 ++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 4a9729b..73f51f3 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -12,6 +12,7 @@ static FILE *cmitmsg, *patchfile, *fin, *fout;
 static int keep_subject;
 static int keep_non_patch_brackets_in_subject;
 static const char *metainfo_charset;
+static int recode_patch;
 static struct strbuf line = STRBUF_INIT;
 static struct strbuf name = STRBUF_INIT;
 static struct strbuf email = STRBUF_INIT;
@@ -830,6 +831,8 @@ static int handle_commit_msg(struct strbuf *line)
 
 static void handle_patch(const struct strbuf *line)
 {
+	if (recode_patch)
+		convert_to_utf8(line, charset.buf);
 	fwrite(line->buf, 1, line->len, patchfile);
 	patch_lines++;
 }
@@ -1021,7 +1024,7 @@ static int git_mailinfo_config(const char *var, const char *value, void *unused)
 }
 
 static const char mailinfo_usage[] =
-	"git mailinfo [-k|-b] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] msg patch < mail >info";
+	"git mailinfo [-k|-b] [-u | --encoding=<encoding> | -n] [--recode-patch] [--scissors | --no-scissors] msg patch < mail >info";
 
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
@@ -1034,6 +1037,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 
 	def_charset = (git_commit_encoding ? git_commit_encoding : "UTF-8");
 	metainfo_charset = def_charset;
+	recode_patch = 0;
 
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "-k"))
@@ -1046,6 +1050,8 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 			metainfo_charset = NULL;
 		else if (!prefixcmp(argv[1], "--encoding="))
 			metainfo_charset = argv[1] + 11;
+		else if (!strcmp(argv[1], "--recode-patch"))
+			recode_patch = 1;
 		else if (!strcmp(argv[1], "--scissors"))
 			use_scissors = 1;
 		else if (!strcmp(argv[1], "--no-scissors"))
diff --git a/man1/git-mailinfo.1 b/man1/git-mailinfo.1
index 4d0e929..d52457f 100644
--- a/man1/git-mailinfo.1
+++ b/man1/git-mailinfo.1
@@ -22,7 +22,7 @@
 git-mailinfo \- Extracts patch and authorship from a single e\-mail message
 .SH "SYNOPSIS"
 .sp
-\fIgit mailinfo\fR [\-k|\-b] [\-u | \-\-encoding=<encoding> | \-n] [\-\-scissors] <msg> <patch>
+\fIgit mailinfo\fR [\-k|\-b] [\-u | \-\-encoding=<encoding> | \-n] [\-\-recode\-patch] [\-\-scissors] <msg> <patch>
 .SH "DESCRIPTION"
 .sp
 Reads a single e\-mail message from the standard input, and writes the commit log message in <msg> file, and the patches in <patch> file\&. The author name, e\-mail and e\-mail subject are written out to the standard output to be used by \fIgit am\fR to create a commit\&. It is usually not necessary to use this command directly\&. See \fBgit-am\fR(1) instead\&.
@@ -70,6 +70,11 @@ Similar to \-u but if the local convention is different from what is specified b
 Disable all charset re\-coding of the metadata\&.
 .RE
 .PP
+\-\-recode\-patch
+.RS 4
+Re\-code patch as well, using the same encoding as metadata\&. The default is off\&.
+.RE
+.PP
 \-\-scissors
 .RS 4
 Remove everything in body before a scissors line\&. A line that mainly consists of scissors (either ">8" or "8<") and perforation (dash "\-") marks is called a scissors line, and is used to request the reader to cut the message at that line\&. If such a line appears in the body of the message before the patch, everything before it (including the scissors line itself) is ignored when this option is used\&.
-- 
1.7.1
