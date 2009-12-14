From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 22/23] Add tests for sparse checkout
Date: Mon, 14 Dec 2009 17:31:05 +0700
Message-ID: <1260786666-8405-23-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:35:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8Gm-0008VO-3p
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756394AbZLNKd5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756366AbZLNKdy
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:33:54 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:34948 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756279AbZLNKdk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:33:40 -0500
Received: by mail-pw0-f42.google.com with SMTP id 9so1839222pwj.21
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=/toteNvuDJmn0LmWL3+aENaSmU/xCesAtHPj09JYoF4=;
        b=coXIEM5Aw1JsS90QSgLuuMnyi6ivq2UN7EhhPIcgDsu1qIY+r7dsXy/BarFwYO8+f0
         Evmi9PTmxnEzykeIuK/xck1PYm1zwXsQZ6a33COz8TQEkrjIls8aBJHaDWfp0duidzDj
         CCde2nd2gXMyOn9AF5fdkUdkflhDXEVrZV9XU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CJ+Sc+54JKJPhhLVhGKhK5omttpm2qa8hpImmlt7F3wYj0a+ImXqZyh+2LnzcjkQin
         6dI7X3YceVLp1/wYlvp6s+7ojyw4H9z/Ev8o7R9MdZo6pWGihAZ8OPhpA/azmg0illAp
         bp1pqkTKNRJFi4zjUQNYyaPPrJ1vJGvkd4mL4=
Received: by 10.141.130.14 with SMTP id h14mr3179795rvn.296.1260786820014;
        Mon, 14 Dec 2009 02:33:40 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 23sm4917195pzk.0.2009.12.14.02.33.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:33:39 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:32:58 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135192>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1011-read-tree-sparse-checkout.sh |  154 ++++++++++++++++++++++++++=
++++++++
 1 files changed, 154 insertions(+), 0 deletions(-)
 create mode 100755 t/t1011-read-tree-sparse-checkout.sh

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
new file mode 100755
index 0000000..2192f5a
--- /dev/null
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -0,0 +1,154 @@
+#!/bin/sh
+
+test_description=3D'sparse checkout tests'
+
+. ./test-lib.sh
+
+cat >expected <<EOF
+100644 77f0ba1734ed79d12881f81b36ee134de6a3327b 0	init.t
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	sub/added
+EOF
+test_expect_success 'setup' '
+	test_commit init &&
+	echo modified >> init.t &&
+	mkdir sub &&
+	touch sub/added &&
+	git add init.t sub/added &&
+	git commit -m "modified and added" &&
+	git tag top &&
+	git rm sub/added &&
+	git commit -m removed &&
+	git tag removed &&
+	git checkout top &&
+	git ls-files --stage > result &&
+	test_cmp expected result
+'
+
+cat >expected.swt <<EOF
+H init.t
+H sub/added
+EOF
+test_expect_success 'read-tree without .git/info/sparse-checkout' '
+	git read-tree -m -u HEAD &&
+	git ls-files --stage > result &&
+	test_cmp expected result &&
+	git ls-files -t > result &&
+	test_cmp expected.swt result
+'
+
+test_expect_success 'read-tree with .git/info/sparse-checkout but disa=
bled' '
+	echo > .git/info/sparse-checkout
+	git read-tree -m -u HEAD &&
+	git ls-files -t > result &&
+	test_cmp expected.swt result &&
+	test -f init.t &&
+	test -f sub/added
+'
+
+test_expect_success 'read-tree --no-sparse-checkout with empty .git/in=
fo/sparse-checkout and enabled' '
+	git config core.sparsecheckout true &&
+	echo > .git/info/sparse-checkout &&
+	git read-tree --no-sparse-checkout -m -u HEAD &&
+	git ls-files -t > result &&
+	test_cmp expected.swt result &&
+	test -f init.t &&
+	test -f sub/added
+'
+
+cat >expected.swt <<EOF
+S init.t
+S sub/added
+EOF
+test_expect_success 'read-tree with empty .git/info/sparse-checkout' '
+	git config core.sparsecheckout true &&
+	echo > .git/info/sparse-checkout &&
+	git read-tree -m -u HEAD &&
+	git ls-files --stage > result &&
+	test_cmp expected result &&
+	git ls-files -t > result &&
+	test_cmp expected.swt result &&
+	test ! -f init.t &&
+	test ! -f sub/added
+'
+
+cat >expected.swt <<EOF
+S init.t
+H sub/added
+EOF
+test_expect_success 'match directories with trailing slash' '
+	echo sub/ > .git/info/sparse-checkout &&
+	git read-tree -m -u HEAD &&
+	git ls-files -t > result &&
+	test_cmp expected.swt result &&
+	test ! -f init.t &&
+	test -f sub/added
+'
+
+cat >expected.swt <<EOF
+H init.t
+H sub/added
+EOF
+test_expect_failure 'match directories without trailing slash' '
+	echo init.t > .git/info/sparse-checkout &&
+	echo sub >> .git/info/sparse-checkout &&
+	git read-tree -m -u HEAD &&
+	git ls-files -t > result &&
+	test_cmp expected.swt result &&
+	test ! -f init.t &&
+	test -f sub/added
+'
+
+cat >expected.swt <<EOF
+H init.t
+S sub/added
+EOF
+test_expect_success 'checkout area changes' '
+	echo init.t > .git/info/sparse-checkout &&
+	git read-tree -m -u HEAD &&
+	git ls-files -t > result &&
+	test_cmp expected.swt result &&
+	test -f init.t &&
+	test ! -f sub/added
+'
+
+test_expect_success 'read-tree updates worktree, absent case' '
+	echo sub/added > .git/info/sparse-checkout &&
+	git checkout -f top &&
+	git read-tree -m -u HEAD^ &&
+	test ! -f init.t
+'
+
+test_expect_success 'read-tree updates worktree, dirty case' '
+	echo sub/added > .git/info/sparse-checkout &&
+	git checkout -f top &&
+	echo dirty > init.t &&
+	git read-tree -m -u HEAD^ &&
+	grep -q dirty init.t &&
+	rm init.t
+'
+
+test_expect_success 'read-tree removes worktree, dirty case' '
+	echo init.t > .git/info/sparse-checkout &&
+	git checkout -f top &&
+	echo dirty > added &&
+	git read-tree -m -u HEAD^ &&
+	grep -q dirty added
+'
+
+test_expect_success 'read-tree adds to worktree, absent case' '
+	echo init.t > .git/info/sparse-checkout &&
+	git checkout -f removed &&
+	git read-tree -u -m HEAD^ &&
+	test ! -f sub/added
+'
+
+test_expect_success 'read-tree adds to worktree, dirty case' '
+	echo init.t > .git/info/sparse-checkout &&
+	git checkout -f removed &&
+	mkdir sub &&
+	echo dirty > sub/added &&
+	git read-tree -u -m HEAD^ &&
+	grep -q dirty sub/added
+'
+
+test_done
--=20
1.6.5.2.216.g9c1ec
