From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] remote-hg: add shared repo upgrade
Date: Mon,  5 Aug 2013 21:29:43 +0200
Message-ID: <1375730983-6620-1-git-send-email-apelisse@gmail.com>
Cc: Joern Hees <dev@joernhees.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 05 21:30:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6QTu-0007kn-3R
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 21:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613Ab3HETaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 15:30:08 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:46143 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595Ab3HETaH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 15:30:07 -0400
Received: by mail-we0-f172.google.com with SMTP id t61so2889577wes.31
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 12:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=t/E+ZdzVLvgwsnM2meMdt0Nsz+oANmy36JmV911PGtg=;
        b=0ZpEI0UKqpQaD62EJ1Kr3T1Tz2M3YzY9NHDzwmdjuTZmgoKg222Ypa+2QZyqKhuwhC
         cLvdeMfml0RN6RrkzX0E/68hWH6re++D9WQM7Dt/B2k4vSic+JVjowjqlr/G8I2I76WU
         HaZgmvFvuftbAxeC2HsVvcHef6DIbHeVQTSREfJErZa2xCJFBFex+0dVPf5O8592B3/j
         R9FZ5jZ6L2cH18mHhCPckjbqFCuuirMasUcx0D8fs5GhxnM73AWfDHT9dLGEgTyYB53y
         TvU61l8GY3zHrKjZUNQM8A8oGlF7uyCZAK/xt1K0MliOPp7WZtiWecgFuvY1RcE/3xKO
         RfnA==
X-Received: by 10.180.126.2 with SMTP id mu2mr7723609wib.63.1375731006001;
        Mon, 05 Aug 2013 12:30:06 -0700 (PDT)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPSA id gg10sm915579wib.1.2013.08.05.12.30.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 05 Aug 2013 12:30:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231694>

From: Felipe Contreras <felipe.contreras@gmail.com>

6796d49 (remote-hg: use a shared repository store) introduced a bug by
making the shared repository '.git/hg', which is already used before
that patch, so clones that happened before that patch, fail after that
patch, because there's no shared Mercurial repo.

It's trivial to upgrade to the new organization by copying the Mercurial
repo from one of the remotes (e.g. 'origin'), so let's do so.

Reported-by: Joern Hees <dev@joernhees.de>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
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
