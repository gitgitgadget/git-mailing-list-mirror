From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/3] mergetool-lib: specialize kdiff3 options when in diff mode
Date: Thu,  2 Apr 2009 03:30:44 -0700
Message-ID: <1238668246-762-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 02 12:33:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpKET-0000C6-O1
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 12:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761800AbZDBKa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 06:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760791AbZDBKa5
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 06:30:57 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:1874 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757781AbZDBKaz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 06:30:55 -0400
Received: by rv-out-0506.google.com with SMTP id f9so556998rvb.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2009 03:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=MMZSCxF3CdTFiYat4eiww99bxrgA5t/v5wyl+4B4ixk=;
        b=AIDDNUWFSBzjzRUIdYR+Rv+gyn2XD9fX6IBXQEtNCryidh1UFLG4k5O5p9TeHQdHUz
         KCJWKfI9kaH0Bt9VozT9wCIPC/ksvFORH/HUzAScGcQ2nxNJ38pCQ84vOJU5hK2GJ7St
         CgWSFIe5mJAbzwvtbljBJRlL+sT1zuCLQOYlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=KR+9bcruaKviGRwp4EPNJ9SyHilwg5HHCnRzCQo+13fVtxAwnaTIL7hwEulPmimDR7
         GKnlfwZGi/ZQPGWkYHJYiG74gph6+EYezasLykQ/gdyTh2g5sjMEZ4z4AToco8xg0Re0
         gCwaIeydJc8++Y82v1CC3ufaRosp3HIDZxXao=
Received: by 10.114.202.15 with SMTP id z15mr5833289waf.67.1238668253355;
        Thu, 02 Apr 2009 03:30:53 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id j15sm991653waf.55.2009.04.02.03.30.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Apr 2009 03:30:52 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.469.gdffc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115452>

kdiff3 should only show two files when in diff mode.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool-lib.sh |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/git-mergetool-lib.sh b/git-mergetool-lib.sh
index d28be68..e2d074d 100644
--- a/git-mergetool-lib.sh
+++ b/git-mergetool-lib.sh
@@ -67,9 +67,19 @@ run_mergetool () {
 			 --L1 "$MERGED (Base)" --L2 "$MERGED (Local)" --L3 "$MERGED (Remote)" \
 			 -o "$MERGED" "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
 		else
-			("$merge_tool_path" --auto \
-			 --L1 "$MERGED (Local)" --L2 "$MERGED (Remote)" \
-			 -o "$MERGED" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
+			if merge_mode; then
+				("$merge_tool_path" --auto \
+				 --L1 "$MERGED (Local)" \
+				 --L2 "$MERGED (Remote)" \
+				 -o "$MERGED" "$LOCAL" "$REMOTE" \
+				> /dev/null 2>&1)
+			else
+				("$merge_tool_path" --auto \
+				 --L1 "$MERGED (A)" \
+				 --L2 "$MERGED (B)" \
+				 "$LOCAL" "$REMOTE" \
+				> /dev/null 2>&1)
+			fi
 		fi
 		status=$?
 		;;
-- 
1.6.2.1.303.g63699
