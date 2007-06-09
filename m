From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-branch: cleanup config file when deleting branches
Date: Sat, 9 Jun 2007 12:35:26 +0000
Message-ID: <20070609123526.3856.qmail@5cc189b277f9b4.315fe32.mid.smarden.org>
References: <20070606100947.18990.qmail@bef1f6489d171f.315fe32.mid.smarden.org> <7vzm3akf6g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 14:35:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx0AB-0001cA-Ou
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 14:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364AbXFIMfY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 08:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753455AbXFIMfY
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 08:35:24 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:51749 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752613AbXFIMfY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 08:35:24 -0400
Received: (qmail 3857 invoked by uid 1000); 9 Jun 2007 12:35:26 -0000
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vzm3akf6g.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49570>

When deleting branches, remove the sections referring to these branches
from the config file.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
On Fri, Jun 08, 2007 at 01:45:27AM -0700, Junio C Hamano wrote:
> Hmph.  Makes sense and might even be a maint material, but it
> probably is safe not to do a behaviour change in maint.
>
> Tests?
Sure, two tests added.  Regards, Gerrit.

 builtin-branch.c  |    9 +++++++--
 t/t3200-branch.sh |    9 +++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 67f46c1..9addd1a 100644
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
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 6f6d884..1322bfb 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -171,6 +171,15 @@ test_expect_success 'test tracking setup via --track but deeper' \
      test "$(git-config branch.my7.remote)" = local &&
      test "$(git-config branch.my7.merge)" = refs/heads/o/o'
 
+test_expect_success 'test deleting branch deletes branch config' \
+    'git-branch -d my7 &&
+     test "$(git-config branch.my7.remote)" = "" &&
+     test "$(git-config branch.my7.merge)" = ""'
+
+test_expect_success 'test deleting branch without config' \
+    'git-branch my7 s &&
+     test "$(git-branch -d my7)" = "Deleted branch my7."'
+
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
 0000000000000000000000000000000000000000 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
-- 
1.5.2.1
