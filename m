From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 05/20] remote-hg: make sure fake bookmarks are updated
Date: Mon,  8 Apr 2013 12:13:19 -0500
Message-ID: <1365441214-21096-6-git-send-email-felipe.contreras@gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:15:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFf6-0004EZ-VS
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934870Ab3DHRPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:15:00 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:35341 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934863Ab3DHRO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:14:58 -0400
Received: by mail-ob0-f169.google.com with SMTP id wp18so5396548obc.0
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=q7cXChdLqQBV+uHWfeQoDVRfx9+Kgf8Egx19nvPX5zs=;
        b=oBxdX2YAdghip3imPWprDgGdImUAkSdpA3QLvjvfoPcwmeWAt3ag0cpHpGkf5uozKv
         IntfjD0r8Y8K/VgxF94I7EfZxPPn91fZvdra8hcUv0SZUKtA+9IPLeMWWNXw3dCBCpcH
         H6JThL/ZzKPs3ifDqB01lVCi3eG5PKSeu7yQVVGFlvXpTusIGuWx/6HVIOB93B6wLaX6
         gOnGsZfKJWwjxF5RVdq0hNypnu2EmJPjT18kjYQAbH7N1LRwHhkT/G4D5nQw9Z9d1Q7+
         UC1TGimILB99yIimJXAri57on1MGdkhLWxmK6pENlusd3aR6QO+xs80PGH5C5sUySyAR
         yLdw==
X-Received: by 10.60.42.200 with SMTP id q8mr8412848oel.72.1365441298136;
        Mon, 08 Apr 2013 10:14:58 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id ri7sm26129868oeb.6.2013.04.08.10.14.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:14:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220449>

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
