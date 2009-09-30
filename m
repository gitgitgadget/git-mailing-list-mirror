From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] Fix some printf format warnings
Date: Wed, 30 Sep 2009 19:49:24 +0100
Message-ID: <4AC3A834.6070208@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: nico@fluxnic.net, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 01 19:52:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtPpK-0001X8-6E
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 19:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728AbZJARwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 13:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753411AbZJARwQ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 13:52:16 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:43314 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752822AbZJARwP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Oct 2009 13:52:15 -0400
X-Greylist: delayed 2179 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Oct 2009 13:52:15 EDT
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1MtPG3-0003Yy-nN; Thu, 01 Oct 2009 17:16:00 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129405>


commit 51ea551 ("make sure byte swapping is optimal for git"
2009-08-18) introduced a "sane definition for ntohl()/htonl()"
for use on some GNU C platforms. Unfortunately, for some of
these platforms, this results in the introduction of a problem
which is essentially the reverse of a problem that commit 6e1c234
("Fix some warnings (on cygwin) to allow -Werror" 2008-07-3) was
intended to fix.

In particular, on platforms where the uint32_t type is defined
to be unsigned long, the return type of the new ntohl()/htonl()
is causing gcc to issue printf format warnings, such as:

    warning: long unsigned int format, unsigned int arg (arg 3)

(nine such warnings, covering six different files). The earlier
commit (6e1c234) needed to suppress these same warnings, except
that the types were in the opposite direction; namely the format
specifier ("%u") was 'unsigned int' and the argument type (ie the
return type of ntohl()) was 'long unsigned int' (aka uint32_t).

In order to suppress these warnings, the earlier commit used the
(C99) PRIu32 format specifier, since the definition of this macro
is suitable for use with the uint32_t type on that platform.
This worked because the return type of the (original) platform
ntohl()/htonl() functions was uint32_t.

In order to suppress these warnings, we change the return type of
the new byte swapping functions in the compat/bswap.h header file
from 'unsigned int' to uint32_t.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/bswap.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index 7246a12..5cc4acb 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -9,7 +9,7 @@
  * Default version that the compiler ought to optimize properly with
  * constant values.
  */
-static inline unsigned int default_swab32(unsigned int val)
+static inline uint32_t default_swab32(uint32_t val)
 {
 	return (((val & 0xff000000) >> 24) |
 		((val & 0x00ff0000) >>  8) |
@@ -20,7 +20,7 @@ static inline unsigned int default_swab32(unsigned int val)
 #if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
 
 #define bswap32(x) ({ \
-	unsigned int __res; \
+	uint32_t __res; \
 	if (__builtin_constant_p(x)) { \
 		__res = default_swab32(x); \
 	} else { \
-- 
1.6.4
