From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 08/20] remote-hg: split bookmark handling
Date: Mon,  8 Apr 2013 12:13:22 -0500
Message-ID: <1365441214-21096-9-git-send-email-felipe.contreras@gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:15:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFf8-0004EZ-0x
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934580Ab3DHRPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:15:13 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:63682 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab3DHRPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:15:09 -0400
Received: by mail-ob0-f179.google.com with SMTP id tb18so2193737obb.24
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=3sa98s6xG0NTvaZ/a8vT1RXW5m0nNo2mGpxEabyJ6yE=;
        b=Cx05TgzDTIqi0EkjYeIrfjS3H6e29SRVRYb/xiyFYCcUcOurtEgusDPVSkgDrgfskX
         YQv4x6YECQsPKsPOd6sT6Kg0BZZUNyLlJ8AyVsBLEhn/Z1o488DM0BhxLq9HzlTNLxpE
         r6JPow9KuUs7XqYZibd4ck8Tx4SdhHXc8xvnN/hbRToaZlMFP78Rt0p4Dtdd7XrvgHZC
         zjh9usLGMonhRxzHwcA0yDpSAp4JdIkPccuVxaNC7NsqlYMOlTB8mDtHYCMtWT8KCYFV
         rGuOhDNaatZoW4bmfGpgBeKan3OcdTfRYD7A1vs8izKM3bYqNauEYA0KHRiy2rk4LWLH
         RH0A==
X-Received: by 10.182.93.193 with SMTP id cw1mr16134470obb.93.1365441309243;
        Mon, 08 Apr 2013 10:15:09 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id ju7sm1931853oeb.3.2013.04.08.10.15.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:15:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220446>

Will be useful for remote bookmarks.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 39 +++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 874ccd4..6901689 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -685,6 +685,8 @@ def parse_tag(parser):
 def do_export(parser):
     global parsed_refs, bmarks, peer
 
+    p_bmarks = []
+
     parser.next()
 
     for line in parser.each_block('done'):
@@ -706,20 +708,9 @@ def do_export(parser):
             pass
         elif ref.startswith('refs/heads/'):
             bmark = ref[len('refs/heads/'):]
-            if bmark in bmarks:
-                old = bmarks[bmark].hex()
-            else:
-                old = ''
-
-            if bmark == 'master' and 'master' not in parser.repo._bookmarks:
-                # fake bookmark
-                print "ok %s" % ref
-                continue
-
-            if not bookmarks.pushbookmark(parser.repo, bmark, old, node):
-                print "error %s" % ref
-                continue
-
+            p_bmarks.append((bmark, node))
+            # handle below
+            continue
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
             parser.repo.tag([tag], node, None, True, None, {})
@@ -731,6 +722,26 @@ def do_export(parser):
     if peer:
         parser.repo.push(peer, force=False)
 
+    # handle bookmarks
+    for bmark, node in p_bmarks:
+        ref = 'refs/heads' + bmark
+
+        if bmark in bmarks:
+            old = bmarks[bmark].hex()
+        else:
+            old = ''
+
+        if bmark == 'master' and 'master' not in parser.repo._bookmarks:
+            # fake bookmark
+            print "ok %s" % ref
+            continue
+
+        if not bookmarks.pushbookmark(parser.repo, bmark, old, node):
+            print "error %s" % ref
+            continue
+
+        print "ok %s" % ref
+
     print
 
 def fix_path(alias, repo, orig_url):
-- 
1.8.2
