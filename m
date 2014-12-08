From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] checkout: add --ignore-other-wortrees
Date: Mon,  8 Dec 2014 21:04:44 +0700
Message-ID: <1418047507-22892-2-git-send-email-pclouds@gmail.com>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 14:54:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxym7-00047h-VW
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 14:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445AbaLHNyv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2014 08:54:51 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:65201 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbaLHNyu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 08:54:50 -0500
Received: by mail-pd0-f169.google.com with SMTP id z10so5222812pdj.28
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 05:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TG7JesFh5k9PuBj3avxeXk4N1dbHKOlzJFE39u4fl10=;
        b=sqj39XMbO8lAYRUuy3C5Poh5+gW6oeZ5ttn2M7dyffE52jY75VYVJ/EDhD/z7ewM09
         UXV7ubfzw8D9oNF7RVbZrQrUB8aJf8p4GS0zc9ZC1vWU2bZQinGmKAsY/cGKO/Ucun6v
         STdiDvcVc8oeDgTUcI04mu2MKvwOoRBrIV0Kn/4n1/jEV4WDhlHLK+7Q7Ds1JJlQ4kUf
         i80RHBG3IBeU/nrV3+5pFbVsWrtT6oDPPa2VWfRGZQ7y7BiUu4lEfRiW6ligC+QRosXf
         ymJ6eC1iSAGpHdte0pGP1rj5NaTxx4SxZNliTh6+/nYV9fjTRzxEEd8U6qFpuF9ca5gs
         g9dQ==
X-Received: by 10.68.102.195 with SMTP id fq3mr60445268pbb.7.1418046888413;
        Mon, 08 Dec 2014 05:54:48 -0800 (PST)
Received: from lanh ([115.73.205.130])
        by mx.google.com with ESMTPSA id oz10sm36581136pdb.95.2014.12.08.05.54.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 05:54:47 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 08 Dec 2014 21:05:23 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261018>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-checkout.txt |  6 ++++++
 builtin/checkout.c             | 19 +++++++++++--------
 t/t2025-checkout-to.sh         |  7 +++++++
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 0c13825..71d9e4e 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -232,6 +232,12 @@ section of linkgit:git-add[1] to learn how to oper=
ate the `--patch` mode.
 	specific files such as HEAD, index... See "MULTIPLE WORKING
 	TREES" section for more information.
=20
+--ignore-other-worktrees::
+	`git checkout` refuses when the wanted ref is already checked out
+	by another worktree. This option makes `git checkout` check the
+	ref out anyway. In other words, the ref is held by more than one
+	worktree.
+
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 953b763..8b2bf20 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -37,6 +37,7 @@ struct checkout_opts {
 	int writeout_stage;
 	int overwrite_ignore;
 	int ignore_skipworktree;
+	int ignore_other_worktrees;
=20
 	const char *new_branch;
 	const char *new_branch_force;
@@ -1079,11 +1080,12 @@ static void check_linked_checkouts(struct branc=
h_info *new)
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new,
-				struct tree **source_tree,
-				unsigned char rev[20],
-				const char **new_branch,
-				int force_detach)
+				struct checkout_opts *opts,
+				unsigned char rev[20])
 {
+	struct tree **source_tree =3D &opts->source_tree;
+	const char **new_branch =3D &opts->new_branch;
+	int force_detach =3D opts->force_detach;
 	int argcount =3D 0;
 	unsigned char branch_rev[20];
 	const char *arg;
@@ -1209,7 +1211,8 @@ static int parse_branchname_arg(int argc, const c=
har **argv,
 		int flag;
 		char *head_ref =3D resolve_refdup("HEAD", 0, sha1, &flag);
 		if (head_ref &&
-		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)))
+		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)) &&
+		    !opts->ignore_other_worktrees)
 			check_linked_checkouts(new);
 		free(head_ref);
 	}
@@ -1340,6 +1343,8 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 				N_("second guess 'git checkout no-such-branch'")),
 		OPT_FILENAME(0, "to", &opts.new_worktree,
 			   N_("check a branch out in a separate working directory")),
+		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
+			 N_("do not check if another worktree is holding the given ref")),
 		OPT_END(),
 	};
=20
@@ -1420,9 +1425,7 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 			opts.track =3D=3D BRANCH_TRACK_UNSPECIFIED &&
 			!opts.new_branch;
 		int n =3D parse_branchname_arg(argc, argv, dwim_ok,
-					     &new, &opts.source_tree,
-					     rev, &opts.new_branch,
-					     opts.force_detach);
+					     &new, &opts, rev);
 		argv +=3D n;
 		argc -=3D n;
 	}
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index 915b506..f8e4df4 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -79,6 +79,13 @@ test_expect_success 'die the same branch is already =
checked out' '
 	)
 '
=20
+test_expect_success 'not die the same branch is already checked out' '
+	(
+		cd here &&
+		git checkout --ignore-other-worktrees --to anothernewmaster newmaste=
r
+	)
+'
+
 test_expect_success 'not die on re-checking out current branch' '
 	(
 		cd there &&
--=20
2.2.0.60.gb7b3c64
