From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 09/31] rebase: align variable content
Date: Tue, 28 Dec 2010 10:30:26 +0100
Message-ID: <1293528648-21873-10-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:33:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYh-0005Wr-8B
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848Ab0L1Pcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:32:42 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58332 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269Ab0L1Pcj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:32:39 -0500
Received: by qyj19 with SMTP id 19so11286158qyj.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=d2E6gxUfy0BhJ88+/ZxAHyxQlQ1sFKgp2frkQTviM60=;
        b=danbelg7AY+PoYG5llSx2nGQ/0Vq30EdLlWaM7KMpTpsyK71SBmkf0SGVHcK0vHuH6
         9jUWI59HwXbMO90zQzmdClw6lBaEvpZEFDpuGB3eFxdW1U2Vo0EgB1qT3qcT8TnW6v8+
         kbdoo5TVegaxYAGAlpuKFLU8t5A3kxR8+jsdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KtpGi36wX+Na143OgFHJeIjJy5NAnSf1JDS838jXB8kIlzqT1iBuUjbnnZETPf5CZA
         iWcw0bEu/swJ5PkNL6HNQqS3bIYUIrGaBkTab/4H1UaCEunS4aUJwv7qV6H7fGlAE2UA
         heafid6vBSJe6NYS88N9L8b+IbqscItseAo/k=
Received: by 10.224.73.137 with SMTP id q9mr13319448qaj.53.1293550358880;
        Tue, 28 Dec 2010 07:32:38 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.32.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:32:38 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164245>

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
index 310d80e..1af739a 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -339,7 +339,8 @@ pick_one_preserving_merges () {
 			# No point in merging the first parent, that's HEAD
 			new_parents=${new_parents# $first_parent}
 			if ! do_with_author output \
-				git merge $strategy -m "$msg" $new_parents
+				git merge ${strategy:+-s $strategy} -m "$msg" \
+					$new_parents
 			then
 				printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
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
 test -d "$DOTEST" &&
diff --git a/git-rebase.sh b/git-rebase.sh
index dc133e3..21366ba 100755
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
1.7.3.2.864.gbbb96
