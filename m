From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/2] remote-hg: add shared repo upgrade
Date: Fri,  9 Aug 2013 17:38:04 -0500
Message-ID: <1376087884-32060-3-git-send-email-felipe.contreras@gmail.com>
References: <1376087884-32060-1-git-send-email-felipe.contreras@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>,
	=?UTF-8?q?J=C3=B6rn=20Hees?= <dev@joernhees.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 10 00:42:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7vNv-0001nm-Id
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 00:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031384Ab3HIWmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 18:42:09 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:37595 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031355Ab3HIWmI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 18:42:08 -0400
Received: by mail-oa0-f41.google.com with SMTP id j6so3474229oag.0
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 15:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ufLxkDCaLGNbT75ekbnW0/SpZ4+LrHZ1nmLJYdd3C8E=;
        b=GvzUNVH3q+XZLx0S8ZFh9E2yPUnnSDUXHUXZAVB6/ii5m0EMsqiIKhOr63AXqxladJ
         yWO1NCFBW9r8QoPsayykIe4OQ/L6ykj8B2tCey2iuiLTPsoFSBkL1tnQd/XUuNjrH+9y
         YxKoy8p0h4j7jDDljsuERQ5tYqGELcLBHYfWOQPfDcL3UUKxRbF5gzqU05YWB9+AvNCp
         QP4EdSQgvOKnnYlK/lqmzaXaWYzuRNHB8lk61PurE7L6kg8hwxoPDEhApRXCrP7G+v5o
         yewI5u0xz1L8TfOZ5Y3YiveNNVvKEQBhkqv/ib8D1EqxyTzPPWd8+YRpssjs1VoNdmKn
         nP8g==
X-Received: by 10.182.128.6 with SMTP id nk6mr2300498obb.11.1376088127547;
        Fri, 09 Aug 2013 15:42:07 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id h3sm21428333oeo.2.2013.08.09.15.42.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 15:42:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.267.gbb4989f
In-Reply-To: <1376087884-32060-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232050>

If we have an old organization (v1.8.3), and want to upgrade to a newer
one (v1.8.4), the user would have to fetch the whole repository, instead
we can just move the repository, so the user would not notice any
difference.

Also, remove other clones, so in time they get set up as shared.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index cfd4f53..6c82b8d 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -392,6 +392,18 @@ def get_repo(url, alias):
     else:
         shared_path = os.path.join(gitdir, 'hg')
 
+        # check and upgrade old organization
+        hg_path = os.path.join(shared_path, '.hg')
+        if os.path.exists(shared_path) and not os.path.exists(hg_path):
+            repos = os.listdir(shared_path)
+            for x in repos:
+                local_hg = os.path.join(shared_path, x, 'clone', '.hg')
+                if not os.path.exists(local_hg):
+                    continue
+                if not os.path.exists(hg_path):
+                    shutil.move(local_hg, hg_path)
+                shutil.rmtree(os.path.join(shared_path, x, 'clone'))
+
         # setup shared repo (if not there)
         try:
             hg.peer(myui, {}, shared_path, create=True)
-- 
1.8.3.267.gbb4989f
