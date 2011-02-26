From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v2 1/3] git-p4: Correct branch base depot path detection
Date: Sat, 26 Feb 2011 23:46:09 +0000
Message-ID: <1298763971-20556-2-git-send-email-vitor.hda@gmail.com>
References: <1298763971-20556-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 27 00:46:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtTqc-0000Rl-N6
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 00:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535Ab1BZXqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 18:46:47 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36718 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab1BZXqp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 18:46:45 -0500
Received: by mail-ww0-f44.google.com with SMTP id 22so1746968wwb.1
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 15:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=FOQwq62pX4HpLwbAipAa6q5dDv536PiTZvGI48jZU6Q=;
        b=Hdg7Y1KvGnU4fHtSzdfhzt7R88tWAwwPwTQfIwh9ktpbKQ2ApYTj0uVGpfwJ8N4861
         GyTPcNL3oJS4ipNYuqKTE3IsYQ7EdBmeU6XTByN5GMznzgFut8Ct4MAEG1oWRRGp+Xt/
         4dqr5HznMwEZVZWgjwfxZumhum6psco8ddHCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZZk14FHXtiJnaKCNAYoKUvqszGoIwhku6lMgRuh43QImhcYi0awnvPTRrqov2NidXc
         L5K9cIle6fU1TunKQbGU8YRHiT5OlFHmJFoMVFyxviy1hrn3wCSVUnuryZG8INsp1oNn
         yyJSn7kAMyGGXlRHbH+pcLptmJqHDmnkIjlm0=
Received: by 10.216.27.202 with SMTP id e52mr3284048wea.75.1298764004775;
        Sat, 26 Feb 2011 15:46:44 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id n78sm1121697weq.27.2011.02.26.15.46.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Feb 2011 15:46:43 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1298763971-20556-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167999>

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
index a92beb6..fad3371 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1599,12 +1599,14 @@ class P4Sync(Command):
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
1.7.4.1
