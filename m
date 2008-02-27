From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 07/40] Windows: A minimal implemention of getpwuid().
Date: Wed, 27 Feb 2008 19:54:30 +0100
Message-ID: <1204138503-6126-8-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVJ-00022R-7r
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756025AbYB0SzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755988AbYB0SzU
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:20 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40430 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249AbYB0SzH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:07 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 3300897558;
	Wed, 27 Feb 2008 19:55:05 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75262>

getpwuid() is implemented just enough that GIT does not issue errors.
Since the information that it returns is not very useful, users are
required to set up user.name and user.email configuration.

All uses of getpwuid() are like getpwuid(getuid()), hence, the return value
of getuid() is irrelevant and the uid parameter is not even looked at.

Side note: getpwnam() is only used to resolve '~' and '~username' paths,
which is an idiom not known on Windows, hence, we don't implement it.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 compat/mingw.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index faa6df3..0c1d0e4 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -62,7 +62,15 @@ struct tm *localtime_r(const time_t *timep, struct tm *result)
 
 struct passwd *getpwuid(int uid)
 {
+	static char user_name[100];
 	static struct passwd p;
+
+	DWORD len = sizeof(user_name);
+	if (!GetUserName(user_name, &len))
+		return NULL;
+	p.pw_name = user_name;
+	p.pw_gecos = "unknown";
+	p.pw_dir = NULL;
 	return &p;
 }
 
-- 
1.5.4.1.126.ge5a7d
