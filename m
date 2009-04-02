From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 10/10] mergetool: use run_mergetool from git-mergetool-lib
Date: Wed,  1 Apr 2009 21:20:40 -0700
Message-ID: <1238646040-46008-3-git-send-email-davvid@gmail.com>
References: <1238646040-46008-1-git-send-email-davvid@gmail.com>
 <1238646040-46008-2-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, markus.heidelberg@web.de,
	charles@hashpling.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 02 06:22:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpERx-0002z2-OE
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 06:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbZDBEU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 00:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbZDBEU5
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 00:20:57 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:31768 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbZDBEUy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 00:20:54 -0400
Received: by rv-out-0506.google.com with SMTP id f9so400794rvb.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 21:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=k2d02y6HHfdsEbnQPz4NMoAZtarc686kV2p9igSFH9k=;
        b=D/QB41L881CthxCxGnLEGpXUNIRTkYM5cknw5bmkOtSIHDMYygBKsRcWTCszpneW64
         AgniWPw/2nbBu5C1TYY2OmBolRM2LcpK44r2caq+omZX/xkPEUKyUvLbQO87UlJB6MNa
         Lu6uFalIR2Ol4x1j+0+yFQ+w+0byHgRtfsIac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ohRm+jAWemUksI2XPnTebkp/7OwfwccTARHIo05mIso9qLYVHASKS65BEz8qZOQawm
         eNrBx8xTI92BLT6StLx4TUoKGPe57GHos3wCDt3iWWFQYvAfe73mYG6le/E//fNuRq7W
         v921TP4FaRuyRsLIcJqY9XBlPgSV3+mIiW8W8=
Received: by 10.141.201.1 with SMTP id d1mr4337052rvq.142.1238646053427;
        Wed, 01 Apr 2009 21:20:53 -0700 (PDT)
Received: from localhost (isrfasc7a1-gw.disneyanimation.com [12.188.26.241])
        by mx.google.com with ESMTPS id g14sm1733222rvb.29.2009.04.01.21.20.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 21:20:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.423.g442d
In-Reply-To: <1238646040-46008-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115436>

This refactors git-mergetool to use run_mergetool.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

Includes fixups from Markus

 git-mergetool.sh |   96 +++--------------------------------------------------
 1 files changed, 6 insertions(+), 90 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 957993c..fd81ad7 100755
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
+
     if test "$status" -ne 0; then
 	echo "merge of $MERGED failed" 1>&2
 	mv -- "$BACKUP" "$MERGED"
-- 
1.6.1.3
