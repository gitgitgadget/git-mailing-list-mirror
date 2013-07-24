From: Joern Hees <dev@joernhees.de>
Subject: [PATCH v2] remotes-hg: bugfix for fetching non local remotes
Date: Wed, 24 Jul 2013 16:21:41 +0200
Message-ID: <1374675701-10592-1-git-send-email-dev@joernhees.de>
Cc: apelisse@gmail.com, gitster@pobox.com, felipe.contreras@gmail.com,
	Joern Hees <dev@joernhees.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 24 16:22:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1zxj-0001pw-F5
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 16:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284Ab3GXOWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 10:22:40 -0400
Received: from srv1.joernhees.de ([81.20.133.80]:56482 "EHLO mail.joernhees.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353Ab3GXOWi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 10:22:38 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.joernhees.de (Postfix) with ESMTP id 4D8AFE8C2B6;
	Wed, 24 Jul 2013 16:22:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at joernhees.de
Received: from mail.joernhees.de ([127.0.0.1])
	by localhost (srv1.joernhees.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JWltakIAcUtb; Wed, 24 Jul 2013 16:22:35 +0200 (CEST)
Received: from dready.de (dfki-098.dfki.uni-kl.de [131.246.194.98])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.joernhees.de (Postfix) with ESMTPSA id 7260CE8C2AE;
	Wed, 24 Jul 2013 16:22:35 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231099>

6796d49 introduced a bug by making shared_path == ".git/hg' which
will most likely exist already, causing a new remote never to be
cloned and subsequently causing hg.share to fail with error msg:
"mercurial.error.RepoError: repository .git/hg not found"

Changing shared_path to ".git/hg/.shared" will solve this problem
and create a shared local mercurial repository for non local remotes.
The initial dot circumvents a name clash problem should a remote be
called "shared".

Signed-off-by: Joern Hees <dev@joernhees.de>
Mentored-by: Antoine Pelisse <apelisse@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 0194c67..4a7d7a8 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -390,7 +390,7 @@ def get_repo(url, alias):
         if not os.path.exists(dirname):
             os.makedirs(dirname)
     else:
-        shared_path = os.path.join(gitdir, 'hg')
+        shared_path = os.path.join(gitdir, 'hg', '.share')
         if not os.path.exists(shared_path):
             try:
                 hg.clone(myui, {}, url, shared_path, update=False, pull=True)
-- 
1.8.3.4
