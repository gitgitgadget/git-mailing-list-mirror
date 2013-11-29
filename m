From: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH] stash: handle specifying stashes with spaces
Date: Fri, 29 Nov 2013 20:22:59 +0100
Message-ID: <1385752979-28162-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 29 20:27:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmTie-00031w-AI
	for gcvg-git-2@plane.gmane.org; Fri, 29 Nov 2013 20:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704Ab3K2T1M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Nov 2013 14:27:12 -0500
Received: from mail-la0-f49.google.com ([209.85.215.49]:60958 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631Ab3K2T1J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Nov 2013 14:27:09 -0500
Received: by mail-la0-f49.google.com with SMTP id er20so6881692lab.8
        for <git@vger.kernel.org>; Fri, 29 Nov 2013 11:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=n2/fpYPDjeXVhR84ZRmH7AWvBHBW/7ugZ4MBrJji7QM=;
        b=l/IbZmFfGqXypULDepH1MNi/fuNC6e+lJaZVZz0JrFzkJA28aSvjtEv/lYW6DrsW+1
         ICm8+O3OzWyMbZes8YoVQwee7DPj8b0M+5K02AsVkYB20FkajgvZX6QhmhedSk0Yl1DK
         6dxRB2FdZqfJiuY/uWVyc+Zr5GIGhPhix3cFCYCn67wl6zJLWr+lyCIfCzR/sI52LbtU
         uyieoZSBc4NJT4qiWS1ZEc5wWd9hcFNmLCFJuT0Rq1DYTmvtbXu3GqGr7Qdy0ecYLS/E
         c5XAAaUzDCC6eFACsjWkpH3h1HdDY4E03MukvRSH6KebGqf10EVqDbcO/0qbwilf0HyT
         qvJQ==
X-Received: by 10.112.173.70 with SMTP id bi6mr305635lbc.56.1385753228101;
        Fri, 29 Nov 2013 11:27:08 -0800 (PST)
Received: from localhost.localdomain (80.156.189.109.customer.cdi.no. [109.189.156.80])
        by mx.google.com with ESMTPSA id ox6sm26672980lbb.6.2013.11.29.11.27.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2013 11:27:07 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1.gd74b616
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238534>

When trying to pop/apply a stash specified with an argument containing
spaces the user will see an error:

    $ git stash pop 'stash@{two hours ago}'
    Too many revisions specified: stash@{two hours ago}

This happens because word splitting is used to count non-option
arguments. Instead shift the positional arguments as the options are
processed; the number of arguments left is then the number we're after.
Add quotes where necessary.

Also add a test that verifies correct behaviour.

Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
---
This is perhaps an esoteric use case but it's still worth fixing in my =
opinion.
It also saves a fork/exec so I see it as a win-win :)

Comments welcome, of course. Especially on the test. I couldn't use a r=
elative
date spec since the commits and stashes are made with bogus timestamps =
and the
spec is compared to the local time. It looks a bit icky the way it's wr=
itten
now.

 git-stash.sh     | 20 ++++++++++----------
 t/t3903-stash.sh | 11 +++++++++++
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 1e541a2..0a48d42 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -358,26 +358,25 @@ parse_flags_and_rev()
 	i_tree=3D
 	u_tree=3D
=20
-	REV=3D$(git rev-parse --no-flags --symbolic "$@") || exit 1
-
 	FLAGS=3D
 	for opt
 	do
 		case "$opt" in
 			-q|--quiet)
 				GIT_QUIET=3D-t
+				shift
 			;;
 			--index)
 				INDEX_OPTION=3D--index
+				shift
 			;;
 			-*)
 				FLAGS=3D"${FLAGS}${FLAGS:+ }$opt"
+				shift
 			;;
 		esac
 	done
=20
-	set -- $REV
-
 	case $# in
 		0)
 			have_stash || die "$(gettext "No stash found.")"
@@ -387,17 +386,18 @@ parse_flags_and_rev()
 			:
 		;;
 		*)
-			die "$(eval_gettext "Too many revisions specified: \$REV")"
+			refs=3D"$*"
+			die "$(eval_gettext "Too many revisions specified: \$refs")"
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
1.8.5.1.g359345f
