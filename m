From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/6] Allows extraction of information about remotes.
Date: Sat, 27 Jan 2007 18:22:43 +0100
Message-ID: <20070127172243.27183.90701.stgit@gandelf.nowhere.earth>
References: <20070127172129.27183.50432.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 18:24:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HArHf-00039p-TC
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 18:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbXA0RX7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 12:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166AbXA0RX7
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 12:23:59 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:58213 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958AbXA0RX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 12:23:58 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 07C2A4A262;
	Sat, 27 Jan 2007 18:23:57 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id B35A31F089;
	Sat, 27 Jan 2007 18:22:43 +0100 (CET)
In-Reply-To: <20070127172129.27183.50432.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37971>


We want to know the list of declared remotes, the local branches they
hold, and which remotes holds a given branch.  All this regardless of
where the information is stored.

If there are any git-1.5 remotes declared in .git/config, we suppose
you know what you're doing and they will take precedence on any
pre-1.5 remotes.

This does not use git-remote for now, since it is 1.5 material not
released yet, does not support legacy branches/ remotes, and does not
allow yet to query all of the information we need.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/git.py |   75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index c21c074..849a417 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -879,3 +879,78 @@ def modifying_revs(files, base_rev):
     revs = [line.strip() for line in _output_lines(cmd + files)]
 
     return revs
+
+
+def __remotes_from_config():
+    configremotes = []
+    stream = os.popen('git repo-config --get-regexp "^remote\..*\.url$"', 'r')
+    for line in stream:
+        m = re.match('^remote\.(.*)\.url ', line)
+        if m:
+            configremotes.append(m.group(1))
+    stream.close()
+    return configremotes
+
+def __remotes_from_dir(dir):
+    return os.listdir(os.path.join(basedir.get(), dir))
+
+def remotes_list():
+    """Return the list of remotes in the repository
+    """
+
+    return set(__remotes_from_config()) | \
+           set(__remotes_from_dir('remotes')) | \
+           set(__remotes_from_dir('branches'))
+
+def remotes_local_branches(remote):
+    """Returns the list of local branches fetched from given remote
+    """
+
+    branches = []
+    if remote in __remotes_from_config():
+        stream = os.popen('git repo-config --get-all "remote.%s.fetch"' % remote, 'r')
+        for line in stream:
+            # FIXME: should factorize refspec handling
+            m = re.match('^[^:]*:([^:]*)\n$', line)
+            if m:
+                branches.append(m.group(1))
+            else:
+                raise GitException, 'Cannot parse refspec "%s"' % line
+        stream.close()
+    elif remote in __remotes_from_dir('remotes'):
+        stream = open(os.path.join(basedir.get(), 'remotes', remote), 'r')
+        for line in stream:
+            # Only consider Pull lines
+            m = re.match('^Pull: (.*)\n$', line)
+            if m:
+                refspec = m.group(1)
+                m = re.match('^[^:]*:([^:]*)$', refspec)
+                if m:
+                    branches.append(m.group(1))
+                else:
+                    raise GitException, 'Cannot parse refspec "%s"' % refspec
+        stream.close()
+        pass
+    elif remote in __remotes_from_dir('branches'):
+        # old-style branches only declare one branch
+        branches.append('refs/heads/'+remote);
+        pass
+    else:
+        raise GitException, 'Unknown remote "%s"' % remote
+
+    return branches
+
+def identify_remote(branchname):
+    """Return the name for the remote to pull the given branchname
+    from, or None if we believe it is a local branch.
+    """
+
+    for remote in remotes_list():
+        if branchname in remotes_local_branches(remote):
+            return remote
+
+    # FIXME: in the case of local branch we should maybe set remote to
+    # "." but are we even sure it is the only case left ?
+
+    # if we get here we've found nothing
+    return None
