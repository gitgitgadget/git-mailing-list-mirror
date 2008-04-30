From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 2/3] commit: Show author if different from committer
Date: Wed, 30 Apr 2008 10:47:15 +0200
Message-ID: <1209545236-4266-3-git-send-email-sbejar@gmail.com>
References: <1209545236-4266-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 10:48:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr7zK-0002bc-DJ
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 10:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757438AbYD3Irk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Apr 2008 04:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757410AbYD3Irk
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 04:47:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:59837 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757303AbYD3Irj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 04:47:39 -0400
Received: by fg-out-1718.google.com with SMTP id 19so75288fgg.17
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 01:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=4DwhE1tKpPRg3cLRMZaMo8rO+G5t5jjoLsT/wlHuGK0=;
        b=OQ+Aphp9E54yGXiaO8iavcglvC8sxFg+nOd4QBBulOCE0Flxnlv1VK49VUTvttbTTtjZh1uQX9JCDIvp54JFMJ6EG0DcU6o2HNHRVQ6XBw3c/tKTi7I0zRh2hPaQnfx3S7xzNvnHzNVFfjpPznX+FDRdoV1t/DlJRgPvz7NdXR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=ryP1u3LUXlk3+PAf11ou8o5mBW4+yP0Ui8rLvf6dxj5WHNO4ZdC+r4NnLdYvKWfMFckrY6kpPcLcXUdxABpR3kLFsRf+0iVJKyNeYAqUXQ4FFEi3MUCQjbGN27TBUYVfbFkFlAFUhz3isDGgbrMcdjNoOWnsECQuPvp+njiuMr0=
Received: by 10.86.3.4 with SMTP id 4mr1282732fgc.79.1209545258276;
        Wed, 30 Apr 2008 01:47:38 -0700 (PDT)
Received: from localhost ( [91.13.102.119])
        by mx.google.com with ESMTPS id u9sm2271742muf.12.2008.04.30.01.47.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Apr 2008 01:47:36 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.148.g37726
In-Reply-To: <1209545236-4266-1-git-send-email-sbejar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80814>

That would help reassure anybody while committing other's changes.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 builtin-commit.c  |   23 ++++++++++++++++++++---
 t/t7502-commit.sh |   10 ++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index a37d8c3..c51c70f 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -47,6 +47,7 @@ static enum {
=20
 static char *logfile, *force_author, *template_file;
 static char *edit_message, *use_message;
+static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, untracked_files, no_verify, allow_empty;
 /*
@@ -395,7 +396,7 @@ static int is_a_merge(const unsigned char *sha1)
=20
 static const char sign_off_header[] =3D "Signed-off-by: ";
=20
-static void determine_author_info(struct strbuf *sb)
+static void determine_author_info()
 {
 	char *name, *email, *date;
=20
@@ -431,7 +432,9 @@ static void determine_author_info(struct strbuf *sb=
)
 		email =3D xstrndup(lb + 2, rb - (lb + 2));
 	}
=20
-	strbuf_addf(sb, "author %s\n", fmt_ident(name, email, date, IDENT_ERR=
OR_ON_NO_NAME));
+	author_name =3D name;
+	author_email =3D email;
+	author_date =3D date;
 }
=20
 static int prepare_to_commit(const char *index_file, const char *prefi=
x)
@@ -443,6 +446,8 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix)
 	FILE *fp;
 	const char *hook_arg1 =3D NULL;
 	const char *hook_arg2 =3D NULL;
+	const char *author_ident;
+	const char *committer_ident;
=20
 	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
 		return 0;
@@ -522,6 +527,8 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix)
=20
 	strbuf_release(&sb);
=20
+	determine_author_info();
+
 	if (use_editor) {
 		if (in_merge)
 			fprintf(fp,
@@ -545,6 +552,15 @@ static int prepare_to_commit(const char *index_fil=
e, const char *prefix)
 		if (only_include_assumed)
 			fprintf(fp, "# %s\n", only_include_assumed);
=20
+		author_ident =3D xstrdup(fmt_name(author_name, author_email));
+		committer_ident =3D
+			xstrdup(fmt_name(getenv("GIT_COMMITTER_NAME"),
+					 getenv("GIT_COMMITTER_EMAIL")));
+		if (strcmp(author_ident, committer_ident))
+			fprintf(fp,
+				"# Author:    %s\n",
+				fmt_name(author_name, author_email));
+
 		saved_color_setting =3D wt_status_use_color;
 		wt_status_use_color =3D 0;
 		commitable =3D run_status(fp, index_file, prefix, 1);
@@ -920,7 +936,8 @@ int cmd_commit(int argc, const char **argv, const c=
har *prefix)
 		strbuf_addf(&sb, "parent %s\n", sha1_to_hex(head_sha1));
 	}
=20
-	determine_author_info(&sb);
+	strbuf_addf(&sb, "author %s\n",
+		    fmt_ident(author_name, author_email, author_date, IDENT_ERROR_ON=
_NO_NAME));
 	strbuf_addf(&sb, "committer %s\n", git_committer_info(IDENT_ERROR_ON_=
NO_NAME));
 	if (!is_encoding_utf8(git_commit_encoding))
 		strbuf_addf(&sb, "encoding %s\n", git_commit_encoding);
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 284c941..95acf4c 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -154,6 +154,16 @@ test_expect_success 'cleanup commit messages (stri=
p,-F,-e)' '
=20
 '
=20
+echo "# Author:    $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" >> expect
+
+test_expect_success 'author different from committer' '
+
+	echo >>negative &&
+	git commit -e -m "sample"
+	head -n 5 .git/COMMIT_EDITMSG >actual &&
+	test_cmp expect actual
+'
+
 pwd=3D`pwd`
 cat >> .git/FAKE_EDITOR << EOF
 #! /bin/sh
--=20
1.5.5.1.148.g37726
