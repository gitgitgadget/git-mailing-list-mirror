From: "ZHANG, Le" <r0bertz@gentoo.org>
Subject: [PATCH v4 3/4] git mailinfo: added a --recode-patch parameter
Date: Mon, 29 Nov 2010 03:10:16 +0800
Message-ID: <1290971417-4474-4-git-send-email-r0bertz@gentoo.org>
References: <1290971417-4474-1-git-send-email-r0bertz@gentoo.org>
Cc: "ZHANG, Le" <r0bertz@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 28 20:11:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMmeX-0001GJ-Bz
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 20:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058Ab0K1TLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 14:11:05 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45177 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866Ab0K1TLB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 14:11:01 -0500
Received: by pzk6 with SMTP id 6so587766pzk.19
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 11:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=EDBS9M1qtwivlso16A8cMO86awTEHWzF+zY/aRY/9vk=;
        b=C0+0S6HH5Go2KRgzZICAYnRDU/+XNbtdlr/yJ1T0NByt2IDPUHRMdf5Fx+xwjHIqLT
         8qImbQjiH1mAN9I6HqZGxniP7Ea3b5ogoJSfDgMdhUoFUcHkl2jHs3VAbGyuuVVZKrGV
         4/7b+J2pQOaM57KkQlbmXeJv/UrkLyid+q4nw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=JDQHPHAv3zy5RQ/gHH8AUKd1lFm9yX/TX1tcXDD4LD+aNWr7vR7zfku7Sjx9ytI3Z5
         D8850Q7B0aULrKv8W683+Rn6p7kTpuZ6jOLKdkd3CLXe7ELDKq87jjoHAaK+WwtcQPIc
         JW6vUNya5iC2E0TZpubS8J1++V7RUDoZ2IJ/M=
Received: by 10.142.128.1 with SMTP id a1mr4482695wfd.282.1290971460842;
        Sun, 28 Nov 2010 11:11:00 -0800 (PST)
Received: from localhost ([183.37.0.219])
        by mx.google.com with ESMTPS id e14sm6319805wfg.20.2010.11.28.11.10.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Nov 2010 11:10:59 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.344.gb3680.dirty
In-Reply-To: <1290971417-4474-1-git-send-email-r0bertz@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162348>

When this parameter is specified, patch will be converted to a target encoding before applied.
The target encoding defaults to UTF-8. It could also be specified by i18n.patchencoding.

Signed-off-by: ZHANG, Le <r0bertz@gentoo.org>
---
 Documentation/git-mailinfo.txt |    6 +++++-
 builtin/mailinfo.c             |   11 +++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 3ea5aad..3e84817 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -45,7 +45,7 @@ OPTIONS
 	them.  This used to be optional but now it is the default.
 +
 Note that the patch is always used as-is without charset
-conversion, even with this flag.
+conversion, even with this flag; use '--recode-patch' for that.
 
 --encoding=<encoding>::
 	Similar to -u.  But when re-coding, the charset specified here is
@@ -54,6 +54,10 @@ conversion, even with this flag.
 -n::
 	Disable all charset re-coding of the metadata.
 
+--recode-patch::
+	Convert the patch from the e-mail to UTF-8 (or the value of the
+	configuration variable i18n.patchencoding if it is set).
+
 --scissors::
 	Remove everything in body before a scissors line.  A line that
 	mainly consists of scissors (either ">8" or "8<") and perforation
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 1406d9f..96181e6 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -12,6 +12,8 @@ static FILE *cmitmsg, *patchfile, *fin, *fout;
 static int keep_subject;
 static int keep_non_patch_brackets_in_subject;
 static const char *metainfo_charset;
+static const char *patch_charset;
+static int recode_patch;
 static struct strbuf line = STRBUF_INIT;
 static struct strbuf name = STRBUF_INIT;
 static struct strbuf email = STRBUF_INIT;
@@ -828,8 +830,10 @@ static int handle_commit_msg(struct strbuf *line)
 	return 0;
 }
 
-static void handle_patch(const struct strbuf *line)
+static void handle_patch(struct strbuf *line)
 {
+	if (recode_patch)
+		convert_to_utf8(line, charset.buf, patch_charset);
 	fwrite(line->buf, 1, line->len, patchfile);
 	patch_lines++;
 }
@@ -1021,7 +1025,7 @@ static int git_mailinfo_config(const char *var, const char *value, void *unused)
 }
 
 static const char mailinfo_usage[] =
-	"git mailinfo [-k|-b] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] msg patch < mail >info";
+	"git mailinfo [-k|-b] [-u | --encoding=<encoding> | -n] [--recode-patch] [--scissors | --no-scissors] msg patch < mail >info";
 
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
@@ -1034,6 +1038,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 
 	def_charset = (git_commit_encoding ? git_commit_encoding : "UTF-8");
 	metainfo_charset = def_charset;
+	patch_charset = git_patch_encoding ? git_patch_encoding : "UTF-8";
 
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "-k"))
@@ -1046,6 +1051,8 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 			metainfo_charset = NULL;
 		else if (!prefixcmp(argv[1], "--encoding="))
 			metainfo_charset = argv[1] + 11;
+		else if (!prefixcmp(argv[1], "--recode-patch"))
+			recode_patch = 1;
 		else if (!strcmp(argv[1], "--scissors"))
 			use_scissors = 1;
 		else if (!strcmp(argv[1], "--no-scissors"))
-- 
1.7.3.2.344.gb3680.dirty
