From: Jeff King <peff@peff.net>
Subject: [PATCH] sha1fd_check: die when we cannot open the file
Date: Wed, 18 Mar 2015 02:30:12 -0400
Message-ID: <20150318063012.GA24730@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 07:30:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY7Uj-0005dz-7g
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 07:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875AbbCRGaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 02:30:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:34439 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754591AbbCRGaP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 02:30:15 -0400
Received: (qmail 22592 invoked by uid 102); 18 Mar 2015 06:30:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 01:30:15 -0500
Received: (qmail 425 invoked by uid 107); 18 Mar 2015 06:30:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 02:30:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Mar 2015 02:30:12 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265681>

Right now we return a NULL "struct sha1file" if we encounter
an error. However, the sole caller (write_idx_file) does not
check the return value, and will segfault if we hit this
case.

One option would be to handle the error in the caller.
However, there's really nothing for it to do but die. This
code path is hit during "git index-pack --verify"; after we
verify the packfile, we check that the ".idx" we would
generate from it is byte-wise identical to what is on disk.
We hit the error (and segfault) if we can't open the .idx
file (a likely cause of this is that somebody else ran "git
repack -ad" while we were verifying). Since we can't
complete the requested verification, we really have no
choice but to die.

Furthermore, the rest of the sha1fd_* functions simply die
on errors. So if were to open the file successfully, for
example, and then hit a read error, sha1write would call
die() for us. So pushing the die() down into sha1fd_check
keeps the interface consistent.

Signed-off-by: Jeff King <peff@peff.net>
---
 csum-file.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index b00b215..a172199 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -130,14 +130,10 @@ struct sha1file *sha1fd_check(const char *name)
 
 	sink = open("/dev/null", O_WRONLY);
 	if (sink < 0)
-		return NULL;
+		die_errno("unable to open /dev/null");
 	check = open(name, O_RDONLY);
-	if (check < 0) {
-		int saved_errno = errno;
-		close(sink);
-		errno = saved_errno;
-		return NULL;
-	}
+	if (check < 0)
+		die_errno("unable to open '%s'", name);
 	f = sha1fd(sink, name);
 	f->check_fd = check;
 	return f;
-- 
2.3.3.520.g3cfbb5d
