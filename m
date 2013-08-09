From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] remote-hg: add shared repo upgrade
Date: Fri,  9 Aug 2013 15:03:01 -0500
Message-ID: <1376078581-24766-3-git-send-email-felipe.contreras@gmail.com>
References: <1376078581-24766-1-git-send-email-felipe.contreras@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>,
	=?UTF-8?q?J=C3=B6rn=20Hees?= <dev@joernhees.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 09 22:07:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7sxp-0001C1-FW
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 22:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030986Ab3HIUHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 16:07:03 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:41067 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030953Ab3HIUHA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 16:07:00 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so7471768oag.10
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 13:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GNqP97FAQAE7wM9KeUV9O/XF92cd7sF1pbrZmY6sfrk=;
        b=bjZVjtRTTGRUEgO1uWUs8EmBftvuX8Fhq9ptkCPs7Pv90H4edc5tlTKfbCDqxs1N4c
         7TWwYxY+yfmZwONf7knAEfAPpQftZyWcZKeXY5edjVpTyzfuUpkF/bOMyvjUBCYjOpEa
         2A3x98wmodCQNhgJxw7D3oNFzlp20Ia6M4WK/sTxJ33yuqe6tliP6P/VOnAKdf+MDEiu
         pgkgUp/v0gRltVG0HIlSWN/oPwteUOF/Y+MCYiDsbVi2QoL/lDQkgYjnnYA7b7YFfW6a
         OANezGlkmB8hUsepIH3sVS29uT/122ZNIQCP0CFmpRim38zTDIUNIpqcdd6CNf4YwzPe
         s6fQ==
X-Received: by 10.182.27.74 with SMTP id r10mr2582533obg.63.1376078819753;
        Fri, 09 Aug 2013 13:06:59 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id h3sm20782706oeo.2.2013.08.09.13.06.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 13:06:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.267.gbb4989f
In-Reply-To: <1376078581-24766-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232019>

6796d49 (remote-hg: use a shared repository store) introduced a bug by
making the shared repository '.git/hg', which is already used before
that patch, so clones that happened before that patch, fail after that
patch, because there's no shared Mercurial repo.

It's trivial to upgrade to the new organization by copying the Mercurial
repo from one of the remotes (e.g. 'origin'), so let's do so.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index cfd4f53..9ec13da 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -392,6 +392,17 @@ def get_repo(url, alias):
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
+                shutil.copytree(local_hg, hg_path)
+                break
+
         # setup shared repo (if not there)
         try:
             hg.peer(myui, {}, shared_path, create=True)
-- 
1.8.3.267.gbb4989f
