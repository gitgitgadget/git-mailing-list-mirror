From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 1/3] git p4: add test for tag import/export enabled via config
Date: Fri, 11 May 2012 07:25:16 +0100
Message-ID: <1336717518-4214-2-git-send-email-luke@diamand.org>
References: <1336717518-4214-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Pete Wyckoff <pw@padd.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 08:25:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSjIA-0004Qx-Gy
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 08:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758017Ab2EKGZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 02:25:28 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:51738 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755994Ab2EKGZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 02:25:25 -0400
Received: by wibhr2 with SMTP id hr2so1334643wib.1
        for <git@vger.kernel.org>; Thu, 10 May 2012 23:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=n+yoHAr0lOZ0N68SVcXmqkvzq1S11zpKv/UD3ReKft0=;
        b=A+MyIyvihQMYCYMYxY35s+hIZLmcIZkDGkpNqzP+fCbiNu+2CapMi8WbLglzLo1jpK
         SoHgmzl5LaqYTeAdioyVakR/ASzel7MfnKcsZvlJC4TroOTJI3QU9LnZMxo21Ibi/S0e
         jw1Gt3thnpmwigoY98xNZ9siQ92uSdxASW4iE2sJdlDgmS3n/X2RCzetx1k2rIID0fP7
         YnF4SsPo7kuJYDjTlSGWuCAQBYtnA2mcIDs7hxdgKaHjEWKpJgC48fhszq7EouhhlnYP
         13a7rbh3jDPWmmleSzAcHRsJB6vMz0fOKkVHYm1cKpp2BzCAazhZVeCh+0iY926V355T
         j9og==
Received: by 10.216.139.79 with SMTP id b57mr643586wej.37.1336717523952;
        Thu, 10 May 2012 23:25:23 -0700 (PDT)
Received: from halilbut.local.diamand.org (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id h8sm13801629wix.4.2012.05.10.23.25.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 23:25:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.221.g3bf1d
In-Reply-To: <1336717518-4214-1-git-send-email-luke@diamand.org>
X-Gm-Message-State: ALoCoQmbZMg01sRHlWSLqc2V8yznKFSI1j5evn34IvqHJlxHtsC8nXYMjajTQkk54WcGYRS5fvho
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197657>

This adds a test for git p4 to check it can import/export tags
when enabled via a config variable rather than on the command
line.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9811-git-p4-label-import.sh |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index fb00ffa..095238f 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -195,6 +195,26 @@ test_expect_success 'tag that cannot be exported' '
 	)
 '
 
+test_expect_success 'use git config to enable import/export of tags' '
+	git p4 clone --verbose --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+		git config git-p4.exportLabels true &&
+		git config git-p4.importLabels true &&
+		git tag CFG_A_GIT_TAG &&
+		git p4 rebase --verbose &&
+		git p4 submit --verbose &&
+		git tag &&
+		git tag | grep TAG_F1_1
+	) &&
+	(
+		cd "$cli" &&
+		p4 labels &&
+		p4 labels | grep CFG_A_GIT_TAG
+	)
+'
+
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.10.282.g2120.dirty
