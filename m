From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 08/13] remote-hg: split bookmark handling
Date: Thu,  4 Apr 2013 09:30:17 -0600
Message-ID: <1365089422-8250-9-git-send-email-felipe.contreras@gmail.com>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 17:32:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNm9J-00048e-SH
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762604Ab3DDPbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:31:46 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:52111 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762411Ab3DDPbp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:31:45 -0400
Received: by mail-oa0-f43.google.com with SMTP id l10so2900129oag.2
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=3sa98s6xG0NTvaZ/a8vT1RXW5m0nNo2mGpxEabyJ6yE=;
        b=KQBFxuP2O57eAg0tG0v/utKKr9suHG3CTSBaowSuyBDeB7qGe9y8762M+WJ4+jpkzF
         +9qtWs3ioFM87QNZreCCIc1DrwT2wzaSaxz6w1gSTWEJcUyI5Se1otZOSxmbLBl+14bl
         GdgDg5rvGLXtMzLKOX2MWvE5xKQFrpr3o51QIL9xNcRMk3F63yeObJBumWyaRxE1KT7P
         CElelV9BhZTW0wIYN7V23w3sL7zdE8atj/si02PwpAIE9eQSHj1RX3OjFZ7LNIkiqod9
         AE09lYSGhn+JUsFdB4NDAoGoObaTCzHc2j7I48RevnihK2vHyEmS2enGEm2EiqUSpkQ7
         pJew==
X-Received: by 10.182.123.76 with SMTP id ly12mr4613966obb.53.1365089504749;
        Thu, 04 Apr 2013 08:31:44 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id j10sm6788978obg.4.2013.04.04.08.31.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 08:31:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220011>

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
