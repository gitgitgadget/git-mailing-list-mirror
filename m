From: Mike Hommey <mh@glandium.org>
Subject: Re: Why Git is so fast
Date: Fri, 1 May 2009 11:34:27 +0200
Message-ID: <20090501093427.GA13264@glandium.org>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com> <m3fxfqnxn5.fsf_-_@localhost.localdomain> <b4087cc50904300556s359c91dfu444fa40ea85bd66e@mail.gmail.com> <200904301728.06989.jnareb@gmail.com> <20090430185244.GR23604@spearce.org> <86iqkllw0c.fsf@broadpark.no> <20090430204033.GV23604@spearce.org> <8663gllt88.fsf@broadpark.no> <f488382f0904301723i37ef03d9w4e93848e603ed28b@mail.gmail.com> <864ow59o53.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Noonan <steven@uplinklabs.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Fri May 01 11:34:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzp8k-00067M-7e
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 11:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbZEAJef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 05:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753645AbZEAJef
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 05:34:35 -0400
Received: from vuizook.err.no ([85.19.221.46]:57771 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752880AbZEAJee (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 05:34:34 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1Lzp8U-0007c8-FU; Fri, 01 May 2009 11:34:29 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1Lzp8V-0003Sy-4u; Fri, 01 May 2009 11:34:27 +0200
Content-Disposition: inline
In-Reply-To: <864ow59o53.fsf@broadpark.no>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118069>

On Fri, May 01, 2009 at 11:19:04AM +0200, Kjetil Barvik wrote:
> * Steven Noonan <steven@uplinklabs.net> writes:
> | On Thu, Apr 30, 2009 at 2:36 PM, Kjetil Barvik <barvik@broadpark.no> wrote:
> |> * "Shawn O. Pearce" <spearce@spearce.org> writes:
> |> |>      4) The "static inline void hashcpy(....)" in cache.h could then
> |> |>         maybe be written like this:
> |> |
> |> | Its already done as "memcpy(a, b, 20)" which most compilers will
> |> | inline and probably reduce to 5 word moves anyway.  That's why
> |> | hashcpy() itself is inline.
> |>
> |>  But would the compiler be able to trust that the hashcpy() is always
> |>  called with correct word alignment on variables a and b?
> 
>  <snipp>
> 
> | Well, I just tested this with GCC myself. I used this segment of code:
> |
> |         #include <memory.h>
> |         void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
> |         {
> |                 memcpy(sha_dst, sha_src, 20);
> |         }
> 
>   OK, here is a smal test, which maybe shows at least one difference
>   between using "unsigned char sha1[20]" and "unsigned long sha1[5]".
>   Given the following file, memcpy_test.c:
> 
> #include <string.h>
> extern void hashcpy_uchar(unsigned char *sha_dst, const unsigned char *sha_src);
> void hashcpy_uchar(unsigned char *sha_dst, const unsigned char *sha_src)
> {
>         memcpy(sha_dst, sha_src, 20);
> }
> extern void hashcpy_ulong(unsigned long *sha_dst, const unsigned long *sha_src);
> void hashcpy_ulong(unsigned long *sha_dst, const unsigned long *sha_src)
> {
>         memcpy(sha_dst, sha_src, 5);
> }
> 
>   And, compiled with the following:
> 
>     gcc -O2 -mtune=core2 -march=core2 -S -fomit-frame-pointer memcpy_test.c
> 
>   It produced the following memcpy_test.s file:
> 
>         .file   "memcpy_test.c"
>         .text
>         .p2align 4,,15
> .globl hashcpy_ulong
>         .type   hashcpy_ulong, @function
> hashcpy_ulong:
>         movl    8(%esp), %edx
>         movl    4(%esp), %ecx
>         movl    (%edx), %eax
>         movl    %eax, (%ecx)
>         movzbl  4(%edx), %eax
>         movb    %al, 4(%ecx)
>         ret
>         .size   hashcpy_ulong, .-hashcpy_ulong
>         .p2align 4,,15
> .globl hashcpy_uchar
>         .type   hashcpy_uchar, @function
> hashcpy_uchar:
>         movl    8(%esp), %edx
>         movl    4(%esp), %ecx
>         movl    (%edx), %eax
>         movl    %eax, (%ecx)
>         movl    4(%edx), %eax
>         movl    %eax, 4(%ecx)
>         movl    8(%edx), %eax
>         movl    %eax, 8(%ecx)
>         movl    12(%edx), %eax
>         movl    %eax, 12(%ecx)
>         movl    16(%edx), %eax
>         movl    %eax, 16(%ecx)
>         ret
>         .size   hashcpy_uchar, .-hashcpy_uchar
>         .ident  "GCC: (Gentoo 4.3.3-r2 p1.1, pie-10.1.5) 4.3.3"
>         .section        .note.GNU-stack,"",@progbits
> 
>   So, the "unsigned long" type hashcpy() used 7 instructions, compared
>   to 13 for the "unsigned char" type hascpy().

But your "unsigned long" version only copies 5 bytes...

Mike
