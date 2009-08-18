From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] make sure byte swapping is optimal for git
Date: Tue, 18 Aug 2009 15:26:55 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908181523430.6044@xanadu.home>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com>
 <4A8AA511.1060205@gmail.com>
 <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com>
 <7v4os5gs0p.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0908181147510.6044@xanadu.home>
 <alpine.LFD.2.00.0908181240400.6044@xanadu.home>
 <7v1vn9f4mz.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0908181357330.6044@xanadu.home>
 <7vk511dk11.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0908181516510.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 21:27:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdUKt-0000WO-BS
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 21:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbZHRT1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 15:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbZHRT07
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 15:26:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41451 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbZHRT07 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 15:26:59 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOL003PF6U7M910@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 18 Aug 2009 15:15:43 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.00.0908181516510.6044@xanadu.home>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126441>

We rely on ntohl() and htonl() to perform byte swapping in many places.
However, some platforms have libraries providing really poor
implementations of those which might cause significant performance
issues, especially with the block-sha1 code.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

On Tue, 18 Aug 2009, Nicolas Pitre wrote:

> Well, I gave in and added a comment to the patch anyway, with more 
> improvements in the case of constant values.  Patch follows.

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 464cb25..d31f2e3 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -4,8 +4,8 @@
  * and to avoid unnecessary copies into the context array.
  */
 
-#include <string.h>
-#include <arpa/inet.h>
+/* this is only to get definitions for memcpy(), ntohl() and htonl() */
+#include "../git-compat-util.h"
 
 #include "sha1.h"
 
diff --git a/compat/bswap.h b/compat/bswap.h
new file mode 100644
index 0000000..7246a12
--- /dev/null
+++ b/compat/bswap.h
@@ -0,0 +1,36 @@
+/*
+ * Let's make sure we always have a sane definition for ntohl()/htonl().
+ * Some libraries define those as a function call, just to perform byte
+ * shifting, bringing significant overhead to what should be a simple
+ * operation.
+ */
+
+/*
+ * Default version that the compiler ought to optimize properly with
+ * constant values.
+ */
+static inline unsigned int default_swab32(unsigned int val)
+{
+	return (((val & 0xff000000) >> 24) |
+		((val & 0x00ff0000) >>  8) |
+		((val & 0x0000ff00) <<  8) |
+		((val & 0x000000ff) << 24));
+}
+
+#if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
+
+#define bswap32(x) ({ \
+	unsigned int __res; \
+	if (__builtin_constant_p(x)) { \
+		__res = default_swab32(x); \
+	} else { \
+		__asm__("bswap %0" : "=r" (__res) : "0" (x)); \
+	} \
+	__res; })
+
+#undef ntohl
+#undef htonl
+#define ntohl(x) bswap32(x)
+#define htonl(x) bswap32(x)
+
+#endif
diff --git a/git-compat-util.h b/git-compat-util.h
index 9f941e4..000859e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -176,6 +176,8 @@ extern char *gitbasename(char *);
 #endif
 #endif
 
+#include "compat/bswap.h"
+
 /* General helper functions */
 extern void usage(const char *err) NORETURN;
 extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
