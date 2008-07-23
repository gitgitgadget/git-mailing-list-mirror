From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 11/12] tests for checkout [--full|--path]
Date: Wed, 23 Jul 2008 21:57:59 +0700
Message-ID: <20080723145759.GA29166@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 16:59:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLfoF-0003Lc-IH
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbYGWO6U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 10:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753104AbYGWO6U
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:58:20 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:42933 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbYGWO6T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:58:19 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1202339tic.23
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 07:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=qZ2OoDKxWfjBQBMkVsEosXp973Rm+mG/5ovusNIP6Ww=;
        b=v1egz70QOZmO3ISlRHH/btB1qhBFxApRlqg3FjXPBCMprGk66SQPTHAdGWQKRAIaWq
         XwDkt/X9GW5xnJn8EqDK6rJb8ZwMJznD/b22Z86gE48jcrArtEml5sZ2T7+PbZlLXGB2
         3Iw3UZ7u9Pdi0T+LFwdTWt8ag0X/GApxx33c4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=Yo+JL0/33HQFlczh0BYtIL58ulK++WQBWnck2CmAzDRwXzTgqzDoaMZo7DyrPoha/L
         K2nqWlt6UhPm6sIS65PhzYiooA2Tq7mgdGgksBcIwmmfQLcwX7IvfzcGQaTcF+AdDH9U
         x8LYqdPLK/LN5AZq4+2PZdmoDV5iZIlc3EeJU=
Received: by 10.110.7.18 with SMTP id 18mr103896tig.39.1216825098534;
        Wed, 23 Jul 2008 07:58:18 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.5.7])
        by mx.google.com with ESMTPS id 14sm14756423tim.16.2008.07.23.07.58.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 07:58:16 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 23 Jul 2008 21:57:59 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89678>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t2010-checkout-sparse.sh |   71 ++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)
 create mode 100755 t/t2010-checkout-sparse.sh

diff --git a/t/t2010-checkout-sparse.sh b/t/t2010-checkout-sparse.sh
new file mode 100755
index 0000000..5bb82ae
--- /dev/null
+++ b/t/t2010-checkout-sparse.sh
@@ -0,0 +1,71 @@
+#!/bin/sh
+
+test_description=3D'sparse checkout'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	mkdir work1 work2 work3
+	touch one two three
+	touch work1/one work2/two work3/three
+	git add one work1/one
+	git commit -m work1
+	git add two work2/two
+	git commit -m work2
+	git add three work3/three
+	git commit -m work3
+'
+
+test_expect_success '--full on no-sparse checkout' '
+	git checkout --full
+'
+
+test_expect_success '--full and --path incompatible' '
+	test_must_fail git checkout --full --path=3Dwork1
+'
+
+test_expect_success 'limit worktree to work1 and work2' '
+	git checkout --path=3Dwork1:work2 &&
+	test work1:work2 =3D "$(git rev-parse --show-sparse-prefix)" &&
+	test -f work1/one &&
+	test -f work2/two &&
+	! test -f work3/three
+'
+
+test_expect_success 'update worktree to work2 and work3' '
+	git checkout --path=3Dwork2:work3 &&
+	test work2:work3 =3D "$(git rev-parse --show-sparse-prefix)" &&
+	! test -f work1/one &&
+	test -f work2/two &&
+	test -f work3/three
+'
+
+test_expect_success 'update sparse prefix with modification' '
+	echo modified >> work2/two &&
+	git checkout --path=3Dwork1:work2 &&
+	test work1:work2 =3D "$(git rev-parse --show-sparse-prefix)" &&
+	test -f work1/one &&
+	test -f work2/two &&
+	! test -f work3/three &&
+	grep -q modified work2/two
+'
+
+test_expect_success 'update sparse should not lose modification' '
+	! git checkout --path=3Dwork1:work3 &&
+	test work1:work2 =3D "$(git rev-parse --show-sparse-prefix)" &&
+	test -f work1/one &&
+	test -f work2/two &&
+	! test -f work3/three &&
+	grep -q modified work2/two
+'
+
+test_expect_success 'exit sparse checkout' '
+	git checkout --full &&
+	test -z "$(git rev-parse --show-sparse-prefix)" &&
+	test -f work1/one &&
+	test -f work2/two &&
+	test -f work3/three &&
+	test one
+'
+
+test_done
--=20
1.5.5.GIT
