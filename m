From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 18/21] remote-hg: fix bad state issue
Date: Thu, 11 Apr 2013 07:23:14 -0500
Message-ID: <1365682997-11329-19-git-send-email-felipe.contreras@gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:25:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGZP-0008SZ-OW
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161539Ab3DKMZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:25:26 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:64290 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161312Ab3DKMZW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:25:22 -0400
Received: by mail-qc0-f180.google.com with SMTP id b40so654087qcq.25
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=8tgSlbuRcTrFZoYBszTWoh9zbE7/PLKlixrxtoGeJdU=;
        b=HlMS/DYDBypiCL5CQVbyWYSh239Z24IBl1NI+D+tjkhujmu8I0q/N+XvgPL+Atm6E+
         nNiDYPt9uFGYojPRy7ximny2lNCGycKbO6D+j4aqcIpo7wA+2vDwc0CNwOll3MMSY4Qy
         BcYYoS4qACAqL6NzzP8T7zvWKiA1X7YL1Z5cMcAtc8rA8tAiTx6JG5A2pG+XnplQ+wVV
         c/2xMN+yMQXSSiGY6VZ+/xYe0jzxfK1iXSFp/KQ9DDiaR1o+8rb+izdwfuGQv2rOE71q
         uYoh7AnnQqkv8Txc+0IrMqSHQMBAll098IuvI9fNUwecGa3DBJ9b4UA2r5k27y5HbIBq
         KZ2Q==
X-Received: by 10.224.149.134 with SMTP id t6mr6892097qav.18.1365683122105;
        Thu, 11 Apr 2013 05:25:22 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id en8sm5891119qeb.0.2013.04.11.05.25.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:25:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220870>

The problem reportedly happened after doing a push that fails, the abort
causes the state of remote-hg to go bad, this happens because
remote-hg's marks are not stored, but 'git fast-export' marks are.

Ensure that the marks are _always_ stored.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 3eb07dc..e3d7f77 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -18,6 +18,7 @@ import json
 import shutil
 import subprocess
 import urllib
+import atexit
 
 #
 # If you want to switch to hg-git compatibility mode:
@@ -791,7 +792,7 @@ def main(args):
     global prefix, dirname, branches, bmarks
     global marks, blob_marks, parsed_refs
     global peer, mode, bad_mail, bad_name
-    global track_branches, force_push
+    global track_branches, force_push, is_tmp
 
     alias = args[1]
     url = args[2]
@@ -833,6 +834,7 @@ def main(args):
     bmarks = {}
     blob_marks = {}
     parsed_refs = {}
+    marks = None
 
     repo = get_repo(url, alias)
     prefix = 'refs/hg/%s' % alias
@@ -860,9 +862,13 @@ def main(args):
             die('unhandled command: %s' % line)
         sys.stdout.flush()
 
+def bye():
+    if not marks:
+        return
     if not is_tmp:
         marks.store()
     else:
         shutil.rmtree(dirname)
 
+atexit.register(bye)
 sys.exit(main(sys.argv))
-- 
1.8.2.1
