From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/13] remote-hg: refactor export
Date: Tue,  2 Apr 2013 13:02:58 -0600
Message-ID: <1364929382-1399-10-git-send-email-felipe.contreras@gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 21:05:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6WA-0007LU-1P
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932984Ab3DBTEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:04:34 -0400
Received: from mail-gh0-f180.google.com ([209.85.160.180]:37625 "EHLO
	mail-gh0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932922Ab3DBTEa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:04:30 -0400
Received: by mail-gh0-f180.google.com with SMTP id f13so112625ghb.25
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=0ILCUQCGPg/0btdwMhoe0vKrbQS99+Nd525es9TKBT8=;
        b=z81uaKNR5o5h1UNN5IDQH+B/ecAlab9nKEuovPgU3uMtL6tVhd4DK+Mu4k+95oVcZ+
         w3cORLuF/YyACoisLQOmWMCHrWGdA87GzwB/sFjLG59cZYEFG7OcWlOM4YC3EfQQNDnC
         hwH6kasYKLU9sZDxioM+KEkwmYe/+TSeGU7GDh3odt/eT+KQrtvpix9pfDW7m6SaOjHZ
         b9rfQLjEj/LF4MnF/VjyToy76KWKP1Sp8xIfPEx7X3BzPdNvhZ0fFCLcnU3IVwkvHM6m
         en+PPlSxWtUhfB8+AZRT3cogt+FOq3I67DnyJL0Gk+H43IfgEFx8HxaQu7JUrduJR9//
         mGIw==
X-Received: by 10.236.193.200 with SMTP id k48mr16083009yhn.69.1364929469623;
        Tue, 02 Apr 2013 12:04:29 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id m28sm4864484yhi.11.2013.04.02.12.04.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 12:04:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219846>

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 73d79cb..11162a2 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -9,7 +9,7 @@
 # Then you can clone with:
 # git clone hg::/path/to/mercurial/repo/
 
-from mercurial import hg, ui, bookmarks, context, util, encoding
+from mercurial import hg, ui, bookmarks, context, util, encoding, node
 
 import re
 import sys
@@ -60,6 +60,9 @@ def hgmode(mode):
     m = { '100755': 'x', '120000': 'l' }
     return m.get(mode, '')
 
+def hghex(node):
+    return hg.node.hex(node)
+
 def get_config(config):
     cmd = ['git', 'config', '--get', config]
     process = subprocess.Popen(cmd, stdout=subprocess.PIPE)
@@ -705,25 +708,25 @@ def do_export(parser):
 
     for ref, node in parsed_refs.iteritems():
         if ref.startswith('refs/heads/branches'):
-            pass
+            print "ok %s" % ref
         elif ref.startswith('refs/heads/'):
             bmark = ref[len('refs/heads/'):]
             p_bmarks.append((bmark, node))
-            # handle below
             continue
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
             parser.repo.tag([tag], node, None, True, None, {})
+            print "ok %s" % ref
         else:
             # transport-helper/fast-export bugs
             continue
-        print "ok %s" % ref
 
     if peer:
         parser.repo.push(peer, force=False)
 
     # handle bookmarks
     for bmark, node in p_bmarks:
+        new = hghex(node)
 
         if bmark in bmarks:
             old = bmarks[bmark].hex()
@@ -732,10 +735,11 @@ def do_export(parser):
 
         if bmark == 'master' and 'master' not in parser.repo._bookmarks:
             # fake bookmark
-            print "ok %s" % ref
-            continue
-
-        if not bookmarks.pushbookmark(parser.repo, bmark, old, node):
+            pass
+        elif bookmarks.pushbookmark(parser.repo, bmark, old, new):
+            # updated locally
+            pass
+        else:
             print "error %s" % ref
             continue
 
-- 
1.8.2
