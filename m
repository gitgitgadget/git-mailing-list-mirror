From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/3] remote-bzr: add support for pushing
Date: Sun,  4 Nov 2012 03:22:02 +0100
Message-ID: <1351995723-20396-3-git-send-email-felipe.contreras@gmail.com>
References: <1351995723-20396-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 03:22:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUprF-0000ke-5s
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 03:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746Ab2KDCWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 22:22:22 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45078 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab2KDCWV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 22:22:21 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1658012bkc.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 19:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=l0E3/7a2xFhrrQqP/pU1PfFb4V9hQkypAc5euFpJSNg=;
        b=RX0Wb/qRzhIbkKBw9qsHsJkYd7WvtahnnxpEseGLmJWlPWLNK8G2h/32D648ZG53Mr
         m8QP31J+QaqdGMiKs6O3t8kpU7xdoYUYau4Hza5Yj/hEfC/NeImiKPz0UHXPnTbOxkB4
         llbOWGYrH4dNVYtx3Hnhme9iNNxnAHNSiEbxk4VQyGoDGSGNqUYgbb4dCSuPcp2fRik9
         DXXLIGalAGu081CScHKw0EOcaAioEjOks+tSa1hCtAcNXR8NiS8bEZjhkmKraPC6W1T5
         l8xGtMJzoKzz3FpshFZ/h63Tl9ZX5n3GCEYk+CxZUXhJopcFCgsdAurvuUrLoYmHkG9x
         xEng==
Received: by 10.204.128.201 with SMTP id l9mr1398397bks.66.1351995739886;
        Sat, 03 Nov 2012 19:22:19 -0700 (PDT)
Received: from localhost (ip-109-43-0-39.web.vodafone.de. [109.43.0.39])
        by mx.google.com with ESMTPS id e3sm7944179bks.7.2012.11.03.19.22.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2012 19:22:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351995723-20396-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209008>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 76a609a..de37217 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -26,6 +26,9 @@ bzrlib.plugin.load_plugins()
 import bzrlib.revisionspec
 
 from bzrlib.plugins.fastimport import exporter as bzr_exporter
+from bzrlib.plugins.fastimport.processors import generic_processor as bzr_generic_processor
+
+import fastimport.parser
 
 import sys
 import os
@@ -140,9 +143,38 @@ def do_import(parser):
 
     sys.stdout.flush()
 
+def do_export(parser):
+    global dirname
+
+    parser.next() # can't handle 'done'?
+
+    controldir = parser.repo.bzrdir
+
+    path = os.path.join(dirname, 'marks-bzr')
+    params = { 'import-marks': path, 'export-marks': path }
+
+    proc = bzr_generic_processor.GenericProcessor(controldir, params)
+    p = fastimport.parser.ImportParser(sys.stdin)
+    proc.process(p.iter_commands)
+
+    if parser.repo.last_revision() != marks.get_tip('master'):
+        print 'ok %s' % 'refs/heads/master'
+
+    print
+
 def do_capabilities(parser):
+    global dirname
+
     print "import"
+    print "export"
     print "refspec refs/heads/*:%s/heads/*" % prefix
+
+    path = os.path.join(dirname, 'marks-git')
+
+    if os.path.exists(path):
+        print "*import-marks %s" % path
+    print "*export-marks %s" % path
+
     print
 
 def do_list(parser):
@@ -178,6 +210,8 @@ def main(args):
             do_list(parser)
         elif parser.check('import'):
             do_import(parser)
+        elif parser.check('export'):
+            do_export(parser)
         else:
             die('unhandled command: %s' % line)
         sys.stdout.flush()
-- 
1.8.0
