From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v4 05/19] Teach Git to respect skip-worktree bit (writing part)
Date: Thu, 20 Aug 2009 20:46:59 +0700
Message-ID: <1250776033-12395-6-git-send-email-pclouds@gmail.com>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
 <1250776033-12395-2-git-send-email-pclouds@gmail.com>
 <1250776033-12395-3-git-send-email-pclouds@gmail.com>
 <1250776033-12395-4-git-send-email-pclouds@gmail.com>
 <1250776033-12395-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 15:49:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me81E-0007ZS-JU
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651AbZHTNrt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 09:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754644AbZHTNrt
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:47:49 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:32782 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754640AbZHTNrs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:47:48 -0400
Received: by wa-out-1112.google.com with SMTP id j5so957051wah.21
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 06:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=iLv9VhZICcj/WWjX1Sb8ZVTKpMZOAHs5DUmrHTI/BlA=;
        b=Zf9897jopxGTY5k934lZNkswrUXKu4wfT6WYf4YdDAzANw78iQIA0tNJTh/u8/RGSg
         xGDp4+13ffJ6F5GnvufaeqzU8Wx3rtFxRgcwOt3GWIbGGAARpiwWq/o9VcpeLD/cS4gy
         9LyRoSL+63iucAB9b0im8wZQAZjiFRMR+Q3KY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=YseHs0YFbx9oDYOtRC/b2mGnkjVg/aeBYk2awMSBmkOR1r2HW1IhyOwvEgauSfUGDO
         j5ju7E17uYvc6oIzpGtANTuW35o5FtDLUtecnU14PXU8dDEXIiGTkNATczKHWFnPmrol
         oWPGYhh8xceA0Rc7bKx7DvDpLEx9dBmru3B+8=
Received: by 10.115.100.20 with SMTP id c20mr9126750wam.75.1250776070032;
        Thu, 20 Aug 2009 06:47:50 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.241.222])
        by mx.google.com with ESMTPS id 21sm185583pzk.15.2009.08.20.06.47.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 06:47:49 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 20 Aug 2009 20:47:43 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250776033-12395-5-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126627>

This part is mainly to remove CE_VALID shortcuts (and as a
consequence, ce_uptodate() shortcuts as it may be turned on by
CE_VALID) in writing code path if skip-worktree is used. Various tests
are added to avoid future breakages.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t7012-skip-worktree-writing.sh |  146 ++++++++++++++++++++++++++++++=
++++++++
 unpack-trees.c                   |    4 +-
 2 files changed, 148 insertions(+), 2 deletions(-)
 create mode 100755 t/t7012-skip-worktree-writing.sh

diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-w=
riting.sh
new file mode 100755
index 0000000..8d8b1c0
--- /dev/null
+++ b/t/t7012-skip-worktree-writing.sh
@@ -0,0 +1,146 @@
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
+test_expect_failure 'git-apply adds file' false
+test_expect_failure 'git-apply updates file' false
+test_expect_failure 'git-apply removes file' false
+test_expect_failure 'git-mv to skip-worktree' false
+test_expect_failure 'git-mv from skip-worktree' false
+test_expect_failure 'git-checkout' false
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 720f7a1..3eda263 100644
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
 			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID))
--=20
1.6.3.GIT
