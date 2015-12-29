From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] bswap: add NO_UNALIGNED_LOADS define
Date: Tue, 29 Dec 2015 01:36:00 -0500
Message-ID: <20151229063600.GB30340@sigill.intra.peff.net>
References: <20151229063449.GA28755@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 07:36:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDntA-0000Ui-RM
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 07:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbbL2GgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 01:36:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:46539 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751097AbbL2GgD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 01:36:03 -0500
Received: (qmail 15725 invoked by uid 102); 29 Dec 2015 06:36:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 00:36:03 -0600
Received: (qmail 18842 invoked by uid 107); 29 Dec 2015 06:36:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:36:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 01:36:00 -0500
Content-Disposition: inline
In-Reply-To: <20151229063449.GA28755@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283076>

The byte-swapping code automatically decides, based on the
platform, whether it is sensible to cast an do a potentially
unaligned ntohl(), or to pick individual bytes out of an
array.

It can be handy to override this decision, though, when
turning on compiler flags that will complain about unaligned
loads (such as -fsanitize=undefined). This patch adds a
macro check to make this possible.

There's no nice Makefile knob here; this is for prodding at
Git's internals, and anybody using it can set
"-DNO_UNALIGNED_LOADS" in the same place they are setting up
"-fsanitize".

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/bswap.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index 7fed637..d47c003 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -149,11 +149,12 @@ static inline uint64_t git_bswap64(uint64_t x)
  * and is faster on architectures with memory alignment issues.
  */
 
-#if defined(__i386__) || defined(__x86_64__) || \
+#if !defined(NO_UNALIGNED_LOADS) && ( \
+    defined(__i386__) || defined(__x86_64__) || \
     defined(_M_IX86) || defined(_M_X64) || \
     defined(__ppc__) || defined(__ppc64__) || \
     defined(__powerpc__) || defined(__powerpc64__) || \
-    defined(__s390__) || defined(__s390x__)
+    defined(__s390__) || defined(__s390x__))
 
 #define get_be16(p)	ntohs(*(unsigned short *)(p))
 #define get_be32(p)	ntohl(*(unsigned int *)(p))
-- 
2.7.0.rc2.368.g1cbb535
