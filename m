From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 3/6] remote-hg: add support for remote pushing
Date: Sun, 21 Oct 2012 19:49:01 +0200
Message-ID: <1350841744-21564-4-git-send-email-felipe.contreras@gmail.com>
References: <1350841744-21564-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 21 19:49:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPzef-0002lv-VE
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 19:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418Ab2JURt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 13:49:29 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:64985 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932303Ab2JURt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 13:49:28 -0400
Received: by mail-wg0-f42.google.com with SMTP id fm10so1103465wgb.1
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 10:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZWr3HCD5kMY7tP8XN9/pPc/7sAKkZuafM6mt/E3idMw=;
        b=N+XdFlB4FOBz89f8mpgunkNI2dU136ssDgEX8wwfZHP2/FpxxkcfRoBo6rMCfPVqCp
         bfHj7mu9Z8P/SG01czy+doCceQ2za/VZO+CXzB5dRRxp67wuSL3/THqzvz/VQKsytLgn
         NcWBRtv4iSj73PrdVzqW9uCG92U/SBYXY7PbmAkJdonVdGYwyvluadbHGCIAoEJ+ezW5
         4wQKQ2f8FToKceJfjTmG1thOYlOWcaUARwFJRi24t4deLfcldljh43EndDC+XBuTCFrf
         rzvvtQ9QkoIjGPcnPi4XwrEnu/hVMt1lULgIER1+xrNdj+4nqhQUDDERa2IiT98AqOYx
         40XA==
Received: by 10.180.102.131 with SMTP id fo3mr31673867wib.1.1350841767312;
        Sun, 21 Oct 2012 10:49:27 -0700 (PDT)
Received: from localhost (ip-109-43-0-67.web.vodafone.de. [109.43.0.67])
        by mx.google.com with ESMTPS id p4sm17150231wix.0.2012.10.21.10.49.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Oct 2012 10:49:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc2.7.g0961fdf.dirty
In-Reply-To: <1350841744-21564-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208131>

I'm not happy with this, but works.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index fc4510c..34a00cd 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
@@ -167,6 +167,7 @@ def fixup_user(user):
 
 def get_repo(url, alias):
     global dirname
+    global peer
 
     myui = ui.ui()
     myui.setconfig('ui', 'interactive', 'off')
@@ -176,7 +177,7 @@ def get_repo(url, alias):
     else:
         local_path = os.path.join(dirname, 'clone')
         if not os.path.exists(local_path):
-            srcpeer, dstpeer = hg.clone(myui, {}, url, local_path, update=False, pull=True)
+            peer, dstpeer = hg.clone(myui, {}, url, local_path, update=False, pull=True)
             repo = dstpeer.local()
         else:
             repo = hg.repository(myui, local_path)
@@ -420,6 +421,8 @@ def parse_commit(parser):
     print "ok %s" % ref
 
 def do_export(parser):
+    global peer
+
     for line in parser.each_block('done'):
         if parser.check('blob'):
             parse_blob(parser)
@@ -427,12 +430,17 @@ def do_export(parser):
             parse_commit(parser)
     print
 
+    if peer:
+        parser.repo.push(peer, force=False)
+
 def main(args):
     global prefix, dirname, branches
     global marks, blob_marks
+    global peer
 
     alias = args[1]
     url = args[2]
+    peer = None
 
     gitdir = os.environ['GIT_DIR']
     dirname = os.path.join(gitdir, 'hg', alias)
-- 
1.8.0.rc2.7.g0961fdf.dirty
