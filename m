From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 10/10] mergetool: use run_mergetool from git-mergetool-lib
Date: Wed,  1 Apr 2009 05:55:14 -0700
Message-ID: <1238590514-41893-11-git-send-email-davvid@gmail.com>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com>
 <1238590514-41893-2-git-send-email-davvid@gmail.com>
 <1238590514-41893-3-git-send-email-davvid@gmail.com>
 <1238590514-41893-4-git-send-email-davvid@gmail.com>
 <1238590514-41893-5-git-send-email-davvid@gmail.com>
 <1238590514-41893-6-git-send-email-davvid@gmail.com>
 <1238590514-41893-7-git-send-email-davvid@gmail.com>
 <1238590514-41893-8-git-send-email-davvid@gmail.com>
 <1238590514-41893-9-git-send-email-davvid@gmail.com>
 <1238590514-41893-10-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com, charles@hashpling.org
X-From: git-owner@vger.kernel.org Wed Apr 01 14:58:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp01k-0004A8-4t
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 14:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757082AbZDAMz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 08:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760233AbZDAMz5
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 08:55:57 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:5877 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764723AbZDAMzs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 08:55:48 -0400
Received: by wa-out-1112.google.com with SMTP id j5so13742wah.21
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 05:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ewS1POHtMPVR0HXn8DMZoo5aqtL9IrFffrGj77biJy0=;
        b=g0F7/5aF1Bg6yBNNK6HlBk39ak/XAUwyAU3DYuexat1gMChVtP40szlMlYnhzhRbeo
         znVtt8qO/wHMWjdRvpHPkoUJRemblaBWikJYGvKBQw420+oieAd7rKWhJuqSm7AUVuyO
         +6UbMojkxNPmw4CiUndw2q9w5V0Y+tGyXPoGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZDNAkoLPoZ2U7vvU4GvOJQRu6n2EY2gVYNoHscb6RmvCf/6fMocWlFZRzMQw+p7HNC
         u7sQlH5E4DiukgftWiQEj2yDEj7hn5AMb+7jWwxNKyWHLVikTLn9TBO6k0wXD8PqGygx
         B+xNJmrme4CDTcJqyGkMGP8/iplnOXaVfbnFY=
Received: by 10.114.74.18 with SMTP id w18mr5227734waa.40.1238590546293;
        Wed, 01 Apr 2009 05:55:46 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m6sm1374317wag.14.2009.04.01.05.55.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 05:55:45 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.423.g442d
In-Reply-To: <1238590514-41893-10-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115389>

This refactors git-mergetool to use run_mergetool.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool.sh |   96 +++--------------------------------------------------
 1 files changed, 6 insertions(+), 90 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 957993c..2c6b325 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -190,96 +190,12 @@ merge_file () {
 	read ans
     fi
 
-    case "$merge_tool" in
-	kdiff3)
-	    if base_present ; then
-		("$merge_tool_path" --auto --L1 "$MERGED (Base)" --L2 "$MERGED (Local)" --L3 "$MERGED (Remote)" \
-		    -o "$MERGED" "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
-	    else
-		("$merge_tool_path" --auto --L1 "$MERGED (Local)" --L2 "$MERGED (Remote)" \
-		    -o "$MERGED" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
-	    fi
-	    status=$?
-	    ;;
-	tkdiff)
-	    if base_present ; then
-		"$merge_tool_path" -a "$BASE" -o "$MERGED" "$LOCAL" "$REMOTE"
-	    else
-		"$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"
-	    fi
-	    status=$?
-	    ;;
-	meld)
-	    touch "$BACKUP"
-	    "$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
-	    check_unchanged
-	    ;;
-	vimdiff)
-	    touch "$BACKUP"
-	    "$merge_tool_path" -c "wincmd l" "$LOCAL" "$MERGED" "$REMOTE"
-	    check_unchanged
-	    ;;
-	gvimdiff)
-	    touch "$BACKUP"
-	    "$merge_tool_path" -c "wincmd l" -f "$LOCAL" "$MERGED" "$REMOTE"
-	    check_unchanged
-	    ;;
-	xxdiff)
-	    touch "$BACKUP"
-	    if base_present ; then
-		"$merge_tool_path" -X --show-merged-pane \
-		    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
-		    -R 'Accel.Search: "Ctrl+F"' \
-		    -R 'Accel.SearchForward: "Ctrl-G"' \
-		    --merged-file "$MERGED" "$LOCAL" "$BASE" "$REMOTE"
-	    else
-		"$merge_tool_path" -X --show-merged-pane \
-		    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
-		    -R 'Accel.Search: "Ctrl+F"' \
-		    -R 'Accel.SearchForward: "Ctrl-G"' \
-		    --merged-file "$MERGED" "$LOCAL" "$REMOTE"
-	    fi
-	    check_unchanged
-	    ;;
-	opendiff)
-	    touch "$BACKUP"
-	    if base_present; then
-		"$merge_tool_path" "$LOCAL" "$REMOTE" -ancestor "$BASE" -merge "$MERGED" | cat
-	    else
-		"$merge_tool_path" "$LOCAL" "$REMOTE" -merge "$MERGED" | cat
-	    fi
-	    check_unchanged
-	    ;;
-	ecmerge)
-	    touch "$BACKUP"
-	    if base_present; then
-		"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" --default --mode=merge3 --to="$MERGED"
-	    else
-		"$merge_tool_path" "$LOCAL" "$REMOTE" --default --mode=merge2 --to="$MERGED"
-	    fi
-	    check_unchanged
-	    ;;
-	emerge)
-	    if base_present ; then
-		"$merge_tool_path" -f emerge-files-with-ancestor-command "$LOCAL" "$REMOTE" "$BASE" "$(basename "$MERGED")"
-	    else
-		"$merge_tool_path" -f emerge-files-command "$LOCAL" "$REMOTE" "$(basename "$MERGED")"
-	    fi
-	    status=$?
-	    ;;
-	*)
-	    if test -n "$merge_tool_cmd"; then
-		if test "$merge_tool_trust_exit_code" = "false"; then
-		    touch "$BACKUP"
-		    ( eval $merge_tool_cmd )
-		    check_unchanged
-		else
-		    ( eval $merge_tool_cmd )
-		    status=$?
-		fi
-	    fi
-	    ;;
-    esac
+    present=false
+    base_present &&
+    present=true
+
+    run_mergetool "$merge_tool" "$present"
+    status=$?
     if test "$status" -ne 0; then
 	echo "merge of $MERGED failed" 1>&2
 	mv -- "$BACKUP" "$MERGED"
-- 
1.6.1.3
