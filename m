From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 13/21] remote-hg: force remote push
Date: Thu, 11 Apr 2013 07:23:09 -0500
Message-ID: <1365682997-11329-14-git-send-email-felipe.contreras@gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:25:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGZ1-0007tC-PO
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161497Ab3DKMZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:25:10 -0400
Received: from mail-qe0-f42.google.com ([209.85.128.42]:62327 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161312Ab3DKMZH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:25:07 -0400
Received: by mail-qe0-f42.google.com with SMTP id cz11so856113qeb.1
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=stXId/We8OptedfTaqUek4F5zc0ls3d/DAVKJfNIy9o=;
        b=TpYokYiKO/BS5wzbO8TtFkNsF4AxWCDFVIndGnrf/mMuRrJflNXi7CqoIpxwBDm6XN
         IbxPt/YAj6bavTiSyJeVktycuKb6lhQISjgw4BXFnQkEnC4hC64DmTweKuWxOGZtZ5OP
         qF5fjJ5sp3QkGO0zAnVHW38SufSHfbL7aBt/C3vlvhKHxFKS+PxlohvORNufnimw1eun
         fv+f2YxgZtvEiuvLrfe5AibS5+4Rinn1hgDel3eFBEjvq5/S9O1kmXOPttcZjKMOSr8O
         omltbIgIzzHoZEwYUaNHueiMLBVB+YgWn+fTorlRGCNHdJHCFFZZlm8lMeDlmmp5657Z
         ArPg==
X-Received: by 10.49.116.80 with SMTP id ju16mr7741960qeb.11.1365683106138;
        Thu, 11 Apr 2013 05:25:06 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id dl6sm6956440qab.12.2013.04.11.05.25.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:25:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220865>

Ideally we shouldn't do this, as it's not recommended in mercurial
documentation, but there's no other way to push multiple bookmarks (on
the same branch), which would be the behavior most similar to git.

At the same time, add a configuration option for the people that don't
want to risk creating new remote heads.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index ec599c6..ff89725 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -27,6 +27,9 @@ import urllib
 # named branches:
 # git config --global remote-hg.track-branches false
 #
+# If you don't want to force pushes (and thus risk creating new remote heads):
+# git config --global remote-hg.force-push false
+#
 # git:
 # Sensible defaults for git.
 # hg bookmarks are exported as git branches, hg branches are prefixed
@@ -730,7 +733,7 @@ def do_export(parser):
             continue
 
     if peer:
-        parser.repo.push(peer, force=False)
+        parser.repo.push(peer, force=force_push)
 
     # handle bookmarks
     for bmark, node in p_bmarks:
@@ -773,7 +776,7 @@ def main(args):
     global prefix, dirname, branches, bmarks
     global marks, blob_marks, parsed_refs
     global peer, mode, bad_mail, bad_name
-    global track_branches
+    global track_branches, force_push
 
     alias = args[1]
     url = args[2]
@@ -781,12 +784,16 @@ def main(args):
 
     hg_git_compat = False
     track_branches = True
+    force_push = True
+
     try:
         if get_config('remote-hg.hg-git-compat') == 'true\n':
             hg_git_compat = True
             track_branches = False
         if get_config('remote-hg.track-branches') == 'false\n':
             track_branches = False
+        if get_config('remote-hg.force-push') == 'false\n':
+            force_push = False
     except subprocess.CalledProcessError:
         pass
 
-- 
1.8.2.1
