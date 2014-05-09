From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 17/25] contrib: remove 'git-resurrect'
Date: Thu,  8 May 2014 19:58:28 -0500
Message-ID: <1399597116-1851-18-git-send-email-felipe.contreras@gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 03:11:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiZL2-0000zM-Ek
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 03:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbaEIBKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 21:10:50 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:61068 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932073AbaEIBKs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 21:10:48 -0400
Received: by mail-yh0-f51.google.com with SMTP id f10so3126215yha.38
        for <git@vger.kernel.org>; Thu, 08 May 2014 18:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d/YG2zbxQL7Hhthurskkv0mtSuHdd4BGXorxKABKvVk=;
        b=jWKPdgGURYTw4LWhKVzWCXtgX9dQ49L8aqm2977Job86jqiliuzdvgaEasb7fHezlS
         8nQsR6FdyanXZjdeuGn6bIqFHjRoUBc59ijmDwNbMIUudEUYwK6szizKigV3ANe6QuMz
         bur2I58X7+Cx6jiMKzU8H7fInUUBiO8DzmjbQpp80zEB+ZJ7PFnEi/4je6DXtGB/3ghB
         o9nXiPOl8G/d1bMO3pij0h7dXVvq9RYKM8/zqqd27rQieGaEYVwN2baqTisCtavvmAYg
         Jh95K/5zoQQFfmgi7ySa35gEnMmsFV4rIXBhnxWmzMrNIQyq3mCdscN2NOrigg6qJwfp
         crGg==
X-Received: by 10.236.62.130 with SMTP id y2mr10214255yhc.158.1399597848429;
        Thu, 08 May 2014 18:10:48 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id r23sm3911339yhb.46.2014.05.08.18.10.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 18:10:47 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.27.gbce2056
In-Reply-To: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248481>

No activity, no documentation, no tests, no chance of ever graduating.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/git-resurrect.sh | 182 -----------------------------------------------
 1 file changed, 182 deletions(-)
 delete mode 100755 contrib/git-resurrect.sh

diff --git a/contrib/git-resurrect.sh b/contrib/git-resurrect.sh
deleted file mode 100755
index d7e97bb..0000000
--- a/contrib/git-resurrect.sh
+++ /dev/null
@@ -1,182 +0,0 @@
-#!/bin/sh
-
-USAGE="[-a] [-r] [-m] [-t] [-n] [-b <newname>] <name>"
-LONG_USAGE="git-resurrect attempts to find traces of a branch tip
-called <name>, and tries to resurrect it.  Currently, the reflog is
-searched for checkout messages, and with -r also merge messages.  With
--m and -t, the history of all refs is scanned for Merge <name> into
-other/Merge <other> into <name> (respectively) commit subjects, which
-is rather slow but allows you to resurrect other people's topic
-branches."
-
-OPTIONS_KEEPDASHDASH=
-OPTIONS_STUCKLONG=
-OPTIONS_SPEC="\
-git resurrect $USAGE
---
-b,branch=            save branch as <newname> instead of <name>
-a,all                same as -l -r -m -t
-k,keep-going         full rev-list scan (instead of first match)
-l,reflog             scan reflog for checkouts (enabled by default)
-r,reflog-merges      scan for merges recorded in reflog
-m,merges             scan for merges into other branches (slow)
-t,merge-targets      scan for merges of other branches into <name>
-n,dry-run            don't recreate the branch"
-
-. git-sh-setup
-
-search_reflog () {
-        sed -ne 's~^\([^ ]*\) .*\tcheckout: moving from '"$1"' .*~\1~p' \
-                < "$GIT_DIR"/logs/HEAD
-}
-
-search_reflog_merges () {
-	git rev-parse $(
-		sed -ne 's~^[^ ]* \([^ ]*\) .*\tmerge '"$1"':.*~\1^2~p' \
-			< "$GIT_DIR"/logs/HEAD
-	)
-}
-
-_x40="[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]"
-_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
-
-search_merges () {
-        git rev-list --all --grep="Merge branch '$1'" \
-                --pretty=tformat:"%P %s" |
-        sed -ne "/^$_x40 \($_x40\) Merge .*/ {s//\1/p;$early_exit}"
-}
-
-search_merge_targets () {
-	git rev-list --all --grep="Merge branch '[^']*' into $branch\$" \
-		--pretty=tformat:"%H %s" --all |
-	sed -ne "/^\($_x40\) Merge .*/ {s//\1/p;$early_exit} "
-}
-
-dry_run=
-early_exit=q
-scan_reflog=t
-scan_reflog_merges=
-scan_merges=
-scan_merge_targets=
-new_name=
-
-while test "$#" != 0; do
-	case "$1" in
-	    -b|--branch)
-		shift
-		new_name="$1"
-		;;
-	    -n|--dry-run)
-		dry_run=t
-		;;
-	    --no-dry-run)
-		dry_run=
-		;;
-	    -k|--keep-going)
-		early_exit=
-		;;
-	    --no-keep-going)
-		early_exit=q
-		;;
-	    -m|--merges)
-		scan_merges=t
-		;;
-	    --no-merges)
-		scan_merges=
-		;;
-	    -l|--reflog)
-		scan_reflog=t
-		;;
-	    --no-reflog)
-		scan_reflog=
-		;;
-	    -r|--reflog_merges)
-		scan_reflog_merges=t
-		;;
-	    --no-reflog_merges)
-		scan_reflog_merges=
-		;;
-	    -t|--merge-targets)
-		scan_merge_targets=t
-		;;
-	    --no-merge-targets)
-		scan_merge_targets=
-		;;
-	    -a|--all)
-		scan_reflog=t
-		scan_reflog_merges=t
-		scan_merges=t
-		scan_merge_targets=t
-		;;
-	    --)
-		shift
-		break
-		;;
-	    *)
-		usage
-		;;
-	esac
-	shift
-done
-
-test "$#" = 1 || usage
-
-all_strategies="$scan_reflog$scan_reflog_merges$scan_merges$scan_merge_targets"
-if test -z "$all_strategies"; then
-	die "must enable at least one of -lrmt"
-fi
-
-branch="$1"
-test -z "$new_name" && new_name="$branch"
-
-if test ! -z "$scan_reflog"; then
-	if test -r "$GIT_DIR"/logs/HEAD; then
-		candidates="$(search_reflog $branch)"
-	else
-		die 'reflog scanning requested, but' \
-			'$GIT_DIR/logs/HEAD not readable'
-	fi
-fi
-if test ! -z "$scan_reflog_merges"; then
-	if test -r "$GIT_DIR"/logs/HEAD; then
-		candidates="$candidates $(search_reflog_merges $branch)"
-	else
-		die 'reflog scanning requested, but' \
-			'$GIT_DIR/logs/HEAD not readable'
-	fi
-fi
-if test ! -z "$scan_merges"; then
-	candidates="$candidates $(search_merges $branch)"
-fi
-if test ! -z "$scan_merge_targets"; then
-	candidates="$candidates $(search_merge_targets $branch)"
-fi
-
-candidates="$(git rev-parse $candidates | sort -u)"
-
-if test -z "$candidates"; then
-	hint=
-	test "z$all_strategies" != "ztttt" \
-		&& hint=" (maybe try again with -a)"
-	die "no candidates for $branch found$hint"
-fi
-
-echo "** Candidates for $branch **"
-for cmt in $candidates; do
-	git --no-pager log --pretty=tformat:"%ct:%h [%cr] %s" --abbrev-commit -1 $cmt
-done \
-| sort -n | cut -d: -f2-
-
-newest="$(git rev-list -1 $candidates)"
-if test ! -z "$dry_run"; then
-	printf "** Most recent: "
-	git --no-pager log -1 --pretty=tformat:"%h %s" $newest
-elif ! git rev-parse --verify --quiet $new_name >/dev/null; then
-	printf "** Restoring $new_name to "
-	git --no-pager log -1 --pretty=tformat:"%h %s" $newest
-	git branch $new_name $newest
-else
-	printf "Most recent: "
-	git --no-pager log -1 --pretty=tformat:"%h %s" $newest
-	echo "** $new_name already exists, doing nothing"
-fi
-- 
1.9.2+fc1.27.gbce2056
