From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 35/48] remote-hg: pass around revision refs
Date: Fri, 24 May 2013 21:29:51 -0500
Message-ID: <1369449004-17981-36-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:33:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Ib-0002do-Ei
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755659Ab3EYCdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:33:35 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:44909 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525Ab3EYCdb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:33:31 -0400
Received: by mail-oa0-f42.google.com with SMTP id i10so7066832oag.29
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=18gLzzl6xs0/wsmrpcYMNVhHLtROFy7hdiO9yzT3hN8=;
        b=06ucq/kIi4Td0qPEiS1ZtH8/h7uWofFNNLBN/b7x42FkgSX+qe0sSWQOPH33V3aUyU
         iOhGdLxbFKTigupP7vWxpedzlBn1nfkjExusaOmCe00oKOm4atBE4Nfie8PSgW6+3KPr
         zXK3SRgggPHyq5RON0lvyzwzHAOYFdwKKbjKaDOAMG7eWqPBzMRQ1rvs/WA96UblQtEJ
         8Scl3yCWmlJWC8oR/oMARiZGqPhBXo7v495zReL2iWUNDFjiOLwsbRBhhmBTZohRHcJB
         8L9orJZdjsJDRKvxO2A5366Ro6kjADRqL/i0AQcF4aO+4RrhQ8w69gun3cXz2LCVOmzk
         DlWQ==
X-Received: by 10.182.84.135 with SMTP id z7mr13749544oby.35.1369449210854;
        Fri, 24 May 2013 19:33:30 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n5sm20064690obi.8.2013.05.24.19.33.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:33:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225447>

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
index 7eb809b..b6f85b2 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -857,18 +857,19 @@ def write_tag(repo, tag, node, msg, author):
 
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
@@ -893,7 +894,11 @@ def checkheads(repo, remote, p_revs):
             if found:
                 continue
 
-            raise Exception("non-fast-forward")
+            node = repo.changelog.node(rev)
+            print "error %s non-fast forward" % p_revs[node]
+            ret = False
+
+    return ret
 
 def push_unsafe(repo, remote, parsed_refs, p_revs):
 
@@ -903,8 +908,8 @@ def push_unsafe(repo, remote, parsed_refs, p_revs):
     commoninc = fci(repo, remote, force=force)
     common, _, remoteheads = commoninc
 
-    if not force:
-        checkheads(repo, remote, p_revs)
+    if not force and not checkheads(repo, remote, p_revs):
+        return None
 
     cg = repo.getbundle('push', heads=list(p_revs), common=common)
 
@@ -940,7 +945,7 @@ def do_export(parser):
     global parsed_refs, bmarks, peer
 
     p_bmarks = []
-    p_revs = set()
+    p_revs = {}
 
     parser.next()
 
@@ -965,7 +970,7 @@ def do_export(parser):
             if branch in branches and bnode in branches[branch]:
                 # up to date
                 continue
-            p_revs.add(bnode)
+            p_revs[bnode] = ref
             print "ok %s" % ref
         elif ref.startswith('refs/heads/'):
             bmark = ref[len('refs/heads/'):]
@@ -980,7 +985,7 @@ def do_export(parser):
                     not (bmark == 'master' and bmark not in parser.repo._bookmarks):
                 p_bmarks.append((ref, bmark, old, new))
 
-            p_revs.add(bnode)
+            p_revs[bnode] = ref
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
             tag = hgref(tag)
@@ -988,20 +993,23 @@ def do_export(parser):
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
index c4d98b5..c4e4a1a 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -328,7 +328,7 @@ test_expect_success 'remote new bookmark' '
 	check_bookmark hgrepo feature-b feature-b
 '
 
-test_expect_failure 'remote push diverged' '
+test_expect_success 'remote push diverged' '
 	test_when_finished "rm -rf gitrepo*" &&
 
 	git clone "hg::hgrepo" gitrepo &&
@@ -351,7 +351,7 @@ test_expect_failure 'remote push diverged' '
 	check_branch hgrepo default bump
 '
 
-test_expect_failure 'remote update bookmark diverge' '
+test_expect_success 'remote update bookmark diverge' '
 	test_when_finished "rm -rf gitrepo*" &&
 
 	(
@@ -398,7 +398,7 @@ test_expect_failure 'remote new bookmark multiple branch head' '
 # cleanup previous stuff
 rm -rf hgrepo
 
-test_expect_failure 'remote big push' '
+test_expect_success 'remote big push' '
 	test_when_finished "rm -rf hgrepo gitrepo*" &&
 
 	(
-- 
1.8.3.rc3.312.g47657de
