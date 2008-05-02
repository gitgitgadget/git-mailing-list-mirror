From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 2/2] user.warnautomatic: add config to control if the committer ident is shown
Date: Fri,  2 May 2008 20:22:21 +0200
Message-ID: <1209752541-19111-3-git-send-email-sbejar@gmail.com>
References: <1209752541-19111-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 20:23:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrzvB-0006zH-Oc
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 20:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764582AbYEBSWv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2008 14:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764643AbYEBSWv
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 14:22:51 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:11240 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764538AbYEBSWt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 14:22:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1009255fgg.17
        for <git@vger.kernel.org>; Fri, 02 May 2008 11:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=QFO433XgRgrADbw7L5+vHz0f0y+72Utc0VWtL9RuqXE=;
        b=SopeNwhXEIqqcpyTp20ECDWtu5T/l9tqgJ1gRl0EH5ZlXAHssnXjh61aiQ/zqTAqN3Xcde0OPh/GhYZ4pww64s4RzLa4Ry5b1Jr6PdSFGAyuuJx+GmmBWGf4hKwgL6A4I80iNom0SILiSPD6xDfSGiWvuibKC8FNxyhj5PkQ4Ak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=jhQji8E2oIgDstoLc2uXrc5CcL48CLLJIGn7GESj1kt0ULpG6vrK1fXzFw9n1m4T6m2GJVytOyABSZzYHEnEVVMWzezb9tBkXcba3nIFQb7DBP/jvfJEcXc/vaJZLGs5vCfuFQc1NKbqfTuMNpldDcYessn9b8EbGF8B7+xe5tU=
Received: by 10.86.53.8 with SMTP id b8mr3987233fga.32.1209752568745;
        Fri, 02 May 2008 11:22:48 -0700 (PDT)
Received: from localhost ( [91.13.90.240])
        by mx.google.com with ESMTPS id j9sm16334553mue.5.2008.05.02.11.22.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 May 2008 11:22:47 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.223.g2532
In-Reply-To: <1209752541-19111-1-git-send-email-sbejar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81018>


Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 Documentation/config.txt |    4 ++++
 builtin-commit.c         |    2 +-
 cache.h                  |    1 +
 config.c                 |    5 +++++
 environment.c            |    1 +
 t/t7502-commit.sh        |   22 ++++++++++++++++++----
 6 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 824e416..9c770a6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -994,6 +994,10 @@ user.signingkey::
 	unchanged to gpg's --local-user parameter, so you may specify a key
 	using any method that gpg supports.
=20
+user.warnautomatic::
+	A boolean to show the committer ident while committing in the editor
+	if it is set automatically. Defaults to true.
+
 whatchanged.difftree::
 	The default linkgit:git-diff-tree[1] arguments to be used
 	for linkgit:git-whatchanged[1].
diff --git a/builtin-commit.c b/builtin-commit.c
index b7cc382..7ab8b40 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -588,7 +588,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix)
 				showed_ident++ ? "" : "#\n",
 				fmt_name(author_name, author_email));
=20
-		if (!user_explicit)
+		if (!user_explicit && user_warnautomatic)
 			fprintf(fp,
 				"%s# Committer: %s\n",
 				showed_ident++ ? "" : "#\n",
diff --git a/cache.h b/cache.h
index e8b26cf..5d0dd23 100644
--- a/cache.h
+++ b/cache.h
@@ -719,6 +719,7 @@ extern int config_error_nonbool(const char *);
 extern char git_default_email[MAX_GITNAME];
 extern char git_default_name[MAX_GITNAME];
 extern int user_explicit;
+extern int user_warnautomatic;
=20
 extern const char *git_commit_encoding;
 extern const char *git_log_output_encoding;
diff --git a/config.c b/config.c
index e49804a..1588053 100644
--- a/config.c
+++ b/config.c
@@ -457,6 +457,11 @@ int git_default_config(const char *var, const char=
 *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "user.warnautomatic")) {
+		user_warnautomatic =3D git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "i18n.commitencoding"))
 		return git_config_string(&git_commit_encoding, var, value);
=20
diff --git a/environment.c b/environment.c
index b941971..6b6ede6 100644
--- a/environment.c
+++ b/environment.c
@@ -12,6 +12,7 @@
 char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
 int user_explicit =3D 0;
+int user_warnautomatic =3D 1;
 int trust_executable_bit =3D 1;
 int quote_path_fully =3D 1;
 int has_symlinks =3D 1;
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 8f65c39..a63f9c4 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -155,25 +155,39 @@ test_expect_success 'cleanup commit messages (str=
ip,-F,-e)' '
 '
=20
 echo "#
-# Author:    $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" >> expect
+# Author:    $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
+#" >> expect
=20
 test_expect_success 'author different from committer' '
=20
 	echo >>negative &&
 	git commit -e -m "sample"
-	head -n 6 .git/COMMIT_EDITMSG >actual &&
+	head -n 7 .git/COMMIT_EDITMSG >actual &&
 	test_cmp expect actual
 '
=20
-echo "# Committer:" >> expect
 unset GIT_COMMITTER_EMAIL
 unset GIT_COMMITTER_NAME
=20
+test_expect_success 'committer is automatic but user.warnautomatic=3Dn=
o' '
+
+	git config user.warnautomatic no
+	echo >>negative &&
+	git commit -e -m "sample"
+	head -n 7 .git/COMMIT_EDITMSG >actual &&
+	test_cmp expect actual
+'
+
+sed -i '$d' expect
+echo "# Committer:
+#" >> expect
+
 test_expect_success 'committer is automatic' '
=20
+	git config --unset user.warnautomatic
 	echo >>negative &&
 	git commit -e -m "sample"
-	head -n 7 .git/COMMIT_EDITMSG |	\
+	head -n 8 .git/COMMIT_EDITMSG |	\
 	sed "s/^# Committer: .*/# Committer:/" >actual &&
 	test_cmp expect actual
 '
--=20
1.5.5.1.223.g2532
