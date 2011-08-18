From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v3 1/4] git-p4: Correct branch base depot path detection
Date: Fri, 19 Aug 2011 00:44:03 +0100
Message-ID: <1313711046-23489-2-git-send-email-vitor.hda@gmail.com>
References: <1313711046-23489-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 01:45:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuCGj-0006mR-Ls
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 01:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806Ab1HRXox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 19:44:53 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39570 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab1HRXow (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 19:44:52 -0400
Received: by wyg24 with SMTP id 24so1758306wyg.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 16:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=b9FXiD59ME8cVzENo7DAktHoo13kjp9fcl5HGEd/3hI=;
        b=AKWHFlfwgoJ1uGd8/IWcNvMQLaOFzqPdBu0CbbVSDlqbRa+UrHqgJsbcsNo0lg16bL
         OtN8PGy6moEbVFRq/zcpmE8t80Nk6JjVyty22/LfPoOZzv+dUm6IwdjN4Xpx1DPs+1XP
         Cwl0HdMMuAk9lxCmClmJJvIxA0ZejNjFlAeZA=
Received: by 10.216.168.198 with SMTP id k48mr1022919wel.109.1313711090724;
        Thu, 18 Aug 2011 16:44:50 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id u22sm1816046weq.15.2011.08.18.16.44.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 16:44:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1313711046-23489-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179661>

When branch detection is enabled each branch is named in git after their
relative depot path in Perforce. To do this the depot paths are compared against
each other to find their common base path. The current algorithm makes this
comparison on a character by character basis.
Assuming we have the following branches:

//depot/branches/featureA
//depot/branches/featureB

Then the base depot path would be //depot/branches/feature, which is an invalid
depot path.
The current patch fixes this by splitting the path into a list and comparing the
list entries, making it choose correctly //depot/branches as the base path.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 contrib/fast-import/git-p4 |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 29a5390..95246e9 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1829,12 +1829,14 @@ class P4Sync(Command, P4UserMap):
                     else:
                         paths = []
                         for (prev, cur) in zip(self.previousDepotPaths, depotPaths):
-                            for i in range(0, min(len(cur), len(prev))):
-                                if cur[i] <> prev[i]:
+                            prev_list = prev.split("/")
+                            cur_list = cur.split("/")
+                            for i in range(0, min(len(cur_list), len(prev_list))):
+                                if cur_list[i] <> prev_list[i]:
                                     i = i - 1
                                     break
 
-                            paths.append (cur[:i + 1])
+                            paths.append ("/".join(cur_list[:i + 1]))
 
                         self.previousDepotPaths = paths
 
-- 
1.7.5.4
