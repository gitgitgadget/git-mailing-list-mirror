From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 6/7] Do not allow ".lock" at the end of any refname component
Date: Sat, 10 Sep 2011 08:50:42 +0200
Message-ID: <1315637443-14012-7-git-send-email-mhagger@alum.mit.edu>
References: <1315637443-14012-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 10 08:51:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2HPf-0001xv-C3
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 08:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758391Ab1IJGv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Sep 2011 02:51:28 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:33358 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756029Ab1IJGvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2011 02:51:08 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEAB10.dip.t-dialin.net [84.190.171.16])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8A6ol8w024666;
	Sat, 10 Sep 2011 08:50:52 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1315637443-14012-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181141>

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
index b0b773b..419788f 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -43,6 +43,8 @@ invalid_ref 'heads/foo?bar'
 valid_ref 'foo./bar'
 invalid_ref 'heads/foo.lock'
 invalid_ref 'heads///foo.lock'
+invalid_ref 'foo.lock/bar'
+invalid_ref 'foo.lock///bar'
 valid_ref 'heads/foo@bar'
 invalid_ref 'heads/v@{ation'
 invalid_ref 'heads/foo\bar'
@@ -158,5 +160,7 @@ invalid_ref_normalized 'heads/./foo'
 invalid_ref_normalized 'heads\foo'
 invalid_ref_normalized 'heads/foo.lock'
 invalid_ref_normalized 'heads///foo.lock'
+invalid_ref_normalized 'foo.lock/bar'
+invalid_ref_normalized 'foo.lock///bar'
 
 test_done
-- 
1.7.6.8.gd2879
