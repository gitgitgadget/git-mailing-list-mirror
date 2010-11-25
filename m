From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH/RFC 09/20] rebase: align variable content
Date: Thu, 25 Nov 2010 20:57:52 +0100
Message-ID: <1290715083-16919-10-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 02:58:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLna6-0001kp-O2
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 02:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257Ab0KZB6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 20:58:20 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58794 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192Ab0KZB6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 20:58:16 -0500
Received: by vws3 with SMTP id 3so348008vws.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 17:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3YGw5U0LYojG1k+RRps7UDYVxT336FnK79YlJMIaAas=;
        b=GtI2p5ZgZwRu0W9wOmkjUavt/fKdVUymWap+hOsIN2NpyFcNHg/GnqaVvFrWeV+0+b
         +QBdebbCFqBF/6vibS4F4g8Ag1+TfU1kznaHU0gZQXFa4xj3ETLFMH1jKelVtYJO9Tme
         KeBbleA8uzG5MNlOKpnV9BiWqkfMeR/vdyZXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rHLTVI9z/ETFYiv6OLPhh4lihhCTUmmWq9CyM6L6gebw/T6KEnXQaM2LZINkdn3t9D
         Nt8b9k8jnZanzOazQEPSyqh3veerPjXoXFM1sYxUHT4Aj9jQDgip46kDHQRYRMtBsK47
         TQEXdUf7sDSb8MDbH8CsRNJjVNJo48DtMBsj4=
Received: by 10.220.121.162 with SMTP id h34mr125926vcr.13.1290736695653;
        Thu, 25 Nov 2010 17:58:15 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y14sm193301vch.28.2010.11.25.17.58.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 17:58:15 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162163>

Make sure to interpret variables with the same name in the same way in
git-rebase.sh and git-rebase--interactive.sh

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--interactive.sh |   14 ++++++++++----
 git-rebase.sh              |    4 +++-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 41a9eb1..886f80b 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -827,11 +827,11 @@ first and then run 'git rebase --continue' again."
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
@@ -860,9 +860,9 @@ first and then run 'git rebase --continue' again."
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
@@ -872,6 +872,12 @@ first and then run 'git rebase --continue' again."
 	shift
 done
 
+if test -n "$onto"
+then
+	onto=$(parse_onto "$onto") || die "Does not point to a valid commit: $1"
+fi
+test -n "$strategy" && strategy="-s $strategy"
+
 test -z "$rebase_root" -a $# -ge 1 -a $# -le 2 ||
 test ! -z "$rebase_root" -a $# -le 1 || usage
 test -d "$DOTEST" &&
diff --git a/git-rebase.sh b/git-rebase.sh
index a5ede42..ed1d4f5 100755
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
@@ -125,6 +125,7 @@ call_merge () {
 	then
 		GIT_MERGE_VERBOSITY=1 && export GIT_MERGE_VERBOSITY
 	fi
+	test -z "$strategy" && strategy=recursive
 	eval 'git-merge-$strategy' $strategy_opts '"$cmt^" -- "$hd" "$cmt"'
 	rv=$?
 	case "$rv" in
@@ -245,6 +246,7 @@ do
 		esac
 		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--$newopt")"
 		do_merge=t
+		test -z "$strategy" && strategy=recursive
 		;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
-- 
1.7.3.2.864.gbbb96
