From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/2] remote.c: silently tolerate single-level keys like remote.default
Date: Thu, 23 Apr 2009 15:49:05 +0200
Message-ID: <1240494546-25775-1-git-send-email-j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 16:22:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwzo0-0001fK-ND
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 16:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755788AbZDWOUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 10:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752914AbZDWOUB
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 10:20:01 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:22913 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbZDWOUA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 10:20:00 -0400
X-Greylist: delayed 1828 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Apr 2009 10:20:00 EDT
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1LwzIu-0008IN-Aa; Thu, 23 Apr 2009 15:49:28 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 023144E9; Thu, 23 Apr 2009 15:49:27 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id BAD51FA43; Thu, 23 Apr 2009 15:49:27 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.rc1.88.g1bf9
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117340>

If the config file contains a section like this:

    [remote]
            default = foo

(it should be '[remotes]') then commands like

    git status
    git checkout
    git branch -v

fail even though they are not obviously related to remotes. (These commands
write "ahead, behind" information and, therefore, access the configuration
of remotes.)

Typos in configuration keys usually do not hurt because they never match
in look-ups. But this case is different: it does match, but it does not
have the expected format. With this patch this situation is treated more
like a typo.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index 91f7485..d66e2f3 100644
--- a/remote.c
+++ b/remote.c
@@ -366,7 +366,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 	}
 	subkey = strrchr(name, '.');
 	if (!subkey)
-		return error("Config with no key for remote %s", name);
+		return 0;
 	remote = make_remote(name, subkey - name);
 	remote->origin = REMOTE_CONFIG;
 	if (!strcmp(subkey, ".mirror"))
-- 
1.6.3.rc1.88.g1bf9
