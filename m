From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 09:43:43 -0700
Message-ID: <7v63clf4xs.fsf@alter.siamese.dyndns.org>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com>
 <4A8AA511.1060205@gmail.com>
 <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com>
 <7v4os5gs0p.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0908180836440.3162@localhost.localdomain>
 <alpine.LFD.2.01.0908180906441.3162@localhost.localdomain>
 <bdca99240908180923x49213f30q79cf9424c6aa8202@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>, Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 18:44:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdRn5-0006Zg-6A
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 18:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759335AbZHRQny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 12:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759329AbZHRQny
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 12:43:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39548 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759237AbZHRQnx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 12:43:53 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 89B81FD69;
	Tue, 18 Aug 2009 12:43:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2427FFD64; Tue, 18 Aug
 2009 12:43:44 -0400 (EDT)
In-Reply-To: <bdca99240908180923x49213f30q79cf9424c6aa8202@mail.gmail.com>
 (Sebastian Schuberth's message of "Tue\, 18 Aug 2009 18\:23\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 51197B60-8C16-11DE-892D-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126413>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Tue, Aug 18, 2009 at 18:08, Linus
> Torvalds<torvalds@linux-foundation.org> wrote:
>
>>> I'd suggest not using a gcc builtin, since if you're using gcc you might
>>> as well just use inline asm that has been around forever (unlike the
>>> builtin).
>>
>> That seems to be what glibc does too.
>>
>> Here's a patch.
>
> Looks good to me, compiles & runs fine on Windows (with Hannes' patch
> also applied).

But the Windows part that avoids arpa/inet.h and includes winsock2.h, only
to undef the two macros immediately after doing so, now looks quite silly.
Are there non i386/amd64 Windows we care about?

Squashing Linus's and Hannes's patch here is what I came up with.

-- >8 --
block-sha1: avoid potentially inefficient ntohl/htonl on i386/x86-64

Johannes Sixt reports that on Windows ntohl()/htonl() are not found in
<arpa/inet.h>, and minimally we need to include <winsock2.h> instead.
Sebastian Schuberth points out that they are implemented as out-of-line
functions on Windows, which defeats the use of these byteorder "macros"
for performance.

Use bswap instruction through gcc inline asm instead on i386/x86-64
as a generic solution to this.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>,
---
diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index a1228cf..fa909a3 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -7,8 +7,6 @@
  */
 
 #include <string.h>
-#include <arpa/inet.h>
-
 #include "sha1.h"
 
 #if defined(__i386__) || defined(__x86_64__)
@@ -24,8 +22,15 @@
 #define SHA_ROL(x,n)	SHA_ASM("rol", x, n)
 #define SHA_ROR(x,n)	SHA_ASM("ror", x, n)
 
+#undef htonl
+#undef ntohl
+#define htonl(x) ({ unsigned int __res; __asm__("bswap %0":"=r" (__res):"0" (x)); __res; })
+#define ntohl(x) htonl(x)
+
 #else
 
+#include <arpa/inet.h>
+
 #define SHA_ROT(X,l,r)	(((X) << (l)) | ((X) >> (r)))
 #define SHA_ROL(X,n)	SHA_ROT(X,n,32-(n))
 #define SHA_ROR(X,n)	SHA_ROT(X,32-(n),n)
