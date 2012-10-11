From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetools/p4merge: Handle "/dev/null"
Date: Wed, 10 Oct 2012 20:22:36 -0700
Message-ID: <1349925756-87801-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Thu Oct 11 05:22:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM9MD-0006hJ-H0
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 05:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181Ab2JKDWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 23:22:35 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35019 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385Ab2JKDWe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 23:22:34 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1385093pbb.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 20:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ngRkh99gjOWyrwf9IVlfaxvOPSrEeGfxTifyAlfTBK8=;
        b=GbiJ9iiXzfs4C1JJPMSqZ764ifDlRzvkhJMHEZ+F2qjAGl4OAppISmOwBibDMhyQ63
         xu0HAW/iN1h/8VBRMTjzxYT20Po8zPQkpmKOvDh/ntGfejPqxahcWENQ+aT5Q4wtTIuw
         M/p8jP0LTV9TPmtWHtKmH52TGn5Hd3Skvb+2JZ1/mtS+qVmOEykZyMLD6Bv44aTn43k3
         eoRXI9KCJ4mu5NL4Ef4AvEtPKgrAEF5vVODE0CFLdvHBj4KMsESG6pzEYqvlrg3njCRW
         PpaweF5oT6R6RAL1q3si817sEXAWr9Md/q7bjxcAd1UE6iOdgRL5imzP/g3KXgRPfQya
         yVHg==
Received: by 10.66.85.10 with SMTP id d10mr67669725paz.52.1349925753826;
        Wed, 10 Oct 2012 20:22:33 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id ko8sm1993182pbc.40.2012.10.10.20.22.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 20:22:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207459>

p4merge does not properly handle the case where "/dev/null"
is passed as a filename.

Workaround it by creating a temporary file for this purpose.

Reported-by: Jeremy Morton <admin@game-point.net>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Jeremy, can you test this?

 mergetools/p4merge | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/mergetools/p4merge b/mergetools/p4merge
index 1a45c1b..295361a 100644
--- a/mergetools/p4merge
+++ b/mergetools/p4merge
@@ -1,5 +1,30 @@
 diff_cmd () {
+	# p4merge does not like /dev/null
+	rm_local=
+	rm_remote=
+	if test "/dev/null" = "$LOCAL"
+	then
+		LOCAL="./p4merge-dev-null.LOCAL.$$"
+		>"$LOCAL"
+		rm_local=true
+	fi
+	if test "/dev/null" = "$REMOTE"
+	then
+		REMOTE="./p4merge-dev-null.REMOTE.$$"
+		>"$REMOTE"
+		rm_remote=true
+	fi
+
 	"$merge_tool_path" "$LOCAL" "$REMOTE"
+
+	if test -n "$rm_local"
+	then
+		rm -f "$LOCAL"
+	fi
+	if test -n "$rm_remote"
+	then
+		rm -f "$REMOTE"
+	fi
 }
 
 merge_cmd () {
-- 
1.8.0.rc1
