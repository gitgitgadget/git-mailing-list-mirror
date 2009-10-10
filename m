From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] disallow refs containing successive slashes
Date: Sat, 10 Oct 2009 19:49:48 +0200
Message-ID: <4AD0C93C.6050306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 20:02:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwgGT-0008Lt-Oa
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 20:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762011AbZJJRzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2009 13:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761899AbZJJRzT
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 13:55:19 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:49480 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757220AbZJJRzP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 13:55:15 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 5C4FD127B58C5;
	Sat, 10 Oct 2009 19:49:53 +0200 (CEST)
Received: from [80.128.95.161] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Mwg4l-0002Fr-00; Sat, 10 Oct 2009 19:49:51 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19tnVndeWE8RpUlbFrjLQNiAy0Dy/RHcuTN9vGx
	38Kh01dfPj8LLLb/0bKAUkQs7hdZjdQyesUCWHuIuTQwEhoPQx
	quwsh/uA3x3IaX4OCs7A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129893>

When creating branches using names starting with '/' or containing a '//',
a leading slash would just vanish and successive slashes were 'compressed'
into just one slash.

This behaviour comes from the refs being stored as files in subdirectories
where the filesystem compresses each '//' in a pathname to a '/' . So
disallowing refs to contain '//' fixes these problems and prohibits
branch names to start with a '/' or to contain '//'.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

I became aware of this issue while looking into problems occuring
when a user created a branch starting with a '/' in git gui (e.g.
"/foo"). Strange things happen, while git gui shows the current
branch as "/foo" under the hood a branch "foo" (without the slash)
had been created. But then you can't delete "/foo" from git gui,
because a branch of that name doesn't exist.

IMHO branch names should not be allowed to start with a '/' or
contain a '//' (branches with trailing slashes are not allowed since
commit 03feddd6). So this implies that refs should never contain a
'//' in the first place.

This behaviour has been changed the last time by commit 03feddd.
The version before that commit didn't allow '//' to be part of a
ref (but still allowed a trailing '/'). The newer version explicitly
states "/* tolerate duplicated slashes */" in the added code. But i
couldn't find any hints on the list or on the interweb *why* these
were allowed. So this patch might break something i can't see right
now, even though the test suite runs fine ...

Thoughts? Objections?


 Documentation/git-check-ref-format.txt |    2 ++
 refs.c                                 |    7 +++++--
 t/t1600-check-ref-format.sh            |   19 +++++++++++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100755 t/t1600-check-ref-format.sh

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 0b7982e..180ffbb 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -38,6 +38,8 @@ imposes the following rules on how references are named:

 . They cannot end with a slash `/` nor a dot `.`.

+. They cannot contain two successive slashes `//`.
+
 . They cannot end with the sequence `.lock`.

 . They cannot contain a sequence `@{`.
diff --git a/refs.c b/refs.c
index 808f56b..cedd768 100644
--- a/refs.c
+++ b/refs.c
@@ -687,6 +687,7 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
  * - it has double dots "..", or
  * - it has ASCII control character, "~", "^", ":" or SP, anywhere, or
  * - it ends with a "/".
+ * - it contains '//'
  * - it ends with ".lock"
  * - it contains a "\" (backslash)
  */
@@ -712,8 +713,10 @@ int check_ref_format(const char *ref)

 	level = 0;
 	while (1) {
-		while ((ch = *cp++) == '/')
-			; /* tolerate duplicated slashes */
+		if ((ch = *cp++) == '/')
+			/* Don't tolerate successive slashes */
+			return CHECK_REF_FORMAT_ERROR;
+
 		if (!ch)
 			/* should not end with slashes */
 			return CHECK_REF_FORMAT_ERROR;
diff --git a/t/t1600-check-ref-format.sh b/t/t1600-check-ref-format.sh
new file mode 100755
index 0000000..05fb9f9
--- /dev/null
+++ b/t/t1600-check-ref-format.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description='git check-ref-format'
+
+. ./test-lib.sh
+
+test_expect_success 'refs/heads/master is ok' '
+	git check-ref-format refs/heads/master
+'
+
+test_expect_success 'no successive slashes allowed' '
+	test_must_fail git check-ref-format a//b
+'
+
+test_expect_success 'no trailing slashes allowed' '
+	test_must_fail git check-ref-format a/b/
+'
+
+test_done
-- 
1.6.5.rc2.205.g1185a
