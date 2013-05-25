From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 10/48] remote-hg: shuffle some code
Date: Fri, 24 May 2013 21:29:26 -0500
Message-ID: <1369449004-17981-11-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:32:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4HK-0001c7-SY
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796Ab3EYCcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:32:15 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:55007 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551Ab3EYCcN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:32:13 -0400
Received: by mail-ob0-f180.google.com with SMTP id xk17so6095915obc.25
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=biZ+ziumTd/znU8hE3vADA7BZeSm9FHEIKWE2SEaJaM=;
        b=lIKVtUFlyCjtfarrf+wG6ETT3qiw6Q7jBNBad3qJ1/+X3QznRFdNZ9y4GRZar1bHIQ
         +Quq+SJUTRk42fL2ukfDYOcChzNCrWs2FWaJsU2RiVstPkbu5jH7GlWrDVW2NBgIZYlZ
         LUGAfSQD5kENUNRY5VRhYDkFKGqspFwFhkCab7ofPJm140r2XcQ9j72ZzvvSagQABWXN
         ieBwcUvEHpayPDfiRngKISb3VxdzPDenpWUsKreIXoR3Lcj7Q8HPr5lVo8vPU6j7St1W
         IXZplgh6vv7vMIyT8NBPLKGw/PDQN3mntpQGYn+ylAJaxTi0QfEK43LZqafxWOrJ0QeB
         m8gQ==
X-Received: by 10.182.129.230 with SMTP id nz6mr13371849obb.49.1369449132630;
        Fri, 24 May 2013 19:32:12 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wz1sm6620734obc.3.2013.05.24.19.32.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:32:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225424>

In preparation to shift to SHA-1's.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 7507976..62520ee 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -75,6 +75,9 @@ def hgmode(mode):
 def hghex(node):
     return hg.node.hex(node)
 
+def hgbin(node):
+    return hg.node.bin(node)
+
 def hgref(ref):
     return ref.replace('___', ' ')
 
@@ -261,7 +264,7 @@ def get_filechanges(repo, ctx, parent):
     removed = set()
 
     # load earliest manifest first for caching reasons
-    prev = repo[parent].manifest().copy()
+    prev = parent.manifest().copy()
     cur = ctx.manifest()
 
     for fn in cur:
@@ -401,7 +404,7 @@ def export_ref(repo, name, kind, head):
         else:
             committer = author
 
-        parents = [p for p in repo.changelog.parentrevs(rev) if p >= 0]
+        parents = [repo[p] for p in repo.changelog.parentrevs(rev) if p >= 0]
 
         if len(parents) == 0:
             modified = c.manifest().keys()
@@ -450,9 +453,9 @@ def export_ref(repo, name, kind, head):
         print desc
 
         if len(parents) > 0:
-            print "from :%s" % (rev_to_mark(parents[0]))
+            print "from :%s" % (rev_to_mark(parents[0].rev()))
             if len(parents) > 1:
-                print "merge :%s" % (rev_to_mark(parents[1]))
+                print "merge :%s" % (rev_to_mark(parents[1].rev()))
 
         for f in modified_final:
             print "M %s :%u %s" % f
@@ -466,10 +469,10 @@ def export_ref(repo, name, kind, head):
 
     # make sure the ref is updated
     print "reset %s/%s" % (prefix, ename)
-    print "from :%u" % rev_to_mark(rev)
+    print "from :%u" % rev_to_mark(head.rev())
     print
 
-    marks.set_tip(ename, rev)
+    marks.set_tip(ename, head.rev())
 
 def export_tag(repo, tag):
     export_ref(repo, tag, 'tags', repo[hgref(tag)])
@@ -739,7 +742,7 @@ def parse_commit(parser):
     tmp = encoding.encoding
     encoding.encoding = 'utf-8'
 
-    node = repo.commitctx(ctx)
+    node = hghex(repo.commitctx(ctx))
 
     encoding.encoding = tmp
 
@@ -763,7 +766,7 @@ def parse_reset(parser):
     parser.next()
 
     node = parser.repo.changelog.node(mark_to_rev(from_mark))
-    parsed_refs[ref] = node
+    parsed_refs[ref] = hghex(node)
 
 def parse_tag(parser):
     name = parser[1]
@@ -788,7 +791,7 @@ def write_tag(repo, tag, node, msg, author):
             data = fctx.data()
         except error.ManifestLookupError:
             data = ""
-        content = data + "%s %s\n" % (hghex(node), tag)
+        content = data + "%s %s\n" % (node, tag)
         return context.memfilectx(f, content, False, False, None)
 
     p1 = tip.hex()
@@ -832,9 +835,10 @@ def do_export(parser):
             die('unhandled export command: %s' % line)
 
     for ref, node in parsed_refs.iteritems():
+        bnode = hgbin(node)
         if ref.startswith('refs/heads/branches'):
             branch = ref[len('refs/heads/branches/'):]
-            if branch in branches and node in branches[branch]:
+            if branch in branches and bnode in branches[branch]:
                 # up to date
                 continue
             print "ok %s" % ref
@@ -848,11 +852,11 @@ def do_export(parser):
             author, msg = parsed_tags.get(tag, (None, None))
             if mode == 'git':
                 if not msg:
-                    msg = 'Added tag %s for changeset %s' % (tag, hghex(node[:6]));
+                    msg = 'Added tag %s for changeset %s' % (tag, node[:12]);
                 write_tag(parser.repo, tag, node, msg, author)
             else:
                 fp = parser.repo.opener('localtags', 'a')
-                fp.write('%s %s\n' % (hghex(node), tag))
+                fp.write('%s %s\n' % (node, tag))
                 fp.close()
             print "ok %s" % ref
         else:
@@ -866,7 +870,7 @@ def do_export(parser):
     # handle bookmarks
     for bmark, node in p_bmarks:
         ref = 'refs/heads/' + bmark
-        new = hghex(node)
+        new = node
 
         if bmark in bmarks:
             old = bmarks[bmark].hex()
-- 
1.8.3.rc3.312.g47657de
