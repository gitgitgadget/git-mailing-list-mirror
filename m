From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 4/5 v2] contrib/diffall: eliminate duplicate while loops
Date: Wed, 14 Mar 2012 12:38:05 -0400
Message-ID: <1331743086-32304-5-git-send-email-tim.henigan@gmail.com>
References: <1331743086-32304-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 14 17:40:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7rFI-0004ws-5i
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 17:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317Ab2CNQkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 12:40:11 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45019 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990Ab2CNQkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 12:40:09 -0400
Received: by yenl12 with SMTP id l12so1995477yen.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 09:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WywLFVITnICVD1gvhJO2BPDQEWtE7EEOs8wnrrvcZrY=;
        b=QrrUmSvg4VxH9XxZta/wVPisnao19w12BexE+locrWWsh8Y+JhHQidHcHxPQERA6eA
         8zLgfs3cLUfjF2xKWDCWAy6pI0JMCCrxYVFHVmIW1NloV4CgaAJzldH80e4I1H0YBGrc
         ZJtw5P2d9AehilTNDQKmFIwdhZaNM8UCuaQAwO6416SBvLe4RS0tEDBlaioEe43napDO
         DVpzyZ8tBOacanDNfeN2kdf35qjhcpL3XGEhrgDLpX/WIWVOwaR8KbVQ+hEDnSDD1jiO
         sH5NDk5NAV6vT8Agb5xsI5gkBJyo82WgHLe4SxF+00/GAX9idP1HPNZG5zLLn21kWTZs
         TauA==
Received: by 10.224.181.198 with SMTP id bz6mr3713659qab.74.1331743208878;
        Wed, 14 Mar 2012 09:40:08 -0700 (PDT)
Received: from localhost ([99.38.69.118])
        by mx.google.com with ESMTPS id i19sm9613591qad.19.2012.03.14.09.40.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Mar 2012 09:40:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc0
In-Reply-To: <1331743086-32304-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193131>

There were 3 instances of a 'while read; do' that used identical logic
to populate '/tmp/right_dir'. This commit groups them into a single loop.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

v2 did not affect this patch.


 contrib/diffall/git-diffall |   24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/contrib/diffall/git-diffall b/contrib/diffall/git-diffall
index f981ac1..91a31c8 100755
--- a/contrib/diffall/git-diffall
+++ b/contrib/diffall/git-diffall
@@ -179,38 +179,32 @@ fi
 mkdir -p "$tmp/$left_dir" "$tmp/$right_dir"
 
 # Populate the tmp/right_dir directory with the files to be compared
-if test -n "$right"
-then
-	while read name
-	do
+while read name
+do
+	if test -n "$right"
+	then
 		ls_list=$(git ls-tree $right "$name")
 		if test -n "$ls_list"
 		then
 			mkdir -p "$tmp/$right_dir/$(dirname "$name")"
 			git show "$right":"$name" >"$tmp/$right_dir/$name" || true
 		fi
-	done < "$tmp/filelist"
-elif test -n "$compare_staged"
-then
-	while read name
-	do
+	elif test -n "$compare_staged"
+	then
 		ls_list=$(git ls-files -- "$name")
 		if test -n "$ls_list"
 		then
 			mkdir -p "$tmp/$right_dir/$(dirname "$name")"
 			git show :"$name" >"$tmp/$right_dir/$name"
 		fi
-	done < "$tmp/filelist"
-else
-	while read name
-	do
+	else
 		if test -e "$name"
 		then
 			mkdir -p "$tmp/$right_dir/$(dirname "$name")"
 			cp "$name" "$tmp/$right_dir/$name"
 		fi
-	done < "$tmp/filelist"
-fi
+	fi
+done < "$tmp/filelist"
 
 # Populate the tmp/left_dir directory with the files to be compared
 while read name
-- 
1.7.10.rc0
