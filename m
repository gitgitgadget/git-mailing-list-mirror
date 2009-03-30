From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 7/8] mergetool: refactor git-mergetool to use run_merge_tool
Date: Sun, 29 Mar 2009 22:03:47 -0700
Message-ID: <1238389428-69328-8-git-send-email-davvid@gmail.com>
References: <1238389428-69328-1-git-send-email-davvid@gmail.com>
 <1238389428-69328-2-git-send-email-davvid@gmail.com>
 <1238389428-69328-3-git-send-email-davvid@gmail.com>
 <1238389428-69328-4-git-send-email-davvid@gmail.com>
 <1238389428-69328-5-git-send-email-davvid@gmail.com>
 <1238389428-69328-6-git-send-email-davvid@gmail.com>
 <1238389428-69328-7-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 30 07:06:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo9hB-0004he-6p
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 07:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485AbZC3FE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 01:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754241AbZC3FE2
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 01:04:28 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:39536 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194AbZC3FEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 01:04:25 -0400
Received: by mail-qy0-f118.google.com with SMTP id 16so3307690qyk.33
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 22:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=swMYk+CkjRGZDqJMgDdv7sa7jWntQ3N2uFXT1jvmgr0=;
        b=gtX4GlP54lh768JceQEPGk+i4MNPtR4/av5YkTtfMa+CG/CQGm7NyqtFw5lIVzWOrR
         8uFTwRUnKFtL+aAtgPOrw7HwUnX/GDY/M2s06vMECb/xHNkpPRoyir4jRxWG1AWp+rm7
         MXvrQCfY2rFmSG8nUutkzD+c2y2eUfIYUuRV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LsU9Uqmdt++zntQdntEf3eOp2Meh08W9tOGK12QSLp4LHNpVkdNd34ts/Zz+nYWpqM
         fkbDwt+ZOQwktTlXD3ZAj5FmkX8RcIzlECK1un3Ba4356FWP7ufT6nWlqjL8viI9yrzk
         e3JSlmcoylSzit1dMjvl6EtVc4dB6D2bY+6gA=
Received: by 10.224.46.20 with SMTP id h20mr3383401qaf.182.1238389463700;
        Sun, 29 Mar 2009 22:04:23 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 6sm5427578qwk.7.2009.03.29.22.04.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Mar 2009 22:04:23 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.404.gb0085
In-Reply-To: <1238389428-69328-7-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115076>

This removes most of the duplicated code in git-mergetool.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool.sh |  106 ++----------------------------------------------------
 1 files changed, 3 insertions(+), 103 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index ec20030..0f5033c 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -191,109 +191,9 @@ merge_file () {
 		read ans
 	fi
 
-	case "$merge_tool" in
-	kdiff3)
-		if base_present ; then
-			("$merge_tool_path" --auto \
-				--L1 "$MERGED (Base)" \
-				--L2 "$MERGED (Local)" \
-				--L3 "$MERGED (Remote)" \
-				-o "$MERGED" "$BASE" "$LOCAL" "$REMOTE" \
-			 > /dev/null 2>&1)
-		else
-			("$merge_tool_path" --auto \
-				--L1 "$MERGED (Local)" \
-				--L2 "$MERGED (Remote)" \
-				-o "$MERGED" "$LOCAL" "$REMOTE" \
-			 > /dev/null 2>&1)
-		fi
-		status=$?
-		;;
-	tkdiff)
-		if base_present ; then
-			"$merge_tool_path" -a "$BASE" -o "$MERGED" "$LOCAL" "$REMOTE"
-		else
-			"$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"
-		fi
-		status=$?
-		;;
-	meld)
-		touch "$BACKUP"
-		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
-		check_unchanged
-		;;
-	vimdiff)
-		touch "$BACKUP"
-		"$merge_tool_path" -c "wincmd l" "$LOCAL" "$MERGED" "$REMOTE"
-		check_unchanged
-		;;
-	gvimdiff)
-		touch "$BACKUP"
-		"$merge_tool_path" -c "wincmd l" -f "$LOCAL" "$MERGED" "$REMOTE"
-		check_unchanged
-		;;
-	xxdiff)
-		touch "$BACKUP"
-		if base_present ; then
-			"$merge_tool_path" -X --show-merged-pane \
-				-R 'Accel.SaveAsMerged: "Ctrl-S"' \
-				-R 'Accel.Search: "Ctrl+F"' \
-				-R 'Accel.SearchForward: "Ctrl-G"' \
-				--merged-file "$MERGED" "$LOCAL" "$BASE" "$REMOTE"
-		else
-			"$merge_tool_path" -X --show-merged-pane \
-				-R 'Accel.SaveAsMerged: "Ctrl-S"' \
-				-R 'Accel.Search: "Ctrl+F"' \
-				-R 'Accel.SearchForward: "Ctrl-G"' \
-				--merged-file "$MERGED" "$LOCAL" "$REMOTE"
-		fi
-		check_unchanged
-		;;
-	opendiff)
-		touch "$BACKUP"
-		if base_present; then
-			"$merge_tool_path" "$LOCAL" "$REMOTE" \
-				-ancestor "$BASE" -merge "$MERGED" | cat
-		else
-			"$merge_tool_path" "$LOCAL" "$REMOTE" \
-				-merge "$MERGED" | cat
-		fi
-		check_unchanged
-		;;
-	ecmerge)
-		touch "$BACKUP"
-		if base_present; then
-			"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" \
-				--default --mode=merge3 --to="$MERGED"
-		else
-			"$merge_tool_path" "$LOCAL" "$REMOTE" \
-				--default --mode=merge2 --to="$MERGED"
-		fi
-		check_unchanged
-		;;
-	emerge)
-		if base_present ; then
-			"$merge_tool_path" -f emerge-files-with-ancestor-command \
-				"$LOCAL" "$REMOTE" "$BASE" "$(basename "$MERGED")"
-		else
-			"$merge_tool_path" -f emerge-files-command \
-				"$LOCAL" "$REMOTE" "$(basename "$MERGED")"
-		fi
-		status=$?
-		;;
-	*)
-		if test -n "$merge_tool_cmd"; then
-			if test "$merge_tool_trust_exit_code" = "false"; then
-				touch "$BACKUP"
-				( eval $merge_tool_cmd )
-				check_unchanged
-			else
-				( eval $merge_tool_cmd )
-				status=$?
-			fi
-		fi
-		;;
-	esac
+	run_merge_tool "$merge_tool"
+	status=$?
+
 	if test "$status" -ne 0; then
 		echo "merge of $MERGED failed" 1>&2
 		mv -- "$BACKUP" "$MERGED"
-- 
1.6.1.3
