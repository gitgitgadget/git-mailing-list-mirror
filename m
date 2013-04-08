From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 14/20] remote-hg: show more proper errors
Date: Mon,  8 Apr 2013 12:13:28 -0500
Message-ID: <1365441214-21096-15-git-send-email-felipe.contreras@gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:16:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFgX-0006Qa-W0
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763362Ab3DHRP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:15:29 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:47605 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab3DHRP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:15:27 -0400
Received: by mail-ob0-f177.google.com with SMTP id uz6so5903745obc.8
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=AtB42VbxH59TmTIXTdYmlXPPaM5hSdeG0SB+NWd/+e8=;
        b=JqymvDQ/eR08SMOFDUJft9TmTac7NJ47HDN3SHuPCZJcfFC/W1nefzvM6lD1vsyzTY
         rDu5Brjm8RFuKto2GAQoelUpCPUvGrRKDsZpkVvaKPsXbsROgCkLhnhasSHZha8ygjKj
         ci+yAMJ7UqExUtVZf6HJI2+QTJdqFK4ImsLa4e9NNKCzE25fdMGbg3yTlmr4sgBrx3GT
         LRE1f0t+xw9QhI93ExDkIA0rKbADukcgYajBI+8Pqng5CPpntjodjvhyb7CsWwQomeCM
         sAVl3TLe4PW3tG7uKq+v/ssqDjJ5pGwnhWH5YotfU/BLKz0eH1swU+k/gezXzQqSigFZ
         Ia0A==
X-Received: by 10.182.156.20 with SMTP id wa20mr16238483obb.59.1365441327258;
        Mon, 08 Apr 2013 10:15:27 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id d10sm26134842oeh.7.2013.04.08.10.15.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:15:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220461>

When cloning or pushing fails, we don't want to show a stack-trace.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 9fb4d8b..078d3e8 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -9,7 +9,7 @@
 # Then you can clone with:
 # git clone hg::/path/to/mercurial/repo/
 
-from mercurial import hg, ui, bookmarks, context, util, encoding, node
+from mercurial import hg, ui, bookmarks, context, util, encoding, node, error
 
 import re
 import sys
@@ -284,11 +284,17 @@ def get_repo(url, alias):
     else:
         local_path = os.path.join(dirname, 'clone')
         if not os.path.exists(local_path):
-            peer, dstpeer = hg.clone(myui, {}, url, local_path, update=False, pull=True)
+            try:
+                peer, dstpeer = hg.clone(myui, {}, url, local_path, update=True, pull=True)
+            except:
+                die('Repository error')
             repo = dstpeer.local()
         else:
             repo = hg.repository(myui, local_path)
-            peer = hg.peer(myui, {}, url)
+            try:
+                peer = hg.peer(myui, {}, url)
+            except:
+                die('Repository error')
             repo.pull(peer, heads=None, force=True)
 
     return repo
-- 
1.8.2
