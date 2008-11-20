From: Joey Hess <joey@kitenet.net>
Subject: [PATCH] sha1_file: avoid bogus "file exists" error message
Date: Thu, 20 Nov 2008 13:56:28 -0500
Message-ID: <20081120185628.GA25604@kodama.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 20 19:57:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3Eir-0007Jp-Mp
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 19:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515AbYKTS4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 13:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755440AbYKTS4e
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 13:56:34 -0500
Received: from wren.kitenet.net ([80.68.85.49]:46401 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755408AbYKTS4d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 13:56:33 -0500
Received: from kodama.kitenet.net (fttu-67-223-5-142.btes.tv [67.223.5.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Joey Hess", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 7E43F31432D
	for <git@vger.kernel.org>; Thu, 20 Nov 2008 13:56:31 -0500 (EST)
Received: by kodama.kitenet.net (Postfix, from userid 1000)
	id 0CE091140F0; Thu, 20 Nov 2008 13:56:28 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.1/8653/Thu Nov 20 04:04:07 2008 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101468>

This avoids the following misleading error message:

error: unable to create temporary sha1 filename ./objects/15: File exists

mkstemp can fail for many reasons, one of which, ENOENT, can occur if
the directory for the temp file doesn't exist. create_tmpfile tried to
handle this case by always trying to mkdir the directory, even if it
already existed. This caused errno to be clobbered, so one cannot tell
why mkstemp really failed, and it truncated the buffer to just the
directory name, resulting in the strange error message shown above.

Note that in both occasions that I've seen this failure, it has not been
due to a missing directory, or bad permissions, but some other, unknown
mkstemp failure mode that did not occur when I ran git again. This code
could perhaps be made more robust by retrying mkstemp, in case it was a
transient failure.

Signed-off-by: Joey Hess <joey@kitenet.net>
---
 sha1_file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index ab2b520..927fb64 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2231,7 +2231,7 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
 	memcpy(buffer, filename, dirlen);
 	strcpy(buffer + dirlen, "tmp_obj_XXXXXX");
 	fd = mkstemp(buffer);
-	if (fd < 0 && dirlen) {
+	if (fd < 0 && dirlen && errno == ENOENT) {
 		/* Make sure the directory exists */
 		memcpy(buffer, filename, dirlen);
 		buffer[dirlen-1] = 0;
-- 
1.5.6.5
