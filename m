From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH] Fix earlier "import quilt patches" patch
Date: Sat, 24 Sep 2005 12:46:23 +0200
Message-ID: <20050924104622.17274.18611.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 16:12:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJAjr-00014X-BK
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 16:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVIXOKj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 10:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVIXOKj
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 10:10:39 -0400
Received: from [151.97.230.9] ([151.97.230.9]:42717 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1750752AbVIXOKj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2005 10:10:39 -0400
Received: (qmail 11862 invoked by uid 508); 24 Sep 2005 16:10:32 +0200
Received: from unknown (HELO ssc.unict.it) (151.97.230.9)
  by ssc.unict.it with SMTP; 24 Sep 2005 16:10:32 +0200
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id 5C5BB2855D;
	Sat, 24 Sep 2005 12:46:37 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9231>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

I forgot to update all cases - I updated __parse_mail, not __parse_patch, so
refactor together this duplication and use the fixed version.

Btw, I don't like those regexps - they'd match in the middle of line too. What
about adding ^ to their beginning like for the "^Index: " regexp?

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 stgit/commands/imprt.py |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -75,6 +75,10 @@ options = [make_option('-m', '--mail',
                        help = 'use COMMEMAIL as the committer e-mail')]
 
 
+def __end_descr(line):
+    return re.match('---\s*$', line) or re.match('diff -', line) or \
+            re.match('^Index: ', line)
+    
 def __parse_mail(filename = None):
     """Parse the input file in a mail format and return (description,
     authname, authemail, authdate)
@@ -116,8 +120,7 @@ def __parse_mail(filename = None):
         line = f.readline()
         if not line:
             break
-        if re.match('---\s*$', line) or re.match('diff -', line) or \
-                re.match('^Index: ', line):
+        if __end_descr(line):
             break
         else:
             descr += line
@@ -150,7 +153,7 @@ def __parse_patch(filename = None):
             auth = re.findall('^.*?:\s+(.*)$', line)[0]
             authname, authemail = name_email(auth)
 
-        if re.match('---\s*$', line) or re.match('diff -', line):
+        if __end_descr(line):
             break
         else:
             descr += line
