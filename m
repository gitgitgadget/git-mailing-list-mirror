From: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH v2] stash: handle specifying stashes with spaces
Date: Fri, 29 Nov 2013 22:00:45 +0100
Message-ID: <1385758845-8627-1-git-send-email-oystwa@gmail.com>
References: <87k3frdlwc.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 29 22:05:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmVFT-0004zh-5Q
	for gcvg-git-2@plane.gmane.org; Fri, 29 Nov 2013 22:05:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241Ab3K2VEw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Nov 2013 16:04:52 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:61209 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab3K2VEv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Nov 2013 16:04:51 -0500
Received: by mail-lb0-f176.google.com with SMTP id x18so7150710lbi.7
        for <git@vger.kernel.org>; Fri, 29 Nov 2013 13:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3IHaXr3uJD4IxvrqS66SXYtTBTxo94Bub5TuhPXEgy8=;
        b=rp3710CHFx8kLrtWHIdW+0kYkGD75GEMScPneZ0jtJJov+ZcIklLM3sxP+THNsho31
         I/52yfBb/BwtVcPm1UDnrYDlgjMLvURC3f9Wdw1a/VJDIps/ffR3IdmgYSlfCA6JuLN7
         GK+lVnb3mS/kpiZAEO1/XUlcXpGmnXT0bDRUATRVcUbCShH+of6ocCepiT+GEz+dfpu7
         0Je/2uWB/XGeSh4RZVlVlntIykgICofr930JlttsvgfsUgc3U3hI2Bt4ukvjoxwFwC1k
         MfOomtKJlesar6Hdr3e4WiAaWIeVyVKMu2BEucZRq3WuplQGaMN02vUZgPQ4c9hSq6oU
         AhPg==
X-Received: by 10.112.199.196 with SMTP id jm4mr49604lbc.59.1385759090095;
        Fri, 29 Nov 2013 13:04:50 -0800 (PST)
Received: from localhost.localdomain (80.156.189.109.customer.cdi.no. [109.189.156.80])
        by mx.google.com with ESMTPSA id z3sm51889416lag.10.2013.11.29.13.04.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2013 13:04:49 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1.g11435f1
In-Reply-To: <87k3frdlwc.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238537>

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
Many thanks to Thomas Rast for helping me with this approach.

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
index debda7a..0568ec5 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -673,4 +673,15 @@ test_expect_success 'store updates stash ref and r=
eflog' '
 	grep quux bazzy
 '
=20
+test_expect_success 'handle stash specification with spaces' '
+	git stash clear
+	echo mook > file &&
+	git stash &&
+	test_tick &&
+	echo kleb > file &&
+	git stash &&
+	git stash apply "stash@{Thu Apr 7 15:17:13 2005 -0700}" &&
+	grep mook file
+'
+
 test_done
--=20
1.8.5.rc0.23.gaa27064.dirty
