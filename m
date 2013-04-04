From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 05/13] remote-hg: make sure fake bookmarks are updated
Date: Thu,  4 Apr 2013 09:30:14 -0600
Message-ID: <1365089422-8250-6-git-send-email-felipe.contreras@gmail.com>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 17:32:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNm90-0003uy-FR
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762579Ab3DDPbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:31:36 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:36999 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762486Ab3DDPbf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:31:35 -0400
Received: by mail-oa0-f50.google.com with SMTP id n1so2857730oag.23
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=q7cXChdLqQBV+uHWfeQoDVRfx9+Kgf8Egx19nvPX5zs=;
        b=Lv5SAH/vmLVXnKOanQh718OGgOVzQOiii2/DD8UtquVnxtQlZ+jr0GZHK5MF4TVte/
         TIv06m3JHGfpGxC63xm9tVZSQHzqdf1iQuOvFA4e4Xc1GaZX5vkAAfuWP97RpiyBqpG+
         fiMu0RxgzRbIaaKcN81C8QIyYQLmt7YNZUTfqHbZOh+eIi8bndru3KNAAcAvOQ6vKcSN
         I1lwbE5vRiJTS0TcyGn2F0sMbyh8gezBpX0BL86ySE7i4uw+o8TceBejRT6mnLx0bBHG
         IJzDwy0lO35Z3yiVGvFcw7TA3YoQfW70LZcZf4PaXxGsyDcv/Hh0URUY+IGnvIiMMwHB
         cVhQ==
X-Received: by 10.60.98.97 with SMTP id eh1mr4714215oeb.84.1365089495478;
        Thu, 04 Apr 2013 08:31:35 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id 6sm6791780obi.0.2013.04.04.08.31.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 08:31:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220007>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg     | 7 +++++++
 contrib/remote-helpers/test-hg-bidi.sh   | 1 +
 contrib/remote-helpers/test-hg-hg-git.sh | 1 +
 3 files changed, 9 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index c6a1a47..b200e60 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -709,9 +709,16 @@ def do_export(parser):
                 old = bmarks[bmark].hex()
             else:
                 old = ''
+
+            if bmark == 'master' and 'master' not in parser.repo._bookmarks:
+                # fake bookmark
+                print "ok %s" % ref
+                continue
+
             if not bookmarks.pushbookmark(parser.repo, bmark, old, node):
                 print "error %s" % ref
                 continue
+
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
             parser.repo.tag([tag], node, None, True, None, {})
diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-helpers/test-hg-bidi.sh
index 1d61982..fe38e49 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/contrib/remote-helpers/test-hg-bidi.sh
@@ -30,6 +30,7 @@ git_clone () {
 hg_clone () {
 	(
 	hg init $2 &&
+	hg -R $2 bookmark -i master &&
 	cd $1 &&
 	git push -q "hg::$PWD/../$2" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/heads/*'
 	) &&
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index 3f253b7..e116cb0 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -35,6 +35,7 @@ git_clone_git () {
 hg_clone_git () {
 	(
 	hg init $2 &&
+	hg -R $2 bookmark -i master &&
 	cd $1 &&
 	git push -q "hg::$PWD/../$2" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/heads/*'
 	) &&
-- 
1.8.2
