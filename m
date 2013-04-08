From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 18/20] remote-hg: fix bad state issue
Date: Mon,  8 Apr 2013 12:13:32 -0500
Message-ID: <1365441214-21096-19-git-send-email-felipe.contreras@gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:16:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFfs-0005gW-Ob
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934848Ab3DHRPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:15:42 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:56996 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760775Ab3DHRPj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:15:39 -0400
Received: by mail-oa0-f48.google.com with SMTP id j1so6419155oag.35
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=+bZAvFsF6+RlYLf8vMIR4dEKJBt4N8SaVYMMPhqWt5Q=;
        b=Wmtx3mNJyiE9i2NUwgqzhLqNnfma2/AOlDBbBqGE5WDJqiBU4x4oPEtsdoGg06Yn26
         E+ypciCnc95XYdiyFTYWLvPorpl4TWAGF9eUsIPNMkZizAYtNxPNGH1GiuLAO5LpQ2tg
         I5jqsGXpAFsNS+lxXf+LIjbP02360hP7BVAU/nCD2UJ8O/1Yuo05dx5jsJ/yNT14bPeO
         XeWFEUTvaug8LmO0amzcGYkYCpot6RMV83xD8mWxuG+nCuTVqQQoQqD/xJtlvrubIks7
         QgVz32+A+z363RWHIaE1TcW9+z9iq45lwzjCINjFR48DnRvO03X+qsVoYH8bEVIE3jMd
         +paQ==
X-Received: by 10.60.62.166 with SMTP id z6mr15731042oer.54.1365441339130;
        Mon, 08 Apr 2013 10:15:39 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id j10sm25000535obg.4.2013.04.08.10.15.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:15:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220456>

The problem reportedly happened after doing a push that fails, the abort
causes the state of remote-hg to go bad, this happens because
remote-hg's marks are not stored, but 'git fast-export' marks are.

Ensure that the marks are _always_ stored.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 2f642a6..a02ec68 100755
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
1.8.2
