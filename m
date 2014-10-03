From: Jeff King <peff@peff.net>
Subject: [PATCH 10/16] count-objects: do not use xsize_t when counting object
 size
Date: Fri, 3 Oct 2014 16:31:37 -0400
Message-ID: <20141003203137.GJ16293@peff.net>
References: <20141003202045.GA15205@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 22:31:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa9Vv-0002CQ-E2
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 22:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbaJCUbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 16:31:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:54849 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751317AbaJCUbj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 16:31:39 -0400
Received: (qmail 3157 invoked by uid 102); 3 Oct 2014 20:31:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 15:31:39 -0500
Received: (qmail 15115 invoked by uid 107); 3 Oct 2014 20:31:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 16:31:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2014 16:31:37 -0400
Content-Disposition: inline
In-Reply-To: <20141003202045.GA15205@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257861>

The point of xsize_t is to safely cast an off_t into a size_t
(because we are about to mmap). But in count-objects, we are
summing the sizes in an off_t. Using xsize_t means that
count-objects could fail on a 32-bit system with a 4G
object (not likely, as other parts of git would fail, but
we should at least be correct here).

Signed-off-by: Jeff King <peff@peff.net>
---
I think the on_disk_bytes is a little weird here, too. We count actual
disk-usage blocks for loose objects here, which makes sense. But we do
_not_ do so for packfiles, or for "garbage" files. Which seems kind of
inconsistent.

I kind of doubt anybody cares too much either way, though.

 builtin/count-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index a7f70cb..316a805 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -53,7 +53,7 @@ static void count_objects(DIR *d, char *path, int len, int verbose,
 			if (lstat(path, &st) || !S_ISREG(st.st_mode))
 				bad = 1;
 			else
-				(*loose_size) += xsize_t(on_disk_bytes(st));
+				(*loose_size) += on_disk_bytes(st);
 		}
 		if (bad) {
 			if (verbose) {
-- 
2.1.1.566.gdb1f904
