From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 13/20] remote-hg: force remote push
Date: Mon,  8 Apr 2013 12:13:27 -0500
Message-ID: <1365441214-21096-14-git-send-email-felipe.contreras@gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:16:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFfr-0005gW-6t
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934562Ab3DHRPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:15:31 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54705 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760355Ab3DHRPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:15:25 -0400
Received: by mail-ob0-f174.google.com with SMTP id wm15so3397519obc.19
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=QDWkvCDSiYMSUeI+paIIQIFq1zrzRlBWQM4pFGleBhg=;
        b=D+tEkU/DbzDKEVAeVmuBVoqlA0pYtULxqXJhYtLkYV7M5fSATOKFS4GOylTzGzowAO
         RB+8CoEhQGUMqrHt2szySBn7Jyqo9hl2PwC7XIHr8xo91d2aWIjFZtSdSNu9QaLXL9ql
         p7p0J49JQshb0YS99NGj1St7NWqRBt2K2W0Oo5gq1SPE2VFBJk7g72IZN5GuxNani1k6
         1N7n1swhMRGcWJ7NFWWc6rr7RPjAQdK079CY3LutOO/UJEfvhD7y5ilX0MBfuNn0/XIL
         VNTuK6tjhGNs85jcp0a3Iy3kIER3lYrKMwa1dVcNCIUpyF66tOuvQHtyONbxrXniHRDu
         lkjQ==
X-Received: by 10.60.142.103 with SMTP id rv7mr15779811oeb.34.1365441324455;
        Mon, 08 Apr 2013 10:15:24 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id n1sm24998054obc.10.2013.04.08.10.15.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:15:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220455>

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
index 8f6809a..9fb4d8b 100755
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
1.8.2
