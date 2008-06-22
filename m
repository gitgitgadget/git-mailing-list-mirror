From: Jing Xue <jingxue@digizenstudio.com>
Subject: [PATCH] Add 'git-p4.allowSubmit' to git-p4
Date: Sun, 22 Jun 2008 14:12:39 -0400
Message-ID: <20080622181239.GA1855@jabba.hq.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, jingxue@digizenstudio.com
To: Junio C Hamano <gitster@pobox.com>, Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Sun Jun 22 20:20:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAUAp-0000ih-6M
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 20:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbYFVSTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 14:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753270AbYFVSTZ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 14:19:25 -0400
Received: from k2smtpout06-01.prod.mesa1.secureserver.net ([64.202.189.102]:33230
	"HELO k2smtpout06-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752394AbYFVSTY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 14:19:24 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Jun 2008 14:19:24 EDT
Received: (qmail 32624 invoked from network); 22 Jun 2008 18:12:44 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout06-01.prod.mesa1.secureserver.net (64.202.189.102) with ESMTP; 22 Jun 2008 18:12:44 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 5E278100A77;
	Sun, 22 Jun 2008 18:12:44 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dT9eDxgGqCup; Sun, 22 Jun 2008 14:12:40 -0400 (EDT)
Received: from jabba.hq.digizenstudio.com (ip70-174-133-176.dc.dc.cox.net [70.174.133.176])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id E8F9210008B;
	Sun, 22 Jun 2008 14:12:39 -0400 (EDT)
Received: by jabba.hq.digizenstudio.com (Postfix, from userid 1000)
	id 241FB48E90; Sun, 22 Jun 2008 14:12:39 -0400 (EDT)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Simon Hausmann <simon@lst.de>, git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85790>

I'm working with a perforce repo using git-p4. There are some config
files which I need to change locally according to my environment. I'm
using a 'local' git branch to park these changes. And I want to avoid
accidentally checking them into p4 just by doing "git p4 submit"
mindlessly without realizing which branch I'm actually on.

This patch adds a new git config, 'git-p4.allowSubmit', which is a
whitelist of branch names. "git p4 submit" will only allow submissions
from local branches on the list. Useful for preventing inadvertently
submitting from a strictly local branch.

For backward compatibility, if this config is not set at all,
submissions from all branches are allowed.

Signed-off-by: Jing Xue <jingxue@digizenstudio.com>
---
 contrib/fast-import/git-p4 |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index d8de9f6..87ca51e 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -687,6 +687,10 @@ class P4Submit(Command):
         else:
             return False
 
+        allowSubmit = gitConfig("git-p4.allowSubmit")
+        if len(allowSubmit) > 0 and not self.master in allowSubmit.split(","):
+            die("%s is not in git-p4.allowSubmit" % self.master)
+
         [upstream, settings] = findUpstreamBranchPoint()
         self.depotPath = settings['depot-paths'][0]
         if len(self.origin) == 0:
-- 
1.5.6.13.g2ae4ef
