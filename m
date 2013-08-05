From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] remote-hg: add shared repo upgrade
Date: Mon,  5 Aug 2013 21:22:47 +0200
Message-ID: <1375730567-3240-1-git-send-email-apelisse@gmail.com>
Cc: Joern Hees <dev@joernhees.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 05 21:23:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6QNF-0004Px-EO
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 21:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406Ab3HETXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 15:23:16 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:47934 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab3HETXP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 15:23:15 -0400
Received: by mail-we0-f177.google.com with SMTP id m46so2731626wev.8
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 12:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=NJko1kMeIfHe5zKzJutOwSfTPphtn7BK7jJN30Y73ng=;
        b=orOJLEPjrQWWNm/+cz3iGFOcLqnAnVYLevK8/hbg3CPoLj9jLYdbDG0V0fGWIvLS1K
         ip+1Zj6EMSgpASbSbfe79pU0bQw+AXX39hOFS0NAlSV63XJUSfQsoIht81cjmQamC5UA
         vNq6j+V7PcY3362RxflPecBzQeK4uQXKh2sR0VhovQfctGtew4y54IDfuBl2A1Gyb0Yl
         NtdXvhuSncmAdY+tU+C6z+GtCamRHsXaHnXwigg5DvhADbdWypp9tlMg6ImiwhUteND8
         AVdJeq9egtzFZyhS+nmldmWNO0VUhJKfRATjMRn1Um02DsAtiE3c+bH+Y5Jmn5tnt/LA
         NccA==
X-Received: by 10.180.187.41 with SMTP id fp9mr3804101wic.33.1375730593923;
        Mon, 05 Aug 2013 12:23:13 -0700 (PDT)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPSA id jf9sm871235wic.5.2013.08.05.12.23.12
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 05 Aug 2013 12:23:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231692>

From: Felipe Contreras <felipe.contreras@gmail.com>

6796d49 (remote-hg: use a shared repository store) introduced a bug by
making the shared repository '.git/hg', which is already used before
that patch, so clones that happened before that patch, fail after that
patch, because there's no shared Mercurial repo.

It's trivial to upgrade to the new organization by copying the Mercurial
repo from one of the remotes (e.g. 'origin'), so let's do so.

Reported-by: Joern Hees <dev@joernhees.de>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 0194c67..02404dc 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -391,11 +391,22 @@ def get_repo(url, alias):
             os.makedirs(dirname)
     else:
         shared_path = os.path.join(gitdir, 'hg')
-        if not os.path.exists(shared_path):
-            try:
-                hg.clone(myui, {}, url, shared_path, update=False, pull=True)
-            except:
-                die('Repository error')
+
+        # check and upgrade old organization
+        hg_path = os.path.join(shared_path, '.hg')
+        if os.path.exists(shared_path) and not os.path.exists(hg_path):
+            repos = os.listdir(shared_path)
+            for x in repos:
+                local_hg = os.path.join(shared_path, x, 'clone', '.hg')
+                if not os.path.exists(local_hg):
+                    continue
+                shutil.copytree(local_hg, hg_path)
+
+        # setup shared repo (if not there)
+        try:
+            hg.peer(myui, {}, shared_path, create=True)
+        except error.RepoError:
+            pass
 
         if not os.path.exists(dirname):
             os.makedirs(dirname)
-- 
1.7.9.5
