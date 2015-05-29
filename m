From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 8/8] t5520: check reflog action in fast-forward merge
Date: Fri, 29 May 2015 19:44:45 +0800
Message-ID: <1432899885-25143-9-git-send-email-pyokagan@gmail.com>
References: <1432899885-25143-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 13:45:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyIjA-00043m-9U
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 13:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387AbbE2LpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 07:45:23 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33207 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755461AbbE2LpS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 07:45:18 -0400
Received: by padbw4 with SMTP id bw4so55992712pad.0
        for <git@vger.kernel.org>; Fri, 29 May 2015 04:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iyNFD81P90Uvp/5KhkifSxswhoX62ZzOeiyZzDZChK4=;
        b=YjXf3lqfIK+5RUgKSpz8RdDcHif5lukta0RpHl4q444mR/0Lk2rgRrz/wVZXPoLEW+
         YZ3qk3rHk2Gka4JqPxoy+3v8GRUCpYl+Z8iI4tlGGhKM6O4UrLnQcgrPo6KIRpw/8QqZ
         OJRg7xWWcApBEakY6xwVw3qJd7q6foaYLtt/ws9AP+XerE5yFFk4bkEaGpBOxa77cLFo
         5LRbTg2IP3dCCw/SiUncZAb3mZdCzNMQVkW54GiGfguugJHwO2Gob7AefPJJDMNCcfzS
         jePqiI7+ryC0fDo9rB28xC5wOe/Meh5M6kx07aSh7zFviNEOBBJ4CQDpt2xYv2hAkjxx
         dTeA==
X-Received: by 10.66.191.226 with SMTP id hb2mr14405828pac.72.1432899918025;
        Fri, 29 May 2015 04:45:18 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qg5sm5392460pdb.13.2015.05.29.04.45.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 May 2015 04:45:16 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1432899885-25143-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270236>

When testing a fast-forward merge with git-pull, check to see if the
reflog action is "pull" with the arguments passed to git-pull.

While we are in the vicinity, remove the empty line as well.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v5:
    
    * Loosen up the pattern used for search-and-replace of the object ID in
      the reflog: it may not always be the case that the abbreviated object
      ID is at least 5 characters.
    
    * Only match the beginning of the reflog entry for the object ID.

 t/t5520-pull.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index a04f55c..af31f04 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -86,7 +86,6 @@ test_expect_success 'pulling into void must not create an octopus' '
 '
 
 test_expect_success 'test . as a remote' '
-
 	git branch copy master &&
 	git config branch.copy.remote . &&
 	git config branch.copy.merge refs/heads/master &&
@@ -95,7 +94,11 @@ test_expect_success 'test . as a remote' '
 	git checkout copy &&
 	test "$(cat file)" = file &&
 	git pull &&
-	test "$(cat file)" = updated
+	test "$(cat file)" = updated &&
+	git reflog -1 >reflog.actual &&
+	sed "s/^[0-9a-f][0-9a-f]*/OBJID/" reflog.actual >reflog.fuzzy &&
+	echo "OBJID HEAD@{0}: pull: Fast-forward" >reflog.expected &&
+	test_cmp reflog.expected reflog.fuzzy
 '
 
 test_expect_success 'the default remote . should not break explicit pull' '
@@ -106,7 +109,11 @@ test_expect_success 'the default remote . should not break explicit pull' '
 	git reset --hard HEAD^ &&
 	test "$(cat file)" = file &&
 	git pull . second &&
-	test "$(cat file)" = modified
+	test "$(cat file)" = modified &&
+	git reflog -1 >reflog.actual &&
+	sed "s/^[0-9a-f][0-9a-f]*/OBJID/" reflog.actual >reflog.fuzzy &&
+	echo "OBJID HEAD@{0}: pull . second: Fast-forward" >reflog.expected &&
+	test_cmp reflog.expected reflog.fuzzy
 '
 
 test_expect_success 'fail if wildcard spec does not match any refs' '
-- 
2.1.4
