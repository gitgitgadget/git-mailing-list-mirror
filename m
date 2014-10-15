From: Jeff King <peff@peff.net>
Subject: [PATCH v2 11/25] count-objects: do not use xsize_t when counting
 object size
Date: Wed, 15 Oct 2014 18:40:58 -0400
Message-ID: <20141015224058.GK25630@peff.net>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:41:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeXFj-0007uj-DD
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbaJOWlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:41:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:58968 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750721AbaJOWlB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:41:01 -0400
Received: (qmail 2450 invoked by uid 102); 15 Oct 2014 22:41:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:41:01 -0500
Received: (qmail 28049 invoked by uid 107); 15 Oct 2014 22:41:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:41:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:40:58 -0400
Content-Disposition: inline
In-Reply-To: <20141015223244.GA25368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The point of xsize_t is to safely cast an off_t into a size_t
(because we are about to mmap). But in count-objects, we are
summing the sizes in an off_t. Using xsize_t means that
count-objects could fail on a 32-bit system with a 4G
object (not likely, as other parts of git would fail, but
we should at least be correct here).

Signed-off-by: Jeff King <peff@peff.net>
---
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
2.1.2.596.g7379948
