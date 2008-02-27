From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 35/40] Windows: Work around an oddity when a pipe with no reader is written to.
Date: Wed, 27 Feb 2008 19:54:58 +0100
Message-ID: <1204138503-6126-36-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVc-00022R-O8
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756687AbYB0S43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756611AbYB0S42
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:56:28 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40470 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755808AbYB0SzN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:13 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 9B94C97721;
	Wed, 27 Feb 2008 19:55:10 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75259>

On Windows, write() is implemented using WriteFile(). After the reader
closed its end of the pipe, the first WriteFile() returns
ERROR_BROKEN_PIPE (which translates to EPIPE), subsequent WriteFile()s
return ERROR_NO_DATA, which is translated to EINVAL.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 write_or_die.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/write_or_die.c b/write_or_die.c
index e125e11..f3b8566 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -34,7 +34,12 @@ void maybe_flush_or_die(FILE *f, const char *desc)
 			return;
 	}
 	if (fflush(f)) {
-		if (errno == EPIPE)
+		/*
+		 * On Windows, EPIPE is returned only by the first write()
+		 * after the reading end has closed its handle; subsequent
+		 * write()s return EINVAL.
+		 */
+		if (errno == EPIPE || errno == EINVAL)
 			exit(0);
 		die("write failure on %s: %s", desc, strerror(errno));
 	}
-- 
1.5.4.1.126.ge5a7d
