From: Joern Hees <dev@joernhees.de>
Subject: [PATCH] remotes-hg: bugfix for fetching non local remotes
Date: Mon, 22 Jul 2013 03:22:59 +0200
Message-ID: <1374456179-96670-1-git-send-email-dev@joernhees.de>
Cc: felipe.contreras@gmail.com, Joern Hees <dev@joernhees.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 22 03:29:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V14wV-0005Ex-CS
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 03:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009Ab3GVB3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 21:29:35 -0400
Received: from srv1.joernhees.de ([81.20.133.80]:40661 "EHLO mail.joernhees.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753922Ab3GVB3e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 21:29:34 -0400
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jul 2013 21:29:34 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.joernhees.de (Postfix) with ESMTP id 887EFE8C2C4;
	Mon, 22 Jul 2013 03:23:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at joernhees.de
Received: from mail.joernhees.de ([127.0.0.1])
	by localhost (srv1.joernhees.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 86TOOgBk7UoY; Mon, 22 Jul 2013 03:23:09 +0200 (CEST)
Received: from localhost.localdomain (xdsl-89-0-148-85.netcologne.de [89.0.148.85])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.joernhees.de (Postfix) with ESMTPSA id B52C7E8C2C3;
	Mon, 22 Jul 2013 03:23:09 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230951>

6796d49 introduced a bug by making shared_path == ".git/hg' which
will most likely exist already, causing a new remote never to be
cloned and subsequently causing hg.share to fail with error msg:
"mercurial.error.RepoError: repository .git/hg not found"

Changing gitdir to dirname causes shared_path ==
.git/hg/<remote_name>/hg. The call to hg.share with local_path ==
.git/hg/<remote_name>/clone works again.
---
 contrib/remote-helpers/git-remote-hg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 0194c67..89dd4cc 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -390,7 +390,7 @@ def get_repo(url, alias):
         if not os.path.exists(dirname):
             os.makedirs(dirname)
     else:
-        shared_path = os.path.join(gitdir, 'hg')
+        shared_path = os.path.join(dirname, 'hg')
         if not os.path.exists(shared_path):
             try:
                 hg.clone(myui, {}, url, shared_path, update=False, pull=True)
-- 
1.8.3.3
