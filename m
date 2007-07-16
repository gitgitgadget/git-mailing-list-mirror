From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: [PATCH] Do _not_ call unlink on a directory
Date: Mon, 16 Jul 2007 19:12:52 +0200
Message-ID: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de>
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 16 19:13:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAU8Q-0002rd-U0
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 19:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760684AbXGPRMy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 13:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760791AbXGPRMy
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 13:12:54 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:44372 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760684AbXGPRMx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 13:12:53 -0400
Received: from faui02.informatik.uni-erlangen.de (faui02.informatik.uni-erlangen.de [131.188.30.102])
	by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 896063F42F;
	Mon, 16 Jul 2007 19:12:52 +0200 (CEST)
Received: (from sithglan@localhost)
	by faui02.informatik.uni-erlangen.de (8.13.8/8.12.3/Debian-8) id l6GHCqaH022446;
	Mon, 16 Jul 2007 19:12:52 +0200
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: 469B821E.85E5EDA9@eudaptics.com
References: 469B821E.85E5EDA9@eudaptics.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52691>

Calling unlink on a directory on a Solaris UFS filesystem as root makes it
inconsistent. Thanks to Johannes Sixt for the obvious fix.
---
 entry.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/entry.c b/entry.c
index 82bf725..1f2e34d 100644
--- a/entry.c
+++ b/entry.c
@@ -14,10 +14,10 @@ static void create_directories(const char *path, const struct checkout *state)
 		if (mkdir(buf, 0777)) {
 			if (errno == EEXIST) {
 				struct stat st;
-				if (len > state->base_dir_len && state->force && !unlink(buf) && !mkdir(buf, 0777))
-					continue;
 				if (!stat(buf, &st) && S_ISDIR(st.st_mode))
 					continue; /* ok */
+				if (len > state->base_dir_len && state->force && !unlink(buf) && !mkdir(buf, 0777))
+					continue;
 			}
 			die("cannot create directory at %s", buf);
 		}
-- 
1.5.2.1
