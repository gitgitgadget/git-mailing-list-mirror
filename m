From: Patrick Higgins <patrick.higgins@cexp.com>
Subject: [PATCH/RFC] Bugfix for AIX tmpfile creation
Date: Mon, 23 Jun 2008 15:33:41 -0600
Message-ID: <1214256821-3169-1-git-send-email-patrick.higgins@cexp.com>
Cc: Patrick Higgins <patrick.higgins@cexp.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 23:39:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAtlG-00089d-FU
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 23:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbYFWViq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 17:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752939AbYFWViq
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 17:38:46 -0400
Received: from mx02.cexp.com ([170.131.136.83]:44625 "EHLO mx02.cexp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752926AbYFWVip (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 17:38:45 -0400
Received: from mailgate2.cexp.com (uscobrmfa-se-07.cexp.com [170.131.144.37])
	by mx02.cexp.com (Postfix) with ESMTP id 4FE56368662
	for <git@vger.kernel.org>; Mon, 23 Jun 2008 15:33:43 -0600 (MDT)
Received: from localhost.localdomain ([10.128.5.63]) by USCOBRMFA-SE-51.northamerica.cexp.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 23 Jun 2008 15:33:43 -0600
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.1/8.13.1) with ESMTP id m5NLXg5N003192;
	Mon, 23 Jun 2008 15:33:42 -0600
Received: (from phiggins@localhost)
	by localhost.localdomain (8.13.1/8.13.1/Submit) id m5NLXfwD003191;
	Mon, 23 Jun 2008 15:33:41 -0600
X-Mailer: git-send-email 1.5.6.dirty
X-OriginalArrivalTime: 23 Jun 2008 21:33:43.0443 (UTC) FILETIME=[CF84AE30:01C8D578]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85938>

The AIX mkstemp will modify it's template parameter to an empty string if
the call fails. This caused a subsequent mkdir to fail.

Signed-off-by: Patrick Higgins <patrick.higgins@cexp.com>
---
 sha1_file.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 191f814..92299ed 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2118,6 +2118,7 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
 	fd = mkstemp(buffer);
 	if (fd < 0 && dirlen) {
 		/* Make sure the directory exists */
+		memcpy(buffer, filename, dirlen);
 		buffer[dirlen-1] = 0;
 		if (mkdir(buffer, 0777) || adjust_shared_perm(buffer))
 			return -1;
-- 
1.5.6.dirty
