From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGit PATCH 3/5] Do not create an empty patch if import failed
	without --reject
Date: Wed, 16 Sep 2009 22:41:05 +0100
Message-ID: <20090916214105.6622.24307.stgit@toshiba-laptop>
References: <20090916214049.6622.44662.stgit@toshiba-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 23:48:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo2Mj-0003lJ-SY
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 23:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760171AbZIPVsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 17:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760164AbZIPVs2
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 17:48:28 -0400
Received: from cpc3-cmbg12-0-0-cust617.cmbg.cable.ntl.com ([86.9.126.106]:45392
	"EHLO toshiba-laptop" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760155AbZIPVs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 17:48:28 -0400
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2009 17:48:28 EDT
Received: by toshiba-laptop (Postfix, from userid 1000)
	id B85721C079E; Wed, 16 Sep 2009 22:41:05 +0100 (BST)
In-Reply-To: <20090916214049.6622.44662.stgit@toshiba-laptop>
User-Agent: StGit/0.15-rc3-5-g9f71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128681>

If the import failed, do not leave an empty patch on the stack. If this
is required, the --reject option should be passed. The patch also fixes
a lowercase typo in the --reject option description.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/imprt.py |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
index aa75065..de77635 100644
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -68,7 +68,7 @@ options = [
     opt('-b', '--base', args = [argparse.commit],
         short = 'Use BASE instead of HEAD for file importing'),
     opt('--reject', action = 'store_true',
-        short = 'leave the rejected hunks in corresponding *.rej files'),
+        short = 'Leave the rejected hunks in corresponding *.rej files'),
     opt('-e', '--edit', action = 'store_true',
         short = 'Invoke an editor for the patch description'),
     opt('-d', '--showdiff', action = 'store_true',
@@ -154,8 +154,13 @@ def __create_patch(filename, message, author_name, author_email,
             base = git_id(crt_series, options.base)
         else:
             base = None
-        git.apply_patch(diff = diff, base = base, reject = options.reject,
-                        strip = options.strip)
+        try:
+            git.apply_patch(diff = diff, base = base, reject = options.reject,
+                            strip = options.strip)
+        except git.GitException:
+            if not options.reject:
+                crt_series.delete_patch(patch)
+            raise
         crt_series.refresh_patch(edit = options.edit,
                                  show_patch = options.showdiff,
                                  author_date = author_date,
