From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v2 1/4] Prevent diff machinery from examining assume-unchanged entries on worktree
Date: Mon, 10 Aug 2009 22:19:19 +0700
Message-ID: <1249917562-5931-2-git-send-email-pclouds@gmail.com>
References: <1249917562-5931-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 17:19:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaWf0-0002iC-DO
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 17:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287AbZHJPTe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2009 11:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755214AbZHJPTe
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 11:19:34 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:22103 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbZHJPTd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 11:19:33 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1021748rvb.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 08:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=pRfVTKncsVCdox4FGkmYwn239zTcB92F0fYOS8Xhq2U=;
        b=PPPims19t5xAkzBWgRz3Wl1tbvA/kNiDewlfCU3pikaZUCxsGK0ay5pqcYx3vHjIVd
         CSTWPNTFZeSuaJuWGLcoCe1TBtiGDrWLBmHQTtTocWAb6TvMj29JpUySqSvdr2t/ouiA
         Rtv4bhBcz4qdefV6J7HnZATCUyb4xjZOFJl0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=He3I0gisQGD5P56iLMGBEExNizVtOsfSqIdILxxQuqUbI1pY+qpXnID7em965CB8I5
         NqjV8bOBPvTGlJ+CkYcRtT8PiJ2V1gmxGstLeWKKd1lZlLr0A93BiP6ovD0XeS7pc0Bh
         cNE4mTIt7Pgpson3pOirq00Ud1vDQV/LYxOS8=
Received: by 10.140.157.12 with SMTP id f12mr1648925rve.112.1249917575321;
        Mon, 10 Aug 2009 08:19:35 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.231.150])
        by mx.google.com with ESMTPS id g31sm25536905rvb.46.2009.08.10.08.19.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 08:19:34 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 10 Aug 2009 22:19:30 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1249917562-5931-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125458>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff-lib.c                       |    5 +++--
 t/t4039-diff-assume-unchanged.sh |   31 ++++++++++++++++++++++++++++++=
+
 2 files changed, 34 insertions(+), 2 deletions(-)
 create mode 100755 t/t4039-diff-assume-unchanged.sh

diff --git a/diff-lib.c b/diff-lib.c
index b7813af..f5787f6 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -159,7 +159,7 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 				continue;
 		}
=20
-		if (ce_uptodate(ce))
+		if (ce_uptodate(ce) || (ce->ce_flags & CE_VALID))
 			continue;
=20
 		changed =3D check_removed(ce, &st);
@@ -337,6 +337,8 @@ static void do_oneway_diff(struct unpack_trees_opti=
ons *o,
 	struct rev_info *revs =3D o->unpack_data;
 	int match_missing, cached;
=20
+	/* if the entry is not checked out, don't examine work tree */
+	cached =3D o->index_only || (idx && (idx->ce_flags & CE_VALID));
 	/*
 	 * Backward compatibility wart - "diff-index -m" does
 	 * not mean "do not ignore merges", but "match_missing".
@@ -344,7 +346,6 @@ static void do_oneway_diff(struct unpack_trees_opti=
ons *o,
 	 * But with the revision flag parsing, that's found in
 	 * "!revs->ignore_merges".
 	 */
-	cached =3D o->index_only;
 	match_missing =3D !revs->ignore_merges;
=20
 	if (cached && idx && ce_stage(idx)) {
diff --git a/t/t4039-diff-assume-unchanged.sh b/t/t4039-diff-assume-unc=
hanged.sh
new file mode 100755
index 0000000..d0e46a7
--- /dev/null
+++ b/t/t4039-diff-assume-unchanged.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+
+test_description=3D'diff with assume-unchanged entries'
+
+. ./test-lib.sh
+
+# external diff has been tested in t4020-diff-external.sh
+
+test_expect_success 'setup' '
+	echo zero > zero &&
+	git add zero &&
+	git commit -m zero &&
+	echo one > one &&
+	echo two > two &&
+	git add one two &&
+	git commit -m onetwo &&
+	git update-index --assume-unchanged one &&
+	echo borked >> one &&
+	test "$(git ls-files -v one)" =3D "h one"
+'
+
+test_expect_success 'diff-index does not examine assume-unchanged entr=
ies' '
+	git diff-index HEAD^ -- one | grep -q 5626abf0f72e58d7a153368ba57db4c=
673c0e171=20
+'
+
+# TODO ced_uptodate()
+test_expect_success 'diff-files does not examine assume-unchanged entr=
ies' '
+	/usr/bin/git diff-files -- one
+'
+
+test_done
--=20
1.6.3.GIT
