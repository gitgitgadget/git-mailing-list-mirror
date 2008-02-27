From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 12/40] Windows: Implement gettimeofday().
Date: Wed, 27 Feb 2008 19:54:35 +0100
Message-ID: <1204138503-6126-13-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVL-00022R-5J
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755334AbYB0Sz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755972AbYB0Sz1
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:27 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40437 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755335AbYB0SzI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:08 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 03F0097658;
	Wed, 27 Feb 2008 19:55:06 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75269>

For this purpose we make my_mktime of date.c public and use it to convert
a struct tm to a time_t.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 compat/mingw.c |   14 ++++++++++++++
 date.c         |    2 +-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 71bca96..24f783b 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -38,6 +38,20 @@ int mkstemp(char *template)
 
 int gettimeofday(struct timeval *tv, void *tz)
 {
+	extern time_t my_mktime(struct tm *tm);
+	SYSTEMTIME st;
+	struct tm tm;
+	GetSystemTime(&st);
+	tm.tm_year = st.wYear-1900;
+	tm.tm_mon = st.wMonth-1;
+	tm.tm_mday = st.wDay;
+	tm.tm_hour = st.wHour;
+	tm.tm_min = st.wMinute;
+	tm.tm_sec = st.wSecond;
+	tv->tv_sec = my_mktime(&tm);
+	if (tv->tv_sec < 0)
+		return -1;
+	tv->tv_usec = st.wMilliseconds*1000;
 	return 0;
 }
 
diff --git a/date.c b/date.c
index 8f70500..9c16eae 100644
--- a/date.c
+++ b/date.c
@@ -6,7 +6,7 @@
 
 #include "cache.h"
 
-static time_t my_mktime(struct tm *tm)
+time_t my_mktime(struct tm *tm)
 {
 	static const int mdays[] = {
 	    0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334
-- 
1.5.4.1.126.ge5a7d
