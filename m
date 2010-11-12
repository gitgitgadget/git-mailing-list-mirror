From: Peter Krefting <peter@softwolves.pp.se>
Subject: [PATCH 1/2] [RFC] Detect attempts at calling git init specifying a
 remote repository.
Date: Fri, 12 Nov 2010 12:27:35 +0100
Message-ID: <3f7d07a2b3a02c1d3f864d2a17f3b8808890a4d1.1289561504.git.peter@softwolves.pp.se>
References: <cover.1289561504.git.peter@softwolves.pp.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 12 12:40:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGrzP-00008W-Qi
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 12:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757305Ab0KLLkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 06:40:13 -0500
Received: from smtp.getmail.no ([84.208.15.66]:59461 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755743Ab0KLLkK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 06:40:10 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBR005BRSEWYR10@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 12 Nov 2010 12:40:08 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id AEBA61EA54DE_CDD2798B	for <git@vger.kernel.org>; Fri,
 12 Nov 2010 11:40:08 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 99DD51EA2C65_CDD2798F	for <git@vger.kernel.org>; Fri,
 12 Nov 2010 11:40:08 +0000 (GMT)
Received: from perkele ([84.215.142.63]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBR008XNSEWJT00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 12 Nov 2010 12:40:08 +0100 (MET)
Received: by perkele (Postfix, from userid 501)	id 5DBD32FC06; Fri,
 12 Nov 2010 12:40:06 +0100 (CET)
In-reply-to: <cover.1289561504.git.peter@softwolves.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161335>

We can only initialize local repositories, so bail out immediately if the
user tries to specify a remote repository.
---
 builtin/init-db.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 9d4886c..f80ff08 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -435,7 +435,12 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		int mkdir_tried = 0;
 	retry:
 		if (chdir(argv[0]) < 0) {
-			if (!mkdir_tried) {
+			if (is_url(argv[0]) || strchr(argv[0], '@') != NULL || (strchr(argv[0], ':') != NULL && !has_dos_drive_prefix(argv[0]))) {
+				/*
+				 * We were passed a remote repository specification.
+				 */
+				die("Cannot initialize remote repository '%s'", argv[0]);
+			} else if (!mkdir_tried) {
 				int saved;
 				/*
 				 * At this point we haven't read any configuration,
-- 
1.7.3
