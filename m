From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2] Introduce new configuation option to override committer information
Date: Sun,  9 Jan 2011 15:59:49 +0530
Message-ID: <1294568989-5848-1-git-send-email-artagnon@gmail.com>
References: <igadki$4tb$2@dough.gmane.org>
Cc: Stephen Kelly <steveire@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 09 11:29:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbsWf-0005Q8-M4
	for gcvg-git-2@lo.gmane.org; Sun, 09 Jan 2011 11:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297Ab1AIK3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jan 2011 05:29:24 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41207 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab1AIK3X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jan 2011 05:29:23 -0500
Received: by iyj18 with SMTP id 18so96538iyj.19
        for <git@vger.kernel.org>; Sun, 09 Jan 2011 02:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ljob+TUXC8dgqlWpJrLRcysGgcsUtLoUdgMrqIDsOE0=;
        b=HsVI6Vj9YVL9K8C1sDL16AhctO7XOHMouMlMIkg3ym0AxL14Mi+IUwPPTthHSWYeO5
         4JlVjiMcRM3sDeInM1tXrQuWknd7gmo9utmZPLLgrRz6T4DfZnA6EUP8qNgszg4XJ4Ua
         n+Ql9ikf7wZuapMz19svbQtcpVe7YxKOyC6QM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OCy03UmnnO4dHHtf8WXWP9VOy53kOmMJDmJS67CT1RT7E9dmsJjcoMzMWiLPDepmf/
         DcqdtrhBVlzB8YkzpwekNIkdm2jL2PnH7tFXJmJD6Fu2xYtzevDp9/7TgR9FhLi5DOi7
         8EZB/H9y81eCDB6W/Amy9BRA/U440vlJJjfVs=
Received: by 10.42.178.133 with SMTP id bm5mr2596022icb.423.1294568962433;
        Sun, 09 Jan 2011 02:29:22 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id y8sm2541780ica.14.2011.01.09.02.29.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 Jan 2011 02:29:20 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.529.gc7bce.dirty
In-Reply-To: <igadki$4tb$2@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164847>

Currently, there is no way to set committer information on a
per-repository basis. The 'user.name' and 'user.email' configuration
options set both author and committer information. To solve this,
introduce 'user.committername' and 'user.committeremail' configuration
options to override committer name and email respectively.

Reported-by: Stephen Kelly <steveire@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Differences since v1: just rebased. Applies cleanly to master now.
 Stephen: Please do not cull CC.

 Documentation/config.txt |   29 +++++++++++++++++++++++------
 builtin/blame.c          |    2 +-
 builtin/commit.c         |    2 +-
 cache.h                  |    4 +++-
 config.c                 |   15 +++++++++++++++
 environment.c            |    2 ++
 ident.c                  |   18 ++++++++++++------
 7 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ff7c225..0b89cb6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1866,14 +1866,31 @@ url.<base>.pushInsteadOf::
 	setting for that remote.
 
 user.email::
-	Your email address to be recorded in any newly created commits.
-	Can be overridden by the 'GIT_AUTHOR_EMAIL', 'GIT_COMMITTER_EMAIL', and
-	'EMAIL' environment variables.  See linkgit:git-commit-tree[1].
+	The email address to be recorded in any newly created commits.
+	Sets both author and committer email.  To override only
+	committer email, use 'user.committeremail'.  Can be overridden
+	by the 'GIT_AUTHOR_EMAIL', 'GIT_COMMITTER_EMAIL', and 'EMAIL'
+	environment variables.  See linkgit:git-commit-tree[1].
 
 user.name::
-	Your full name to be recorded in any newly created commits.
-	Can be overridden by the 'GIT_AUTHOR_NAME' and 'GIT_COMMITTER_NAME'
-	environment variables.  See linkgit:git-commit-tree[1].
+	The full name to be recorded in any newly created commits.
+	Sets both author and committer name.  To override only
+	committer name, use 'user.committername'.  Can be overridden
+	by the 'GIT_AUTHOR_NAME' and 'GIT_COMMITTER_NAME' environment
+	variables.  See linkgit:git-commit-tree[1].
+
+user.committeremail::
+	The email address of the committer to use while recording
+	newly created commits.  Used to override committer email
+	specified in 'user.email'.  Can be overridden by the
+	'GIT_COMMITTER_EMAIL', and 'EMAIL' environment variables.  See
+	linkgit:git-commit-tree[1].
+
+user.committername::
+	The full name of the committer to use while recording newly
+	created commits.  Used to override committer name specified in
+	'user.name'.  Can be overridden by the 'GIT_COMMITTER_NAME'
+	environment variable.  See linkgit:git-commit-tree[1].
 
 user.signingkey::
 	If linkgit:git-tag[1] is not selecting the key you want it to
diff --git a/builtin/blame.c b/builtin/blame.c
index aa30ec5..7fc4d56 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2161,7 +2161,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	cache_tree_invalidate_path(active_cache_tree, path);
 
 	commit->buffer = xmalloc(400);
-	ident = fmt_ident("Not Committed Yet", "not.committed.yet", NULL, 0);
+	ident = fmt_ident("Not Committed Yet", "not.committed.yet", NULL, 0, 0);
 	snprintf(commit->buffer, 400,
 		"tree 0000000000000000000000000000000000000000\n"
 		"parent %s\n"
diff --git a/builtin/commit.c b/builtin/commit.c
index 22ba54f..4d0dcac 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -505,7 +505,7 @@ static void determine_author_info(struct strbuf *author_ident)
 
 	if (force_date)
 		date = force_date;
-	strbuf_addstr(author_ident, fmt_ident(name, email, date,
+	strbuf_addstr(author_ident, fmt_ident(name, email, date, 0,
 					      IDENT_ERROR_ON_NO_NAME));
 }
 
diff --git a/cache.h b/cache.h
index d83d68c..bf22df6 100644
--- a/cache.h
+++ b/cache.h
@@ -834,7 +834,7 @@ enum date_mode parse_date_format(const char *format);
 #define IDENT_NO_DATE	       4
 extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
-extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
+extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int, int);
 extern const char *fmt_name(const char *name, const char *email);
 extern const char *git_editor(void);
 extern const char *git_pager(int stdout_is_tty);
@@ -1013,6 +1013,8 @@ extern const char *config_exclusive_filename;
 #define MAX_GITNAME (1000)
 extern char git_default_email[MAX_GITNAME];
 extern char git_default_name[MAX_GITNAME];
+extern char git_default_committeremail[MAX_GITNAME];
+extern char git_default_committername[MAX_GITNAME];
 #define IDENT_NAME_GIVEN 01
 #define IDENT_MAIL_GIVEN 02
 #define IDENT_ALL_GIVEN (IDENT_NAME_GIVEN|IDENT_MAIL_GIVEN)
diff --git a/config.c b/config.c
index 625e051..3032522 100644
--- a/config.c
+++ b/config.c
@@ -682,6 +682,21 @@ static int git_default_user_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "user.committername")) {
+		if (!value)
+			return config_error_nonbool(var);
+		strlcpy(git_default_committername, value,
+			sizeof(git_default_committername));
+		return 0;
+	}
+
+	if (!strcmp(var, "user.committeremail")) {
+		if (!value)
+			return config_error_nonbool(var);
+		strlcpy(git_default_committeremail, value,
+			sizeof(git_default_committeremail));
+		return 0;
+	}
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 9564475..641d6ca 100644
--- a/environment.c
+++ b/environment.c
@@ -11,6 +11,8 @@
 
 char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
+char git_default_committeremail[MAX_GITNAME];
+char git_default_committername[MAX_GITNAME];
 int user_ident_explicitly_given;
 int trust_executable_bit = 1;
 int trust_ctime = 1;
diff --git a/ident.c b/ident.c
index 1c4adb0..1a616b7 100644
--- a/ident.c
+++ b/ident.c
@@ -183,7 +183,7 @@ static const char *env_hint =
 "\n";
 
 const char *fmt_ident(const char *name, const char *email,
-		      const char *date_str, int flag)
+		const char *date_str, int committer_info, int flag)
 {
 	static char buffer[1000];
 	char date[50];
@@ -193,9 +193,15 @@ const char *fmt_ident(const char *name, const char *email,
 	int name_addr_only = (flag & IDENT_NO_DATE);
 
 	setup_ident();
-	if (!name)
+	if (committer_info) {
+		if (!name)
+			name = git_default_committername;
+		if (!email)
+			email = git_default_committeremail;
+	}
+	if (!name || !*name)
 		name = git_default_name;
-	if (!email)
+	if (!email || !*email)
 		email = git_default_email;
 
 	if (!*name) {
@@ -239,7 +245,7 @@ const char *fmt_ident(const char *name, const char *email,
 
 const char *fmt_name(const char *name, const char *email)
 {
-	return fmt_ident(name, email, NULL, IDENT_ERROR_ON_NO_NAME | IDENT_NO_DATE);
+	return fmt_ident(name, email, NULL, 0, IDENT_ERROR_ON_NO_NAME | IDENT_NO_DATE);
 }
 
 const char *git_author_info(int flag)
@@ -247,7 +253,7 @@ const char *git_author_info(int flag)
 	return fmt_ident(getenv("GIT_AUTHOR_NAME"),
 			 getenv("GIT_AUTHOR_EMAIL"),
 			 getenv("GIT_AUTHOR_DATE"),
-			 flag);
+			 0, flag);
 }
 
 const char *git_committer_info(int flag)
@@ -259,7 +265,7 @@ const char *git_committer_info(int flag)
 	return fmt_ident(getenv("GIT_COMMITTER_NAME"),
 			 getenv("GIT_COMMITTER_EMAIL"),
 			 getenv("GIT_COMMITTER_DATE"),
-			 flag);
+			 1, flag);
 }
 
 int user_ident_sufficiently_given(void)
-- 
1.7.2.2.409.gdbb11.dirty
