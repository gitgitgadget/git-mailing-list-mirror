From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 06/22] Do not allow ".lock" at the end of any refname component
Date: Thu, 15 Sep 2011 23:10:27 +0200
Message-ID: <1316121043-29367-7-git-send-email-mhagger@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 23:11:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JDD-0005wW-Rv
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934971Ab1IOVLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:11:06 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40085 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934967Ab1IOVLE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:11:04 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R4J8l-00019o-2f; Thu, 15 Sep 2011 23:06:35 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181496>

Allowing any refname component to end with ".lock" is looking for
trouble; for example,

    $ git br foo.lock/bar
    $ git br foo
    fatal: Unable to create '[...]/.git/refs/heads/foo.lock': File exists.

Therefore, do not allow any refname component to end with ".lock".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

This change was discussed on the mailing list [1].  It is regrettable
that we can't change the name of the lock files to something that
cannot appear in a reference name (like .refname.lock), but such a
change would cause problems if two versions of git are simultaneously
accessing the same repository.

[1] http://thread.gmane.org/gmane.comp.version-control.git/181051/focus=181069

 Documentation/git-check-ref-format.txt |    4 +---
 refs.c                                 |    4 ++--
 t/t1402-check-ref-format.sh            |    8 ++++----
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index dcb8cc3..9114751 100644
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
index 5259724..5a0bd0f 100644
--- a/refs.c
+++ b/refs.c
@@ -898,6 +898,8 @@ static int check_refname_component(const char *ref)
 		return -1; /* Component has zero length. */
 	if (ref[0] == '.')
 		return -1; /* Component starts with '.'. */
+	if (cp - ref >= 5 && !memcmp(cp - 5, ".lock", 5))
+		return -1; /* Refname ends with ".lock". */
 	return cp - ref;
 }
 
@@ -931,8 +933,6 @@ int check_refname_format(const char *ref, int flags)
 
 	if (ref[component_len - 1] == '.')
 		return -1; /* Refname ends with '.'. */
-	if (component_len >= 5 && !memcmp(&ref[component_len - 5], ".lock", 5))
-		return -1; /* Refname ends with ".lock". */
 	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
 		return -1; /* Refname has only one component. */
 	return 0;
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 1cad88f..419788f 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -43,8 +43,8 @@ invalid_ref 'heads/foo?bar'
 valid_ref 'foo./bar'
 invalid_ref 'heads/foo.lock'
 invalid_ref 'heads///foo.lock'
-valid_ref 'foo.lock/bar'
-valid_ref 'foo.lock///bar'
+invalid_ref 'foo.lock/bar'
+invalid_ref 'foo.lock///bar'
 valid_ref 'heads/foo@bar'
 invalid_ref 'heads/v@{ation'
 invalid_ref 'heads/foo\bar'
@@ -160,7 +160,7 @@ invalid_ref_normalized 'heads/./foo'
 invalid_ref_normalized 'heads\foo'
 invalid_ref_normalized 'heads/foo.lock'
 invalid_ref_normalized 'heads///foo.lock'
-valid_ref_normalized 'foo.lock/bar' 'foo.lock/bar'
-valid_ref_normalized 'foo.lock///bar' 'foo.lock/bar'
+invalid_ref_normalized 'foo.lock/bar'
+invalid_ref_normalized 'foo.lock///bar'
 
 test_done
-- 
1.7.6.8.gd2879
