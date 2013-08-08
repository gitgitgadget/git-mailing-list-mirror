From: Alexandru Juncu <alexj@rosedu.org>
Subject: [PATCH] git-p4: Fix occasional truncation of symlink contents.
Date: Thu,  8 Aug 2013 16:17:38 +0300
Message-ID: <1375967858-10615-1-git-send-email-ajuncu@ixiacom.com>
Cc: Alexandru Juncu <ajuncu@ixiacom.com>,
	Alex Badea <abadea@ixiacom.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 15:18:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Q6W-0007Nk-PF
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 15:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757831Ab3HHNSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 09:18:08 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:47389 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757795Ab3HHNSG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 09:18:06 -0400
Received: by mail-qc0-f181.google.com with SMTP id k15so1534051qcv.12
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 06:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KFk9fjDgVsmxp6xfgN794wSUOtGe9UInLZaRMhGj8J8=;
        b=GYgP4LzU477YjqsCKvHtb/bUSFvQ3yzLWjcCTg9LrXdGckAC+rRDTlck0IkXeOzI+z
         LI8sPNHVenblvLoRayczk/RfkH68K/LxbmDdo8pJP0/dKY638OuCjAQIjVn6Mamy+naF
         9HOJHSrSMbPOXhldkOW4ra8kYoytzK1ZRHAxMHPc1JeUQC6+RTRWIKixisClTUlcqmFd
         W4g94A6LLO2JyXk/0S7tgVRtM9RA0gNUJ+NG44AD2JN9ZsxgbGAlOf/EEm0bJxzmcMRq
         1fJTrNnZKb9sfuboecGX2BWFRopmWG1r57Dg9kiLahJBu4DqePTtFas0NS7jB2YsX9fG
         oefA==
X-Gm-Message-State: ALoCoQnfFFYlWfH3OtP9siAeL7Sbq7Rfy+B5pte13uW1R5z9iU3cyV2v+bat7qbHnig3/goLNX2T
X-Received: by 10.229.159.75 with SMTP id i11mr1367615qcx.59.1375967885406;
        Thu, 08 Aug 2013 06:18:05 -0700 (PDT)
Received: from ixro-alexj.ixiacom.com ([205.168.23.154])
        by mx.google.com with ESMTPSA id y1sm17258562qaj.2.2013.08.08.06.18.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 06:18:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.1.g8f6a3e5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231881>

Symlink contents in p4 print sometimes have a trailing
new line character, but sometimes it doesn't. git-p4
should only remove the last character if that character
is '\n'.

Signed-off-by: Alex Juncu <ajuncu@ixiacom.com>
Signed-off-by: Alex Badea <abadea@ixiacom.com>
---
 git-p4.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 31e71ff..a53a6dc 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2180,9 +2180,13 @@ class P4Sync(Command, P4UserMap):
             git_mode = "100755"
         if type_base == "symlink":
             git_mode = "120000"
-            # p4 print on a symlink contains "target\n"; remove the newline
+            # p4 print on a symlink sometimes contains "target\n";
+            # if it does, remove the newline
             data = ''.join(contents)
-            contents = [data[:-1]]
+            if data[-1] == '\n':
+                contents = [data[:-1]]
+            else:
+                contents = [data]
 
         if type_base == "utf16":
             # p4 delivers different text in the python output to -G
-- 
1.8.4.rc0.1.g8f6a3e5
