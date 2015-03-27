From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 2/2] git-p4: Fix copy detection test
Date: Fri, 27 Mar 2015 01:04:29 +0000
Message-ID: <1427418269-3263-3-git-send-email-vitor.hda@gmail.com>
References: <1427418269-3263-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 02:05:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbIiA-0007YS-4b
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 02:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178AbbC0BFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 21:05:19 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38847 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbbC0BFS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 21:05:18 -0400
Received: by wibgn9 with SMTP id gn9so10989844wib.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2015 18:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c5wfwhUzknjGqjfXsc/VsRh+wNx1HUDZZP4fdGAR6X4=;
        b=Eslb3G1/BYbYPnDNpMCkqMABOGh+LbIyXaFfIkCXGNpckX7uKIXwM/vNWgYrcheTFL
         IKajSEMkSYo/0TONewpK98S7OOg/7N60tTJrNs8FCatHiI6ge9oO9+BzU061jkNa4eUH
         sa4PAzWZjmYj8y9uLT86wPm6SvecDwIk1QjbKvgQ+EUV26zmMQms28AsNVUzn6HNRKWw
         0WJi6L4aV89ftRuUxt83GEG5i8SFep6yHFPSBE0rFyerUFAt8q0g3NoctKMLTbBMsbIg
         fEM+LwvV18JWFIwhCIdRm9OSDePdzJxMpIxUa8mzxR4g5RvFZVJGkBcqsCp9MuIwrVOu
         JYSA==
X-Received: by 10.180.90.34 with SMTP id bt2mr9461817wib.43.1427418316969;
        Thu, 26 Mar 2015 18:05:16 -0700 (PDT)
Received: from localhost.localdomain (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id u10sm1231219wib.1.2015.03.26.18.05.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2015 18:05:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1427418269-3263-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266360>

File file11 is copied from file2 and diff-tree correctly reports this file as
its the source, but the test expression was checking for file10 instead (which
was a file that also originated from file2). It is possible that the diff-tree
algorithm was updated in recent versions, which resulted in this mismatch in
behavior.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 t/t9814-git-p4-rename.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 24008ff..018f01d 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -156,14 +156,14 @@ test_expect_success 'detect copies' '
 		git diff-tree -r -C HEAD &&
 		git p4 submit &&
 		p4 filelog //depot/file10 &&
-		p4 filelog //depot/file10 | grep -q "branch from //depot/file" &&
+		p4 filelog //depot/file10 | grep -q "branch from //depot/file2" &&
 
 		cp file2 file11 &&
 		git add file11 &&
 		git commit -a -m "Copy file2 to file11" &&
 		git diff-tree -r -C --find-copies-harder HEAD &&
 		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
-		test "$src" = file10 &&
+		test "$src" = file2 &&
 		git config git-p4.detectCopiesHarder true &&
 		git p4 submit &&
 		p4 filelog //depot/file11 &&
-- 
1.7.10.4
