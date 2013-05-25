From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 26/48] remote-hg: add test for bookmark diverge
Date: Fri, 24 May 2013 21:29:42 -0500
Message-ID: <1369449004-17981-27-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:33:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4IC-0002JM-Qj
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab3EYCdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:33:05 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:46380 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347Ab3EYCdC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:33:02 -0400
Received: by mail-ob0-f171.google.com with SMTP id ef5so6224673obb.2
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=q45EiSy7eVDAKhuaMAh2kqIO/s2L3WC35gr0tRChC10=;
        b=EBsTcPvCoKbsEIYsu4VNbkEbe8DM7ln7U0feKuHEWxRh7YfNwYEA+pyd7u57Kh9vpx
         4KlmXouzCHSOo/BDrID6tTp8Lwir2bAUVuq0brixQYas3vRJ2tddzTUEyo3PtH6pMa1F
         OVa1NcMzUPE5uzVHg5tY9BPc06cRxkC5q/IZzRAyU08L5y25BrZVBEW7NtP+zAHb0HbC
         Kh06BZb4a9i+LCe+jjlkrmITwS2HUAx9/NY3mxpPSjQRC7ncM8mxSKhGhyqc1FI7Lqym
         zjeiUJWuECDkAAa9NPC0ijRgaICypFGbIrr1z0iPCPIQsIETQa9Ma5jb+sXNjAV9yrvz
         5kAQ==
X-Received: by 10.182.199.106 with SMTP id jj10mr13449328obc.45.1369449181825;
        Fri, 24 May 2013 19:33:01 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wz1sm6623886obc.3.2013.05.24.19.33.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:33:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225440>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 252553e..e059bbc 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -341,4 +341,33 @@ test_expect_failure 'remote push diverged' '
 	check_branch hgrepo default bump
 '
 
+test_expect_failure 'remote update bookmark diverge' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	cd hgrepo &&
+	hg checkout tip^ &&
+	hg bookmark diverge
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+
+	(
+	cd hgrepo &&
+	echo "bump bookmark" > content &&
+	hg commit -m "bump bookmark"
+	) &&
+
+	(
+	cd gitrepo &&
+	git checkout --quiet diverge &&
+	echo diverge > content &&
+	git commit -a -m diverge &&
+	test_expect_code 1 git push 2> error &&
+	grep "^ ! \[rejected\] *diverge -> diverge (non-fast-forward)$" error
+	) &&
+
+	check_bookmark hgrepo diverge "bump bookmark"
+'
+
 test_done
-- 
1.8.3.rc3.312.g47657de
