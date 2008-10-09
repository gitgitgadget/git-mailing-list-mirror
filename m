From: Samuel Tardieu <sam@rfc1149.net>
Subject: [StGit PATCH 1/2] Handle "git diff-tree --stdin" error
Date: Thu, 09 Oct 2008 11:01:57 +0200
Message-ID: <20081009090157.12637.45887.stgit@arrakis.enst.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 11:14:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnrbD-0000fm-DV
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 11:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbYJIJNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 05:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752754AbYJIJNJ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 05:13:09 -0400
Received: from revol1.enst.fr ([137.194.2.7]:50612 "EHLO smtp2.enst.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752753AbYJIJNI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 05:13:08 -0400
X-Greylist: delayed 668 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Oct 2008 05:13:08 EDT
Received: from localhost (localhost.enst.fr [127.0.0.1])
	by smtp2.enst.fr (Postfix) with ESMTP id 2FE14844C4;
	Thu,  9 Oct 2008 11:01:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at enst.fr
Received: from arrakis.enst.fr (arrakis.enst.fr [137.194.161.143])
	by smtp2.enst.fr (Postfix) with ESMTP id F0260844B9;
	Thu,  9 Oct 2008 11:01:57 +0200 (CEST)
Received: from arrakis.enst.fr (localhost [127.0.0.1])
	by arrakis.enst.fr (Postfix) with ESMTP id 4925D20463;
	Thu,  9 Oct 2008 11:01:57 +0200 (CEST)
User-Agent: StGIT/unknown-version
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97836>

If, for any reason, one of the SHA1 is not a commit object,
"git diff-tree --stdin" will signal an error on its standard
error and will only issue the requested "end" pattern.

"stg diff" could wait forver for the right references to
happen. With this patch, we now get:

% stg diff
stg diff: error: Object 6daaab2215a3d277a315d6938bdda86b2f75f6af not a commit
---
 stgit/lib/git.py |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 4f210f8..45c0b32 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -579,10 +579,10 @@ class DiffTreeProcesses(object):
         p.stdin.write(query + end)
         p.stdin.flush()
         s = ''
-        while not (s.endswith('\n' + end) or s.endswith('\0' + end)):
+        while not s.endswith(end):
             s += os.read(p.stdout.fileno(), 4096)
-        assert s.startswith(query)
-        assert s.endswith(end)
+        if not s.startswith(query):
+            raise RepositoryException(os.read(p.stderr.fileno(), 4096))
         return s[len(query):-len(end)]
 
 class Repository(RunWithEnv):
