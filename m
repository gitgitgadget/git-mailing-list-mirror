From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 5/6] Do not allow ".lock" at the end of any refname component
Date: Fri,  9 Sep 2011 13:46:17 +0200
Message-ID: <1315568778-3592-6-git-send-email-mhagger@alum.mit.edu>
References: <1315568778-3592-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 13:47:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1zYJ-0005zY-KE
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 13:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933519Ab1IILqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 07:46:53 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:46255 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933373Ab1IILqm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 07:46:42 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R1zTb-0002Qy-8r; Fri, 09 Sep 2011 13:42:31 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1315568778-3592-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181056>

Allowing any refname component to end with ".lock" is looking for
trouble; for example,

    $ git br foo.lock/bar
    $ git br foo
    fatal: Unable to create '[...]/.git/refs/heads/foo.lock': File exists.

Therefore, do not allow any refname component to end with ".lock".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-check-ref-format.txt |    4 +---
 refs.c                                 |    6 +++---
 t/t1402-check-ref-format.sh            |    4 ++++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 3ab22b9..f2d21c7 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -28,7 +28,7 @@ git imposes the following rules on how references are named:
 
 . They can include slash `/` for hierarchical (directory)
   grouping, but no slash-separated component can begin with a
-  dot `.`.
+  dot `.` or end with the sequence `.lock`.
 
 . They must contain at least one `/`. This enforces the presence of a
   category like `heads/`, `tags/` etc. but the actual names are not
@@ -47,8 +47,6 @@ git imposes the following rules on how references are named:
 
 . They cannot end with a slash `/` nor a dot `.`.
 
-. They cannot end with the sequence `.lock`.
-
 . They cannot contain a sequence `@{`.
 
 . They cannot contain a `\`.
diff --git a/refs.c b/refs.c
index 372350e..6985a3f 100644
--- a/refs.c
+++ b/refs.c
@@ -933,14 +933,14 @@ int normalize_refname(char *dst, int dstlen, const char *ref, int flags)
 		if (component[0] == '.')
 			/* Components must not start with '.'. */
 			return -1;
+		if (component_len >= 5 && !memcmp(&component[component_len - 5], ".lock", 5))
+			/* Components must not end with ".lock". */
+			return -1;
 	} while (ch != 0);
 
 	if (last == '.')
 		/* Refname must not end with '.'. */
 		return -1;
-	if (component_len >= 5 && !memcmp(&component[component_len - 5], ".lock", 5))
-		/* Refname must not end with ".lock". */
-		return -1;
 	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
 		/* Refname must have at least two components. */
 		return -1;
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 20a7782..6848bfb 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -40,6 +40,8 @@ invalid_ref 'heads/foo?bar'
 valid_ref 'foo./bar'
 invalid_ref 'heads/foo.lock'
 invalid_ref 'heads///foo.lock'
+invalid_ref 'foo.lock/bar'
+invalid_ref 'foo.lock///bar'
 valid_ref 'heads/foo@bar'
 invalid_ref 'heads/v@{ation'
 invalid_ref 'heads/foo\bar'
@@ -155,5 +157,7 @@ invalid_ref_normalized 'heads/./foo'
 invalid_ref_normalized 'heads\foo'
 invalid_ref_normalized 'heads/foo.lock'
 invalid_ref_normalized 'heads///foo.lock'
+invalid_ref_normalized 'foo.lock/bar'
+invalid_ref_normalized 'foo.lock///bar'
 
 test_done
-- 
1.7.6.8.gd2879
