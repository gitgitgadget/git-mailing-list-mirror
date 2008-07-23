From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 09/12] tests for sparse clone
Date: Wed, 23 Jul 2008 21:57:28 +0700
Message-ID: <20080723145728.GA29144@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 16:59:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLfoE-0003Lc-0K
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbYGWO5u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 10:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753060AbYGWO5u
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:57:50 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:42933 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbYGWO5s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:57:48 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1202339tic.23
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=TQmMI5Vp3E8tG77F+ghjHTV3GlloezqtUYviWVxSS2k=;
        b=NGnn+OMWCO9HGIdGIjs4OvoNL83uFe5HYRDvDokJVeMGiGTuioYNx3Ze89RZ0kvepO
         jBYVt+/pSKJXG8UGBkplGDZWe4FJS67fM6ZqYHB/HBeLBs1dqQtOdy6jp0w+JAg70+rw
         l66Y95f41d786WxqRwoWIHKVavlqFCi56f57U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=s8pxr295rdAvJfPl3TpJJYZA9B4yzAoF3Bl/Bn2Prk2SQiCrseaFIkLvMDnWB2GFBF
         7UL+RELTvnFAEOnYmCnO4b1WjnBIyVmhRq/9KBhkwB+hKirGYSc+5l3N/tn9qWF7I4zk
         +9ZwPRnoQSV1ofv/ZEMFrPBHN/SiJtUpyFOdw=
Received: by 10.110.28.15 with SMTP id b15mr117195tib.26.1216825067643;
        Wed, 23 Jul 2008 07:57:47 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.5.7])
        by mx.google.com with ESMTPS id y5sm14816352tia.8.2008.07.23.07.57.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 07:57:46 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 23 Jul 2008 21:57:28 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89679>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5703-clone-sparse.sh |   40 +++++++++++++++++++++++++++++++++++++++=
+
 1 files changed, 40 insertions(+), 0 deletions(-)
 create mode 100755 t/t5703-clone-sparse.sh

diff --git a/t/t5703-clone-sparse.sh b/t/t5703-clone-sparse.sh
new file mode 100755
index 0000000..012ead0
--- /dev/null
+++ b/t/t5703-clone-sparse.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description=3D'sparse clone'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	rm -fr .git &&
+	test_create_repo src &&
+	(
+		cd src
+		mkdir -p work/sub/dir
+		touch untracked tracked modified added
+		touch work/untracked work/tracked work/modified work/added
+		git add tracked work/tracked
+		git add modified work/modified
+		git commit -m initial
+	)
+
+'
+
+test_expect_success 'sparse clone incompatible with --bare' '
+	rm -fr dst &&
+	test_must_fail git clone --path=3Dwork --bare src dst
+'
+
+test_expect_success 'sparse clone incompatible with --no-checkout' '
+	rm -fr dst &&
+	test_must_fail git clone --path=3Dwork -n src dst
+'
+
+test_expect_success 'clone with --path' '
+	rm -fr dst &&
+	git clone --path=3Dwork src dst &&
+	cd dst &&
+	test work =3D "$(git rev-parse --show-sparse-prefix)" &&
+	test -z "$(git ls-files | grep -v ^work/)"
+'
+
+test_done
--=20
1.5.5.GIT
