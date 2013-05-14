From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 41/47] remote-hg: pass around revision refs
Date: Mon, 13 May 2013 23:37:04 -0500
Message-ID: <1368506230-19614-42-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:41:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc732-000504-KF
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909Ab3ENEk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:40:56 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:40438 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184Ab3ENEkz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:40:55 -0400
Received: by mail-oa0-f41.google.com with SMTP id n9so106591oag.0
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=SjqaiVkx0wfV3oiHI6A5i4Ra3MmJHlUH8OYI41c0A3E=;
        b=ff7goXpBNfqKVw0v7dHCmYreIntT5BHN4OsFpEUc2LHa9+t5MoOEGF92Eare0gVvYS
         TutwV81OpVLE2tV9O0X17wjTjkry0gFCnnhwyrjatiVgHF6QUr+x5gYMlznHY62DmlHO
         rWQfVofksu6JtSfx8ZNdu+FqjUjMNNDwQS/0myKGHUWrSOfzkVvBzP458LtCbpio05po
         QjIDySslYO208heqBsge2aTds2o7NU8abC+mTOdWnjbfnEy2FBbldablDdVD4l5CLPHa
         6ves+2pHrcT0gevHuG8mFXmRbgeq0oHD7A3PKmgeqJbOl6DXvhQH641/r79YT73Ax7H7
         vjvg==
X-Received: by 10.60.59.198 with SMTP id b6mr15407569oer.84.1368506454705;
        Mon, 13 May 2013 21:40:54 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jt9sm20073651obc.0.2013.05.13.21.40.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:40:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224271>

So that when a diverge is detected, we know which ref to report an error
for.

Also, since we are not throwing an exception, return a proper error
code.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 34 +++++++++++++++++++++-------------
 contrib/remote-helpers/test-hg.sh    |  6 +++---
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index abc0738..5a5667d 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -837,18 +837,19 @@ def write_tag(repo, tag, node, msg, author):
 
     encoding.encoding = tmp
 
-    return tagnode
+    return (tagnode, branch)
 
 def checkheads(repo, remote, p_revs):
 
     remotemap = remote.branchmap()
     if not remotemap:
         # empty repo
-        return
+        return True
 
     new = {}
+    ret = True
 
-    for node in p_revs:
+    for node, ref in p_revs.iteritems():
         ctx = repo[node]
         branch = ctx.branch()
         if not branch in remotemap:
@@ -870,7 +871,11 @@ def checkheads(repo, remote, p_revs):
             if found:
                 continue
 
-            raise Exception("non-fast-forward")
+            node = repo.changelog.node(rev)
+            print "error %s non-fast forward" % p_revs[node]
+            ret = False
+
+    return ret
 
 def push_unsafe(repo, remote, parsed_refs, p_revs):
 
@@ -887,8 +892,8 @@ def push_unsafe(repo, remote, parsed_refs, p_revs):
         # nothing to push
         return None
 
-    if not force:
-        checkheads(unfi, remote, p_revs)
+    if not force and not checkheads(unfi, remote, p_revs):
+        return None
 
     cg = repo.getlocalbundle('push', outgoing)
 
@@ -924,7 +929,7 @@ def do_export(parser):
     global parsed_refs, bmarks, peer
 
     p_bmarks = []
-    p_revs = set()
+    p_revs = {}
 
     parser.next()
 
@@ -949,7 +954,7 @@ def do_export(parser):
             if branch in branches and bnode in branches[branch]:
                 # up to date
                 continue
-            p_revs.add(bnode)
+            p_revs[bnode] = ref
             print "ok %s" % ref
         elif ref.startswith('refs/heads/'):
             bmark = ref[len('refs/heads/'):]
@@ -966,7 +971,7 @@ def do_export(parser):
             else:
                 p_bmarks.append((ref, bmark, old, new))
 
-            p_revs.add(bnode)
+            p_revs[bnode] = ref
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
             tag = hgref(tag)
@@ -974,20 +979,23 @@ def do_export(parser):
             if mode == 'git':
                 if not msg:
                     msg = 'Added tag %s for changeset %s' % (tag, node[:12]);
-                tagnode = write_tag(parser.repo, tag, node, msg, author)
-                p_revs.add(tagnode)
+                tagnode, branch = write_tag(parser.repo, tag, node, msg, author)
+                p_revs[tagnode] = 'refs/heads/branches/' + gitref(branch)
             else:
                 fp = parser.repo.opener('localtags', 'a')
                 fp.write('%s %s\n' % (node, tag))
                 fp.close()
-            p_revs.add(bnode)
+            p_revs[bnode] = ref
             print "ok %s" % ref
         else:
             # transport-helper/fast-export bugs
             continue
 
     if peer:
-        push(parser.repo, peer, parsed_refs, p_revs)
+        if not push(parser.repo, peer, parsed_refs, p_revs):
+            # do not update bookmarks
+            print
+            return
 
         # update remote bookmarks
         remote_bmarks = peer.listkeys('bookmarks')
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 9d62e26..4f6fd4c 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -268,7 +268,7 @@ test_expect_success 'remote new bookmark' '
 	check_bookmark hgrepo feature-b feature-b
 '
 
-test_expect_failure 'remote push diverged' '
+test_expect_success 'remote push diverged' '
 	test_when_finished "rm -rf gitrepo*" &&
 
 	git clone "hg::hgrepo" gitrepo &&
@@ -291,7 +291,7 @@ test_expect_failure 'remote push diverged' '
 	check_branch hgrepo default bump
 '
 
-test_expect_failure 'remote update bookmark diverge' '
+test_expect_success 'remote update bookmark diverge' '
 	test_when_finished "rm -rf gitrepo*" &&
 
 	(
@@ -338,7 +338,7 @@ test_expect_failure 'remote new bookmark multiple branch head' '
 # cleanup previous stuff
 rm -rf hgrepo
 
-test_expect_failure 'remote big push' '
+test_expect_success 'remote big push' '
 	test_when_finished "rm -rf hgrepo gitrepo*" &&
 
 	(
-- 
1.8.3.rc1.579.g184e698
