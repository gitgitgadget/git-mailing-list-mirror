From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH 2/2 v3] checkout: add a test for creating a new branch with regexp as a starting point
Date: Fri, 6 Aug 2010 01:24:44 +0400
Message-ID: <20100805212444.GB12207@wo.int.altlinux.org>
References: <AANLkTimeQA2_fQ_f2pQchbo1coj3=mV9TRPnbET8SQ4F@mail.gmail.com> <20100731001919.GB24129@wo.int.altlinux.org> <AANLkTin11hHryAbJiOkiBH5TfpPbKREJK-ekWkd4fDhw@mail.gmail.com> <20100731014449.GA19956@wo.int.altlinux.org> <AANLkTi=+60yK8A-bYT6ySFTxXxmCD9nD_LW1WX2GgDbm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 23:24:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh7vp-0007GJ-S0
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 23:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426Ab0HEVYr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 17:24:47 -0400
Received: from vint.altlinux.org ([194.107.17.35]:41778 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932556Ab0HEVYq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 17:24:46 -0400
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id E57FB3F80032
	for <git@vger.kernel.org>; Thu,  5 Aug 2010 21:24:44 +0000 (UTC)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id D8B42519000D; Fri,  6 Aug 2010 01:24:44 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <AANLkTi=+60yK8A-bYT6ySFTxXxmCD9nD_LW1WX2GgDbm@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152720>

Reported-by: Ivan Zakharyaschev <imz@altlinux.org>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
Acked-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
---

The only difference between v2 and v3 editions of this patch is that
test_expect_failure has been replaced with test_expect_success, because
the fix (jc/sha1-name-find-fix) is already available.

 t/t2018-checkout-branch.sh |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 1caffea..13f7194 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -4,12 +4,13 @@ test_description=3D'checkout '
=20
 . ./test-lib.sh
=20
-# Arguments: <branch> <sha> [<checkout options>]
+# Arguments: <branch> <start_point> [<checkout options>]
 #
 # Runs "git checkout" to switch to <branch>, testing that
 #
 #   1) we are on the specified branch, <branch>;
-#   2) HEAD is <sha>; if <sha> is not specified, the old HEAD is used.
+#   2) HEAD points to the same commit as <start_point> does;
+#      if <start_point> is not specified, the old HEAD is used.
 #
 # If <checkout options> is not specified, "git checkout" is run with -=
b.
 do_checkout() {
@@ -17,7 +18,8 @@ do_checkout() {
 	exp_ref=3D"refs/heads/$exp_branch" &&
=20
 	# if <sha> is not specified, use HEAD.
-	exp_sha=3D${2:-$(git rev-parse --verify HEAD)} &&
+	start_point=3D${2:-HEAD}
+	exp_sha=3D$(git rev-parse --verify $start_point) &&
=20
 	# default options for git checkout: -b
 	if [ -z "$3" ]; then
@@ -26,7 +28,7 @@ do_checkout() {
 		opts=3D"$3"
 	fi
=20
-	git checkout $opts $exp_branch $exp_sha &&
+	git checkout $opts $exp_branch $start_point &&
=20
 	test $exp_ref =3D $(git rev-parse --symbolic-full-name HEAD) &&
 	test $exp_sha =3D $(git rev-parse --verify HEAD)
@@ -118,7 +120,22 @@ test_expect_success 'checkout -b to an existing br=
anch fails' '
 	test_must_fail do_checkout branch2 $HEAD2
 '
=20
+test_expect_success 'checkout -b new_branch :/regexp' '
+	# clean up from previous test
+	git reset --hard &&
+
+	do_checkout old_regexp_branch branch1 &&
+	# The first commit in this test should not be referenced by
+	# other branches or tags.
+	test_commit first a a "" &&
+	test_commit second &&
+
+	do_checkout new_regexp_branch :/first
+'
+
 test_expect_success 'checkout -B to an existing branch resets branch t=
o HEAD' '
+	# clean up from previous test
+	git reset --hard &&
 	git checkout branch1 &&
=20
 	do_checkout branch2 "" -B

--=20
ldv
