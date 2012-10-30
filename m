From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 05/14] remote-hg: add support to push URLs
Date: Tue, 30 Oct 2012 05:35:27 +0100
Message-ID: <1351571736-4682-6-git-send-email-felipe.contreras@gmail.com>
References: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 05:36:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT3Yu-0005xW-IZ
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 05:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549Ab2J3EgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 00:36:12 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56861 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500Ab2J3EgK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 00:36:10 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2268812bkc.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 21:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=BMXnTLKvtbWEQIxxxkTHAbZPmEEDMV55bUpMi+c4fTs=;
        b=uZViNrdvRVbW74HkCj24lyJ3juvKSfKZYtw6S4ofnkxX0/4Ws2l/ElBnQ6iWE76/R+
         OEOkvF3fS3zUm5+NtNfWHk2Vyba+k3vIjUsctVhq51FAylJdB8al2mr/Jmxz1oPDvFeL
         ASQV7MMKHVdtebbnAlEUyh8FkCmbTGE6FC7KYpA8MYuGuuYoYDGygmZivVzdyZ1F+LKT
         k/E9y0vhG+S/VaBvTOXJzhmazVfyvuNHuISjCBhcdwuKtgHOn3lc9tMXj9auEuMp7Htt
         q/2z0CIwYZXXChO0h+CVEeTAQtwenfCz3bX0u4X/oZ+0BscoHeg2WCUzfzp6ZjXO/RMN
         11KQ==
Received: by 10.204.9.8 with SMTP id j8mr6878497bkj.37.1351571770297;
        Mon, 29 Oct 2012 21:36:10 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id 9sm5169667bkq.13.2012.10.29.21.36.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Oct 2012 21:36:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208668>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index 959ab80..4d49923 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
@@ -9,12 +9,13 @@
 # Then you can clone with:
 # git clone hg::/path/to/mercurial/repo/
 
-from mercurial import hg, ui, bookmarks, context
+from mercurial import hg, ui, bookmarks, context, util
 
 import re
 import sys
 import os
 import json
+import shutil
 
 NAME_RE = re.compile('^([^<>]+)')
 AUTHOR_RE = re.compile('^([^<>]+?)? ?<([^<>]+)>$')
@@ -554,6 +555,12 @@ def main(args):
     url = args[2]
     peer = None
 
+    if alias[4:] == url:
+        is_tmp = True
+        alias = util.sha1(alias).hexdigest()
+    else:
+        is_tmp = False
+
     gitdir = os.environ['GIT_DIR']
     dirname = os.path.join(gitdir, 'hg', alias)
     branches = {}
@@ -584,6 +591,9 @@ def main(args):
             die('unhandled command: %s' % line)
         sys.stdout.flush()
 
-    marks.store()
+    if not is_tmp:
+        marks.store()
+    else:
+        shutil.rmtree(dirname)
 
 sys.exit(main(sys.argv))
-- 
1.8.0
