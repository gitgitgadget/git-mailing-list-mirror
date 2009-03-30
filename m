From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 8/8] difftool: refactor git-difftool-helper to use run_merge_tool
Date: Sun, 29 Mar 2009 22:03:48 -0700
Message-ID: <1238389428-69328-9-git-send-email-davvid@gmail.com>
References: <1238389428-69328-1-git-send-email-davvid@gmail.com>
 <1238389428-69328-2-git-send-email-davvid@gmail.com>
 <1238389428-69328-3-git-send-email-davvid@gmail.com>
 <1238389428-69328-4-git-send-email-davvid@gmail.com>
 <1238389428-69328-5-git-send-email-davvid@gmail.com>
 <1238389428-69328-6-git-send-email-davvid@gmail.com>
 <1238389428-69328-7-git-send-email-davvid@gmail.com>
 <1238389428-69328-8-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 30 07:06:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo9hB-0004he-Un
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 07:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559AbZC3FEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 01:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755455AbZC3FE3
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 01:04:29 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:39536 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164AbZC3FE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 01:04:28 -0400
Received: by mail-qy0-f118.google.com with SMTP id 16so3307690qyk.33
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 22:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=EHmJfVpOlfRAOjLI6fI3n/3oIzBxOunnLf/6IpdeK0o=;
        b=OBLCiz5E9IHbZPVjxDB7SaKol9aMDA8Qmrud+db9kxluWExRF6hDwwsJOD0tvrKau1
         ot87GfzFsgEPIwNztWQT/7jelgp9v6X0z/IVW41dHrBNm3+VzAmapyMHna5joM/6G1+o
         RJfKqfLWOcLdGG9gMTlYZ9rdvWhc5xOuy15E8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dKMXIzsRWyfiiHZiA9Sgus6VQtlqflb/2Y5vf1mp874Yny/vxJIC4Bu53n2dnWa9Mc
         aCQsL9+o7e4MUkS0oV3Vm4pTuCKVkSPhPPVlazhscXg8iGfLYexmsQY7Tl6x5Yo1b3NG
         dbQxReNoOY1M6bo5kpTv74X1yg6w50cJ89CLs=
Received: by 10.224.28.70 with SMTP id l6mr2867465qac.72.1238389466498;
        Sun, 29 Mar 2009 22:04:26 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 6sm5411846qwk.27.2009.03.29.22.04.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Mar 2009 22:04:25 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.404.gb0085
In-Reply-To: <1238389428-69328-8-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115077>

This removes most of the duplicated code in git-difftool-helper.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool-helper.sh |   67 ++++-------------------------------------------
 1 files changed, 6 insertions(+), 61 deletions(-)

diff --git a/git-difftool-helper.sh b/git-difftool-helper.sh
index 2051a35..d90277b 100755
--- a/git-difftool-helper.sh
+++ b/git-difftool-helper.sh
@@ -10,6 +10,11 @@
 TOOL_MODE=diff
 . git-sh-tools
 
+base_present()
+{
+	return 1
+}
+
 # difftool.prompt controls the default prompt/no-prompt behavior
 # and is overridden with $GIT_DIFFTOOL*_PROMPT.
 should_prompt () {
@@ -42,67 +47,7 @@ launch_merge_tool () {
 	fi
 
 	# Run the appropriate merge tool command
-	case "$merge_tool" in
-	kdiff3)
-		basename=$(basename "$MERGED")
-		"$merge_tool_path" --auto \
-			--L1 "$basename (A)" \
-			--L2 "$basename (B)" \
-			-o "$MERGED" "$LOCAL" "$REMOTE" \
-			> /dev/null 2>&1
-		;;
-
-	kompare)
-		"$merge_tool_path" "$LOCAL" "$REMOTE"
-		;;
-
-	tkdiff)
-		"$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"
-		;;
-
-	meld)
-		"$merge_tool_path" "$LOCAL" "$REMOTE"
-		;;
-
-	vimdiff)
-		"$merge_tool_path" -c "wincmd l" "$LOCAL" "$REMOTE"
-		;;
-
-	gvimdiff)
-		"$merge_tool_path" -c "wincmd l" -f "$LOCAL" "$REMOTE"
-		;;
-
-	xxdiff)
-		"$merge_tool_path" \
-			-X \
-			-R 'Accel.SaveAsMerged: "Ctrl-S"' \
-			-R 'Accel.Search: "Ctrl+F"' \
-			-R 'Accel.SearchForward: "Ctrl-G"' \
-			--merged-file "$MERGED" \
-			"$LOCAL" "$REMOTE"
-		;;
-
-	opendiff)
-		"$merge_tool_path" "$LOCAL" "$REMOTE" \
-			-merge "$MERGED" | cat
-		;;
-
-	ecmerge)
-		"$merge_tool_path" "$LOCAL" "$REMOTE" \
-			--default --mode=merge2 --to="$MERGED"
-		;;
-
-	emerge)
-		"$merge_tool_path" -f emerge-files-command \
-			"$LOCAL" "$REMOTE" "$(basename "$MERGED")"
-		;;
-
-	*)
-		if test -n "$merge_tool_cmd"; then
-			( eval $merge_tool_cmd )
-		fi
-		;;
-	esac
+	run_merge_tool "$merge_tool"
 }
 
 # Allow GIT_DIFF_TOOL and GIT_MERGE_TOOL to provide default values
-- 
1.6.1.3
