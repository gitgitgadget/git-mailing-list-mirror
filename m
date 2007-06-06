From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Accept dates before 2000/01/01 when specified as seconds since the epoch
Date: Wed,  6 Jun 2007 10:11:55 +0200
Message-ID: <11811175153355-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Jun 06 10:12:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvqck-0006Zo-Ke
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 10:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbXFFIMA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 04:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752983AbXFFIMA
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 04:12:00 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:38380 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbXFFIL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 04:11:59 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.44)
	id 1HvqcW-0008TV-W8; Wed, 06 Jun 2007 10:11:58 +0200
Received: from srv.linz.eudaptics (srv.linz.eudaptics [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9868B54D; Wed,  6 Jun 2007 10:11:56 +0200 (CEST)
Received: by srv.linz.eudaptics (Postfix, from userid 503)
	id CB6B7103; Wed,  6 Jun 2007 10:11:55 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.1.120.gd732
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49261>

Tests with git-filter-branch on a repository that was converted from
CVS and that has commits reaching back to 1999 revealed that it is
necessary to parse dates before 2000/01/01 when they are specified
as seconds since 1970/01/01. There is now still a limit, 100000000,
which is 1973/03/03 09:46:40 UTC, in order to allow that dates are
represented as 8 digits.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 date.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/date.c b/date.c
index a9b59a2..4690371 100644
--- a/date.c
+++ b/date.c
@@ -414,9 +414,11 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 	num = strtoul(date, &end, 10);
 
 	/*
-	 * Seconds since 1970? We trigger on that for anything after Jan 1, 2000
+	 * Seconds since 1970? We trigger on that for any numbers with
+	 * more than 8 digits. This is because we don't want to rule out
+	 * numbers like 20070606 as a YYYYMMDD date.
 	 */
-	if (num > 946684800) {
+	if (num >= 100000000) {
 		time_t time = num;
 		if (gmtime_r(&time, tm)) {
 			*tm_gmt = 1;
-- 
1.5.2.1.120.gd732
