From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v3 1/5] git-p4: Allow setting rename/copy detection threshold
Date: Mon, 22 Aug 2011 09:33:05 +0100
Message-ID: <1314001989-29017-2-git-send-email-vitor.hda@gmail.com>
References: <1314001989-29017-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 22 10:34:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvPxf-0001Mc-7T
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 10:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627Ab1HVIeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 04:34:18 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58449 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab1HVIeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 04:34:16 -0400
Received: by wwf5 with SMTP id 5so4968962wwf.1
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 01:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=oRMfgx+nbdg4SX24aHQ9vOi273EwvsejiJqxKRx5Wco=;
        b=aEEfWxZBmLfQiJ9yx0YwYJA2VUpd/ftPF8AM5X8Y+yZavEHBgXDMGbTYmMY8EIp1RY
         1X/qA+qHW+q062esHXYXvkkAMvRJ7Ixf7bShzrE2L7VSvknYwS8SpljEnmGbO34eofe7
         Tb4p9gF3/c97zmVsw23C5LGaWLnVqbj5g1NYM=
Received: by 10.216.88.194 with SMTP id a44mr1751315wef.98.1314002055365;
        Mon, 22 Aug 2011 01:34:15 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id e44sm3284981wed.41.2011.08.22.01.34.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Aug 2011 01:34:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1314001989-29017-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179845>

Copy and rename detection arguments (-C and -M) allow setting a threshold value
for the similarity ratio. If the similarity is below this threshold the rename
or copy is ignored and the file is added as new.
This patch allows setting git-p4.detectRenames and git-p4.detectCopies options
to an integer value to set the respective threshold.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 contrib/fast-import/git-p4 |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 6b9de9e..29a5390f 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -774,15 +774,20 @@ class P4Submit(Command, P4UserMap):
 
         if not self.detectRenames:
             # If not explicitly set check the config variable
-            self.detectRenames = gitConfig("git-p4.detectRenames").lower() == "true"
+            self.detectRenames = gitConfig("git-p4.detectRenames")
 
-        if self.detectRenames:
+        if self.detectRenames.lower() == "false" or self.detectRenames == "":
+            diffOpts = ""
+        elif self.detectRenames.lower() == "true":
             diffOpts = "-M"
         else:
-            diffOpts = ""
+            diffOpts = "-M%s" % self.detectRenames
 
-        if gitConfig("git-p4.detectCopies").lower() == "true":
+        detectCopies = gitConfig("git-p4.detectCopies")
+        if detectCopies.lower() == "true":
             diffOpts += " -C"
+        elif detectCopies != "" and detectCopies.lower() != "false":
+            diffOpts += " -C%s" % detectCopies
 
         if gitConfig("git-p4.detectCopiesHarder").lower() == "true":
             diffOpts += " --find-copies-harder"
-- 
1.7.5.4
