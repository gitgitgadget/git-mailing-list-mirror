From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 09/31] rebase: align variable content
Date: Sun,  6 Feb 2011 13:43:38 -0500
Message-ID: <1297017841-20678-10-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:46:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9ci-0004j0-F2
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647Ab1BFSqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:05 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58927 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627Ab1BFSqC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:02 -0500
Received: by mail-qy0-f181.google.com with SMTP id 12so3422584qyk.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=iXi6vm67wnGp4EExuyz10yU3ngVfJIy+as6d13fv4eU=;
        b=QZvenhqbKxv/LqsIuVdvLZC6IJ+IZJt3QcUZgHGDxNbY46a9HxqsgXg64FmVBsZlT+
         KCg9b3lvB9hRYH61e5YXwOiTHe8Pk3zPYUUSPXko5ejjNHmJc9VgMv24Eee059dLBm63
         pt9U9lYiQBAyq4IC84r/8ilR1jXL94mBO7YSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mObySqjK4RpyK27FgyPGEPbHC0Ok4M+LDJIJ4e3J+lp/f9dg/NhkTSlaCeYNHZqiP6
         kSG4LzdBE0lAoNnRCWu9kmjYE6sUmeMMtNqI5kZ5HoWes8qZBECyr+gXtYUU3DGgmT3U
         qhEl1xzfS2LP64+jwNr4dMe4CMaJA5sTs7TeU=
Received: by 10.229.211.206 with SMTP id gp14mr11963523qcb.289.1297017961784;
        Sun, 06 Feb 2011 10:46:01 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:01 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166168>

Make sure to interpret variables with the same name in the same way in
git-rebase.sh and git-rebase--interactive.sh. This will make it easier
to factor out code from git-rebase.sh to git-rebase--interactive and
export the variables.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--interactive.sh |   16 +++++++++++-----
 git-rebase.sh              |    4 +++-
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2fa348b..8b0d7b0 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -339,7 +339,8 @@ pick_one_preserving_merges () {
 			# No point in merging the first parent, that's HEAD
 			new_parents=${new_parents# $first_parent}
 			if ! do_with_author output \
-				git merge $strategy -m "$msg_content" $new_parents
+				git merge ${strategy:+-s $strategy} -m \
+					"$msg_content" $new_parents
 			then
 				printf "%s\n" "$msg_content" > "$GIT_DIR"/MERGE_MSG
 				die_with_patch $sha1 "Error redoing merge $sha1"
@@ -827,11 +828,11 @@ first and then run 'git rebase --continue' again."
 	-s)
 		case "$#,$1" in
 		*,*=*)
-			strategy="-s "$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
+			strategy=$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
 		1,*)
 			usage ;;
 		*)
-			strategy="-s $2"
+			strategy="$2"
 			shift ;;
 		esac
 		;;
@@ -860,9 +861,9 @@ first and then run 'git rebase --continue' again."
 		autosquash=
 		;;
 	--onto)
+		test 2 -le "$#" || usage
+		onto="$2"
 		shift
-		onto=$(parse_onto "$1") ||
-			die "Does not point to a valid commit: $1"
 		;;
 	--)
 		shift
@@ -872,6 +873,11 @@ first and then run 'git rebase --continue' again."
 	shift
 done
 
+if test -n "$onto"
+then
+	onto=$(parse_onto "$onto") || die "Does not point to a valid commit: $1"
+fi
+
 test -z "$rebase_root" -a $# -ge 1 -a $# -le 2 ||
 test ! -z "$rebase_root" -a $# -le 1 || usage
 test -d "$dotest" &&
diff --git a/git-rebase.sh b/git-rebase.sh
index dfde62f..3eac5a4 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -43,7 +43,7 @@ If you would prefer to skip this patch, instead run \"git rebase --skip\".
 To restore the original branch and stop rebasing run \"git rebase --abort\".
 "
 unset onto
-strategy=recursive
+strategy=
 strategy_opts=
 do_merge=
 merge_dir="$GIT_DIR"/rebase-merge
@@ -130,6 +130,7 @@ call_merge () {
 	then
 		GIT_MERGE_VERBOSITY=1 && export GIT_MERGE_VERBOSITY
 	fi
+	test -z "$strategy" && strategy=recursive
 	eval 'git-merge-$strategy' $strategy_opts '"$cmt^" -- "$hd" "$cmt"'
 	rv=$?
 	case "$rv" in
@@ -267,6 +268,7 @@ do
 		esac
 		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--$newopt")"
 		do_merge=t
+		test -z "$strategy" && strategy=recursive
 		;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
-- 
1.7.4.rc2.33.g8a14f
