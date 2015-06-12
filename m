From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] checkout: don't check worktrees when not necessary
Date: Fri, 12 Jun 2015 17:49:24 +0700
Message-ID: <1434106164-28699-1-git-send-email-pclouds@gmail.com>
References: <87zj47gyif.fsf@earth.i-did-not-set--mail-host-address--so-tickle-me>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: catern@catern.com, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 12:49:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3MWy-0007Lp-1L
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 12:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbbFLKtn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2015 06:49:43 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34290 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbbFLKtm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 06:49:42 -0400
Received: by pdbki1 with SMTP id ki1so22676213pdb.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 03:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=v34Ocvam0+4Xbp8sm/LTrb94MR2VvcBjt4BRoQVsyy4=;
        b=qxaiByRp3ulOE2Inwf8x5u3jHu9W7gejCDaP5cJbNu2iIMUEsYv8rSRbjnah7iW+4V
         lbjpgtVIQPBzijqYE44PdkJW0wtMp6/5PTVOIoDcXalcjxB8K4BwODIjP/q6Ps6GniPf
         jnm1jIZzLPg6pzz76POEPVlKiuTw9BhP7GII8fQfo0n/T9bDc7GJxt39nPwf9eIT4ZNZ
         vbp1eHmFfyM4hlQOFyptaSmvaaRukrpAKmcQD4/qwwwiB10VFSZZ23ZNAWbQCn3xGMmK
         lbNVY4NQ2LoU8B2Sr5CDOC8z+xX2Q4i6m62QG61+kYsnKUkeIG04oOcYdkmrAVyl4Qta
         SIAQ==
X-Received: by 10.70.37.167 with SMTP id z7mr22434710pdj.55.1434106182277;
        Fri, 12 Jun 2015 03:49:42 -0700 (PDT)
Received: from lanh ([115.73.38.172])
        by mx.google.com with ESMTPSA id eo3sm3277953pbd.66.2015.06.12.03.49.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jun 2015 03:49:41 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 12 Jun 2015 17:50:00 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <87zj47gyif.fsf@earth.i-did-not-set--mail-host-address--so-tickle-me>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271478>

When --patch or pathspecs are passed to git checkout, the working tree
will not be switching branch, so there's no need to check if the branch
that we are running checkout on is already checked out.

Original-patch-by: Spencer Baugh <sbaugh@catern.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c     | 23 +++++++++++------------
 t/t2025-checkout-to.sh |  8 ++++++++
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9b49f0e..e227f64 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1110,7 +1110,6 @@ static int parse_branchname_arg(int argc, const c=
har **argv,
 {
 	struct tree **source_tree =3D &opts->source_tree;
 	const char **new_branch =3D &opts->new_branch;
-	int force_detach =3D opts->force_detach;
 	int argcount =3D 0;
 	unsigned char branch_rev[20];
 	const char *arg;
@@ -1231,17 +1230,6 @@ static int parse_branchname_arg(int argc, const =
char **argv,
 	else
 		new->path =3D NULL; /* not an existing branch */
=20
-	if (new->path && !force_detach && !*new_branch) {
-		unsigned char sha1[20];
-		int flag;
-		char *head_ref =3D resolve_refdup("HEAD", 0, sha1, &flag);
-		if (head_ref &&
-		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)) &&
-		    !opts->ignore_other_worktrees)
-			check_linked_checkouts(new);
-		free(head_ref);
-	}
-
 	new->commit =3D lookup_commit_reference_gently(rev, 1);
 	if (!new->commit) {
 		/* not a commit */
@@ -1321,6 +1309,17 @@ static int checkout_branch(struct checkout_opts =
*opts,
 		die(_("Cannot switch branch to a non-commit '%s'"),
 		    new->name);
=20
+	if (new->path && !opts->force_detach && !opts->new_branch) {
+		unsigned char sha1[20];
+		int flag;
+		char *head_ref =3D resolve_refdup("HEAD", 0, sha1, &flag);
+		if (head_ref &&
+		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)) &&
+		    !opts->ignore_other_worktrees)
+			check_linked_checkouts(new);
+		free(head_ref);
+	}
+
 	if (opts->new_worktree)
 		return prepare_linked_checkout(opts, new);
=20
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index f8e4df4..a8d9336 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -28,6 +28,14 @@ test_expect_success 'checkout --to refuses to checko=
ut locked branch' '
 	! test -d .git/worktrees/zere
 '
=20
+test_expect_success 'checking out paths not complaining about linked c=
heckouts' '
+	(
+	cd existing_empty &&
+	echo dirty >>init.t &&
+	git checkout master -- init.t
+	)
+'
+
 test_expect_success 'checkout --to a new worktree' '
 	git rev-parse HEAD >expect &&
 	git checkout --detach --to here master &&
--=20
2.3.0.rc1.137.g477eb31
