From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/32] rev-list: support --narrow-tree
Date: Wed, 25 Aug 2010 08:20:01 +1000
Message-ID: <1282688422-7738-12-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:22:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1sz-0001Xh-2H
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293Ab0HXWWL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:22:11 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:37012 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270Ab0HXWWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:22:09 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so2813054pxi.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=s+CvbvkkCtHPjFRXvedXg7QVVAmIXdqObyYb0KqiHUg=;
        b=BRHYBgJOTZUvs1cTQ33DmIlEWOWnqeza3+/s4nfF6OuUbHPG0Xrk21eFVxtVaf7pNq
         2WCyX+weZT620NutNANAhIs8AuU17St7v6FhRqTUvUEg7v/DbQKRd5sG4aJ3mcRQgWuW
         q4gsu4hBJXkPGT+FjrtZMgXkILVTWxn4Zndzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=MYNvfmB2hnPldXnr+yP07yhzoNYw90AdJAfWQDUrRnwUm8dLyphhgM74Et7lL1JgUf
         64OdVKX1DdQGGIlABEfn24xJejXsj8jaL9xxD/8XURCujpd82MZC62+LNIoehomFDPKC
         urvZtfgr0h15I+5TBA6DqpJEmAqq2tMXkWmH0=
Received: by 10.114.204.7 with SMTP id b7mr8484886wag.124.1282688529539;
        Tue, 24 Aug 2010 15:22:09 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id n32sm948312wag.11.2010.08.24.15.22.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:22:07 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:22:02 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154356>

These options allow plumbing to access narrow tree traverse modes.
As a consequence, tests can now be written to test these modes.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 revision.c                 |    5 ++
 t/t6061-rev-list-narrow.sh |  158 ++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 163 insertions(+), 0 deletions(-)
 create mode 100755 t/t6061-rev-list-narrow.sh

diff --git a/revision.c b/revision.c
index 7e82efd..a4eb11f 100644
--- a/revision.c
+++ b/revision.c
@@ -1562,6 +1562,11 @@ int setup_revisions(int argc, const char **argv,=
 struct rev_info *revs, struct s
 				read_revisions_from_stdin(revs, &prune_data);
 				continue;
 			}
+			if (!prefixcmp(arg, "--narrow-tree=3D")) {
+				revs->narrow_prefix =3D arg + 14;
+				revs->narrow_tree =3D 1;
+				continue;
+			}
=20
 			opts =3D handle_revision_opt(revs, argc - i, argv + i, &left, argv)=
;
 			if (opts > 0) {
diff --git a/t/t6061-rev-list-narrow.sh b/t/t6061-rev-list-narrow.sh
new file mode 100755
index 0000000..e489347
--- /dev/null
+++ b/t/t6061-rev-list-narrow.sh
@@ -0,0 +1,158 @@
+#!/bin/sh
+
+test_description=3D'rev-list in narrow tree mode'
+
+. ./test-lib.sh
+
+# Normal tree
+cat <<EOF >revlist.expected
+ba7a30916c792624a8372cb26da50f5594098222
+3b52e9990a52d9ea46b25199b5810566324759f4=20
+573541ac9702dd3969c9bc859d2b91ec1f7e6e56 f0
+fa0bba1767985729582729a12a5459cd041d6cf6 t1
+f599e28b8ab0d8c9c57a486c89c4a5132dcbd3b2 t1/f10
+d81015b2a1c40fc6cbc5bf5a8b16949018c3aede t1/t12
+52bd8e43afb01d0c9747f1fedf2fc94684ee4cc4 t1/t12/f120
+74a398027f0b59183db54ca8c67dc30b5aeed0ff t2
+209e3ef4b6247ce746048d5711befda46206d235 t2/f20
+EOF
+
+# narrowed down tree
+cat <<EOF >t12.expected
+ba7a30916c792624a8372cb26da50f5594098222
+3b52e9990a52d9ea46b25199b5810566324759f4=20
+fa0bba1767985729582729a12a5459cd041d6cf6 t1
+d81015b2a1c40fc6cbc5bf5a8b16949018c3aede t1/t12
+52bd8e43afb01d0c9747f1fedf2fc94684ee4cc4 t1/t12/f120
+EOF
+
+# local tree
+cat <<EOF >t12-subtree.expected
+ba7a30916c792624a8372cb26da50f5594098222
+c0167b5ce78e9fb801ef96dcc319f3411d35278b=20
+e9a12654c859aff51978b25b2a6c5eddf6c1e13c t1
+d81015b2a1c40fc6cbc5bf5a8b16949018c3aede t1/t12
+52bd8e43afb01d0c9747f1fedf2fc94684ee4cc4 t1/t12/f120
+EOF
+
+cat <<EOF >t2.expected
+ba7a30916c792624a8372cb26da50f5594098222
+3b52e9990a52d9ea46b25199b5810566324759f4=20
+74a398027f0b59183db54ca8c67dc30b5aeed0ff t2
+209e3ef4b6247ce746048d5711befda46206d235 t2/f20
+EOF
+
+test_expect_success setup '
+	test_tick &&
+	mkdir t1 t2 t1/t12 &&
+	echo 0 > f0 &&
+	echo 10 > t1/f10 &&
+	echo 120 > t1/t12/f120 &&
+	echo 20 > t2/f20
+	git add t1 t2 f0 && git commit -m initial &&
+	C1=3D`git rev-parse HEAD` &&
+	T2=3D`git rev-parse HEAD^{tree}` &&
+	git rev-list --objects HEAD >result &&
+	test_cmp revlist.expected result
+'
+
+cat <<EOF >branch1.expected
+7475cb8a389b36ce238b9ee6cbfdfa26a1b67e35
+ba7a30916c792624a8372cb26da50f5594098222
+aa0602ee56ea4cb5e5bfff8713bb8a9a6ab4303e=20
+407c07594c8083c3d0521a1cb463b1204d880c13 f0
+d77d258d806b2aa7cdb5a301e6a54f023d9bdcfe t1
+737483f30ba682e414d715f7976fe9a9904fdbc0 t1/f10
+ab246f7eb05e94f695d2a0e30093d94fde7b837e t1/t12
+04156ae83e615fa5b6019170928bc131539f9996 t1/t12/f120
+1da4df952e59f2fa7ff211a8ee9f72b3174bbfb7 t2
+9aa2407894b849226773016ef5d68c5b87a23926 t2/f20
+3b52e9990a52d9ea46b25199b5810566324759f4=20
+573541ac9702dd3969c9bc859d2b91ec1f7e6e56 f0
+fa0bba1767985729582729a12a5459cd041d6cf6 t1
+f599e28b8ab0d8c9c57a486c89c4a5132dcbd3b2 t1/f10
+d81015b2a1c40fc6cbc5bf5a8b16949018c3aede t1/t12
+52bd8e43afb01d0c9747f1fedf2fc94684ee4cc4 t1/t12/f120
+74a398027f0b59183db54ca8c67dc30b5aeed0ff t2
+209e3ef4b6247ce746048d5711befda46206d235 t2/f20
+EOF
+
+test_expect_success 'setup branch1' '
+	echo common >> t1/t12/f120 &&
+	echo branch1 >> t1/f10 &&
+	echo branch1 >> t2/f20 &&
+	echo branch1 >> f0 &&
+	git add -u && git commit -m branch1 &&
+	BRANCH1=3D`git rev-parse HEAD` &&
+	git rev-list --objects $BRANCH1 > result &&
+	test_cmp branch1.expected result
+'
+
+cat <<EOF >branch2.expected
+af9c31c0e217154296d93d66b9a5a41892c7b321
+ba7a30916c792624a8372cb26da50f5594098222
+72e05e456b9ff4c01ccf6178ce60d9b52b41aae4=20
+573541ac9702dd3969c9bc859d2b91ec1f7e6e56 f0
+4fc1656b01ce8b21987c55a2870b8c9a431ec772 t1
+f599e28b8ab0d8c9c57a486c89c4a5132dcbd3b2 t1/f10
+ab246f7eb05e94f695d2a0e30093d94fde7b837e t1/t12
+04156ae83e615fa5b6019170928bc131539f9996 t1/t12/f120
+cef4db52388f5e0853acc772faa68058436a95ff t2
+7319a2144592e50a564d49902302a8b1bad2f49c t2/f20
+3b52e9990a52d9ea46b25199b5810566324759f4=20
+fa0bba1767985729582729a12a5459cd041d6cf6 t1
+d81015b2a1c40fc6cbc5bf5a8b16949018c3aede t1/t12
+52bd8e43afb01d0c9747f1fedf2fc94684ee4cc4 t1/t12/f120
+74a398027f0b59183db54ca8c67dc30b5aeed0ff t2
+209e3ef4b6247ce746048d5711befda46206d235 t2/f20
+EOF
+
+test_expect_success 'setup branch2' '
+	git reset --hard HEAD^ &&
+	echo common >> t1/t12/f120 &&
+	echo branch2 >> t2/f20 &&
+	git add -u && git commit -m branch2 &&
+	BRANCH2=3D`git rev-parse HEAD` &&
+	git rev-list --objects $BRANCH2 > result &&
+	test_cmp branch2.expected result
+'
+
+test_expect_success 'setup merge' '
+	git reset --hard HEAD^
+	MERGE=3D`echo merge | git commit-tree $T2 -p $BRANCH1 -p $BRANCH2`
+'
+
+test_expect_success 'rev-list --narrow-tree=3Dt2' '
+	git rev-list --objects --narrow-tree=3Dt2 HEAD >result &&
+	test_cmp t2.expected result
+'
+
+test_expect_success 'rev-list --narrow-tree=3Dt1/t12' '
+	git rev-list --objects --narrow-tree=3Dt1/t12 HEAD >result &&
+	test_cmp t12.expected result
+'
+
+cat <<EOF >merge.expected
+0da28f8308e336bd4b2c26b61c7fc44e41a30e49
+7475cb8a389b36ce238b9ee6cbfdfa26a1b67e35
+af9c31c0e217154296d93d66b9a5a41892c7b321
+ba7a30916c792624a8372cb26da50f5594098222
+74a398027f0b59183db54ca8c67dc30b5aeed0ff t2
+3b52e9990a52d9ea46b25199b5810566324759f4=20
+fa0bba1767985729582729a12a5459cd041d6cf6 t1
+d81015b2a1c40fc6cbc5bf5a8b16949018c3aede t1/t12
+52bd8e43afb01d0c9747f1fedf2fc94684ee4cc4 t1/t12/f120
+aa0602ee56ea4cb5e5bfff8713bb8a9a6ab4303e=20
+d77d258d806b2aa7cdb5a301e6a54f023d9bdcfe t1
+ab246f7eb05e94f695d2a0e30093d94fde7b837e t1/t12
+04156ae83e615fa5b6019170928bc131539f9996 t1/t12/f120
+72e05e456b9ff4c01ccf6178ce60d9b52b41aae4=20
+4fc1656b01ce8b21987c55a2870b8c9a431ec772 t1
+EOF
+
+test_expect_success 'rev-list --narrow-tree=3Dt1/t12 with merges' '
+	git rev-list --objects --narrow-tree=3Dt1/t12 $MERGE >result &&
+	test_cmp merge.expected result
+'
+
+test_done
--=20
1.7.1.rc1.69.g24c2f7
