From: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH v3] stash: handle specifying stashes with spaces
Date: Tue,  7 Jan 2014 09:22:15 +0100
Message-ID: <1389082935-16159-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 07 09:22:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0Rvn-0007qA-FV
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 09:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928AbaAGIWa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jan 2014 03:22:30 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:53945 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647AbaAGIW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 03:22:29 -0500
Received: by mail-lb0-f169.google.com with SMTP id u14so44534lbd.28
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 00:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=XdufVDtdC5SZuGtsT4ccqwAt8E2VIssAmM0C9z2DOUo=;
        b=TrHFNB7qzFl+V/Mh0JbRTSP0KCTZjSiW8vw7+fEyzbf5AtnueCvbaEQgC6qgHFoZ1E
         BFc8Vx59MU3O/CdLcH1FbsaO06MGq44oYSp3rTgbqt171yciZftHUVaO5yzSCQFPtrJY
         U82Vvr8UMxsx/BuACQ//6OefJnMNmEctaCnRdPXeR22IgHa5u2o4RD21/udsDiSjC8ZL
         JpvW4oYdR5r3pbuLsufZmzlgFdYOC6FK+kr5mYz2uZJLxBctbgjIOEpE64jsvaYjN0Jq
         9grSGXWzU0t3reGq9vEGZtbg11nICtDwrPlKRzbWZmfujdsJYpbDpd0efQ6o95XzwlPI
         FqlA==
X-Received: by 10.152.2.165 with SMTP id 5mr2103229lav.70.1389082948226;
        Tue, 07 Jan 2014 00:22:28 -0800 (PST)
Received: from localhost.localdomain (80.156.189.109.customer.cdi.no. [109.189.156.80])
        by mx.google.com with ESMTPSA id a8sm57118191lae.5.2014.01.07.00.22.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2014 00:22:26 -0800 (PST)
X-Mailer: git-send-email 1.8.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240100>

When trying to pop/apply a stash specified with an argument containing
spaces git-stash will throw an error:

    $ git stash pop 'stash@{two hours ago}'
    Too many revisions specified: stash@{two hours ago}

This happens because word splitting is used to count non-option
arguments. Make use of rev-parse's --sq option to quote the arguments
for us to ensure a correct count. Add quotes where necessary.

Also add a test that verifies correct behaviour.

Helped-by: Thomas Rast <tr@thomasrast.ch>
Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
---
v3 uses the same eval/--sq technique as v2, suggested by Thomas Rast.
This is basically a resend except that I added a missing '&&' in the
test that Eric Sunshine noticed when reading v1.

 git-stash.sh     | 14 +++++++-------
 t/t3903-stash.sh | 11 +++++++++++
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 1e541a2..f0a94ab 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -358,7 +358,7 @@ parse_flags_and_rev()
 	i_tree=3D
 	u_tree=3D
=20
-	REV=3D$(git rev-parse --no-flags --symbolic "$@") || exit 1
+	REV=3D$(git rev-parse --no-flags --symbolic --sq "$@") || exit 1
=20
 	FLAGS=3D
 	for opt
@@ -376,7 +376,7 @@ parse_flags_and_rev()
 		esac
 	done
=20
-	set -- $REV
+	eval set -- $REV
=20
 	case $# in
 		0)
@@ -391,13 +391,13 @@ parse_flags_and_rev()
 		;;
 	esac
=20
-	REV=3D$(git rev-parse --quiet --symbolic --verify $1 2>/dev/null) || =
{
+	REV=3D$(git rev-parse --quiet --symbolic --verify "$1" 2>/dev/null) |=
| {
 		reference=3D"$1"
 		die "$(eval_gettext "\$reference is not valid reference")"
 	}
=20
-	i_commit=3D$(git rev-parse --quiet --verify $REV^2 2>/dev/null) &&
-	set -- $(git rev-parse $REV $REV^1 $REV: $REV^1: $REV^2: 2>/dev/null)=
 &&
+	i_commit=3D$(git rev-parse --quiet --verify "$REV^2" 2>/dev/null) &&
+	set -- $(git rev-parse "$REV" "$REV^1" "$REV:" "$REV^1:" "$REV^2:" 2>=
/dev/null) &&
 	s=3D$1 &&
 	w_commit=3D$1 &&
 	b_commit=3D$2 &&
@@ -408,8 +408,8 @@ parse_flags_and_rev()
 	test "$ref_stash" =3D "$(git rev-parse --symbolic-full-name "${REV%@*=
}")" &&
 	IS_STASH_REF=3Dt
=20
-	u_commit=3D$(git rev-parse --quiet --verify $REV^3 2>/dev/null) &&
-	u_tree=3D$(git rev-parse $REV^3: 2>/dev/null)
+	u_commit=3D$(git rev-parse --quiet --verify "$REV^3" 2>/dev/null) &&
+	u_tree=3D$(git rev-parse "$REV^3:" 2>/dev/null)
 }
=20
 is_stash_like()
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index debda7a..7eb011c 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -673,4 +673,15 @@ test_expect_success 'store updates stash ref and r=
eflog' '
 	grep quux bazzy
 '
=20
+test_expect_success 'handle stash specification with spaces' '
+	git stash clear &&
+	echo pig > file &&
+	git stash &&
+	test_tick &&
+	echo cow > file &&
+	git stash &&
+	git stash apply "stash@{Thu Apr 7 15:17:13 2005 -0700}" &&
+	grep pig file
+'
+
 test_done
--=20
1.8.5
