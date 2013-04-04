From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 09/13] remote-hg: refactor export
Date: Thu,  4 Apr 2013 09:30:18 -0600
Message-ID: <1365089422-8250-10-git-send-email-felipe.contreras@gmail.com>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 17:32:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNm9K-00048e-Dq
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762611Ab3DDPbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:31:49 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:51551 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762411Ab3DDPbs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:31:48 -0400
Received: by mail-oa0-f44.google.com with SMTP id h1so2935406oag.31
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=mEfqzNtgVLaFlUPCY5ijGE/gss2dNuMIjF4TrQ83J04=;
        b=nZVlU5zw7h1tYn5oZaum/b6/pdwK+XHwwQxCAI9FN9homGudF/GoVO5/WmaIbdsYAL
         BFYjrRftn5KsVeEBlPj9A+WoxI0y1EH6cNCU7gZ8li29e7dWi86sGW0EI8p/+WD2x/5f
         o3xpdnCZRXNQJXV4H2WBooKXZuXaOUH+idxJ8dDM7ziL/vhWH+p0dn2JC4nwK/H1C2te
         /5UnGOISKmNZl9duZ8gacbSWdMUlS3aPkh0SJnSX5YaBNiusYTDK9HZxleVQW5BDCY8h
         M7Ha1NkSRd/J0LE2BERRc9Qniv1Wnl6sQxn5+VKEL8Blhl7V55Fm6NPNKlTd1eN4CxfW
         8otw==
X-Received: by 10.60.135.234 with SMTP id pv10mr4501383oeb.101.1365089508031;
        Thu, 04 Apr 2013 08:31:48 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id ka6sm6790058obb.3.2013.04.04.08.31.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 08:31:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220012>

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
