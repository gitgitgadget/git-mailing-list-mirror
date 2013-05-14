From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 18/47] remote-hg: shuffle some code
Date: Mon, 13 May 2013 23:36:41 -0500
Message-ID: <1368506230-19614-19-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:39:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc71d-0004Aq-Nx
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab3ENEjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:39:40 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:37285 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab3ENEji (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:39:38 -0400
Received: by mail-ob0-f179.google.com with SMTP id xn12so94960obc.24
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=2UB4AK5tpihDAPDRIfxkLlm3ReVJPtSqY7/RtinGDu0=;
        b=Rv60hDsAAOZe+YDyO8QDtTUr+s5UdwsHqLhTk8QWP7f01dddHa2XhY8gOpilW4bPPN
         +KvvQTpt8P9L4JWa09D3qTrLnRo8dvJ+RnROlag/2iCG/H6ZV98mUId7YcVo6pPLOWzs
         6TafYF/hgbMZQB4mLDy+aoZaOHCJ5yg5UAmRHuJkAAJph7b1F/mGjMlhPFqxYK+iLkJq
         4opfXAEU2oiqMV66so+4oRDVl5p5u2jaKfjfze8tWMNizGC04Nm6gm1uVe3E63lLY/1E
         KIMe0+CzZ0oGNcof5cqg4nfwwJ5VP0ILja7NhXxtquuDS3xP5+MqHr8LEyLOXsFWaRvZ
         tiIA==
X-Received: by 10.60.148.130 with SMTP id ts2mr14802647oeb.115.1368506377800;
        Mon, 13 May 2013 21:39:37 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wq8sm19998395obb.7.2013.05.13.21.39.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:39:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224250>

In preparation to shift to SHA-1's.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index d676c98..8417d1e 100755
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
@@ -404,7 +407,7 @@ def export_ref(repo, name, kind, head):
         else:
             committer = author
 
-        parents = [p for p in repo.changelog.parentrevs(rev) if p >= 0]
+        parents = [repo[p] for p in repo.changelog.parentrevs(rev) if p >= 0]
 
         if len(parents) == 0:
             modified = c.manifest().keys()
@@ -453,9 +456,9 @@ def export_ref(repo, name, kind, head):
         print desc
 
         if len(parents) > 0:
-            print "from :%s" % (rev_to_mark(parents[0]))
+            print "from :%s" % (rev_to_mark(parents[0].rev()))
             if len(parents) > 1:
-                print "merge :%s" % (rev_to_mark(parents[1]))
+                print "merge :%s" % (rev_to_mark(parents[1].rev()))
 
         for f in modified_final:
             print "M %s :%u %s" % f
@@ -469,10 +472,10 @@ def export_ref(repo, name, kind, head):
 
     # make sure the ref is updated
     print "reset %s/%s" % (prefix, ename)
-    print "from :%u" % rev_to_mark(rev)
+    print "from :%u" % rev_to_mark(head.rev())
     print
 
-    marks.set_tip(ename, rev)
+    marks.set_tip(ename, head.rev())
 
 def export_tag(repo, tag):
     export_ref(repo, tag, 'tags', repo[hgref(tag)])
@@ -742,7 +745,7 @@ def parse_commit(parser):
     tmp = encoding.encoding
     encoding.encoding = 'utf-8'
 
-    node = repo.commitctx(ctx)
+    node = hghex(repo.commitctx(ctx))
 
     encoding.encoding = tmp
 
@@ -766,7 +769,7 @@ def parse_reset(parser):
     parser.next()
 
     node = parser.repo.changelog.node(mark_to_rev(from_mark))
-    parsed_refs[ref] = node
+    parsed_refs[ref] = hghex(node)
 
 def parse_tag(parser):
     name = parser[1]
@@ -791,7 +794,7 @@ def write_tag(repo, tag, node, msg, author):
             data = fctx.data()
         except error.ManifestLookupError:
             data = ""
-        content = data + "%s %s\n" % (hghex(node), tag)
+        content = data + "%s %s\n" % (node, tag)
         return context.memfilectx(f, content, False, False, None)
 
     p1 = tip.hex()
@@ -835,9 +838,10 @@ def do_export(parser):
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
@@ -851,11 +855,11 @@ def do_export(parser):
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
@@ -869,7 +873,7 @@ def do_export(parser):
     # handle bookmarks
     for bmark, node in p_bmarks:
         ref = 'refs/heads/' + bmark
-        new = hghex(node)
+        new = node
 
         if bmark in bmarks:
             old = bmarks[bmark].hex()
-- 
1.8.3.rc1.579.g184e698
