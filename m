From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 13:17:57 -0700
Message-ID: <7vprasc1vu.fsf@alter.siamese.dyndns.org>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com>
 <4A8AA511.1060205@gmail.com>
 <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com>
 <7v4os5gs0p.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0908181147510.6044@xanadu.home>
 <alpine.LFD.2.00.0908181240400.6044@xanadu.home>
 <bdca99240908180959h69f37671k4d526fbf4814e8d1@mail.gmail.com>
 <7vpratdpc8.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0908181411320.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 22:18:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdV8N-0007qt-GU
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 22:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbZHRUSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 16:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbZHRUSJ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 16:18:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45484 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbZHRUSI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 16:18:08 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 76BC5FDAA;
	Tue, 18 Aug 2009 16:18:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07802FDA4; Tue, 18 Aug
 2009 16:17:58 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3EA2EC00-8C34-11DE-956F-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126448>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 18 Aug 2009, Junio C Hamano wrote:
>
>> To reduce confusion, you may want to rename compat/bswap.h to something
>> like compat/ntohl-htonl-fix.h ;-)
>
> Bah.  If you wish, you can edit the patch directly for this, unless you 
> really prefer me to repost.  Maybe we might want to add a 8-byte 
> versions of those as well eventually, which is why I chose a more 
> generic name.

Ok, here is what I came up with after many squashing...

-- >8 --
From: Nicolas Pitre <nico@cam.org>
Date: Tue, 18 Aug 2009 12:43:08 -0400
Subject: [PATCH] bswap: avoid potentially inefficient ntohl/htonl on i386/x86-64

Johannes Sixt reports that on Windows ntohl()/htonl() are not found in
<arpa/inet.h>, and as a minimal fix we need to include <winsock2.h>
instead.  Sebastian Schuberth points out that they are implemented as
out-of-line functions on Windows, which defeats these byteorder "macros"
used for performance.

Use bswap instruction through gcc inline asm instead on i386/x86-64
as a generic solution to this.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Nicolas Pitre <nico@cam.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 block-sha1/sha1.c |    4 +---
 compat/bswap.h    |   19 +++++++++++++++++++
 git-compat-util.h |    2 ++
 3 files changed, 22 insertions(+), 3 deletions(-)
 create mode 100644 compat/bswap.h

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
index 0000000..78fd2df
--- /dev/null
+++ b/compat/bswap.h
@@ -0,0 +1,19 @@
+/*
+ * Let's make sure we always have a sane definition for ntohl()/htonl().
+ * Some libraries define those as a function call, just to perform byte
+ * swapping, bringing significant overhead to what should be a simple
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
-- 
1.6.4.245.g50659
