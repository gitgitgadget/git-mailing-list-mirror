From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 04/10] remote-hg: add new get_config_bool() helper
Date: Mon, 13 May 2013 18:11:54 -0500
Message-ID: <1368486720-2716-5-git-send-email-felipe.contreras@gmail.com>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 01:14:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc1ww-0007Jj-36
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 01:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755536Ab3EMXOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 19:14:18 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:35957 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755478Ab3EMXOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 19:14:16 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so8283748oag.19
        for <git@vger.kernel.org>; Mon, 13 May 2013 16:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=VeFn0H1Pczkiy4A33gs3sBiacEVgFOcwFj7IsuNGR8U=;
        b=nL7f+ZTBNN9I7IcXTEaBtWlG17G+2gycj6wEgq9cUsL22mcO4EuJjJvMikv1VAtSTL
         WBptmLsmtJpTls3EsVZ/1dG3aRN6uVDhgwn1rzgjnudxwKFXJ5PQG7OexBS0yIk0kPD5
         kshMmw5w3RtJJOci/MMSxbkyCToNF4O7yU9LbeT7El1zLG23x6eEdruCeDn75lTgcKky
         MFWxb6WF0ht6VweS0drsucYqVY6bYpvDPjE78ZB9nILdhrRizaV3ZPdwrKKFa094V6Gi
         oTUPMuuSZicOzjzCwf6/Ub5CQ5SA1ouhJuG5zMdMMRZo4Qz7dqF5JABdVagIC6KCpCME
         rJ9g==
X-Received: by 10.60.144.99 with SMTP id sl3mr14742815oeb.0.1368486856120;
        Mon, 13 May 2013 16:14:16 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id w7sm18745713obx.9.2013.05.13.16.14.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 16:14:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224222>

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index de3a96e..4a5c72f 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -87,6 +87,15 @@ def get_config(config):
     output, _ = process.communicate()
     return output
 
+def get_config_bool(config, default=False):
+    value = get_config(config).rstrip('\n')
+    if value == "true":
+        return True
+    elif value == "false":
+        return False
+    else:
+        return default
+
 class Marks:
 
     def __init__(self, path):
@@ -327,7 +336,7 @@ def get_repo(url, alias):
     myui.setconfig('ui', 'interactive', 'off')
     myui.fout = sys.stderr
 
-    if get_config('remote-hg.insecure') == 'true\n':
+    if get_config_bool('remote-hg.insecure'):
         myui.setconfig('web', 'cacerts', '')
 
     try:
@@ -903,16 +912,9 @@ def main(args):
     url = args[2]
     peer = None
 
-    hg_git_compat = False
-    track_branches = True
-    force_push = True
-
-    if get_config('remote-hg.hg-git-compat') == 'true\n':
-        hg_git_compat = True
-    if get_config('remote-hg.track-branches') == 'false\n':
-        track_branches = False
-    if get_config('remote-hg.force-push') == 'false\n':
-        force_push = False
+    hg_git_compat = get_config_bool('remote-hg.hg-git-compat')
+    track_branches = get_config_bool('remote-hg.track-branches', True)
+    force_push = get_config_bool('remote-hg.force-push', True)
 
     if hg_git_compat:
         mode = 'hg'
-- 
1.8.3.rc1.579.g184e698
