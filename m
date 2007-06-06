From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-branch: cleanup config file when deleting branches
Date: Wed, 6 Jun 2007 10:09:47 +0000
Message-ID: <20070606100947.18990.qmail@bef1f6489d171f.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 12:11:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvsTo-0004fO-Vf
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 12:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbXFFKK4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 06:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757146AbXFFKKz
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 06:10:55 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:56692 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752140AbXFFKKz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 06:10:55 -0400
Received: (qmail 18991 invoked by uid 1000); 6 Jun 2007 10:09:47 -0000
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49278>

When deleting branches, remove the sections referring to these branches
from the config file.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 builtin-branch.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index a5b6bbe..3a70a7d 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -85,6 +85,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 	unsigned char sha1[20];
 	char *name = NULL;
 	const char *fmt, *remote;
+	char section[PATH_MAX];
 	int i;
 	int ret = 0;
 
@@ -152,9 +153,13 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 			error("Error deleting %sbranch '%s'", remote,
 			       argv[i]);
 			ret = 1;
-		} else
+		} else {
 			printf("Deleted %sbranch %s.\n", remote, argv[i]);
-
+			snprintf(section, sizeof(section), "branch.%s",
+				 argv[i]);
+			if (git_config_rename_section(section, NULL) < 0)
+				warning("Update of config-file failed");
+		}
 	}
 
 	if (name)
-- 
1.5.2
