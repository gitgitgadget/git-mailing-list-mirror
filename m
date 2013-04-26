From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 3/9] remote-bzr: fix bad state issue
Date: Fri, 26 Apr 2013 16:12:33 -0500
Message-ID: <1367010759-17928-4-git-send-email-felipe.contreras@gmail.com>
References: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 23:14:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVpyA-0007H1-4r
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 23:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757451Ab3DZVOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 17:14:07 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:48150 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987Ab3DZVOE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 17:14:04 -0400
Received: by mail-oa0-f52.google.com with SMTP id n12so4333626oag.39
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 14:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=91y7+3PO9PInBcwky5h9Bkkh3QP/MpXC+EzrYoHiK6Q=;
        b=x+D44Rc6hSER1vh+fZcbBdMnQWrhRQ58FFwuHO22OGT7mkPsCqOSKryfFNDzSww9pX
         zCAFrLhojxV85+/rtiDjlD4Vfkjm6wlaMin4XqOwrxbjMJV6LQ2qasaDoC+5d+uaxPIr
         FIXL5fQHJ1dff+ZsvCbFWOvqUdUNXNScnlgUZaUsNns9ZV+hWMAfptmPVHLyC/9ejVSj
         JImg1miGaPIKeO9iRzcyp8ejyAbGgHMXbVcs2IludLg9tzQ020yCUu/HFEtvrQDYkBYU
         pq64lob8V0TYXVLVpkQd6kI3dk3qidQ6bCEqp3FFGFTLRT9fn8QTYc4vm5qerAahz/d8
         sXMQ==
X-Received: by 10.60.92.201 with SMTP id co9mr18956409oeb.113.1367010844277;
        Fri, 26 Apr 2013 14:14:04 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id l9sm5289776oem.7.2013.04.26.14.14.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 14:14:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222584>

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
index 87c54bf..7b6584e 100755
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
1.8.2.1.1031.g2ee5873
