From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATH 1/4] remote-hg: shuffle some code
Date: Fri,  5 Apr 2013 05:36:16 -0600
Message-ID: <1365161779-32170-2-git-send-email-felipe.contreras@gmail.com>
References: <1365161779-32170-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Max Horn <max@quendi.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 18:56:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWFY-0002u6-Ag
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032Ab3DELhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 07:37:21 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:59421 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab3DELhT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 07:37:19 -0400
Received: by mail-oa0-f51.google.com with SMTP id g12so3871297oah.38
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 04:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=wjCQ8Qnv1p3zIiqven3JmiSw6BGz0OjBJOf/pNhsmmU=;
        b=nRx+L+zPMrQzWZBONxhpko6T1ujwbJE/5tOjyvoVQUVwQmH995HCZZLwoQM+/LlD7+
         OMLeHK4sJs+EImlw45x0fw/3otmJm0Wv+sM9h/2AQI8xlPgRDc2IKNjJnDPwqAioX7gp
         ZCcf+iqSw3EuMnG/S01rsEk6C8BDeT45zqcyST5G6WTyQenZNMQ44NOncGVBRszD5w2o
         ntA+QHhkWakIRGvEZ8I3g7nyZzim81B2mqSZYLi4T8JHtF52jEbM517yy4POAvvIpbR6
         D9GXF6LZ6z8k23KaQ7smu9WtbsSPS0wsWEayQtL1Qfzru4aE7Rt+4G9MqCBiulakuLGb
         DnRA==
X-Received: by 10.182.112.202 with SMTP id is10mr7283423obb.8.1365161839031;
        Fri, 05 Apr 2013 04:37:19 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id v8sm11894252oea.4.2013.04.05.04.37.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Apr 2013 04:37:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365161779-32170-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220171>

In preparation to shift to SHA-1's.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index d82eb2d..a8591a2 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -63,6 +63,9 @@ def hgmode(mode):
 def hghex(node):
     return hg.node.hex(node)
 
+def hgbin(node):
+    return hg.node.bin(node)
+
 def get_config(config):
     cmd = ['git', 'config', '--get', config]
     process = subprocess.Popen(cmd, stdout=subprocess.PIPE)
@@ -207,7 +210,7 @@ def get_filechanges(repo, ctx, parent):
     removed = set()
 
     cur = ctx.manifest()
-    prev = repo[parent].manifest().copy()
+    prev = parent.manifest().copy()
 
     for fn in cur:
         if fn in prev:
@@ -326,7 +329,7 @@ def export_ref(repo, name, kind, head):
         else:
             committer = author
 
-        parents = [p for p in repo.changelog.parentrevs(rev) if p >= 0]
+        parents = [repo[p] for p in repo.changelog.parentrevs(rev) if p >= 0]
 
         if len(parents) == 0:
             modified = c.manifest().keys()
@@ -372,9 +375,9 @@ def export_ref(repo, name, kind, head):
         print desc
 
         if len(parents) > 0:
-            print "from :%s" % (rev_to_mark(parents[0]))
+            print "from :%s" % (rev_to_mark(parents[0].rev()))
             if len(parents) > 1:
-                print "merge :%s" % (rev_to_mark(parents[1]))
+                print "merge :%s" % (rev_to_mark(parents[1].rev()))
 
         for f in modified:
             export_file(c.filectx(f))
@@ -389,10 +392,10 @@ def export_ref(repo, name, kind, head):
 
     # make sure the ref is updated
     print "reset %s/%s" % (prefix, ename)
-    print "from :%u" % rev_to_mark(rev)
+    print "from :%u" % rev_to_mark(head.rev())
     print
 
-    marks.set_tip(ename, rev)
+    marks.set_tip(ename, head.rev())
 
 def export_tag(repo, tag):
     export_ref(repo, tag, 'tags', repo[tag])
@@ -651,7 +654,7 @@ def parse_commit(parser):
     tmp = encoding.encoding
     encoding.encoding = 'utf-8'
 
-    node = repo.commitctx(ctx)
+    node = hghex(repo.commitctx(ctx))
 
     encoding.encoding = tmp
 
@@ -675,7 +678,7 @@ def parse_reset(parser):
     parser.next()
 
     node = parser.repo.changelog.node(mark_to_rev(from_mark))
-    parsed_refs[ref] = node
+    parsed_refs[ref] = hghex(node)
 
 def parse_tag(parser):
     name = parser[1]
@@ -720,10 +723,10 @@ def do_export(parser):
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
             if mode == 'git':
-                msg = 'Added tag %s for changeset %s' % (tag, hghex(node[:6]));
-                parser.repo.tag([tag], node, msg, False, None, {})
+                msg = 'Added tag %s for changeset %s' % (tag, node[:6]);
+                parser.repo.tag([tag], hgbin(node), msg, False, None, {})
             else:
-                parser.repo.tag([tag], node, None, True, None, {})
+                parser.repo.tag([tag], hgbin(node), None, True, None, {})
             print "ok %s" % ref
         else:
             # transport-helper/fast-export bugs
@@ -735,7 +738,7 @@ def do_export(parser):
     # handle bookmarks
     for bmark, node in p_bmarks:
         ref = 'refs/heads' + bmark
-        new = hghex(node)
+        new = node
 
         if bmark in bmarks:
             old = bmarks[bmark].hex()
-- 
1.8.2
