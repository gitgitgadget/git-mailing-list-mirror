From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v4 1/4] git-p4: Correct branch base depot path detection
Date: Sun, 28 Aug 2011 22:58:27 +0100
Message-ID: <1314568710-6472-2-git-send-email-vitor.hda@gmail.com>
References: <1314568710-6472-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 23:59:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxnNx-0002vP-V0
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 23:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465Ab1H1V7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 17:59:04 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49150 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab1H1V7B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 17:59:01 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so5126411wwf.1
        for <git@vger.kernel.org>; Sun, 28 Aug 2011 14:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dkIM2KleoClizgHKlKTXljlbRe7uAhncIvxKsu85wzE=;
        b=mW3li3x2Eucyx3VdXeHiqTSp+fPiHkmXJn6Nw3wDMwIoiE0fa4NMHeSeXycHvxVpZO
         RuGmQeSsm9xh9iPN8kU073Ra0xaHw0XCduf5OF/i3U7WZSdLgesgD1RCW5+D/ylzHFT1
         oAAcQrhJ2C5zwcoJ2+6SKESg7yIsZaUYqpm5o=
Received: by 10.227.2.129 with SMTP id 1mr3212532wbj.39.1314568740651;
        Sun, 28 Aug 2011 14:59:00 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id fh17sm3211909wbb.3.2011.08.28.14.58.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 28 Aug 2011 14:59:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1314568710-6472-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180284>

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
index 0db3e72..72a5b6c 100755
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
