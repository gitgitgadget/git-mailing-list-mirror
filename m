From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v2 1/4] git-p4: Allow setting rename/copy detection threshold.
Date: Thu, 18 Aug 2011 23:20:51 +0100
Message-ID: <1313706054-11740-2-git-send-email-vitor.hda@gmail.com>
References: <1313706054-11740-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 00:21:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuAy8-0002QM-7g
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900Ab1HRWVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 18:21:37 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34913 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab1HRWVg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:21:36 -0400
Received: by wyg24 with SMTP id 24so1729052wyg.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 15:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DD+W/PzKO2P6FAjbigfBI7zPtiTwCW9FTUPbo7kVazs=;
        b=DsytHd8IixSnHWYEemwTPcCWJt9RqvOvFfwmHhBbpQar4uVtGLov8eI9O2LvDZdmA7
         8ToCRsleQu2o8KDwDr8Gad4Dhcg4OuquMXTfHd677l/bkPXQ+bgtSM63Y7scZCKz7WR/
         L3sfutOc41bme/OrsFNDWq5lsebuQVyKIbjOo=
Received: by 10.227.177.133 with SMTP id bi5mr2438754wbb.39.1313706095521;
        Thu, 18 Aug 2011 15:21:35 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id fy12sm2103590wbb.32.2011.08.18.15.21.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 15:21:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1313706054-11740-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179637>

Copy and rename detection arguments (-C and -M) allow setting a threshold value
for the similarity ratio. If the similarity is below this threshold the rename
or copy is ignored and the file is added as new.
This patch allows setting git-p4.detectRenames and git-p4.detectCopies options
to an integer value to set the respective threshold.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 contrib/fast-import/git-p4 |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 6b9de9e..cf719be 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -774,15 +774,23 @@ class P4Submit(Command, P4UserMap):
 
         if not self.detectRenames:
             # If not explicitly set check the config variable
-            self.detectRenames = gitConfig("git-p4.detectRenames").lower() == "true"
+            self.detectRenames = gitConfig("git-p4.detectRenames")
 
-        if self.detectRenames:
+        diffOpts = ""
+        if self.detectRenames.lower() == "true":
             diffOpts = "-M"
-        else:
-            diffOpts = ""
+        elif self.detectRenames != "":
+            self.detectRenames = int(self.detectRenames)
+            if self.detectRenames >= 0 and self.detectRenames <= 100:
+                diffOpts = "-M%d" % self.detectRenames
 
-        if gitConfig("git-p4.detectCopies").lower() == "true":
+        detectCopies = gitConfig("git-p4.detectCopies")
+        if detectCopies.lower() == "true":
             diffOpts += " -C"
+        elif detectCopies != "":
+            detectCopies = int(detectCopies)
+            if detectCopies >= 0 and detectCopies <= 100:
+                diffOpts += " -C%d" % detectCopies
 
         if gitConfig("git-p4.detectCopiesHarder").lower() == "true":
             diffOpts += " --find-copies-harder"
-- 
1.7.5.4
