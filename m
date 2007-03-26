From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] sha1_file.c (write_sha1_from_fd): Detect close failure.
Date: Mon, 26 Mar 2007 15:57:23 +0200
Message-ID: <874po8umyk.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 15:57:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVphQ-0006zr-0Q
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 15:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbXCZN5Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 09:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbXCZN5Z
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 09:57:25 -0400
Received: from mx.meyering.net ([82.230.74.64]:47669 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752669AbXCZN5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 09:57:24 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 3BD388EB0; Mon, 26 Mar 2007 15:57:23 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43152>

I stumbled across this in the context of the fchmod 0444 patch.
At first, I was going to unlink and call error like the two subsequent
tests do, but a failed write (above) provokes a "die", so I made
this do the same.  This is testing for a write failure, after all.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 sha1_file.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 0897b94..42aef33 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2155,7 +2155,8 @@ int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
 	inflateEnd(&stream);

 	fchmod(local, 0444);
-	close(local);
+	if (close(local) != 0)
+		die("unable to write sha1 file");
 	SHA1_Final(real_sha1, &c);
 	if (ret != Z_STREAM_END) {
 		unlink(tmpfile);
--
1.5.1.rc1.51.gb08b
