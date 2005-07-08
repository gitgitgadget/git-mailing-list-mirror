From: Peter Osterlund <petero2@telia.com>
Subject: Re: Stacked GIT 0.3 (now more Quilt-like)
Date: 08 Jul 2005 10:14:21 +0200
Message-ID: <m3d5ptlnoi.fsf@telia.com>
References: <1119994003.9631.6.camel@localhost.localdomain>
	<m31x6acdcl.fsf@telia.com> <7vk6k2dr8i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 10:16:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqo1R-0001mF-H4
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 10:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVGHIPc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 04:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVGHIPc
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 04:15:32 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:2810 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S262103AbVGHIPR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2005 04:15:17 -0400
Received: from r3000.localdomain (62.20.228.225) by pne-smtpout2-sn1.fre.skanova.net (7.2.060.1)
        id 42B93717002E349C; Fri, 8 Jul 2005 10:15:09 +0200
Received: from r3000.localdomain (r3000.localdomain [127.0.0.1])
	by r3000.localdomain (8.13.1/8.13.1) with ESMTP id j688EZjD008726;
	Fri, 8 Jul 2005 10:14:35 +0200
Received: (from petero@localhost)
	by r3000.localdomain (8.13.1/8.13.1/Submit) id j688EMMS008715;
	Fri, 8 Jul 2005 10:14:22 +0200
X-Authentication-Warning: r3000.localdomain: petero set sender to petero2@telia.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6k2dr8i.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> >>>>> "PO" == Peter Osterlund <petero2@telia.com> writes:
> 
> PO> I think it would be good if it was possible to include diffstat output
> PO> in exported patches, something like this:
> 
> PO> Added possibility to include diffstat output in exported patches.
> 
> And you wuold want to do things similarly to what others have
> already done.  git-resolve-script uses "git-apply --stat" there,
> instead of "diffstat", so people without diffstat installed can
> still get the same information.

Thanks for the hint. Here is a replacement patch that uses git-apply
instead.


Added possibility to include diffstat output in exported patches.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 stgit/git.py  |   23 +++++++++++++++++++++++
 stgit/main.py |    2 ++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -345,6 +345,29 @@ def diff(files = [], rev1 = 'HEAD', rev2
                      % (rev1, files_str, extra_args)) != 0:
             raise GitException, 'git-diff-cache failed'
 
+def diffstat(files = [], rev1 = 'HEAD', rev2 = None):
+    """Return the diffstat between rev1 and rev2
+    """
+    files_str = reduce(lambda x, y: x + ' ' + y, files, '')
+
+    os.system('git-update-cache --refresh > /dev/null')
+    ds_cmd = '| git-apply --stat --summary'
+
+    if rev2:
+        f = os.popen('git-diff-tree -p %s %s %s %s'
+                     % (rev1, rev2, files_str, ds_cmd), 'r')
+        str = f.read()
+        if f.close():
+            raise GitException, 'git-diff-tree failed'
+        return str
+    else:
+        f = os.popen('git-diff-cache -p %s %s %s'
+                     % (rev1, files_str, ds_cmd), 'r')
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
