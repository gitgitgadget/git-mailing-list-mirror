From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 09/20] remote-hg: refactor export
Date: Mon,  8 Apr 2013 12:13:23 -0500
Message-ID: <1365441214-21096-10-git-send-email-felipe.contreras@gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:15:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFf8-0004EZ-HM
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761995Ab3DHRPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:15:16 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:34841 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761383Ab3DHRPN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:15:13 -0400
Received: by mail-ob0-f171.google.com with SMTP id v19so2879924obq.16
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=mEfqzNtgVLaFlUPCY5ijGE/gss2dNuMIjF4TrQ83J04=;
        b=oeOfsXesJyZkkjI3qfDheBsj7cwaGbLPaws8mfIQLuWgJfM91uMMUH2lD96wlzHamL
         8kTxS6eG7zMQbY4LS0P4JTNy0TstEqtdMWpQnOJR6hpqaRunGVxYUPTnnrl3WYjse/Zv
         79CrnRkc82j48YjdH/4uifOAQ21FkvVXqSReQS7qWkOjibq8PVZEsEm5agWGMF9WUxTg
         7jL+9LhtAe1cv7h6hYi4yP+1mcJA6oQiIRm29VtYox5eMT4P1mgUJqmdMCcieDV7uj0a
         KrI8X5yTny+kvDZ4dVsBO2fSM1YcnnhTN/vlTWIOGvlTZ9N4+gpeBX47EoZVKMZ538Qk
         067w==
X-Received: by 10.182.106.16 with SMTP id gq16mr16121397obb.27.1365441312424;
        Mon, 08 Apr 2013 10:15:12 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id it9sm24998359obb.6.2013.04.08.10.15.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:15:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220450>

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 6901689..c741f13 100755
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
@@ -705,19 +708,18 @@ def do_export(parser):
 
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
@@ -725,6 +727,7 @@ def do_export(parser):
     # handle bookmarks
     for bmark, node in p_bmarks:
         ref = 'refs/heads' + bmark
+        new = hghex(node)
 
         if bmark in bmarks:
             old = bmarks[bmark].hex()
@@ -733,10 +736,11 @@ def do_export(parser):
 
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
