From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCHv2 3/3] commit: Show committer if different from the parent and automatic
Date: Thu,  1 May 2008 14:09:35 +0200
Message-ID: <1209643775-2362-4-git-send-email-sbejar@gmail.com>
References: <1209643775-2362-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 14:11:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrXd3-0004vn-0R
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 14:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757309AbYEAMKX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 May 2008 08:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757288AbYEAMKW
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 08:10:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:1094 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757275AbYEAMKU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 08:10:20 -0400
Received: by fg-out-1718.google.com with SMTP id 19so526390fgg.17
        for <git@vger.kernel.org>; Thu, 01 May 2008 05:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=2+Xt8WoW9ujpBPIxOavSSVZfaHlWZ0vpXvfRAojk0eY=;
        b=b6DbS52+NcLIWJscVaacTal0j+LMoVzYmcskiaAPmJGCbMTmvY5IeOR/aIQkMXLi811AcV6WpBLEahAlQj7ZfXzLrb2NiuQGxXtasi5f4pajNz5Dgu4F/j0xraz+HhbW1aUi2HTTgEgCsGGFs+pRyf+kbCEzNW+KFJ7v/ctiFPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=SOSldmVMEBKfvTxD/3Ve7ixVRkx1KHXSpLXS57LTIQS9s4KMphzCHwcEoGTkAg5g+7ApMtp8YO0yUEPeADSVv8sziR6VxEhOtCC1Z8odAJrxNZ5j/wcVvx6lIIWnd9FuL/tbSoYlgOk1mbBnfwawiyBWro/nZKx67JvWjwK633I=
Received: by 10.86.94.11 with SMTP id r11mr2887327fgb.0.1209643819736;
        Thu, 01 May 2008 05:10:19 -0700 (PDT)
Received: from localhost ( [91.13.119.190])
        by mx.google.com with ESMTPS id y37sm3247403mug.9.2008.05.01.05.10.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 May 2008 05:10:18 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.102.gfcc7d.dirty
In-Reply-To: <1209643775-2362-1-git-send-email-sbejar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80904>

To remind the committer ident in case it is not what you want
(taken from the gecos field, want to use different ident in
different repositories).

[sb: thanks to Jeff King for the enhancement and fix to this patch]

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 builtin-commit.c  |   42 +++++++++++++++++++++++++++++++++++++++---
 cache.h           |    1 +
 config.c          |    4 ++++
 environment.c     |    1 +
 t/t7502-commit.sh |   12 ++++++++++++
 5 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 057749b..3501ba7 100644
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
@@ -448,6 +471,8 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix)
 	const char *hook_arg2 =3D NULL;
 	const char *author_ident;
 	const char *committer_ident;
+	const char *parent_ident;
+	int showed_ident =3D 0;
=20
 	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
 		return 0;
@@ -558,11 +583,22 @@ static int prepare_to_commit(const char *index_fi=
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
+		parent_ident =3D get_parent_ident();
+		if (!user_explicit &&
+		    (!parent_ident || strcmp(parent_ident, committer_ident)))
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
index 3fcc283..941441a 100644
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
index b0ada51..e39df5b 100644
--- a/config.c
+++ b/config.c
@@ -443,6 +443,8 @@ int git_default_config(const char *var, const char =
*value)
 		if (!value)
 			return config_error_nonbool(var);
 		strlcpy(git_default_name, value, sizeof(git_default_name));
+		if (!git_default_email[0])
+			user_explicit =3D 1;
 		return 0;
 	}
=20
@@ -450,6 +452,8 @@ int git_default_config(const char *var, const char =
*value)
 		if (!value)
 			return config_error_nonbool(var);
 		strlcpy(git_default_email, value, sizeof(git_default_email));
+		if (!git_default_name[0])
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
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 11de910..b1509a0 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -165,6 +165,18 @@ test_expect_success 'author different from committ=
er' '
 	test_cmp expect actual
 '
=20
+GIT_COMMITTER_NAME=3D"C. O. Mitter"
+export GIT_COMMITTER_NAME
+echo "# Committer: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >> expe=
ct
+
+test_expect_success 'committer different from the parent committer' '
+
+	echo >>negative &&
+	git commit -e -m "sample"
+	head -n 7 .git/COMMIT_EDITMSG >actual &&
+	test_cmp expect actual
+'
+
 pwd=3D`pwd`
 cat >> .git/FAKE_EDITOR << EOF
 #! /bin/sh
--=20
1.5.5.1.102.gfcc7d.dirty
