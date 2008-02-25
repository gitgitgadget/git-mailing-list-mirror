From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 2/2] daemon: Verify base-path and interpolated-path early
Date: Mon, 25 Feb 2008 14:27:25 +0100
Message-ID: <47C2C23D.1030609@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 14:28:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTdNE-0000P0-Vn
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 14:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbYBYN12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 08:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbYBYN12
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 08:27:28 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:29296 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbYBYN11 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 08:27:27 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JTdM4-0006Gs-TE; Mon, 25 Feb 2008 14:26:53 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 734AF4E4; Mon, 25 Feb 2008 14:27:25 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75027>

Any request to the daemon would fail if either interpolated-path or
base-path (if specified) would not be absolute. Hence, we can check those
paths for validity upfront and not start the daemon at all if the paths are
invalid.

Additionally, we now check that the base-path is an existing directory.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 daemon.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/daemon.c b/daemon.c
index dd0177f..64c7fff 100644
--- a/daemon.c
+++ b/daemon.c
@@ -220,12 +220,6 @@ static char *path_ok(struct interp *itable)
 		}
 	}
 	else if (interpolated_path && saw_extended_args) {
-		if (*dir != '/') {
-			/* Allow only absolute */
-			logerror("'%s': Non-absolute path denied (interpolated-path active)", dir);
-			return NULL;
-		}
-
 		interpolate(interp_path, PATH_MAX, interpolated_path,
 			    interp_table, ARRAY_SIZE(interp_table));
 		loginfo("Interpolated dir '%s'", interp_path);
@@ -233,11 +227,6 @@ static char *path_ok(struct interp *itable)
 		dir = interp_path;
 	}
 	else if (base_path) {
-		if (*dir != '/') {
-			/* Allow only absolute */
-			logerror("'%s': Non-absolute path denied (base-path active)", dir);
-			return NULL;
-		}
 		snprintf(rpath, PATH_MAX, "%s%s", base_path, dir);
 		dir = rpath;
 	}
@@ -1184,6 +1173,19 @@ int main(int argc, char **argv)
 	if (strict_paths && (!ok_paths || !*ok_paths))
 		die("option --strict-paths requires a whitelist");

+	if (base_path) {
+		struct stat st;
+
+		if (!is_absolute_path(base_path))
+			die("base-path must be absolute");
+		if (stat(base_path, &st) || !S_ISDIR(st.st_mode))
+			die("base-path '%s' does not exist or "
+			    "is not a directory", base_path);
+	}
+
+	if (interpolated_path && !is_absolute_path(interpolated_path))
+		die("interpolated-path must be absolute");
+
 	if (inetd_mode) {
 		struct sockaddr_storage ss;
 		struct sockaddr *peer = (struct sockaddr *)&ss;
-- 
1.5.4.3.229.g5c72
