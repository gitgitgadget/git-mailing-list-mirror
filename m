From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 7/8] remote-hg: make sure we omit multiple heads
Date: Tue, 29 Apr 2014 04:04:34 -0500
Message-ID: <1398762275-346-8-git-send-email-felipe.contreras@gmail.com>
References: <1398762275-346-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 11:16:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf48u-0000RT-P7
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933279AbaD2JPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:15:54 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:51082 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933251AbaD2JPe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:15:34 -0400
Received: by mail-oa0-f51.google.com with SMTP id l6so887625oag.10
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 02:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xEloE/VV71vtvi1RQBvWUrK4IObjp6+nyyy3TZNeTew=;
        b=HZ7UAYmZtVnwU+/pWlKitjzi+B3yt9zULsJO5fE2qq+UVgGDk3boKyLHIqjPdwHLSU
         OJVy77QWGARSCYDeX97LdQk4+mFqfiJt/6n47dRAzX+6HIjNEmqTefCUG7wZXv0MJCKI
         1xzk3f1yFWLKbV0Uytw8rc4Wl9uWRFjckeR6ZoRM/toztgvSVTeWd2Yz73EoGmlWyYS3
         zygocXmFfF+yqwL7O60RBAmm9rkqa+T2UG3Sie29TMERGG6cHBZNdAb72Jp+JMOo4mMt
         xWbyTVQipGX6nzg+guWA3LG25akcdWZ/OH0BCuQ/yigG0m1iOg23syEFQ19sPihaiRLu
         wVSg==
X-Received: by 10.60.117.229 with SMTP id kh5mr22818768oeb.19.1398762934226;
        Tue, 29 Apr 2014 02:15:34 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id qh7sm42791749obc.13.2014.04.29.02.15.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 02:15:33 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.3.gade8541
In-Reply-To: <1398762275-346-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247554>

We want to ignore secondary heads, otherwise we will import revisions
that won't have any ref pointing to them and might eventually be pruned,
which would cause problems with the synchronization of marks.

This can only be expressed properly as '::b - ::a', but that's not
efficient, specially in older versions of Mercurial.
'ancestor(a,b)::b - ancestor(a,b)::a' might be better, but it's not
particularly pretty. Mercurial v3.0 will have a new 'only(b, a)' that
does the same, but that hasn't even been released yet. Either way all of
these require repo.revs() which is only available after Mercurial v2.1.

Also, we would need special considerations for when there's no base
revision (importing from root).

It's much better to implement our own function to get a range of
revisions.

The new gitrange() is inspired by Mercurial's revset.missingancestors().

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-hg.py | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/git-remote-hg.py b/git-remote-hg.py
index cd3d79e..402b92f 100755
--- a/git-remote-hg.py
+++ b/git-remote-hg.py
@@ -437,16 +437,45 @@ def rev_to_mark(rev):
 def mark_to_rev(mark):
     return marks.to_rev(mark)
 
+# Get a range of revisions in the form of a..b (git committish)
+def gitrange(repo, a, b):
+    positive = []
+    pending = set([int(b)])
+    negative = set([int(a)])
+    for cur in xrange(b, -1, -1):
+        if not pending:
+            break
+
+        parents = [p for p in repo.changelog.parentrevs(cur) if p >= 0]
+
+        if cur in pending:
+            positive.append(cur)
+            pending.remove(cur)
+            for p in parents:
+                if not p in negative:
+                    pending.add(p)
+        elif cur in negative:
+            negative.remove(cur)
+            for p in parents:
+                if not p in pending:
+                    negative.add(p)
+                else:
+                    pending.discard(p)
+
+    positive.reverse()
+    return positive
+
 def export_ref(repo, name, kind, head):
     ename = '%s/%s' % (kind, name)
     try:
         tip = marks.get_tip(ename)
-        tip = repo[tip].rev()
+        tip = repo[tip]
     except:
-        tip = 0
+        tip = repo[-1]
 
-    revs = xrange(tip, head.rev() + 1)
+    revs = gitrange(repo, tip, head)
     total = len(revs)
+    tip = tip.rev()
 
     for rev in revs:
 
-- 
1.9.2+fc1.3.gade8541
