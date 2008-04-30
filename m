From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 3/3] commit: Show the committer ident when is different from the parent
Date: Wed, 30 Apr 2008 10:47:16 +0200
Message-ID: <1209545236-4266-4-git-send-email-sbejar@gmail.com>
References: <1209545236-4266-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 10:48:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr7zW-0002ei-Cp
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 10:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757611AbYD3Iru convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Apr 2008 04:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757590AbYD3Iru
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 04:47:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:59837 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757410AbYD3Irt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 04:47:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so75288fgg.17
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 01:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=hAGbWpSAI/+hNertfz3qSX/SJz3GGBIlOatktDfNF8E=;
        b=xFAPfTFvZ9kKCtFeEJzHBu6xCLjDU6WZHbTyhbgm2dFtXtqr3WaQC8hctZB23i9r7G5ohykACrWLbsVonNml6jC0Fy+zEzAfTQ29VP4goApCZdkqzLNOycuDctItWlv0sdFe9cShAax5Yg/TneUm1RMcb0Mo7JpaUjMo+TzPJRg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=tZrLuRdov+MqzJua/uX28tz9qYi/II2tPRKBHkdlWfBdVwShT56dmk9otB696Z46mAkepNE9dRLuze24r7E9gZ0Vr4ztnNwOWB2EF/Hm3k/pk0iREBWu1viMIOw9xuB8i3+dQ0NPxj1BfB+GxWMKWkgsxLh6p8MRklLYGMRta6U=
Received: by 10.86.66.11 with SMTP id o11mr1286772fga.74.1209545268423;
        Wed, 30 Apr 2008 01:47:48 -0700 (PDT)
Received: from localhost ( [91.13.102.119])
        by mx.google.com with ESMTPS id e10sm918121muf.3.2008.04.30.01.47.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Apr 2008 01:47:47 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.148.g37726
In-Reply-To: <1209545236-4266-1-git-send-email-sbejar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80815>

To remind the committer ident in case it is not what you want
(taken from the gecos field, want to use different ident in
different repositories).

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
Hi,

  it does not work with the initial commit, I don't know why.
  Even with this:
	if (!commit)
		return NULL;

  Can someone help me? Thanks

 builtin-commit.c  |   30 ++++++++++++++++++++++++++++++
 t/t7502-commit.sh |   12 ++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index c51c70f..06582ef 100644
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
+	const char *parent_ident;
=20
 	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
 		return 0;
@@ -561,6 +585,12 @@ static int prepare_to_commit(const char *index_fil=
e, const char *prefix)
 				"# Author:    %s\n",
 				fmt_name(author_name, author_email));
=20
+		parent_ident =3D xstrdup(get_parent_ident());
+		if (strcmp(parent_ident, committer_ident))
+			fprintf(fp,
+				"# Committer: %s\n",
+				committer_ident);
+
 		saved_color_setting =3D wt_status_use_color;
 		wt_status_use_color =3D 0;
 		commitable =3D run_status(fp, index_file, prefix, 1);
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 95acf4c..96b5dcb 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -164,6 +164,18 @@ test_expect_success 'author different from committ=
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
+	head -n 6 .git/COMMIT_EDITMSG >actual &&
+	test_cmp expect actual
+'
+
 pwd=3D`pwd`
 cat >> .git/FAKE_EDITOR << EOF
 #! /bin/sh
--=20
1.5.5.1.148.g37726
