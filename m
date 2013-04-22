From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/16] remote-hg: custom method to write tags
Date: Mon, 22 Apr 2013 16:55:15 -0500
Message-ID: <1366667724-567-8-git-send-email-felipe.contreras@gmail.com>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 22 23:58:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUOl5-0002xN-8F
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 23:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007Ab3DVV6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 17:58:42 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:34595 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab3DVV6l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 17:58:41 -0400
Received: by mail-ob0-f181.google.com with SMTP id ta17so1244072obb.26
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 14:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=pxyRHcvQyHSPhm3wHuvSxEXDiaqY0sqRUJUr2tmhPmU=;
        b=YdXQKvZwNNQO9+pdwnjfVXutXY66Nzy9lonpLHW2PerFgVQnk3MPyyF8Lbo1j93m3I
         otG/vm3gFx4hJaEYkG8xhksl+V0O45/Mz+gDAA9ckAjJAhZxuctayvFhpeBXyG9lh5fL
         vxPNr5+2cHuRSJ91U5vkYp0nLQs2pMCggLD5oV0iXI9YIKjMgm3dYA4DnlNemxnnYp99
         oXumJDgzbSGz9XQm6gSfh7z5HRLEJx8LQvvH85m2ngp3m8dr6aXYiLJg6u/yHEhtiCmi
         rMq5WbJjyuDRH+CIQSwA+eV+tNa8xABigQyw82NU+gnrU+EV1jRGR4phqgJsuEi7x+d7
         9KKw==
X-Received: by 10.60.164.9 with SMTP id ym9mr11396595oeb.107.1366667921456;
        Mon, 22 Apr 2013 14:58:41 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id zc8sm20060829obc.8.2013.04.22.14.58.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 14:58:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222104>

The one from mercurial is meant for users, on top of the latest tip.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 4a1c637..f5e4ba7 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -724,6 +724,37 @@ def parse_tag(parser):
 
     parsed_tags[name] = (tagger, data)
 
+def write_tag(repo, tag, node, msg, author):
+    tip = repo['tip']
+
+    def getfilectx(repo, memctx, f):
+        try:
+            fctx = tip.filectx(f)
+            data = fctx.data()
+        except error.ManifestLookupError:
+            data = ""
+        content = data + "%s %s\n" % (hghex(node), tag)
+        return context.memfilectx(f, content, False, False, None)
+
+    p1 = tip.hex()
+    p2 = '\0' * 20
+    if not author:
+        author = (None, 0, 0)
+    user, date, tz = author
+
+    ctx = context.memctx(repo, (p1, p2), msg,
+            ['.hgtags'], getfilectx,
+            user, (date, tz), {})
+
+    tmp = encoding.encoding
+    encoding.encoding = 'utf-8'
+
+    tagnode = repo.commitctx(ctx)
+
+    encoding.encoding = tmp
+
+    return tagnode
+
 def do_export(parser):
     global parsed_refs, bmarks, peer
 
@@ -762,7 +793,7 @@ def do_export(parser):
             if mode == 'git':
                 if not msg:
                     msg = 'Added tag %s for changeset %s' % (tag, hghex(node[:6]));
-                parser.repo.tag([tag], node, msg, False, author[0], {})
+                write_tag(parser.repo, tag, node, msg, author)
             else:
                 parser.repo.tag([tag], node, None, True, None, {})
             print "ok %s" % ref
-- 
1.8.2.1.790.g4588561
