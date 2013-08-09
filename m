From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 1/2] remote-hg: add shared repo upgrade
Date: Fri,  9 Aug 2013 18:49:46 +0200
Message-ID: <1376066986-27950-1-git-send-email-apelisse@gmail.com>
References: <CALWbr2y+fE1EvGuTQXQiL81yavpDR+RqmrxWjNTUme-fmjY8EQ@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 09 18:50:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7ptO-0003v3-QI
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 18:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030569Ab3HIQuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 12:50:11 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:41340 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968212Ab3HIQuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 12:50:09 -0400
Received: by mail-wg0-f48.google.com with SMTP id f12so3308446wgh.15
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WM8WM9tB8fP+PI3Bzz0f4JR3lPpbI4ah8mTJr0PO/B8=;
        b=lxd+jFJdbkUY2gZDCG7Z6TBqB4Z5kooIvVtZIHTA94xoSJmq1NlpiEnGL+UN3VQiXW
         Xpr17awju9usatqofZqXiWVj+O/DjmbHYcVCl7UldB58I2GCl878GPmJYeTQQ7X5B7VH
         UHsJn6o4mOE+ISqkGVPaP54kUAB7A7brdBC9BIWNrU+CaWGHtR4ttazC3kBfgs/3+EJW
         AXlyDDNCxlltlVTixrSG2WvGLJZvR/bwx37UJvwvw2Wc7yIWRcWs/+qsZBOlW2Is3qCe
         hq13ILWEErH4DqjKkVesC8jmZxstWcANf9367NSOzLEXcOmyK/383dvipceIiQpQBt7x
         PSKA==
X-Received: by 10.194.23.196 with SMTP id o4mr938416wjf.62.1376067007941;
        Fri, 09 Aug 2013 09:50:07 -0700 (PDT)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPSA id nb12sm3802678wic.3.2013.08.09.09.50.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 09:50:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <CALWbr2y+fE1EvGuTQXQiL81yavpDR+RqmrxWjNTUme-fmjY8EQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231993>

From: Felipe Contreras <felipe.contreras@gmail.com>

6796d49 (remote-hg: use a shared repository store) introduced a bug by
making the shared repository '.git/hg', which is already used before
that patch, so clones that happened before that patch, fail after that
patch, because there's no shared Mercurial repo.

It's trivial to upgrade to the new organization by copying the Mercurial
repo from one of the remotes (e.g. 'origin'), so let's do so. If we
can't find any existing repo, we create an empty one.

Reported-by: Joern Hees <dev@joernhees.de>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 contrib/remote-helpers/git-remote-hg |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 0194c67..1897327 100755
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
+                if os.path.exists(local_hg):
+                    shutil.copytree(local_hg, hg_path)
+                    break
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
