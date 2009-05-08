From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH/RFC RESEND 2/2] Automated test script for 'git subtree'.
Date: Fri,  8 May 2009 18:39:09 -0400
Message-ID: <1241822349-27470-3-git-send-email-apenwarr@gmail.com>
References: <1241822349-27470-1-git-send-email-apenwarr@gmail.com>
 <1241822349-27470-2-git-send-email-apenwarr@gmail.com>
Cc: Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 09 00:42:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Ym7-0003a6-CI
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 00:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755613AbZEHWmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 18:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754911AbZEHWmP
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 18:42:15 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:35698 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081AbZEHWmN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 18:42:13 -0400
Received: by mail-fx0-f158.google.com with SMTP id 2so1646385fxm.37
        for <git@vger.kernel.org>; Fri, 08 May 2009 15:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=NRtDF8MbAHCrFEQeGby/djmwA1Lj4SGgJU+GTDTJEqg=;
        b=OakJl0M7hgqIAA15BEkmX/pxYRDfCgBpRv6hJf0gBuPl1+9hslFq/I30GwEwmy+qvB
         VV6uxKHoUJokCVTZAiOG44fQITqLduGMunVEj5GWGVzQexXopoJ1syKifHaYyTyFZjCH
         Td+s3pYcsy1l62KXgf237BbEkTvsQ8rMC59Do=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=c7oyH2OJVqRHwaZxiafCplPunWQ9qcDmztBKhMOSDLn5lUjQk14lKuIglo2jHEHfpR
         8jMUprMU3GHjtKEkmbbXtlGhwFhEh6dx0Gdes3hLDMW88vHts2otcqK+wr79ZBlLrQdm
         cjFjNNFC4+bDt0Uv/xxdSQKy9S/k3I1i3vZ0g=
Received: by 10.103.229.12 with SMTP id g12mr2678903mur.87.1241822533686;
        Fri, 08 May 2009 15:42:13 -0700 (PDT)
Received: from afterlife.apenwarr.local (CPE001c10b0d47a-CM00195efb67e8.cpe.net.cable.rogers.com [99.249.243.14])
        by mx.google.com with ESMTPS id n10sm3341224mue.47.2009.05.08.15.42.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 May 2009 15:42:12 -0700 (PDT)
Received: by afterlife.apenwarr.local (sSMTP sendmail emulation); Fri, 08 May 2009 18:39:26 -0400
X-Mailer: git-send-email 1.6.3.2.g3d624
In-Reply-To: <1241822349-27470-2-git-send-email-apenwarr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118637>

TEMPORARY: this script hasn't yet been integrated into the main git unit
tests; it runs standalone for the moment.
---
 subtree-test.sh |  206 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 206 insertions(+), 0 deletions(-)
 create mode 100755 subtree-test.sh

diff --git a/subtree-test.sh b/subtree-test.sh
new file mode 100755
index 0000000..38dff7a
--- /dev/null
+++ b/subtree-test.sh
@@ -0,0 +1,206 @@
+#!/bin/bash
+. shellopts.sh
+set -e
+
+create()
+{
+	echo "$1" >"$1"
+	git add "$1"
+}
+
+check()
+{
+	echo
+	echo "check:" "$@"
+	if "$@"; then
+		echo ok
+		return 0
+	else
+		echo FAILED
+		exit 1
+	fi
+}
+
+check_equal()
+{
+	echo
+	echo "check a:" "{$1}"
+	echo "      b:" "{$2}"
+	if [ "$1" = "$2" ]; then
+		return 0
+	else
+		echo FAILED
+		exit 1
+	fi
+}
+
+fixnl()
+{	
+	t=""
+	while read x; do
+		t="$t$x "
+	done
+	echo $t
+}
+
+multiline()
+{
+	while read x; do
+		set -- $x
+		for d in "$@"; do
+			echo "$d"
+		done
+	done
+}
+
+rm -rf mainline subproj
+mkdir mainline subproj
+
+cd subproj
+git init
+
+create sub1
+git commit -m 'sub1'
+git branch sub1
+git branch -m master subproj
+check true
+
+create sub2
+git commit -m 'sub2'
+git branch sub2
+
+create sub3
+git commit -m 'sub3'
+git branch sub3
+
+cd ../mainline
+git init
+create main4
+git commit -m 'main4'
+git branch -m master mainline
+
+git fetch ../subproj sub1
+git branch sub1 FETCH_HEAD
+git subtree add --prefix=subdir FETCH_HEAD
+
+# this shouldn't actually do anything, since FETCH_HEAD is already a parent
+git merge -m 'merge -s -ours' -s ours FETCH_HEAD
+
+create subdir/main-sub5
+git commit -m 'main-sub5'
+
+create main6
+git commit -m 'main6 boring'
+
+create subdir/main-sub7
+git commit -m 'main-sub7'
+
+git fetch ../subproj sub2
+git branch sub2 FETCH_HEAD
+git subtree merge --prefix=subdir FETCH_HEAD
+git branch pre-split
+
+spl1=$(git subtree split --annotate='*' \
+		--prefix subdir --onto FETCH_HEAD --rejoin)
+echo "spl1={$spl1}"
+git branch spl1 "$spl1"
+
+create subdir/main-sub8
+git commit -m 'main-sub8'
+
+cd ../subproj
+git fetch ../mainline spl1
+git branch spl1 FETCH_HEAD
+git merge FETCH_HEAD
+
+create sub9
+git commit -m 'sub9'
+
+cd ../mainline
+split2=$(git subtree split --annotate='*' --prefix subdir --rejoin)
+git branch split2 "$split2"
+
+create subdir/main-sub10
+git commit -m 'main-sub10'
+
+spl3=$(git subtree split --annotate='*' --prefix subdir --rejoin)
+git branch spl3 "$spl3"
+
+cd ../subproj
+git fetch ../mainline spl3
+git branch spl3 FETCH_HEAD
+git merge FETCH_HEAD
+git branch subproj-merge-spl3
+
+chkm="main4 main6"
+chkms="main-sub10 main-sub5 main-sub7 main-sub8"
+chkms_sub=$(echo $chkms | multiline | sed 's,^,subdir/,' | fixnl)
+chks="sub1 sub2 sub3 sub9"
+chks_sub=$(echo $chks | multiline | sed 's,^,subdir/,' | fixnl)
+
+# make sure exactly the right set of files ends up in the subproj
+subfiles=$(git ls-files | fixnl)
+check_equal "$subfiles" "$chkms $chks"
+
+# make sure the subproj history *only* contains commits that affect the subdir.
+allchanges=$(git log --name-only --pretty=format:'' | sort | fixnl)
+check_equal "$allchanges" "$chkms $chks"
+
+cd ../mainline
+git fetch ../subproj subproj-merge-spl3
+git branch subproj-merge-spl3 FETCH_HEAD
+git subtree pull --prefix=subdir ../subproj subproj-merge-spl3
+
+# make sure exactly the right set of files ends up in the mainline
+mainfiles=$(git ls-files | fixnl)
+check_equal "$mainfiles" "$chkm $chkms_sub $chks_sub"
+
+# make sure each filename changed exactly once in the entire history.
+# 'main-sub??' and '/subdir/main-sub??' both change, because those are the
+# changes that were split into their own history.  And 'subdir/sub??' never
+# change, since they were *only* changed in the subtree branch.
+allchanges=$(git log --name-only --pretty=format:'' | sort | fixnl)
+check_equal "$allchanges" "$chkm $chkms $chks $chkms_sub"
+
+# make sure the --rejoin commits never make it into subproj
+check_equal "$(git log --pretty=format:'%s' HEAD^2 | grep -i split)" ""
+
+# make sure no 'git subtree' tagged commits make it into subproj. (They're
+# meaningless to subproj since one side of the merge refers to the mainline)
+check_equal "$(git log --pretty=format:'%s%n%b' HEAD^2 | grep 'git-subtree.*:')" ""
+
+# make sure no patch changes more than one file.  The original set of commits
+# changed only one file each.  A multi-file change would imply that we pruned
+# commits too aggressively.
+joincommits()
+{
+	commit=
+	all=
+	while read x y; do
+		echo "{$x}" >&2
+		if [ -z "$x" ]; then
+			continue
+		elif [ "$x" = "commit:" ]; then
+			if [ -n "$commit" ]; then
+				echo "$commit $all"
+				all=
+			fi
+			commit="$y"
+		else
+			all="$all $y"
+		fi
+	done
+	echo "$commit $all"
+}
+x=
+git log --pretty=format:'commit: %H' | joincommits |
+(	while read commit a b; do
+		echo "Verifying commit $commit"
+		check_equal "$b" ""
+		x=1
+	done
+	check_equal "$x" 1
+) || exit 1
+
+echo
+echo 'ok'
-- 
1.6.3.2.g3d624
