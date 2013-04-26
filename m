From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/20] remote-bzr: fixes for branch diverge
Date: Thu, 25 Apr 2013 20:07:54 -0500
Message-ID: <1366938488-25425-7-git-send-email-felipe.contreras@gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 03:09:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXAX-0003Zu-Cn
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663Ab3DZBJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:09:42 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:42807 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758382Ab3DZBJk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:09:40 -0400
Received: by mail-oa0-f45.google.com with SMTP id o17so3527405oag.32
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=XhTfbB2MfggMCgFYDRzdF23DVTqsFhQJpx6q2xTN2nY=;
        b=yvWaYuM7+fziRhwPtAIhRQmh2sKH5CPziNq+W2yVDcH1E0Htmj9SRm6icwt6FvFK6m
         xYvTh0h+G1PzGs/q8Q8ATytBBicpIBFjdoE/d1eHTu5QoiPNf3vGP1+GQHd3wcx6yfYK
         xdzwfGTUJKIscv7ojfF0mRIvBCWIcvksaRyVTYxFwM2R+BjntEAOYXLanGA63c9hlOnm
         Dxup8rEv2g/DPo5dwFG0mIoi5MTbCD7IPchlLjVwkUh3doDM87lUvxr0pmpJSemXjwk7
         4OWxIcNVknXwZRSacPGM4oH3vDsDWZPFS2EONer8Q0Ey0o6kAkJkt7ojptBhAIK1MTzE
         qDyQ==
X-Received: by 10.60.59.197 with SMTP id b5mr5094034oer.4.1366938580335;
        Thu, 25 Apr 2013 18:09:40 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jw8sm5846729obb.14.2013.04.25.18.09.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 18:09:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222488>

If the branches diverge we want to reset the pointer to where the remote
actually is. Since we can access remote branches just as easily as local
ones, let's do so.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 6a7f836..bf254a0 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -354,6 +354,7 @@ def do_import(parser):
     if os.path.exists(path):
         print "feature import-marks=%s" % path
     print "feature export-marks=%s" % path
+    print "feature force"
     sys.stdout.flush()
 
     while parser.check('import'):
@@ -716,7 +717,12 @@ def get_repo(url, alias):
             # pull
             d = bzrlib.bzrdir.BzrDir.open(clone_path)
             branch = d.open_branch()
-            result = branch.pull(remote_branch, [], None, False)
+            try:
+                result = branch.pull(remote_branch, [], None, False)
+            except bzrlib.errors.DivergedBranches:
+                # use remote branch for now
+                peer = None
+                return remote_branch
         else:
             # clone
             d = origin.sprout(clone_path, None,
-- 
1.8.2.1.884.g3532a8d
