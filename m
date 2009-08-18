From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 12:43:08 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908181240400.6044@xanadu.home>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com>
 <4A8AA511.1060205@gmail.com>
 <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com>
 <7v4os5gs0p.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0908181147510.6044@xanadu.home>
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
X-From: git-owner@vger.kernel.org Tue Aug 18 18:43:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdRmL-0006J5-Jd
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 18:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759305AbZHRQnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 12:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759113AbZHRQnN
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 12:43:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28906 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908AbZHRQnM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 12:43:12 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOK00BGMZRW79E0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 18 Aug 2009 12:43:08 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.00.0908181147510.6044@xanadu.home>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126412>

On Tue, 18 Aug 2009, Nicolas Pitre wrote:

> Well...  Given that git already uses ntohl/htonl quite extensively in 
> its core already, I'd suggest making this more globally available 
> instead.

What about something like this?

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 464cb25..51a27c1 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -4,9 +4,7 @@
  * and to avoid unnecessary copies into the context array.
  */
 
-#include <string.h>
-#include <arpa/inet.h>
-
+#include "../git-compat-util.h"
 #include "sha1.h"
 
 #if defined(__i386__) || defined(__x86_64__)
diff --git a/compat/bswap.h b/compat/bswap.h
new file mode 100644
index 0000000..b436360
--- /dev/null
+++ b/compat/bswap.h
@@ -0,0 +1,19 @@
+/*
+ * Let's make sure we always have a sane definition for ntohl()/htonl().
+ * Some libraries define those as a function call, just to perform byte
+ * shifting, bringing significant overhead to what should be a sinple
+ * operation.
+ */
+
+#if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
+
+#define bswap32(x) ({ \
+	unsigned int __res; \
+	__asm__("bswap %0" : "=r" (__res) : "0" (x)); \
+	__res; })
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
