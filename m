From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 09/21] remote-hg: refactor export
Date: Thu, 11 Apr 2013 07:23:05 -0500
Message-ID: <1365682997-11329-10-git-send-email-felipe.contreras@gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:25:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGYl-0007U0-0q
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161329Ab3DKMYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:24:53 -0400
Received: from mail-qe0-f50.google.com ([209.85.128.50]:63386 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161312Ab3DKMYw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:24:52 -0400
Received: by mail-qe0-f50.google.com with SMTP id a11so851596qen.9
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=aeVp3cutFtLewa2xu4l9ZtYVMa2yb8tCBEmGVH7Ovqs=;
        b=rUxYH+KGkAZfSj5cTF2F9Z9od53ijiCuov+eDYK5s55V+X50LoTu39EqhZ8hBvad6z
         2T20HUfeCYUviD+SsIXKMWJoUaioIC9pNh5Ey0DtIg2Rhp+CVWAPPRVwgSWoATU6HYbK
         F1+9Egq/8K8RvR264Gau8KV/CER66Es+l7K0S43Q0XNGDJAMEUdd8h5dCmaWXCs0vw0g
         hMN+EksAQkxtECEC77IoJTplYdy34duexpWHJJfpDhNX3fjcceFj/HDnnKt6KLrnkG8Z
         /zRldzPlWmKbGGD5Xwus1pATwTTCjvVeFs9NMCRFpWz1uqJgMTRwnqsOAlURe07ZEmrN
         I1Qw==
X-Received: by 10.49.82.4 with SMTP id e4mr7539551qey.62.1365683092076;
        Thu, 11 Apr 2013 05:24:52 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id e2sm6304969qey.3.2013.04.11.05.24.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:24:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220862>

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 73cd812..3ceec85 100755
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
         ref = 'refs/heads/' + bmark
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
1.8.2.1
