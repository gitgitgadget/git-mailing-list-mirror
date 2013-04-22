From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 15/16] remote-hg: use marks instead of inlined files
Date: Mon, 22 Apr 2013 16:55:23 -0500
Message-ID: <1366667724-567-16-git-send-email-felipe.contreras@gmail.com>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 23 00:00:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUOn1-0006aH-WD
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 00:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130Ab3DVWAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 18:00:43 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44857 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab3DVWAn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 18:00:43 -0400
Received: by mail-oa0-f46.google.com with SMTP id k3so3847209oag.33
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 15:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=re9sjYJsTxsKL8j1nL0clI3YOokYA9aU0o/xIMC6/1g=;
        b=mOiOFaep7/s1T2g/UQ8rBEW3tmxGYu/SfWeYrWlKF1gBRMaRFdjkTMi567O0d0otBR
         z5I56x2/o62p/X/KRC3TJSBJ+EAYIr1DTJC4NYIjg+pxX8crWA6s+diVTtxoB8oATQ5q
         LIo4VCdDwPK10Yl1TAyfjl73s/2vW9f4mTAAFWP2zBum4xpFsgY8yzwsTLhc9Wt1dbM+
         k2DmJno/1iRbm+FG6vujgY/bvR9mP7dlIyNHwvHFvT7TLtDqZ1ub8Y65hMNg2gUnS7OG
         Ljs02efjssTtESeY4UjLfwptlDvKN+UUgBno5GKspezfQuevCviQvuTuJyoKpDplGbWJ
         9FMg==
X-Received: by 10.182.32.1 with SMTP id e1mr10441146obi.90.1366668042773;
        Mon, 22 Apr 2013 15:00:42 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id xz9sm20877762oeb.5.2013.04.22.15.00.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 15:00:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222113>

So that we can find already exported ones. We can never be 100% sure
that we already exported such data, due to mercurial design, it at least
sometimes we should detect them, and so should give ups some performance
boost.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 41 +++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index f80236b..d0e552c 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -126,6 +126,10 @@ class Marks:
     def to_rev(self, mark):
         return self.rev_marks[mark]
 
+    def next_mark(self):
+        self.last_mark += 1
+        return self.last_mark
+
     def get_mark(self, rev):
         self.last_mark += 1
         self.marks[str(rev)] = self.last_mark
@@ -218,12 +222,29 @@ def fix_file_path(path):
         return path
     return os.path.relpath(path, '/')
 
-def export_file(fc):
-    d = fc.data()
-    path = fix_file_path(fc.path())
-    print "M %s inline %s" % (gitmode(fc.flags()), path)
-    print "data %d" % len(d)
-    print d
+def export_files(files):
+    global marks, filenodes
+
+    final = []
+    for f in files:
+        fid = node.hex(f.filenode())
+
+        if fid in filenodes:
+            mark = filenodes[fid]
+        else:
+            mark = marks.next_mark()
+            filenodes[fid] = mark
+            d = f.data()
+
+            print "blob"
+            print "mark :%u" % mark
+            print "data %d" % len(d)
+            print d
+
+        path = fix_file_path(f.path())
+        final.append((gitmode(f.flags()), mark, path))
+
+    return final
 
 def get_filechanges(repo, ctx, parent):
     modified = set()
@@ -413,6 +434,8 @@ def export_ref(repo, name, kind, head):
         if len(parents) == 0 and rev:
             print 'reset %s/%s' % (prefix, ename)
 
+        modified_final = export_files(c.filectx(f) for f in modified)
+
         print "commit %s/%s" % (prefix, ename)
         print "mark :%d" % (marks.get_mark(rev))
         print "author %s" % (author)
@@ -425,8 +448,8 @@ def export_ref(repo, name, kind, head):
             if len(parents) > 1:
                 print "merge :%s" % (rev_to_mark(parents[1]))
 
-        for f in modified:
-            export_file(c.filectx(f))
+        for f in modified_final:
+            print "M %s :%u %s" % f
         for f in removed:
             print "D %s" % (fix_file_path(f))
         print
@@ -878,6 +901,7 @@ def main(args):
     global peer, mode, bad_mail, bad_name
     global track_branches, force_push, is_tmp
     global parsed_tags
+    global filenodes
 
     alias = args[1]
     url = args[2]
@@ -921,6 +945,7 @@ def main(args):
     parsed_refs = {}
     marks = None
     parsed_tags = {}
+    filenodes = {}
 
     repo = get_repo(url, alias)
     prefix = 'refs/hg/%s' % alias
-- 
1.8.2.1.790.g4588561
