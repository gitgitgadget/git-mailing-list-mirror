From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 3/6] Properly detect that HEAD is detached
Date: Mon, 08 Oct 2007 10:55:23 +0200
Message-ID: <20071008085523.9734.44817.stgit@yoghurt>
References: <20071008085430.9734.75797.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 10:57:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeoQ6-0003VA-Qn
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 10:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbXJHIzb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2007 04:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbXJHIza
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 04:55:30 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2223 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbXJHIz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 04:55:28 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IeoOa-00025E-00; Mon, 08 Oct 2007 09:55:24 +0100
In-Reply-To: <20071008085430.9734.75797.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60305>

We still error out on a lot of places we shouldn't, e.g. "stg branch"
when on a detached HEAD, but at least now we give a sane error
message.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/git.py |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)


diff --git a/stgit/git.py b/stgit/git.py
index 812b77a..cc6acb1 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -246,11 +246,19 @@ def get_head():
         __head =3D rev_parse('HEAD')
     return __head
=20
+class DetachedHeadException(GitException):
+    def __init__(self):
+        GitException.__init__(self, 'Not on any branch')
+
 def get_head_file():
-    """Returns the name of the file pointed to by the HEAD link
-    """
-    return strip_prefix('refs/heads/',
-                        GRun('git-symbolic-ref', 'HEAD').output_one_li=
ne())
+    """Return the name of the file pointed to by the HEAD symref.
+    Throw an exception if HEAD is detached."""
+    try:
+        return strip_prefix(
+            'refs/heads/', GRun('git-symbolic-ref', '-q', 'HEAD'
+                                ).output_one_line())
+    except GitRunException:
+        raise DetachedHeadException()
=20
 def set_head_file(ref):
     """Resets HEAD to point to a new ref
@@ -385,8 +393,11 @@ def rename_ref(from_ref, to_ref):
 def rename_branch(from_name, to_name):
     """Rename a git branch."""
     rename_ref('refs/heads/%s' % from_name, 'refs/heads/%s' % to_name)
-    if get_head_file() =3D=3D from_name:
-        set_head_file(to_name)
+    try:
+        if get_head_file() =3D=3D from_name:
+            set_head_file(to_name)
+    except DetachedHeadException:
+        pass # detached HEAD, so the renamee can't be the current bran=
ch
     reflog_dir =3D os.path.join(basedir.get(), 'logs', 'refs', 'heads'=
)
     if os.path.exists(reflog_dir) \
            and os.path.exists(os.path.join(reflog_dir, from_name)):
