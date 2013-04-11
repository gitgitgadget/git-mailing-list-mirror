From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 05/21] remote-hg: make sure fake bookmarks are updated
Date: Thu, 11 Apr 2013 07:23:01 -0500
Message-ID: <1365682997-11329-6-git-send-email-felipe.contreras@gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:24:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGYV-00071t-PC
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161251Ab3DKMYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:24:40 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:53790 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161139Ab3DKMYj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:24:39 -0400
Received: by mail-qa0-f53.google.com with SMTP id o19so234202qap.5
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=xBGvYnRZVLWZxwg9mKqyYmc/kpG6VJfGjbIlMDbtXJk=;
        b=grvaIDDlfPa6Q7m6Jqv/GyHG49AIMhIEk88ld0WUh2l7wpEDVwDly6kJmY1vkMMnSw
         KUDwc+VYlKj7Su1AM/bx82IHXVRnU/Eu5JVAZH2msNEhyi279LFZdYIb3lYdAXAxTWtX
         XmZoUCIbzcW0j4WNUopcMVKYdJxDX4mA8/WQco5v+ji6ZG77TP5RoKx0M1Hdk7RQsvTD
         ulmLxjJk0nadaKAZFBER1uEU4okPc7X7zXrafBLvD26VOaY+kmumyK79ISRiNr71VCO+
         ajZyu2U2qy5xCoFfrbFMqHAMPseGAeTkTrWE9NLguOW/BhZ052yUORkyUD4K4mn6Ek1I
         LX/Q==
X-Received: by 10.229.92.213 with SMTP id s21mr9102qcm.48.1365683078386;
        Thu, 11 Apr 2013 05:24:38 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id dl6sm6954726qab.12.2013.04.11.05.24.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:24:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220857>

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
1.8.2.1
