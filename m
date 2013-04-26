From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/9] remote-bzr: fix bad state issue
Date: Thu, 25 Apr 2013 19:08:16 -0500
Message-ID: <1366934902-18704-4-git-send-email-felipe.contreras@gmail.com>
References: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 02:09:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVWEe-0003ha-H6
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 02:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439Ab3DZAJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 20:09:48 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47288 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932256Ab3DZAJr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 20:09:47 -0400
Received: by mail-ob0-f174.google.com with SMTP id wc20so3050715obb.19
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 17:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=SQ1hNUUMU4sG8GWsbyjGEAh3RKeKn4RlHvD/Qj9jgBQ=;
        b=LGTU1LghSMnAUi23F0CDmgSBGxBewCH3P11WgizJkRGuS4gmIw9LNBpjX70od+QzNR
         rX27EX0iuTtguHkU7yuDwf5qsxx8j6pNzg/lcY8/e/Ces0vfCTEDcVQLUu5LY1dGZjMl
         hphPkD6nQ7/KiOM010g0tZ6/THHaj0dHPvPvRGzb836puarn1l1WbN2clzUa7r34DmaV
         8YJkUIV3lcqNMYFt9OuECOk3LvKI2JjhN95n8eoxrKtlV79oizALETovABJsDGTEjuUB
         cjTi+A66MQRZu5y7M/jo1iyYrPBuVuiNOUeYxyLiFZl4Xo0Hi3mcNZ2Z6d5loSvb7NxK
         QfOg==
X-Received: by 10.60.136.129 with SMTP id qa1mr16728492oeb.47.1366934987276;
        Thu, 25 Apr 2013 17:09:47 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x5sm5892591oep.1.2013.04.25.17.09.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 17:09:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222472>

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
1.8.2.1.884.g3532a8d
