From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/9] remote-bzr: fix bad state issue
Date: Thu, 25 Apr 2013 06:20:43 -0500
Message-ID: <1366888849-19607-4-git-send-email-felipe.contreras@gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 13:22:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVKFz-00043H-Jz
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 13:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758102Ab3DYLW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 07:22:27 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:49302 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756038Ab3DYLW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 07:22:26 -0400
Received: by mail-oa0-f41.google.com with SMTP id g12so2712823oah.14
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 04:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=SMdvvextp+YpgezGG1ogITqs/HJQ8Sp8SclWBOW8b2s=;
        b=LlRuifS4cDIWpJls+FHYTY813DupnlvhjTMcfy0I+3i4yog5oF5YE4gMvuhWq6ola2
         GDZMd380zvU8n7pSZQ+unDyYMA9W86m21dZ8SbiD2UcOEDg8dunP/8XYtWmD+mcdWoCQ
         N3IeamQHR3vghI2U55/A1qvYRtaS2okrUxeqy8+53/jarbempTYavXo8frMEDBf139X8
         QNVLxM2o0USWiyZKl3NJZBDhE9LiqrxMVmgcb4sVl5ntrGFVcme1IcqYmMSHDrt+I+/y
         WIOgxcl0KbBwIhVgVD8v5iazfxdnJdedtFcR8wdFEIIJyCRwqgd/YA6+yEy0IGfzDrhi
         EuKw==
X-Received: by 10.182.236.202 with SMTP id uw10mr15122710obc.14.1366888945646;
        Thu, 25 Apr 2013 04:22:25 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x5sm3195509oep.1.2013.04.25.04.22.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 04:22:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222371>

Carried from remote-hg.

The problem reportedly happened after doing a push that fails, the abort
causes the state of remote-hg to go bad, this happens because
remote-hg's marks are not stored, but 'git fast-export' marks are.

Ensure that the marks are _always_ stored.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 82bf7c7..84734c7 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -32,6 +32,7 @@ import os
 import json
 import re
 import StringIO
+import atexit
 
 NAME_RE = re.compile('^([^<>]+)')
 AUTHOR_RE = re.compile('^([^<>]+?)? ?<([^<>]*)>$')
@@ -728,6 +729,7 @@ def main(args):
     blob_marks = {}
     parsed_refs = {}
     files_cache = {}
+    marks = None
 
     gitdir = os.environ['GIT_DIR']
     dirname = os.path.join(gitdir, 'bzr', alias)
@@ -754,6 +756,10 @@ def main(args):
             die('unhandled command: %s' % line)
         sys.stdout.flush()
 
+def bye():
+    if not marks:
+        return
     marks.store()
 
+atexit.register(bye)
 sys.exit(main(sys.argv))
-- 
1.8.2.1
