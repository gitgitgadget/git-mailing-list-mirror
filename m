From: Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH v2 1/2] add --recode-patch option to git-mailinfo
Date: Mon, 14 Jun 2010 02:50:39 +0800
Message-ID: <1276455040-14726-1-git-send-email-r0bertz@gentoo.org>
Cc: Zhang Le <r0bertz@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 13 20:51:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONsHM-0007fp-Dx
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 20:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668Ab0FMSvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 14:51:11 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50400 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306Ab0FMSvK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 14:51:10 -0400
Received: by pwi1 with SMTP id 1so2217281pwi.19
        for <git@vger.kernel.org>; Sun, 13 Jun 2010 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=DNRkwQp5KqRzhst9IxzkUXfxqPiHSm7Y2Q/cq5NeUoc=;
        b=P/6UKtLPiu0oPTtaHEtuFwBDXzQl5GXYfBlazBqJ66WMwSX80NeHHUmouqmTGsGI2M
         vWdUCAWWSpZnOt2dNdaByw1PUNvna1eR6Ok4tQmmrUll698kp9fkhTgddQ/h2iUhk+nD
         hcxgDPKmyuUjqRQ4g+GzY54Jx6jf/TBIJ3/vs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=mOFBl2Qs/8dsF7gHJobALaacJpfqJJ8dz7tALhfhm19CSJ3yj+8eUpCtV8iwMDAeXz
         5R8ZgAotyHu1zsM3QLrU2uwBEmcl7jIY3z7TXJOYdlonTKCFh8JSAOiy9TFOjO7y5mR7
         NVld0wyEGCEEDH+PXlKEG9tevJuHasEnJnOnY=
Received: by 10.142.202.4 with SMTP id z4mr3339685wff.294.1276455069407;
        Sun, 13 Jun 2010 11:51:09 -0700 (PDT)
Received: from localhost ([121.34.28.151])
        by mx.google.com with ESMTPS id c22sm44612733wam.6.2010.06.13.11.51.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Jun 2010 11:51:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149058>

I have a translation project which uses UTF-8 as charset.
So the patch must be encoded in UTF-8, not just the commit msg etc.
And we use google group as our mailing list.

Recently, mails saved from gmail are encoded using local charset based on
google group's setting. This seems smart but it caused inconvinience for
our project.

Since we can't no control on what google will do, so I took another way,
i.e. add this option to git-mailinfo. I hope this could benefit others as
well.

Signed-off-by: Zhang Le <r0bertz@gentoo.org>
---
 Documentation/git-mailinfo.txt |    6 +++++-
 builtin/mailinfo.c             |    8 +++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 3ea5aad..24d5bd7 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -45,7 +45,7 @@ OPTIONS
 	them.  This used to be optional but now it is the default.
 +
 Note that the patch is always used as-is without charset
-conversion, even with this flag.
+conversion, even with this flag.  Unless --recode-patch is used.
 
 --encoding=<encoding>::
 	Similar to -u.  But when re-coding, the charset specified here is
@@ -54,6 +54,10 @@ conversion, even with this flag.
 -n::
 	Disable all charset re-coding of the metadata.
 
+--recode-patch::
+	Similar to -u.  But what is re-coded is the patch instead of the
+	metainfo.  The default is off.
+
 --scissors::
 	Remove everything in body before a scissors line.  A line that
 	mainly consists of scissors (either ">8" or "8<") and perforation
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
-- 
1.7.1
