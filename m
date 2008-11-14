From: Sam Vilain <sam@vilain.net>
Subject: [PATCH] sha1_file: make sure correct error is propagated
Date: Fri, 14 Nov 2008 20:19:34 +1300
Message-ID: <1226647174-15844-1-git-send-email-sam@vilain.net>
Cc: Sam Vilain <samv@maia.lan>, Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 14 08:21:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0szV-0004H1-Ls
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 08:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbYKNHTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 02:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbYKNHTm
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 02:19:42 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:52908 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbYKNHTl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 02:19:41 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id ECB1921C3F3; Fri, 14 Nov 2008 20:19:39 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	by mail.utsl.gen.nz (Postfix) with ESMTP id 808AA21C3B6;
	Fri, 14 Nov 2008 20:19:34 +1300 (NZDT)
X-Mailer: git-send-email debian.1.5.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100957>

From: Sam Vilain <samv@maia.lan>

In the case that a object directory exists, but is not writable, the
code path that tries to create it is followed and the returned errno
and path that of the directory tried to be created.  The resultant
error message is confusing.

So, if the mkstemp() fails with EPERM, don't try to create the
directory - return straight away.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 sha1_file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index ab2b520..7662330 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2231,7 +2231,7 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
 	memcpy(buffer, filename, dirlen);
 	strcpy(buffer + dirlen, "tmp_obj_XXXXXX");
 	fd = mkstemp(buffer);
-	if (fd < 0 && dirlen) {
+	if (fd < 0 && dirlen && (errno != EPERM)) {
 		/* Make sure the directory exists */
 		memcpy(buffer, filename, dirlen);
 		buffer[dirlen-1] = 0;
-- 
debian.1.5.6.1
