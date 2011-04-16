From: "ZHANG, Le" <r0bertz@gentoo.org>
Subject: [PATCH 2/2] i18n.repositoryencoding: a new variable specifying the encoding of blobs in the repository
Date: Sat, 16 Apr 2011 13:50:04 -0700
Message-ID: <1302987004-28134-1-git-send-email-r0bertz@gentoo.org>
Cc: "ZHANG, Le" <r0bertz@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 22:50:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBCRm-000848-9R
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 22:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525Ab1DPUuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 16:50:22 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63751 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262Ab1DPUuV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 16:50:21 -0400
Received: by pwi15 with SMTP id 15so1599185pwi.19
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 13:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer;
        bh=coHRpnelYNDZNeyKnKKmtQQVjlSkXSwrKQXNwq3nGzs=;
        b=BeFVCGSuIvwTgeFH/XqDQthdrTVkmtvOjFSgFAE6a4q6DctyDbCvXKCWfTWErLMuaF
         qFKECEm6f4NKWhBtu/q9p16vdCEqWUkMNq3ONAuP7LO0u0Qy/DLaPrtOTjkywEB+dLkc
         JyIs23vWRLT4LKqAPjneYCgyR6PCL02/Omdx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=c5p5CNZEqKXVX+NATLSN/HbhmuVVSI+iNNmluLJyvd3Z6G0VCZTvKh4MvR1M30w0Jx
         6ayFELjdVJSXmk8RYA4lhOxuTOd1ez8MOayfSFATrRt4LXRZ6rvXdTmP19OnMJIgE/Bv
         9KznM7lMU0zPe3Zw9uzWs3kNX9XVxFfsxPsZY=
Received: by 10.68.39.137 with SMTP id p9mr3803023pbk.145.1302987020560;
        Sat, 16 Apr 2011 13:50:20 -0700 (PDT)
Received: from localhost (c-67-180-129-150.hsd1.ca.comcast.net [67.180.129.150])
        by mx.google.com with ESMTPS id m10sm1131495pbn.97.2011.04.16.13.50.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Apr 2011 13:50:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc2.5.gb2ee76.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171694>

When not set it defaults to 'verbatim', nothing will be done.
When set, the encoding of the blobs in repository will be converted to it.
The original encoding is get from mail header.

Signed-off-by: ZHANG, Le <r0bertz@gentoo.org>
---
 Documentation/git-mailinfo.txt |    2 +-
 builtin/mailinfo.c             |    6 +++++-
 cache.h                        |    2 ++
 config.c                       |    3 +++
 environment.c                  |    6 ++++++
 5 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index ed45662..cbdd9bb 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -45,7 +45,7 @@ OPTIONS
 	them.  This used to be optional but now it is the default.
 +
 Note that the patch is always used as-is without charset
-conversion, even with this flag.
+conversion, even with this flag; use 'i18n.repositoryencoding' for that.
 
 --encoding=<encoding>::
 	Similar to -u.  But when re-coding, the charset specified here is
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 0f42ff1..51d950b 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -12,6 +12,7 @@ static FILE *cmitmsg, *patchfile, *fin, *fout;
 static int keep_subject;
 static int keep_non_patch_brackets_in_subject;
 static const char *metainfo_charset;
+static const char *repository_charset;
 static struct strbuf line = STRBUF_INIT;
 static struct strbuf name = STRBUF_INIT;
 static struct strbuf email = STRBUF_INIT;
@@ -824,8 +825,10 @@ static int handle_commit_msg(struct strbuf *line)
 	return 0;
 }
 
-static void handle_patch(const struct strbuf *line)
+static void handle_patch(struct strbuf *line)
 {
+	if (strcasecmp(repository_charset, "verbatim"))
+		convert_to(line, repository_charset, charset.buf);
 	fwrite(line->buf, 1, line->len, patchfile);
 	patch_lines++;
 }
@@ -1030,6 +1033,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 
 	def_charset = get_commit_output_encoding();
 	metainfo_charset = def_charset;
+	repository_charset = get_repository_encoding();
 
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "-k"))
diff --git a/cache.h b/cache.h
index 2674f4c..ebc3a92 100644
--- a/cache.h
+++ b/cache.h
@@ -1029,6 +1029,7 @@ extern int git_config_system(void);
 extern int config_error_nonbool(const char *);
 extern const char *get_log_output_encoding(void);
 extern const char *get_commit_output_encoding(void);
+extern const char *get_repository_encoding(void);
 
 extern const char *config_exclusive_filename;
 
@@ -1042,6 +1043,7 @@ extern int user_ident_explicitly_given;
 extern int user_ident_sufficiently_given(void);
 
 extern const char *git_commit_encoding;
+extern const char *git_repository_encoding;
 extern const char *git_log_output_encoding;
 extern const char *git_mailmap_file;
 
diff --git a/config.c b/config.c
index 0abcada..35cc09a 100644
--- a/config.c
+++ b/config.c
@@ -691,6 +691,9 @@ static int git_default_i18n_config(const char *var, const char *value)
 	if (!strcmp(var, "i18n.commitencoding"))
 		return git_config_string(&git_commit_encoding, var, value);
 
+	if (!strcmp(var, "i18n.repositoryencoding"))
+		return git_config_string(&git_repository_encoding, var, value);
+
 	if (!strcmp(var, "i18n.logoutputencoding"))
 		return git_config_string(&git_log_output_encoding, var, value);
 
diff --git a/environment.c b/environment.c
index f4549d3..135fdfc 100644
--- a/environment.c
+++ b/environment.c
@@ -24,6 +24,7 @@ int log_all_ref_updates = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
 int repository_format_version;
 const char *git_commit_encoding;
+const char *git_repository_encoding;
 const char *git_log_output_encoding;
 int shared_repository = PERM_UMASK;
 const char *apply_default_whitespace;
@@ -232,3 +233,8 @@ const char *get_commit_output_encoding(void)
 {
 	return git_commit_encoding ? git_commit_encoding : "UTF-8";
 }
+
+const char *get_repository_encoding(void)
+{
+    return git_repository_encoding ? git_repository_encoding : "verbatim";
+}
-- 
1.7.5.rc2.5.gb2ee76.dirty
