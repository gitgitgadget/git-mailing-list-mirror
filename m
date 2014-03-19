From: Andrei Dinu <mandrei.dinu@gmail.com>
Subject: [PATCH v5] fsck.c: fsck_tree() now use is_dot_or_dotdot().
Date: Wed, 19 Mar 2014 18:08:10 +0200
Message-ID: <1395245290-6677-1-git-send-email-mandrei.dinu@gmail.com>
Cc: Andrei Dinu <mandrei.dinu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 17:08:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQJ2V-0001IP-20
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 17:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbaCSQIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 12:08:17 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:45280 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933859AbaCSQIR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 12:08:17 -0400
Received: by mail-ee0-f54.google.com with SMTP id d49so6891320eek.27
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=EeVYw5TVnUXu3RMOreG7klqAEnttlTpT85m9cMR+Wlg=;
        b=AbWnK1EuR6I05jI5Qi9l698qXNMJwqMKCwjp8pR+ZVEVksjZYSce+NGWirquYRUrnh
         JEMjbp74YLu0D36znuSkiYLkTxEPVF4rrf+1Ev07lBkRs4ByFgyDO5/SGdD6Cpgi+q56
         QeksEUO1Gy328SmTbrLN3u8I7SusEdE+aRMlmSFh8910HJ6vE1rPYbzHQlm48ZMovNcJ
         n+1uLyZOJedw5XB9mxVOaK+5ElreDEFKIl9WitOXGdV6kAduBmDa6id8zG7sL2ZEQUnf
         YjhnNNigNH2bmyd8lQz1Q1Gb8oOR34XlCRYxRIKTL/vcIN/CdqsDVCVVRTURM2CbAzGq
         NkhQ==
X-Received: by 10.14.172.69 with SMTP id s45mr36682913eel.26.1395245294240;
        Wed, 19 Mar 2014 09:08:14 -0700 (PDT)
Received: from localhost.localdomain (p5.eregie.pub.ro. [141.85.0.105])
        by mx.google.com with ESMTPSA id t50sm43256713eev.28.2014.03.19.09.08.12
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Mar 2014 09:08:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244458>

Rewrite fsck_tree() to use is_dot_or_dotdot() from "dir.h".

Signed-off-by: Andrei Dinu <mandrei.dinu@gmail.com>


---
 I try to find other sites that can use id_dot_or_dotdot() function.

 fsck.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index 64bf279..82a55ab 100644
--- a/fsck.c
+++ b/fsck.c
@@ -6,6 +6,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "fsck.h"
+#include "dir.h"
 
 static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
 {
@@ -171,10 +172,12 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 			has_full_path = 1;
 		if (!*name)
 			has_empty_name = 1;
-		if (!strcmp(name, "."))
-			has_dot = 1;
-		if (!strcmp(name, ".."))
-			has_dotdot = 1;
+		if (is_dot_or_dotdot(name)) {
+            if (name[1] == '\0')
+			    has_dot = 1;
+            else
+			    has_dotdot = 1;
+        }
 		if (!strcmp(name, ".git"))
 			has_dotgit = 1;
 		has_zero_pad |= *(char *)desc.buffer == '0';
-- 
1.7.9.5
