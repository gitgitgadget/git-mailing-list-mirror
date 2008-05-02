From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 1/2] commit: Show committer if automatic
Date: Fri,  2 May 2008 20:22:20 +0200
Message-ID: <1209752541-19111-2-git-send-email-sbejar@gmail.com>
References: <1209752541-19111-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 20:23:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrzur-0006o7-2N
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 20:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbYEBSWo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2008 14:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765680AbYEBSWn
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 14:22:43 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:52932 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765487AbYEBSWm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 14:22:42 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1229443fkq.5
        for <git@vger.kernel.org>; Fri, 02 May 2008 11:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=Y0a89D09ex+BWa6u0W1NxHGT6GidcH+Hf0qQMXCW+UE=;
        b=pKjlXENMbJVBwwO1H/kJECoIIMuDbW9DzSuJ31rTvW8vdPNbrQ4dhcRbYDvNmo0n3amH5st2rQnS1wdS0iSN1xG6uIzDJpDvyftfq7WrWa7R6kGxCvd9Pgx5P+x3ZHIzySErXPyi3nTbXsry5hqk24HMKTKPgUS6hhHBaiIQaRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=KCAaOZn5oGIq3Klqa3vxED0EZzfQia0FJ10s/6AM44dacorN1RKZeuNy6dWH12I4VDOccuFrL30BW+NMlXf2lWE0tWSfZQ8+W/uqB7rwu/aWG8Ly9PjHQAbQ9Q0glB/R8oMQQUOVN62gKvWz9NG8OTSpg0oydEbj6YX+JNk4Kq8=
Received: by 10.86.3.4 with SMTP id 4mr3819210fgc.50.1209752559845;
        Fri, 02 May 2008 11:22:39 -0700 (PDT)
Received: from localhost ( [91.13.90.240])
        by mx.google.com with ESMTPS id s10sm5625730muh.10.2008.05.02.11.22.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 May 2008 11:22:38 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.223.g2532
In-Reply-To: <1209752541-19111-1-git-send-email-sbejar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81017>

To remind the committer ident in case it is not what you want
(taken from the gecos field, want to use different ident in
different repositories).

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 builtin-commit.c  |   40 +++++++++++++++++++++++++++++++++++++---
 cache.h           |    1 +
 config.c          |    4 ++++
 environment.c     |    1 +
 ident.c           |    3 +++
 t/t7502-commit.sh |   13 +++++++++++++
 6 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 057749b..b7cc382 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -437,6 +437,29 @@ static void determine_author_info()
 	author_date =3D date;
 }
=20
+const char *get_parent_ident()
+{
+	unsigned char sha1[20];
+	struct commit *commit;
+	const char *a, *lb, *rb, *eol;
+
+
+	get_sha1("HEAD", sha1);
+	commit =3D lookup_commit_reference(sha1);
+	if (!commit)
+		return NULL;
+
+	a =3D strstr(commit->buffer, "\ncommitter ");
+
+	lb =3D strstr(a + 11, " <");
+	rb =3D strstr(a + 11, "> ");
+	eol =3D strchr(a + 11, '\n');
+	if (!lb || !rb || !eol)
+		return NULL;
+
+	return xstrndup(a + 11, rb + 1 - (a + 11));
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefi=
x)
 {
 	struct stat statbuf;
@@ -448,6 +471,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix)
 	const char *hook_arg2 =3D NULL;
 	const char *author_ident;
 	const char *committer_ident;
+	int showed_ident =3D 0;
=20
 	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
 		return 0;
@@ -528,6 +552,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix)
 	strbuf_release(&sb);
=20
 	determine_author_info();
+	git_committer_info(0);
=20
 	if (use_editor) {
 		if (in_merge)
@@ -558,11 +583,20 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix)
 					 getenv("GIT_COMMITTER_EMAIL")));
 		if (strcmp(author_ident, committer_ident))
 			fprintf(fp,
-				"#\n"
-				"# Author:    %s\n"
-				"#\n",
+				"%s"
+				"# Author:    %s\n",
+				showed_ident++ ? "" : "#\n",
 				fmt_name(author_name, author_email));
=20
+		if (!user_explicit)
+			fprintf(fp,
+				"%s# Committer: %s\n",
+				showed_ident++ ? "" : "#\n",
+				committer_ident);
+
+		if (showed_ident)
+			fprintf(fp, "#\n");
+
 		saved_color_setting =3D wt_status_use_color;
 		wt_status_use_color =3D 0;
 		commitable =3D run_status(fp, index_file, prefix, 1);
diff --git a/cache.h b/cache.h
index 5a28ddd..e8b26cf 100644
--- a/cache.h
+++ b/cache.h
@@ -718,6 +718,7 @@ extern int config_error_nonbool(const char *);
 #define MAX_GITNAME (1000)
 extern char git_default_email[MAX_GITNAME];
 extern char git_default_name[MAX_GITNAME];
+extern int user_explicit;
=20
 extern const char *git_commit_encoding;
 extern const char *git_log_output_encoding;
diff --git a/config.c b/config.c
index b0ada51..e49804a 100644
--- a/config.c
+++ b/config.c
@@ -443,6 +443,8 @@ int git_default_config(const char *var, const char =
*value)
 		if (!value)
 			return config_error_nonbool(var);
 		strlcpy(git_default_name, value, sizeof(git_default_name));
+		if (git_default_email[0])
+			user_explicit =3D 1;
 		return 0;
 	}
=20
@@ -450,6 +452,8 @@ int git_default_config(const char *var, const char =
*value)
 		if (!value)
 			return config_error_nonbool(var);
 		strlcpy(git_default_email, value, sizeof(git_default_email));
+		if (git_default_name[0])
+			user_explicit =3D 1;
 		return 0;
 	}
=20
diff --git a/environment.c b/environment.c
index 6739a3f..b941971 100644
--- a/environment.c
+++ b/environment.c
@@ -11,6 +11,7 @@
=20
 char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
+int user_explicit =3D 0;
 int trust_executable_bit =3D 1;
 int quote_path_fully =3D 1;
 int has_symlinks =3D 1;
diff --git a/ident.c b/ident.c
index ed44a53..67ccbf3 100644
--- a/ident.c
+++ b/ident.c
@@ -250,6 +250,9 @@ const char *git_author_info(int flag)
=20
 const char *git_committer_info(int flag)
 {
+	if (getenv("GIT_COMMITTER_NAME") &&
+	    getenv("GIT_COMMITTER_EMAIL"))
+		user_explicit =3D 1;
 	return fmt_ident(getenv("GIT_COMMITTER_NAME"),
 			 getenv("GIT_COMMITTER_EMAIL"),
 			 getenv("GIT_COMMITTER_DATE"),
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 11de910..8f65c39 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -165,6 +165,19 @@ test_expect_success 'author different from committ=
er' '
 	test_cmp expect actual
 '
=20
+echo "# Committer:" >> expect
+unset GIT_COMMITTER_EMAIL
+unset GIT_COMMITTER_NAME
+
+test_expect_success 'committer is automatic' '
+
+	echo >>negative &&
+	git commit -e -m "sample"
+	head -n 7 .git/COMMIT_EDITMSG |	\
+	sed "s/^# Committer: .*/# Committer:/" >actual &&
+	test_cmp expect actual
+'
+
 pwd=3D`pwd`
 cat >> .git/FAKE_EDITOR << EOF
 #! /bin/sh
--=20
1.5.5.1.223.g2532
