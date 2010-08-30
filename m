From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/3] don't write to git_log_output_encoding outside git_config()
Date: Tue, 31 Aug 2010 01:15:22 +0200
Message-ID: <1283210123-19752-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqhbibbthi.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 31 01:15:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqDZu-0007oP-9R
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 01:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809Ab0H3XPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 19:15:44 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46458 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749Ab0H3XPo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 19:15:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o7UNC70l010667
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 31 Aug 2010 01:12:07 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OqDZg-000224-KM; Tue, 31 Aug 2010 01:15:36 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OqDZg-0007gb-J6; Tue, 31 Aug 2010 01:15:36 +0200
X-Mailer: git-send-email 1.7.2.2.175.ga619d.dirty
In-Reply-To: <vpqhbibbthi.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 31 Aug 2010 01:12:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7UNC70l010667
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1283814731.80953@xERCiHTMuFnLm5M02KnZzQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154869>

The log encoding can be given by the user either with --encoding=foo or
with i18n.logoutputencoding. The code dealing with this used to write to
git_log_output_encoding in both places, making sure that --encoding=foo
is dealt with after reading the configuration file.

This is a very fragile mechanism, since any further call to
git_config(git_default_config, ...) the value given on the command line.

Instead, keep the config value and the cli value, and decide which one to
take at read time (in the straightforward accessor
get_git_log_output_encoding()).

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
So, this isn't strictly necessary since the new version of the patch
implementing the gitattributes file doesn't read the full config
anymore, but I think that makes the code more robust.

 builtin/log.c |    4 ++--
 cache.h       |   18 ++++++++++++++++++
 environment.c |    4 +++-
 pretty.c      |    4 ++--
 revision.c    |    4 ++--
 5 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index eaa1ee0..f30a6ba 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -329,8 +329,8 @@ static void show_tagger(char *buf, int len, struct rev_info *rev)
 	struct strbuf out = STRBUF_INIT;
 
 	pp_user_info("Tagger", rev->commit_format, &out, buf, rev->date_mode,
-		git_log_output_encoding ?
-		git_log_output_encoding: git_commit_encoding);
+		get_git_log_output_encoding() ?
+		get_git_log_output_encoding(): git_commit_encoding);
 	printf("%s", out.buf);
 	strbuf_release(&out);
 }
diff --git a/cache.h b/cache.h
index eb77e1d..7e10a39 100644
--- a/cache.h
+++ b/cache.h
@@ -1005,7 +1005,25 @@ extern int user_ident_explicitly_given;
 extern int user_ident_sufficiently_given(void);
 
 extern const char *git_commit_encoding;
+
+/* Value found in config file */
 extern const char *git_log_output_encoding;
+
+/* Value given in command line with --encoding */
+extern const char *git_log_output_encoding_cli;
+
+/* 
+ * Prioritize the value given by the command-line over the value found
+ * in the config file.
+ */
+static inline
+const char *get_git_log_output_encoding()
+{
+	return git_log_output_encoding_cli ?
+		git_log_output_encoding_cli :
+		git_log_output_encoding;
+}
+
 extern const char *git_mailmap_file;
 
 /* IO helper functions */
diff --git a/environment.c b/environment.c
index 83d38d3..212f086 100644
--- a/environment.c
+++ b/environment.c
@@ -23,7 +23,9 @@ int log_all_ref_updates = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
 int repository_format_version;
 const char *git_commit_encoding;
-const char *git_log_output_encoding;
+const char *git_log_output_encoding = NULL;
+const char *git_log_output_encoding_cli = NULL;
+
 int shared_repository = PERM_UMASK;
 const char *apply_default_whitespace;
 const char *apply_default_ignorewhitespace;
diff --git a/pretty.c b/pretty.c
index f85444b..4187a50 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1159,8 +1159,8 @@ char *reencode_commit_message(const struct commit *commit, const char **encoding
 {
 	const char *encoding;
 
-	encoding = (git_log_output_encoding
-		    ? git_log_output_encoding
+	encoding = (get_git_log_output_encoding()
+		    ? get_git_log_output_encoding()
 		    : git_commit_encoding);
 	if (!encoding)
 		encoding = "UTF-8";
diff --git a/revision.c b/revision.c
index b1c1890..791c757 100644
--- a/revision.c
+++ b/revision.c
@@ -1402,9 +1402,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->grep_filter.all_match = 1;
 	} else if ((argcount = parse_long_opt("encoding", argv, &optarg))) {
 		if (strcmp(optarg, "none"))
-			git_log_output_encoding = xstrdup(optarg);
+			git_log_output_encoding_cli = xstrdup(optarg);
 		else
-			git_log_output_encoding = "";
+			git_log_output_encoding_cli = "";
 		return argcount;
 	} else if (!strcmp(arg, "--reverse")) {
 		revs->reverse ^= 1;
-- 
1.7.2.2.175.ga619d.dirty
