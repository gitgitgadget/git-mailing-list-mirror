From: Peter Osterlund <petero2@telia.com>
Subject: Re: Stacked GIT 0.3 (now more Quilt-like)
Date: 08 Jul 2005 03:10:02 +0200
Message-ID: <m31x6acdcl.fsf@telia.com>
References: <1119994003.9631.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 08 03:11:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqhNr-0005ut-Am
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 03:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbVGHBKP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 21:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVGHBKP
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 21:10:15 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:10115 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262406AbVGHBKN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2005 21:10:13 -0400
Received: from r3000.localdomain (62.20.229.17) by pne-smtpout2-sn2.hy.skanova.net (7.2.060.1)
        id 42B94E29002D8D68; Fri, 8 Jul 2005 03:10:10 +0200
Received: from r3000.localdomain (r3000.localdomain [127.0.0.1])
	by r3000.localdomain (8.13.1/8.13.1) with ESMTP id j681A41X029222;
	Fri, 8 Jul 2005 03:10:04 +0200
Received: (from petero@localhost)
	by r3000.localdomain (8.13.1/8.13.1/Submit) id j681A3Y5029217;
	Fri, 8 Jul 2005 03:10:03 +0200
X-Authentication-Warning: r3000.localdomain: petero set sender to petero2@telia.com using -f
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <1119994003.9631.6.camel@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> writes:

> A new StGIT release is available from http://procode.org/stgit/

I think it would be good if it was possible to include diffstat output
in exported patches, something like this:


Added possibility to include diffstat output in exported patches.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 b/stgit/git.py  |   22 ++++++++++++++++++++++
 b/stgit/main.py |    2 ++
 2 files changed, 24 insertions(+)

diff --git a/stgit/git.py b/stgit/git.py
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -345,6 +345,28 @@ def diff(files = [], rev1 = 'HEAD', rev2
                      % (rev1, files_str, extra_args)) != 0:
             raise GitException, 'git-diff-cache failed'
 
+def diffstat(files = [], rev1 = 'HEAD', rev2 = None):
+    """Return the diffstat between rev1 and rev2
+    """
+    files_str = reduce(lambda x, y: x + ' ' + y, files, '')
+
+    os.system('git-update-cache --refresh > /dev/null')
+
+    if rev2:
+        f = os.popen('git-diff-tree -p %s %s %s | diffstat -p0'
+                     % (rev1, rev2, files_str), 'r')
+        str = f.read()
+        if f.close():
+            raise GitException, 'git-diff-tree failed'
+        return str
+    else:
+        f = os.popen('git-diff-cache -p %s %s | diffstat -p0'
+                     % (rev1, files_str), 'r')
+        str = f.read()
+        if f.close():
+            raise GitException, 'git-diff-cache failed'
+        return str
+
 def checkout(files = [], force = False):
     """Check out the given or all files
     """
diff --git a/stgit/main.py b/stgit/main.py
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -659,6 +659,8 @@ def export(parser, options, args):
         patch = crt_series.get_patch(p)
 
         tmpl_dict = {'description': patch.get_description().rstrip(),
+                     'diffstat': git.diffstat(rev1 = __git_id('%s/bottom' % p),
+                                              rev2 = __git_id('%s/top' % p)),
                      'authname': patch.get_authname(),
                      'authemail': patch.get_authemail(),
                      'authdate': patch.get_authdate(),

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
