From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] Do not allow refnames to start with a slash
Date: Thu, 25 Aug 2011 10:08:15 +0200
Message-ID: <1314259695-30801-1-git-send-email-mhagger@alum.mit.edu>
References: <4E55FFAA.9030904@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 10:08:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwUzL-000677-Ij
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 10:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922Ab1HYIIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 04:08:31 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:53274 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab1HYII2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 04:08:28 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QwUvm-0001Sl-Pq; Thu, 25 Aug 2011 10:04:54 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <4E55FFAA.9030904@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180066>

Previously, refnames with leading slashes were handled inconsistently.
So forbid them altogether.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This patch chooses the alternative of forbidding leading slashes,
because I feel that it is the safer option.  It is like Carlos's patch
but with documentation changes, test-suite additions, and an
corresponding change to git.py.  If anybody knows of other
implementations of the ref format checking code, please let me know.

This patch applies to either master or maint.  Since it restricts the
DWIM behavior in some cases, master is probably the better choice.

 Documentation/git-check-ref-format.txt |    7 ++++---
 git_remote_helpers/git/git.py          |    3 ++-
 refs.c                                 |    3 +++
 t/t1402-check-ref-format.sh            |    4 ++++
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index c9fdf84..238b185 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -34,15 +34,16 @@ git imposes the following rules on how references are named:
   category like `heads/`, `tags/` etc. but the actual names are not
   restricted.
 
-. They cannot have two consecutive dots `..` anywhere.
+. They must not start or end with slash `/`.
+
+. They cannot have two consecutive dots `..` anywhere or end with a
+  dot `.`.
 
 . They cannot have ASCII control characters (i.e. bytes whose
   values are lower than \040, or \177 `DEL`), space, tilde `~`,
   caret `{caret}`, colon `:`, question-mark `?`, asterisk `*`,
   or open bracket `[` anywhere.
 
-. They cannot end with a slash `/` nor a dot `.`.
-
 . They cannot end with the sequence `.lock`.
 
 . They cannot contain a sequence `@{`.
diff --git a/git_remote_helpers/git/git.py b/git_remote_helpers/git/git.py
index a383e6c..6df53aa 100644
--- a/git_remote_helpers/git/git.py
+++ b/git_remote_helpers/git/git.py
@@ -55,7 +55,8 @@ def valid_git_ref (ref_name):
     # command.  The rules were derived from the git check-ref-format(1)
     # manual page.  This code should be replaced by a call to
     # check_ref_format() in the git library, when such is available.
-    if ref_name.endswith('/') or \
+    if ref_name.startswith('/') or \
+       ref_name.endswith('/') or \
        ref_name.startswith('.') or \
        ref_name.count('/.') or \
        ref_name.count('..') or \
diff --git a/refs.c b/refs.c
index 6f313a9..84c5af3 100644
--- a/refs.c
+++ b/refs.c
@@ -880,6 +880,9 @@ int check_ref_format(const char *ref)
 	const char *cp = ref;
 
 	level = 0;
+	if (*cp == '/')
+		/* no leading slashes */
+		return CHECK_REF_FORMAT_ERROR;
 	while (1) {
 		while ((ch = *cp++) == '/')
 			; /* tolerate duplicated slashes */
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 1b0f82f..b05ca26 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -18,6 +18,10 @@ invalid_ref 'foo'
 valid_ref 'foo/bar/baz'
 valid_ref 'refs///heads/foo'
 invalid_ref 'heads/foo/'
+invalid_ref '/foo'
+invalid_ref 'foo/'
+invalid_ref '/foo/bar'
+invalid_ref 'foo/bar/'
 invalid_ref './foo'
 invalid_ref '.refs/foo'
 invalid_ref 'heads/foo..bar'
-- 
1.7.6.8.gd2879
