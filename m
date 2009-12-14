From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/23] Teach Git to respect skip-worktree bit (writing part)
Date: Mon, 14 Dec 2009 17:30:52 +0700
Message-ID: <1260786666-8405-10-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:33:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8FG-0007wL-LQ
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137AbZLNKcs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756145AbZLNKco
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:32:44 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:62201 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756103AbZLNKcj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:32:39 -0500
Received: by mail-px0-f174.google.com with SMTP id 4so1691169pxi.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=E1Uaqn9ChBUf5SRNrUrlatB7nxeYabPyMOmO5AmEvKg=;
        b=vQ7QX4S0WNPIDGGSOMknrJaBlzxhRKetbh73/44uVj++md06hSpeF+12z4MRqfUn08
         rPg0HPundNSixRR3fYh0CIvx/sg4j0BARuprLBQkoLuhCwzbblb8ljqAn7OKSrzxR+N2
         MTnJV6hYqyRicE16F+xBxbEi75q2GD0FL+rs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=bExatFtH5qg2os2ASbsmYHyPCMVS2ebTlhXCwj3CBMD0j3vQxeJXArHocM5fkS+bSS
         huJJHp8e1IuwtawhefTZU8iigaybJX6xrI+8S+XYAUfl6KJmVsG647pTnvKVqC5yOmVa
         eRwLP+pFHmrZ5WJPLh9K3ZrwvsoU9d8AsxzKw=
Received: by 10.142.75.1 with SMTP id x1mr890927wfa.194.1260786759299;
        Mon, 14 Dec 2009 02:32:39 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 22sm4898547pzk.14.2009.12.14.02.32.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:32:38 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:31:57 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135182>

This part is mainly to remove CE_VALID shortcuts (and as a
consequence, ce_uptodate() shortcuts as it may be turned on by
CE_VALID) in writing code path if skip-worktree is used. Various tests
are added to avoid future breakages.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7012-skip-worktree-writing.sh |  139 ++++++++++++++++++++++++++++++=
++++++++
 unpack-trees.c                   |    4 +-
 2 files changed, 141 insertions(+), 2 deletions(-)
 create mode 100755 t/t7012-skip-worktree-writing.sh

diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-w=
riting.sh
new file mode 100755
index 0000000..c75efe4
--- /dev/null
+++ b/t/t7012-skip-worktree-writing.sh
@@ -0,0 +1,139 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
+#
+
+test_description=3D'test worktree writing operations when skip-worktre=
e is used'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit init &&
+	echo modified >> init.t &&
+	touch added &&
+	git add init.t added &&
+	git commit -m "modified and added" &&
+	git tag top
+'
+
+test_expect_success 'read-tree updates worktree, absent case' '
+	git checkout -f top &&
+	git update-index --skip-worktree init.t &&
+	rm init.t &&
+	git read-tree -m -u HEAD^ &&
+	echo init > expected &&
+	test_cmp expected init.t
+'
+
+test_expect_success 'read-tree updates worktree, dirty case' '
+	git checkout -f top &&
+	git update-index --skip-worktree init.t &&
+	echo dirty >> init.t &&
+	test_must_fail git read-tree -m -u HEAD^ &&
+	grep -q dirty init.t &&
+	test "$(git ls-files -t init.t)" =3D "S init.t" &&
+	git update-index --no-skip-worktree init.t
+'
+
+test_expect_success 'read-tree removes worktree, absent case' '
+	git checkout -f top &&
+	git update-index --skip-worktree added &&
+	rm added &&
+	git read-tree -m -u HEAD^ &&
+	test ! -f added
+'
+
+test_expect_success 'read-tree removes worktree, dirty case' '
+	git checkout -f top &&
+	git update-index --skip-worktree added &&
+	echo dirty >> added &&
+	test_must_fail git read-tree -m -u HEAD^ &&
+	grep -q dirty added &&
+	test "$(git ls-files -t added)" =3D "S added" &&
+	git update-index --no-skip-worktree added
+'
+
+NULL_SHA1=3De69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+ZERO_SHA0=3D0000000000000000000000000000000000000000
+setup_absent() {
+	test -f 1 && rm 1
+	git update-index --remove 1 &&
+	git update-index --add --cacheinfo 100644 $NULL_SHA1 1 &&
+	git update-index --skip-worktree 1
+}
+
+test_absent() {
+	echo "100644 $NULL_SHA1 0	1" > expected &&
+	git ls-files --stage 1 > result &&
+	test_cmp expected result &&
+	test ! -f 1
+}
+
+setup_dirty() {
+	git update-index --force-remove 1 &&
+	echo dirty > 1 &&
+	git update-index --add --cacheinfo 100644 $NULL_SHA1 1 &&
+	git update-index --skip-worktree 1
+}
+
+test_dirty() {
+	echo "100644 $NULL_SHA1 0	1" > expected &&
+	git ls-files --stage 1 > result &&
+	test_cmp expected result &&
+	echo dirty > expected
+	test_cmp expected 1
+}
+
+cat >expected <<EOF
+S 1
+H 2
+H init.t
+S sub/1
+H sub/2
+EOF
+
+test_expect_success 'index setup' '
+	git checkout -f init &&
+	mkdir sub &&
+	touch ./1 ./2 sub/1 sub/2 &&
+	git add 1 2 sub/1 sub/2 &&
+	git update-index --skip-worktree 1 sub/1 &&
+	git ls-files -t > result &&
+	test_cmp expected result
+'
+
+test_expect_success 'git-add ignores worktree content' '
+	setup_absent &&
+	git add 1 &&
+	test_absent
+'
+
+test_expect_success 'git-add ignores worktree content' '
+	setup_dirty &&
+	git add 1 &&
+	test_dirty
+'
+
+test_expect_success 'git-rm fails if worktree is dirty' '
+	setup_dirty &&
+	test_must_fail git rm 1 &&
+	test_dirty
+'
+
+cat >expected <<EOF
+Would remove expected
+Would remove result
+EOF
+test_expect_success 'git-clean, absent case' '
+	setup_absent &&
+	git clean -n > result &&
+	test_cmp expected result
+'
+
+test_expect_success 'git-clean, dirty case' '
+	setup_dirty &&
+	git clean -n > result &&
+	test_cmp expected result
+'
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 4870da9..1ab3c89 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -450,7 +450,7 @@ static int verify_uptodate(struct cache_entry *ce,
 {
 	struct stat st;
=20
-	if (o->index_only || o->reset || ce_uptodate(ce))
+	if (o->index_only || (!ce_skip_worktree(ce) && (o->reset || ce_uptoda=
te(ce))))
 		return 0;
=20
 	if (!lstat(ce->name, &st)) {
@@ -1004,7 +1004,7 @@ int oneway_merge(struct cache_entry **src, struct=
 unpack_trees_options *o)
=20
 	if (old && same(old, a)) {
 		int update =3D 0;
-		if (o->reset && !ce_uptodate(old)) {
+		if (o->reset && !ce_uptodate(old) && !ce_skip_worktree(old)) {
 			struct stat st;
 			if (lstat(old->name, &st) ||
 			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_=
MATCH_IGNORE_SKIP_WORKTREE))
--=20
1.6.5.2.216.g9c1ec
