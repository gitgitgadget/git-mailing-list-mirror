From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 21/40] Windows: Disambiguate DOS style paths from SSH URLs.
Date: Wed, 27 Feb 2008 19:54:44 +0100
Message-ID: <1204138503-6126-22-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVP-00022R-OH
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627AbYB0Szp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755300AbYB0Szo
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:44 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40451 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755627AbYB0SzK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:10 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id C0AC8976EB;
	Wed, 27 Feb 2008 19:55:07 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75255>

If on Windows a path is specified as C:/path, then this is also a valid
SSH URL. To disambiguate between the two interpretations we require that
a SSH URL must have a host name with at least two characters.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 connect.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/connect.c b/connect.c
index 5ac3572..7e18ac8 100644
--- a/connect.c
+++ b/connect.c
@@ -529,7 +529,13 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		end = host;
 
 	path = strchr(end, c);
-	if (path) {
+#ifdef __MINGW32__
+	/* host must have at least 2 chars to catch DOS C:/path */
+	if (path && path - end > 1)
+#else
+	if (path)
+#endif
+	{
 		if (c == ':') {
 			protocol = PROTO_SSH;
 			*path++ = '\0';
-- 
1.5.4.1.126.ge5a7d
