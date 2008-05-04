From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCHv4 3/4] commit: Show committer if automatic
Date: Sun,  4 May 2008 18:04:51 +0200
Message-ID: <1209917092-12146-4-git-send-email-sbejar@gmail.com>
References: <1209917092-12146-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 18:06:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsgjG-0007JP-KI
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 18:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbYEDQFZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2008 12:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbYEDQFZ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 12:05:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:56874 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbYEDQFX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 12:05:23 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1618419fgg.17
        for <git@vger.kernel.org>; Sun, 04 May 2008 09:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=dPn949rzIUK8fpf3FkEEMRTZyco2f6N019+RR0LHLRE=;
        b=ViKXi8f5d2WHND946WFzU9miWFex3WBCdj7E3T37Lw5kl6U3XngtrwFRDLX4ZK7pauz/bhf/XPkShXLC6jlA5PFoAZse+Ow6LpQFJym2RVJe4M+mDhYonDwNAUciWiBJvza00s+NLQ7gIGxm9vfLkodE+RQtrloGKjeZgWM4TzM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=ga7gQ21b/hvtV6BoEHx05Cij7xY9/QbNVaok7/2Rrs7QSoNkTMxoiPGmZZTvsFJ0jC3LDeqQpGhD8KVGySeagsMPYgh34ANk/VbmeP8en7E+DdaiSww6LWWhANqTXHDws55YdJ9fMbHZfwpTE8kTmoaaKfynW9al9Az9HoT+Z6w=
Received: by 10.86.78.4 with SMTP id a4mr7858007fgb.73.1209917122762;
        Sun, 04 May 2008 09:05:22 -0700 (PDT)
Received: from localhost ( [91.13.106.248])
        by mx.google.com with ESMTPS id e11sm4223026fga.1.2008.05.04.09.05.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 May 2008 09:05:21 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.224.gadb29
In-Reply-To: <1209917092-12146-1-git-send-email-sbejar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81181>

To warn the user in case he/she might be using an unintended
committer identity.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 builtin-commit.c  |   19 ++++++++++++++++---
 cache.h           |    1 +
 config.c          |    4 ++++
 environment.c     |    1 +
 ident.c           |    3 +++
 t/t7502-commit.sh |   15 +++++++++++++++
 6 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index d03b6b2..353f9c7 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -448,6 +448,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix)
 	const char *hook_arg2 =3D NULL;
 	const char *author_ident;
 	const char *committer_ident;
+	int showed_ident =3D 0;
=20
 	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
 		return 0;
@@ -528,6 +529,8 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix)
 	strbuf_release(&sb);
=20
 	determine_author_info();
+	/* To know if the committer ident is automatic */
+	git_committer_info(0);
=20
 	if (use_editor) {
 		if (in_merge)
@@ -558,11 +561,21 @@ static int prepare_to_commit(const char *index_fi=
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
 				author_ident);
=20
+		if (!user_explicit)
+			fprintf(fp,
+				"%s"
+				"# Committer: %s\n",
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
index 0b1db40..018060c 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -166,6 +166,21 @@ test_expect_success 'author different from committ=
er' '
 	test_cmp expect actual
 '
=20
+sed -i '$d' expect
+echo "# Committer:
+#" >> expect
+unset GIT_COMMITTER_EMAIL
+unset GIT_COMMITTER_NAME
+
+test_expect_success 'committer is automatic' '
+
+	echo >>negative &&
+	git commit -e -m "sample"
+	head -n 8 .git/COMMIT_EDITMSG |	\
+	sed "s/^# Committer: .*/# Committer:/" >actual &&
+	test_cmp expect actual
+'
+
 pwd=3D`pwd`
 cat >> .git/FAKE_EDITOR << EOF
 #! /bin/sh
--=20
1.5.5.1.224.gadb29
