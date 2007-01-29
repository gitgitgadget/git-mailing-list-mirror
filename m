From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 4/7] Allows extraction of information about remotes.
Date: Tue, 30 Jan 2007 00:05:40 +0100
Message-ID: <20070129230540.7102.43825.stgit@gandelf.nowhere.earth>
References: <20070129230117.7102.64322.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 00:06:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBfa5-00053b-Oz
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 00:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbXA2XGb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 18:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbXA2XGb
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 18:06:31 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:40077 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964827AbXA2XG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 18:06:28 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id D51F04A06B;
	Tue, 30 Jan 2007 00:06:26 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id A5BBD2004;
	Tue, 30 Jan 2007 00:05:40 +0100 (CET)
In-Reply-To: <20070129230117.7102.64322.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38104>


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

 stgit/git.py |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index 249080e..038aaac 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -881,3 +881,71 @@ def modifying_revs(files, base_rev):
     revs = [line.strip() for line in _output_lines(cmd + files)]
 
     return revs
+
+
+def refspec_localpart(refspec):
+    m = re.match('^[^:]*:([^:]*)$', refspec)
+    if m:
+        return m.group(1)
+    else:
+        raise GitException, 'Cannot parse refspec "%s"' % line
+
+def refspec_remotepart(refspec):
+    m = re.match('^([^:]*):[^:]*$', refspec)
+    if m:
+        return m.group(1)
+    else:
+        raise GitException, 'Cannot parse refspec "%s"' % line
+    
+
+def __remotes_from_config():
+    return config.sections_matching(r'remote\.(.*)\.url')
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
+        for line in config.getall('remote.%s.fetch' % remote):
+            branches.append(refspec_localpart(line))
+    elif remote in __remotes_from_dir('remotes'):
+        stream = open(os.path.join(basedir.get(), 'remotes', remote), 'r')
+        for line in stream:
+            # Only consider Pull lines
+            m = re.match('^Pull: (.*)\n$', line)
+            branches.append(refspec_localpart(m.group(1)))
+        stream.close()
+    elif remote in __remotes_from_dir('branches'):
+        # old-style branches only declare one branch
+        branches.append('refs/heads/'+remote);
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
