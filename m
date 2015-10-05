From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] precompose_utf8: drop unused variable
Date: Sun, 4 Oct 2015 23:43:14 -0400
Message-ID: <20151005034313.GA25502@sigill.intra.peff.net>
References: <20151005034126.GA5639@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 05 05:43:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiwgL-0004el-9o
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 05:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbbJEDnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 23:43:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:39533 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751975AbbJEDnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 23:43:16 -0400
Received: (qmail 30174 invoked by uid 102); 5 Oct 2015 03:43:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 04 Oct 2015 22:43:16 -0500
Received: (qmail 11704 invoked by uid 107); 5 Oct 2015 03:43:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 04 Oct 2015 23:43:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Oct 2015 23:43:14 -0400
Content-Disposition: inline
In-Reply-To: <20151005034126.GA5639@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279031>

The result of iconv is assigned to a variable, but we never
use it (instead, we check errno and whether the function
consumed all bytes). Let's drop the assignment, as it
triggers gcc's -Wunused-but-set-variable.

Signed-off-by: Jeff King <peff@peff.net>
---
This is obviously completely optional; I just needed it to get the
"precompose on Linux" hack to build at all with my usual "-Wall -Werror"
settings. I guess clang doesn't have a similar warning, or maybe people
on Macs are not as pedantic as I am.

 compat/precompose_utf8.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 95fe849..044c686 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -139,9 +139,8 @@ struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
 				size_t inleft = namelenz;
 				char *outpos = &prec_dir->dirent_nfc->d_name[0];
 				size_t outsz = prec_dir->dirent_nfc->max_name_len;
-				size_t cnt;
 				errno = 0;
-				cnt = iconv(prec_dir->ic_precompose, &cp, &inleft, &outpos, &outsz);
+				iconv(prec_dir->ic_precompose, &cp, &inleft, &outpos, &outsz);
 				if (errno || inleft) {
 					/*
 					 * iconv() failed and errno could be E2BIG, EILSEQ, EINVAL, EBADF
-- 
2.6.0.455.ga3f9923
