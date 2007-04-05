From: Geert Bosch <bosch@gnat.com>
Subject: [PATCH] Fix renaming branch without config file
Date: Thu, 5 Apr 2007 10:20:55 -0400
Message-ID: <20070405144359.4B8832A7C67@potomac.gnat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 17:16:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZTgs-0006xj-ML
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 17:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767041AbXDEPPz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 11:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767042AbXDEPPz
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 11:15:55 -0400
Received: from potomac.gnat.com ([205.232.38.124]:52756 "EHLO potomac.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767023AbXDEPPz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 11:15:55 -0400
X-Greylist: delayed 1915 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Apr 2007 11:15:55 EDT
Received: by potomac.gnat.com (Postfix, from userid 4190)
	id 4B8832A7C67; Thu,  5 Apr 2007 10:43:59 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43831>

Make git_config_rename_section return success if no config file
exists.  Otherwise, renaming a branch would abort, leaving the
repository in an inconsistent state.

Signed-off-by: Geert Bosch <bosch@gnat.com>
---
 config.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 6479855..70d1055 100644
--- a/config.c
+++ b/config.c
@@ -916,8 +916,8 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 	}
 
 	if (!(config_file = fopen(config_filename, "rb"))) {
-		ret = error("Could not open config file!");
-		goto out;
+		/* no config file means nothing to rename, no error */
+		goto unlock_and_out;
 	}
 
 	while (fgets(buf, sizeof(buf), config_file)) {
@@ -951,6 +951,7 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 		}
 	}
 	fclose(config_file);
+ unlock_and_out:
 	if (close(out_fd) || commit_lock_file(lock) < 0)
 			ret = error("Cannot commit config file!");
  out:
-- 
1.4.5-rc0.GIT
