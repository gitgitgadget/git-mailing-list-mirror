From: "George Spelvin" <linux@horizon.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: 4 Aug 2009 00:48:42 -0400
Message-ID: <20090804044842.6792.qmail@science.horizon.com>
References: <alpine.LFD.2.01.0908031924230.3270@localhost.localdomain>
Cc: git@vger.kernel.org, linux@horizon.com
To: torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Tue Aug 04 06:49:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYBxT-0002Ie-Rc
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 06:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbZHDEsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 00:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753638AbZHDEsq
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 00:48:46 -0400
Received: from science.horizon.com ([71.41.210.146]:33751 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753567AbZHDEso (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 00:48:44 -0400
Received: (qmail 6793 invoked by uid 1000); 4 Aug 2009 00:48:42 -0400
In-Reply-To: <alpine.LFD.2.01.0908031924230.3270@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124748>

> It would be better to have a more git-centric benchmark that actually 
> shows some real git load, rather than a sha1-only microbenchmark.
> 
> The thing that I'd prefer is simply
>
>	git fsck --full
>
> on the Linux kernel archive. For me (with a fast machine), it takes about 
> 4m30s with the OpenSSL SHA1, and takes 6m40s with the Mozilla SHA1 (ie 
> using a NO_OPENSSL=1 build).

The actual goal of this effort is to address the dynamic linker startup
time issues by removing the second-largest contributor after libcurl,
namely openssl.  Optimizing the assembly code is just the fun part. ;-)

Anyway, on the git repository:

[1273]$ time x/git-fsck --full			(New SHA1 code)
dangling tree 524973049a7e4593df4af41e0564912f678a41ac
dangling tree 7da7d73185a1df5c2a477d2ee5599ac8a58cad56

real    0m59.306s
user    0m58.760s
sys     0m0.550s
[1274]$ time ./git-fsck --full			(OpenSSL)
dangling tree 524973049a7e4593df4af41e0564912f678a41ac
dangling tree 7da7d73185a1df5c2a477d2ee5599ac8a58cad56

real    1m0.364s
user    0m59.970s
sys     0m0.400s

1.6% is a pretty minor difference, especially as the machine is running
a backup at the time (but it's a quad-core, with near-zero CPU usage;
the business is all I/O).

On the full Linux repository, I repacked it first to make sure that
everything was in RAM, and I have the first result:

[517]$ time ~/git/x/git-fsck --full		(New SHA1 code)

real    10m12.702s
user    9m48.410s
sys     0m23.350s
[518]$ time ~/git/git-fsck --full		(OpenSSL)

real    10m26.083s
user    10m2.800s
sys     0m22.000s

Again, 2.2% is not a huge improvement.  But my only goal was not to be worse.

> So that's an example of a load that is actually very sensitive to SHA1 
> performance (more so than _most_ git loads, I suspect), and at the same 
> time is a real git load rather than some SHA1-only microbenchmark. It also 
> shows very clearly why we default to the OpenSSL version over the Mozilla 
> one.

I wasn't questioning *that*.  As I said, I was just doing the fun part
of importing a heavily-optimized OpenSSL-like SHA1 implementation into
the git source tree.

(The un-fun part is modifying the build process to detect the target
processor and include the right asm automatically.)

Anyway, if you want to test it, here's a crude x86_32-only patch to the
git tree.  "make NO_OPENSSL=1" to use the new code.

diff --git a/Makefile b/Makefile
index daf4296..8531c39 100644
--- a/Makefile
+++ b/Makefile
@@ -1176,8 +1176,10 @@ ifdef ARM_SHA1
 	LIB_OBJS += arm/sha1.o arm/sha1_arm.o
 else
 ifdef MOZILLA_SHA1
-	SHA1_HEADER = "mozilla-sha1/sha1.h"
-	LIB_OBJS += mozilla-sha1/sha1.o
+#	SHA1_HEADER = "mozilla-sha1/sha1.h"
+#	LIB_OBJS += mozilla-sha1/sha1.o
+	SHA1_HEADER = "x86/sha1.h"
+	LIB_OBJS += x86/sha1.o x86/sha1-x86.o
 else
 	SHA1_HEADER = <openssl/sha.h>
 	EXTLIBS += $(LIB_4_CRYPTO)
diff --git a/x86/sha1-x86.s b/x86/sha1-x86.s
new file mode 100644
index 0000000..96796d4
--- /dev/null
+++ b/x86/sha1-x86.s
@@ -0,0 +1,1372 @@
+.file	"sha1-586.s"
+.text
+.globl	sha1_block_data_order
+.type	sha1_block_data_order,@function
+.align	16
+sha1_block_data_order:
+	pushl	%ebp
+	pushl	%ebx
+	pushl	%esi
+	pushl	%edi
+	movl	20(%esp),%edi
+	movl	24(%esp),%esi
+	movl	28(%esp),%eax
+	subl	$64,%esp
+	shll	$6,%eax
+	addl	%esi,%eax
+	movl	%eax,92(%esp)
+	movl	16(%edi),%ebp
+	movl	12(%edi),%edx
+.align	16
+.L000loop:
+	movl	(%esi),%ecx
+	movl	4(%esi),%ebx
+	bswap	%ecx
+	movl	8(%esi),%eax
+	bswap	%ebx
+	movl	%ecx,(%esp)
+	movl	12(%esi),%ecx
+	bswap	%eax
+	movl	%ebx,4(%esp)
+	movl	16(%esi),%ebx
+	bswap	%ecx
+	movl	%eax,8(%esp)
+	movl	20(%esi),%eax
+	bswap	%ebx
+	movl	%ecx,12(%esp)
+	movl	24(%esi),%ecx
+	bswap	%eax
+	movl	%ebx,16(%esp)
+	movl	28(%esi),%ebx
+	bswap	%ecx
+	movl	%eax,20(%esp)
+	movl	32(%esi),%eax
+	bswap	%ebx
+	movl	%ecx,24(%esp)
+	movl	36(%esi),%ecx
+	bswap	%eax
+	movl	%ebx,28(%esp)
+	movl	40(%esi),%ebx
+	bswap	%ecx
+	movl	%eax,32(%esp)
+	movl	44(%esi),%eax
+	bswap	%ebx
+	movl	%ecx,36(%esp)
+	movl	48(%esi),%ecx
+	bswap	%eax
+	movl	%ebx,40(%esp)
+	movl	52(%esi),%ebx
+	bswap	%ecx
+	movl	%eax,44(%esp)
+	movl	56(%esi),%eax
+	bswap	%ebx
+	movl	%ecx,48(%esp)
+	movl	60(%esi),%ecx
+	bswap	%eax
+	movl	%ebx,52(%esp)
+	bswap	%ecx
+	movl	%eax,56(%esp)
+	movl	%ecx,60(%esp)
+	movl	%esi,88(%esp)
+	movl	8(%edi),%ecx
+	movl	4(%edi),%ebx
+	movl	(%edi),%eax
+	/* 00_15 0 */
+	movl	%edx,%edi
+	movl	(%esp),%esi
+	xorl	%ecx,%edi
+	andl	%ebx,%edi
+	rorl	$2,%ebx
+	leal	1518500249(%ebp,%esi,1),%ebp
+	movl	%eax,%esi
+	xorl	%edx,%edi
+	roll	$5,%esi
+	addl	%edi,%ebp
+	movl	%ecx,%edi
+	addl	%esi,%ebp
+	/* 00_15 1 */
+	movl	4(%esp),%esi
+	xorl	%ebx,%edi
+	andl	%eax,%edi
+	rorl	$2,%eax
+	leal	1518500249(%edx,%esi,1),%edx
+	movl	%ebp,%esi
+	xorl	%ecx,%edi
+	roll	$5,%esi
+	addl	%edi,%edx
+	movl	%ebx,%edi
+	addl	%esi,%edx
+	/* 00_15 2 */
+	movl	8(%esp),%esi
+	xorl	%eax,%edi
+	andl	%ebp,%edi
+	rorl	$2,%ebp
+	leal	1518500249(%ecx,%esi,1),%ecx
+	movl	%edx,%esi
+	xorl	%ebx,%edi
+	roll	$5,%esi
+	addl	%edi,%ecx
+	movl	%eax,%edi
+	addl	%esi,%ecx
+	/* 00_15 3 */
+	movl	12(%esp),%esi
+	xorl	%ebp,%edi
+	andl	%edx,%edi
+	rorl	$2,%edx
+	leal	1518500249(%ebx,%esi,1),%ebx
+	movl	%ecx,%esi
+	xorl	%eax,%edi
+	roll	$5,%esi
+	addl	%edi,%ebx
+	movl	%ebp,%edi
+	addl	%esi,%ebx
+	/* 00_15 4 */
+	movl	16(%esp),%esi
+	xorl	%edx,%edi
+	andl	%ecx,%edi
+	rorl	$2,%ecx
+	leal	1518500249(%eax,%esi,1),%eax
+	movl	%ebx,%esi
+	xorl	%ebp,%edi
+	roll	$5,%esi
+	addl	%edi,%eax
+	movl	%edx,%edi
+	addl	%esi,%eax
+	/* 00_15 5 */
+	movl	20(%esp),%esi
+	xorl	%ecx,%edi
+	andl	%ebx,%edi
+	rorl	$2,%ebx
+	leal	1518500249(%ebp,%esi,1),%ebp
+	movl	%eax,%esi
+	xorl	%edx,%edi
+	roll	$5,%esi
+	addl	%edi,%ebp
+	movl	%ecx,%edi
+	addl	%esi,%ebp
+	/* 00_15 6 */
+	movl	24(%esp),%esi
+	xorl	%ebx,%edi
+	andl	%eax,%edi
+	rorl	$2,%eax
+	leal	1518500249(%edx,%esi,1),%edx
+	movl	%ebp,%esi
+	xorl	%ecx,%edi
+	roll	$5,%esi
+	addl	%edi,%edx
+	movl	%ebx,%edi
+	addl	%esi,%edx
+	/* 00_15 7 */
+	movl	28(%esp),%esi
+	xorl	%eax,%edi
+	andl	%ebp,%edi
+	rorl	$2,%ebp
+	leal	1518500249(%ecx,%esi,1),%ecx
+	movl	%edx,%esi
+	xorl	%ebx,%edi
+	roll	$5,%esi
+	addl	%edi,%ecx
+	movl	%eax,%edi
+	addl	%esi,%ecx
+	/* 00_15 8 */
+	movl	32(%esp),%esi
+	xorl	%ebp,%edi
+	andl	%edx,%edi
+	rorl	$2,%edx
+	leal	1518500249(%ebx,%esi,1),%ebx
+	movl	%ecx,%esi
+	xorl	%eax,%edi
+	roll	$5,%esi
+	addl	%edi,%ebx
+	movl	%ebp,%edi
+	addl	%esi,%ebx
+	/* 00_15 9 */
+	movl	36(%esp),%esi
+	xorl	%edx,%edi
+	andl	%ecx,%edi
+	rorl	$2,%ecx
+	leal	1518500249(%eax,%esi,1),%eax
+	movl	%ebx,%esi
+	xorl	%ebp,%edi
+	roll	$5,%esi
+	addl	%edi,%eax
+	movl	%edx,%edi
+	addl	%esi,%eax
+	/* 00_15 10 */
+	movl	40(%esp),%esi
+	xorl	%ecx,%edi
+	andl	%ebx,%edi
+	rorl	$2,%ebx
+	leal	1518500249(%ebp,%esi,1),%ebp
+	movl	%eax,%esi
+	xorl	%edx,%edi
+	roll	$5,%esi
+	addl	%edi,%ebp
+	movl	%ecx,%edi
+	addl	%esi,%ebp
+	/* 00_15 11 */
+	movl	44(%esp),%esi
+	xorl	%ebx,%edi
+	andl	%eax,%edi
+	rorl	$2,%eax
+	leal	1518500249(%edx,%esi,1),%edx
+	movl	%ebp,%esi
+	xorl	%ecx,%edi
+	roll	$5,%esi
+	addl	%edi,%edx
+	movl	%ebx,%edi
+	addl	%esi,%edx
+	/* 00_15 12 */
+	movl	48(%esp),%esi
+	xorl	%eax,%edi
+	andl	%ebp,%edi
+	rorl	$2,%ebp
+	leal	1518500249(%ecx,%esi,1),%ecx
+	movl	%edx,%esi
+	xorl	%ebx,%edi
+	roll	$5,%esi
+	addl	%edi,%ecx
+	movl	%eax,%edi
+	addl	%esi,%ecx
+	/* 00_15 13 */
+	movl	52(%esp),%esi
+	xorl	%ebp,%edi
+	andl	%edx,%edi
+	rorl	$2,%edx
+	leal	1518500249(%ebx,%esi,1),%ebx
+	movl	%ecx,%esi
+	xorl	%eax,%edi
+	roll	$5,%esi
+	addl	%edi,%ebx
+	movl	%ebp,%edi
+	addl	%esi,%ebx
+	/* 00_15 14 */
+	movl	56(%esp),%esi
+	xorl	%edx,%edi
+	andl	%ecx,%edi
+	rorl	$2,%ecx
+	leal	1518500249(%eax,%esi,1),%eax
+	movl	%ebx,%esi
+	xorl	%ebp,%edi
+	roll	$5,%esi
+	addl	%edi,%eax
+	movl	%edx,%edi
+	addl	%esi,%eax
+	/* 00_15 15 */
+	movl	60(%esp),%esi
+	xorl	%ecx,%edi
+	andl	%ebx,%edi
+	rorl	$2,%ebx
+	leal	1518500249(%ebp,%esi,1),%ebp
+	xorl	%edx,%edi
+	movl	(%esp),%esi
+	addl	%edi,%ebp
+	movl	%eax,%edi
+	xorl	8(%esp),%esi
+	roll	$5,%edi
+	xorl	32(%esp),%esi
+	/* 16_19 16 */
+	xorl	52(%esp),%esi
+	addl	%edi,%ebp
+	movl	%ecx,%edi
+	roll	$1,%esi
+	xorl	%ebx,%edi
+	movl	%esi,(%esp)
+	andl	%eax,%edi
+	rorl	$2,%eax
+	leal	1518500249(%edx,%esi,1),%edx
+	movl	4(%esp),%esi
+	xorl	%ecx,%edi
+	xorl	12(%esp),%esi
+	addl	%edi,%edx
+	movl	%ebp,%edi
+	xorl	36(%esp),%esi
+	roll	$5,%edi
+	/* 16_19 17 */
+	xorl	56(%esp),%esi
+	addl	%edi,%edx
+	movl	%ebx,%edi
+	roll	$1,%esi
+	xorl	%eax,%edi
+	movl	%esi,4(%esp)
+	andl	%ebp,%edi
+	rorl	$2,%ebp
+	leal	1518500249(%ecx,%esi,1),%ecx
+	movl	8(%esp),%esi
+	xorl	%ebx,%edi
+	xorl	16(%esp),%esi
+	addl	%edi,%ecx
+	movl	%edx,%edi
+	xorl	40(%esp),%esi
+	roll	$5,%edi
+	/* 16_19 18 */
+	xorl	60(%esp),%esi
+	addl	%edi,%ecx
+	movl	%eax,%edi
+	roll	$1,%esi
+	xorl	%ebp,%edi
+	movl	%esi,8(%esp)
+	andl	%edx,%edi
+	rorl	$2,%edx
+	leal	1518500249(%ebx,%esi,1),%ebx
+	movl	12(%esp),%esi
+	xorl	%eax,%edi
+	xorl	20(%esp),%esi
+	addl	%edi,%ebx
+	movl	%ecx,%edi
+	xorl	44(%esp),%esi
+	roll	$5,%edi
+	/* 16_19 19 */
+	xorl	(%esp),%esi
+	addl	%edi,%ebx
+	movl	%ebp,%edi
+	roll	$1,%esi
+	xorl	%edx,%edi
+	movl	%esi,12(%esp)
+	andl	%ecx,%edi
+	rorl	$2,%ecx
+	leal	1518500249(%eax,%esi,1),%eax
+	movl	16(%esp),%esi
+	xorl	%ebp,%edi
+	xorl	24(%esp),%esi
+	addl	%edi,%eax
+	movl	%ebx,%edi
+	xorl	48(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 20 */
+	xorl	4(%esp),%esi
+	addl	%edi,%eax
+	roll	$1,%esi
+	movl	%edx,%edi
+	movl	%esi,16(%esp)
+	xorl	%ebx,%edi
+	rorl	$2,%ebx
+	leal	1859775393(%ebp,%esi,1),%ebp
+	movl	20(%esp),%esi
+	xorl	%ecx,%edi
+	xorl	28(%esp),%esi
+	addl	%edi,%ebp
+	movl	%eax,%edi
+	xorl	52(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 21 */
+	xorl	8(%esp),%esi
+	addl	%edi,%ebp
+	roll	$1,%esi
+	movl	%ecx,%edi
+	movl	%esi,20(%esp)
+	xorl	%eax,%edi
+	rorl	$2,%eax
+	leal	1859775393(%edx,%esi,1),%edx
+	movl	24(%esp),%esi
+	xorl	%ebx,%edi
+	xorl	32(%esp),%esi
+	addl	%edi,%edx
+	movl	%ebp,%edi
+	xorl	56(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 22 */
+	xorl	12(%esp),%esi
+	addl	%edi,%edx
+	roll	$1,%esi
+	movl	%ebx,%edi
+	movl	%esi,24(%esp)
+	xorl	%ebp,%edi
+	rorl	$2,%ebp
+	leal	1859775393(%ecx,%esi,1),%ecx
+	movl	28(%esp),%esi
+	xorl	%eax,%edi
+	xorl	36(%esp),%esi
+	addl	%edi,%ecx
+	movl	%edx,%edi
+	xorl	60(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 23 */
+	xorl	16(%esp),%esi
+	addl	%edi,%ecx
+	roll	$1,%esi
+	movl	%eax,%edi
+	movl	%esi,28(%esp)
+	xorl	%edx,%edi
+	rorl	$2,%edx
+	leal	1859775393(%ebx,%esi,1),%ebx
+	movl	32(%esp),%esi
+	xorl	%ebp,%edi
+	xorl	40(%esp),%esi
+	addl	%edi,%ebx
+	movl	%ecx,%edi
+	xorl	(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 24 */
+	xorl	20(%esp),%esi
+	addl	%edi,%ebx
+	roll	$1,%esi
+	movl	%ebp,%edi
+	movl	%esi,32(%esp)
+	xorl	%ecx,%edi
+	rorl	$2,%ecx
+	leal	1859775393(%eax,%esi,1),%eax
+	movl	36(%esp),%esi
+	xorl	%edx,%edi
+	xorl	44(%esp),%esi
+	addl	%edi,%eax
+	movl	%ebx,%edi
+	xorl	4(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 25 */
+	xorl	24(%esp),%esi
+	addl	%edi,%eax
+	roll	$1,%esi
+	movl	%edx,%edi
+	movl	%esi,36(%esp)
+	xorl	%ebx,%edi
+	rorl	$2,%ebx
+	leal	1859775393(%ebp,%esi,1),%ebp
+	movl	40(%esp),%esi
+	xorl	%ecx,%edi
+	xorl	48(%esp),%esi
+	addl	%edi,%ebp
+	movl	%eax,%edi
+	xorl	8(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 26 */
+	xorl	28(%esp),%esi
+	addl	%edi,%ebp
+	roll	$1,%esi
+	movl	%ecx,%edi
+	movl	%esi,40(%esp)
+	xorl	%eax,%edi
+	rorl	$2,%eax
+	leal	1859775393(%edx,%esi,1),%edx
+	movl	44(%esp),%esi
+	xorl	%ebx,%edi
+	xorl	52(%esp),%esi
+	addl	%edi,%edx
+	movl	%ebp,%edi
+	xorl	12(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 27 */
+	xorl	32(%esp),%esi
+	addl	%edi,%edx
+	roll	$1,%esi
+	movl	%ebx,%edi
+	movl	%esi,44(%esp)
+	xorl	%ebp,%edi
+	rorl	$2,%ebp
+	leal	1859775393(%ecx,%esi,1),%ecx
+	movl	48(%esp),%esi
+	xorl	%eax,%edi
+	xorl	56(%esp),%esi
+	addl	%edi,%ecx
+	movl	%edx,%edi
+	xorl	16(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 28 */
+	xorl	36(%esp),%esi
+	addl	%edi,%ecx
+	roll	$1,%esi
+	movl	%eax,%edi
+	movl	%esi,48(%esp)
+	xorl	%edx,%edi
+	rorl	$2,%edx
+	leal	1859775393(%ebx,%esi,1),%ebx
+	movl	52(%esp),%esi
+	xorl	%ebp,%edi
+	xorl	60(%esp),%esi
+	addl	%edi,%ebx
+	movl	%ecx,%edi
+	xorl	20(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 29 */
+	xorl	40(%esp),%esi
+	addl	%edi,%ebx
+	roll	$1,%esi
+	movl	%ebp,%edi
+	movl	%esi,52(%esp)
+	xorl	%ecx,%edi
+	rorl	$2,%ecx
+	leal	1859775393(%eax,%esi,1),%eax
+	movl	56(%esp),%esi
+	xorl	%edx,%edi
+	xorl	(%esp),%esi
+	addl	%edi,%eax
+	movl	%ebx,%edi
+	xorl	24(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 30 */
+	xorl	44(%esp),%esi
+	addl	%edi,%eax
+	roll	$1,%esi
+	movl	%edx,%edi
+	movl	%esi,56(%esp)
+	xorl	%ebx,%edi
+	rorl	$2,%ebx
+	leal	1859775393(%ebp,%esi,1),%ebp
+	movl	60(%esp),%esi
+	xorl	%ecx,%edi
+	xorl	4(%esp),%esi
+	addl	%edi,%ebp
+	movl	%eax,%edi
+	xorl	28(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 31 */
+	xorl	48(%esp),%esi
+	addl	%edi,%ebp
+	roll	$1,%esi
+	movl	%ecx,%edi
+	movl	%esi,60(%esp)
+	xorl	%eax,%edi
+	rorl	$2,%eax
+	leal	1859775393(%edx,%esi,1),%edx
+	movl	(%esp),%esi
+	xorl	%ebx,%edi
+	xorl	8(%esp),%esi
+	addl	%edi,%edx
+	movl	%ebp,%edi
+	xorl	32(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 32 */
+	xorl	52(%esp),%esi
+	addl	%edi,%edx
+	roll	$1,%esi
+	movl	%ebx,%edi
+	movl	%esi,(%esp)
+	xorl	%ebp,%edi
+	rorl	$2,%ebp
+	leal	1859775393(%ecx,%esi,1),%ecx
+	movl	4(%esp),%esi
+	xorl	%eax,%edi
+	xorl	12(%esp),%esi
+	addl	%edi,%ecx
+	movl	%edx,%edi
+	xorl	36(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 33 */
+	xorl	56(%esp),%esi
+	addl	%edi,%ecx
+	roll	$1,%esi
+	movl	%eax,%edi
+	movl	%esi,4(%esp)
+	xorl	%edx,%edi
+	rorl	$2,%edx
+	leal	1859775393(%ebx,%esi,1),%ebx
+	movl	8(%esp),%esi
+	xorl	%ebp,%edi
+	xorl	16(%esp),%esi
+	addl	%edi,%ebx
+	movl	%ecx,%edi
+	xorl	40(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 34 */
+	xorl	60(%esp),%esi
+	addl	%edi,%ebx
+	roll	$1,%esi
+	movl	%ebp,%edi
+	movl	%esi,8(%esp)
+	xorl	%ecx,%edi
+	rorl	$2,%ecx
+	leal	1859775393(%eax,%esi,1),%eax
+	movl	12(%esp),%esi
+	xorl	%edx,%edi
+	xorl	20(%esp),%esi
+	addl	%edi,%eax
+	movl	%ebx,%edi
+	xorl	44(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 35 */
+	xorl	(%esp),%esi
+	addl	%edi,%eax
+	roll	$1,%esi
+	movl	%edx,%edi
+	movl	%esi,12(%esp)
+	xorl	%ebx,%edi
+	rorl	$2,%ebx
+	leal	1859775393(%ebp,%esi,1),%ebp
+	movl	16(%esp),%esi
+	xorl	%ecx,%edi
+	xorl	24(%esp),%esi
+	addl	%edi,%ebp
+	movl	%eax,%edi
+	xorl	48(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 36 */
+	xorl	4(%esp),%esi
+	addl	%edi,%ebp
+	roll	$1,%esi
+	movl	%ecx,%edi
+	movl	%esi,16(%esp)
+	xorl	%eax,%edi
+	rorl	$2,%eax
+	leal	1859775393(%edx,%esi,1),%edx
+	movl	20(%esp),%esi
+	xorl	%ebx,%edi
+	xorl	28(%esp),%esi
+	addl	%edi,%edx
+	movl	%ebp,%edi
+	xorl	52(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 37 */
+	xorl	8(%esp),%esi
+	addl	%edi,%edx
+	roll	$1,%esi
+	movl	%ebx,%edi
+	movl	%esi,20(%esp)
+	xorl	%ebp,%edi
+	rorl	$2,%ebp
+	leal	1859775393(%ecx,%esi,1),%ecx
+	movl	24(%esp),%esi
+	xorl	%eax,%edi
+	xorl	32(%esp),%esi
+	addl	%edi,%ecx
+	movl	%edx,%edi
+	xorl	56(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 38 */
+	xorl	12(%esp),%esi
+	addl	%edi,%ecx
+	roll	$1,%esi
+	movl	%eax,%edi
+	movl	%esi,24(%esp)
+	xorl	%edx,%edi
+	rorl	$2,%edx
+	leal	1859775393(%ebx,%esi,1),%ebx
+	movl	28(%esp),%esi
+	xorl	%ebp,%edi
+	xorl	36(%esp),%esi
+	addl	%edi,%ebx
+	movl	%ecx,%edi
+	xorl	60(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 39 */
+	xorl	16(%esp),%esi
+	addl	%edi,%ebx
+	roll	$1,%esi
+	movl	%ebp,%edi
+	movl	%esi,28(%esp)
+	xorl	%ecx,%edi
+	rorl	$2,%ecx
+	leal	1859775393(%eax,%esi,1),%eax
+	movl	32(%esp),%esi
+	xorl	%edx,%edi
+	xorl	40(%esp),%esi
+	addl	%edi,%eax
+	movl	%ebx,%edi
+	xorl	(%esp),%esi
+	roll	$5,%edi
+	/* 40_59 40 */
+	addl	%edi,%eax
+	movl	%edx,%edi
+	xorl	20(%esp),%esi
+	andl	%ecx,%edi
+	roll	$1,%esi
+	addl	%edi,%ebp
+	movl	%edx,%edi
+	movl	%esi,32(%esp)
+	xorl	%ecx,%edi
+	leal	2400959708(%ebp,%esi,1),%ebp
+	andl	%ebx,%edi
+	rorl	$2,%ebx
+	movl	36(%esp),%esi
+	addl	%edi,%ebp
+	movl	%eax,%edi
+	xorl	44(%esp),%esi
+	roll	$5,%edi
+	xorl	4(%esp),%esi
+	/* 40_59 41 */
+	addl	%edi,%ebp
+	movl	%ecx,%edi
+	xorl	24(%esp),%esi
+	andl	%ebx,%edi
+	roll	$1,%esi
+	addl	%edi,%edx
+	movl	%ecx,%edi
+	movl	%esi,36(%esp)
+	xorl	%ebx,%edi
+	leal	2400959708(%edx,%esi,1),%edx
+	andl	%eax,%edi
+	rorl	$2,%eax
+	movl	40(%esp),%esi
+	addl	%edi,%edx
+	movl	%ebp,%edi
+	xorl	48(%esp),%esi
+	roll	$5,%edi
+	xorl	8(%esp),%esi
+	/* 40_59 42 */
+	addl	%edi,%edx
+	movl	%ebx,%edi
+	xorl	28(%esp),%esi
+	andl	%eax,%edi
+	roll	$1,%esi
+	addl	%edi,%ecx
+	movl	%ebx,%edi
+	movl	%esi,40(%esp)
+	xorl	%eax,%edi
+	leal	2400959708(%ecx,%esi,1),%ecx
+	andl	%ebp,%edi
+	rorl	$2,%ebp
+	movl	44(%esp),%esi
+	addl	%edi,%ecx
+	movl	%edx,%edi
+	xorl	52(%esp),%esi
+	roll	$5,%edi
+	xorl	12(%esp),%esi
+	/* 40_59 43 */
+	addl	%edi,%ecx
+	movl	%eax,%edi
+	xorl	32(%esp),%esi
+	andl	%ebp,%edi
+	roll	$1,%esi
+	addl	%edi,%ebx
+	movl	%eax,%edi
+	movl	%esi,44(%esp)
+	xorl	%ebp,%edi
+	leal	2400959708(%ebx,%esi,1),%ebx
+	andl	%edx,%edi
+	rorl	$2,%edx
+	movl	48(%esp),%esi
+	addl	%edi,%ebx
+	movl	%ecx,%edi
+	xorl	56(%esp),%esi
+	roll	$5,%edi
+	xorl	16(%esp),%esi
+	/* 40_59 44 */
+	addl	%edi,%ebx
+	movl	%ebp,%edi
+	xorl	36(%esp),%esi
+	andl	%edx,%edi
+	roll	$1,%esi
+	addl	%edi,%eax
+	movl	%ebp,%edi
+	movl	%esi,48(%esp)
+	xorl	%edx,%edi
+	leal	2400959708(%eax,%esi,1),%eax
+	andl	%ecx,%edi
+	rorl	$2,%ecx
+	movl	52(%esp),%esi
+	addl	%edi,%eax
+	movl	%ebx,%edi
+	xorl	60(%esp),%esi
+	roll	$5,%edi
+	xorl	20(%esp),%esi
+	/* 40_59 45 */
+	addl	%edi,%eax
+	movl	%edx,%edi
+	xorl	40(%esp),%esi
+	andl	%ecx,%edi
+	roll	$1,%esi
+	addl	%edi,%ebp
+	movl	%edx,%edi
+	movl	%esi,52(%esp)
+	xorl	%ecx,%edi
+	leal	2400959708(%ebp,%esi,1),%ebp
+	andl	%ebx,%edi
+	rorl	$2,%ebx
+	movl	56(%esp),%esi
+	addl	%edi,%ebp
+	movl	%eax,%edi
+	xorl	(%esp),%esi
+	roll	$5,%edi
+	xorl	24(%esp),%esi
+	/* 40_59 46 */
+	addl	%edi,%ebp
+	movl	%ecx,%edi
+	xorl	44(%esp),%esi
+	andl	%ebx,%edi
+	roll	$1,%esi
+	addl	%edi,%edx
+	movl	%ecx,%edi
+	movl	%esi,56(%esp)
+	xorl	%ebx,%edi
+	leal	2400959708(%edx,%esi,1),%edx
+	andl	%eax,%edi
+	rorl	$2,%eax
+	movl	60(%esp),%esi
+	addl	%edi,%edx
+	movl	%ebp,%edi
+	xorl	4(%esp),%esi
+	roll	$5,%edi
+	xorl	28(%esp),%esi
+	/* 40_59 47 */
+	addl	%edi,%edx
+	movl	%ebx,%edi
+	xorl	48(%esp),%esi
+	andl	%eax,%edi
+	roll	$1,%esi
+	addl	%edi,%ecx
+	movl	%ebx,%edi
+	movl	%esi,60(%esp)
+	xorl	%eax,%edi
+	leal	2400959708(%ecx,%esi,1),%ecx
+	andl	%ebp,%edi
+	rorl	$2,%ebp
+	movl	(%esp),%esi
+	addl	%edi,%ecx
+	movl	%edx,%edi
+	xorl	8(%esp),%esi
+	roll	$5,%edi
+	xorl	32(%esp),%esi
+	/* 40_59 48 */
+	addl	%edi,%ecx
+	movl	%eax,%edi
+	xorl	52(%esp),%esi
+	andl	%ebp,%edi
+	roll	$1,%esi
+	addl	%edi,%ebx
+	movl	%eax,%edi
+	movl	%esi,(%esp)
+	xorl	%ebp,%edi
+	leal	2400959708(%ebx,%esi,1),%ebx
+	andl	%edx,%edi
+	rorl	$2,%edx
+	movl	4(%esp),%esi
+	addl	%edi,%ebx
+	movl	%ecx,%edi
+	xorl	12(%esp),%esi
+	roll	$5,%edi
+	xorl	36(%esp),%esi
+	/* 40_59 49 */
+	addl	%edi,%ebx
+	movl	%ebp,%edi
+	xorl	56(%esp),%esi
+	andl	%edx,%edi
+	roll	$1,%esi
+	addl	%edi,%eax
+	movl	%ebp,%edi
+	movl	%esi,4(%esp)
+	xorl	%edx,%edi
+	leal	2400959708(%eax,%esi,1),%eax
+	andl	%ecx,%edi
+	rorl	$2,%ecx
+	movl	8(%esp),%esi
+	addl	%edi,%eax
+	movl	%ebx,%edi
+	xorl	16(%esp),%esi
+	roll	$5,%edi
+	xorl	40(%esp),%esi
+	/* 40_59 50 */
+	addl	%edi,%eax
+	movl	%edx,%edi
+	xorl	60(%esp),%esi
+	andl	%ecx,%edi
+	roll	$1,%esi
+	addl	%edi,%ebp
+	movl	%edx,%edi
+	movl	%esi,8(%esp)
+	xorl	%ecx,%edi
+	leal	2400959708(%ebp,%esi,1),%ebp
+	andl	%ebx,%edi
+	rorl	$2,%ebx
+	movl	12(%esp),%esi
+	addl	%edi,%ebp
+	movl	%eax,%edi
+	xorl	20(%esp),%esi
+	roll	$5,%edi
+	xorl	44(%esp),%esi
+	/* 40_59 51 */
+	addl	%edi,%ebp
+	movl	%ecx,%edi
+	xorl	(%esp),%esi
+	andl	%ebx,%edi
+	roll	$1,%esi
+	addl	%edi,%edx
+	movl	%ecx,%edi
+	movl	%esi,12(%esp)
+	xorl	%ebx,%edi
+	leal	2400959708(%edx,%esi,1),%edx
+	andl	%eax,%edi
+	rorl	$2,%eax
+	movl	16(%esp),%esi
+	addl	%edi,%edx
+	movl	%ebp,%edi
+	xorl	24(%esp),%esi
+	roll	$5,%edi
+	xorl	48(%esp),%esi
+	/* 40_59 52 */
+	addl	%edi,%edx
+	movl	%ebx,%edi
+	xorl	4(%esp),%esi
+	andl	%eax,%edi
+	roll	$1,%esi
+	addl	%edi,%ecx
+	movl	%ebx,%edi
+	movl	%esi,16(%esp)
+	xorl	%eax,%edi
+	leal	2400959708(%ecx,%esi,1),%ecx
+	andl	%ebp,%edi
+	rorl	$2,%ebp
+	movl	20(%esp),%esi
+	addl	%edi,%ecx
+	movl	%edx,%edi
+	xorl	28(%esp),%esi
+	roll	$5,%edi
+	xorl	52(%esp),%esi
+	/* 40_59 53 */
+	addl	%edi,%ecx
+	movl	%eax,%edi
+	xorl	8(%esp),%esi
+	andl	%ebp,%edi
+	roll	$1,%esi
+	addl	%edi,%ebx
+	movl	%eax,%edi
+	movl	%esi,20(%esp)
+	xorl	%ebp,%edi
+	leal	2400959708(%ebx,%esi,1),%ebx
+	andl	%edx,%edi
+	rorl	$2,%edx
+	movl	24(%esp),%esi
+	addl	%edi,%ebx
+	movl	%ecx,%edi
+	xorl	32(%esp),%esi
+	roll	$5,%edi
+	xorl	56(%esp),%esi
+	/* 40_59 54 */
+	addl	%edi,%ebx
+	movl	%ebp,%edi
+	xorl	12(%esp),%esi
+	andl	%edx,%edi
+	roll	$1,%esi
+	addl	%edi,%eax
+	movl	%ebp,%edi
+	movl	%esi,24(%esp)
+	xorl	%edx,%edi
+	leal	2400959708(%eax,%esi,1),%eax
+	andl	%ecx,%edi
+	rorl	$2,%ecx
+	movl	28(%esp),%esi
+	addl	%edi,%eax
+	movl	%ebx,%edi
+	xorl	36(%esp),%esi
+	roll	$5,%edi
+	xorl	60(%esp),%esi
+	/* 40_59 55 */
+	addl	%edi,%eax
+	movl	%edx,%edi
+	xorl	16(%esp),%esi
+	andl	%ecx,%edi
+	roll	$1,%esi
+	addl	%edi,%ebp
+	movl	%edx,%edi
+	movl	%esi,28(%esp)
+	xorl	%ecx,%edi
+	leal	2400959708(%ebp,%esi,1),%ebp
+	andl	%ebx,%edi
+	rorl	$2,%ebx
+	movl	32(%esp),%esi
+	addl	%edi,%ebp
+	movl	%eax,%edi
+	xorl	40(%esp),%esi
+	roll	$5,%edi
+	xorl	(%esp),%esi
+	/* 40_59 56 */
+	addl	%edi,%ebp
+	movl	%ecx,%edi
+	xorl	20(%esp),%esi
+	andl	%ebx,%edi
+	roll	$1,%esi
+	addl	%edi,%edx
+	movl	%ecx,%edi
+	movl	%esi,32(%esp)
+	xorl	%ebx,%edi
+	leal	2400959708(%edx,%esi,1),%edx
+	andl	%eax,%edi
+	rorl	$2,%eax
+	movl	36(%esp),%esi
+	addl	%edi,%edx
+	movl	%ebp,%edi
+	xorl	44(%esp),%esi
+	roll	$5,%edi
+	xorl	4(%esp),%esi
+	/* 40_59 57 */
+	addl	%edi,%edx
+	movl	%ebx,%edi
+	xorl	24(%esp),%esi
+	andl	%eax,%edi
+	roll	$1,%esi
+	addl	%edi,%ecx
+	movl	%ebx,%edi
+	movl	%esi,36(%esp)
+	xorl	%eax,%edi
+	leal	2400959708(%ecx,%esi,1),%ecx
+	andl	%ebp,%edi
+	rorl	$2,%ebp
+	movl	40(%esp),%esi
+	addl	%edi,%ecx
+	movl	%edx,%edi
+	xorl	48(%esp),%esi
+	roll	$5,%edi
+	xorl	8(%esp),%esi
+	/* 40_59 58 */
+	addl	%edi,%ecx
+	movl	%eax,%edi
+	xorl	28(%esp),%esi
+	andl	%ebp,%edi
+	roll	$1,%esi
+	addl	%edi,%ebx
+	movl	%eax,%edi
+	movl	%esi,40(%esp)
+	xorl	%ebp,%edi
+	leal	2400959708(%ebx,%esi,1),%ebx
+	andl	%edx,%edi
+	rorl	$2,%edx
+	movl	44(%esp),%esi
+	addl	%edi,%ebx
+	movl	%ecx,%edi
+	xorl	52(%esp),%esi
+	roll	$5,%edi
+	xorl	12(%esp),%esi
+	/* 40_59 59 */
+	addl	%edi,%ebx
+	movl	%ebp,%edi
+	xorl	32(%esp),%esi
+	andl	%edx,%edi
+	roll	$1,%esi
+	addl	%edi,%eax
+	movl	%ebp,%edi
+	movl	%esi,44(%esp)
+	xorl	%edx,%edi
+	leal	2400959708(%eax,%esi,1),%eax
+	andl	%ecx,%edi
+	rorl	$2,%ecx
+	movl	48(%esp),%esi
+	addl	%edi,%eax
+	movl	%ebx,%edi
+	xorl	56(%esp),%esi
+	roll	$5,%edi
+	xorl	16(%esp),%esi
+	/* 20_39 60 */
+	xorl	36(%esp),%esi
+	addl	%edi,%eax
+	roll	$1,%esi
+	movl	%edx,%edi
+	movl	%esi,48(%esp)
+	xorl	%ebx,%edi
+	rorl	$2,%ebx
+	leal	3395469782(%ebp,%esi,1),%ebp
+	movl	52(%esp),%esi
+	xorl	%ecx,%edi
+	xorl	60(%esp),%esi
+	addl	%edi,%ebp
+	movl	%eax,%edi
+	xorl	20(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 61 */
+	xorl	40(%esp),%esi
+	addl	%edi,%ebp
+	roll	$1,%esi
+	movl	%ecx,%edi
+	movl	%esi,52(%esp)
+	xorl	%eax,%edi
+	rorl	$2,%eax
+	leal	3395469782(%edx,%esi,1),%edx
+	movl	56(%esp),%esi
+	xorl	%ebx,%edi
+	xorl	(%esp),%esi
+	addl	%edi,%edx
+	movl	%ebp,%edi
+	xorl	24(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 62 */
+	xorl	44(%esp),%esi
+	addl	%edi,%edx
+	roll	$1,%esi
+	movl	%ebx,%edi
+	movl	%esi,56(%esp)
+	xorl	%ebp,%edi
+	rorl	$2,%ebp
+	leal	3395469782(%ecx,%esi,1),%ecx
+	movl	60(%esp),%esi
+	xorl	%eax,%edi
+	xorl	4(%esp),%esi
+	addl	%edi,%ecx
+	movl	%edx,%edi
+	xorl	28(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 63 */
+	xorl	48(%esp),%esi
+	addl	%edi,%ecx
+	roll	$1,%esi
+	movl	%eax,%edi
+	movl	%esi,60(%esp)
+	xorl	%edx,%edi
+	rorl	$2,%edx
+	leal	3395469782(%ebx,%esi,1),%ebx
+	movl	(%esp),%esi
+	xorl	%ebp,%edi
+	xorl	8(%esp),%esi
+	addl	%edi,%ebx
+	movl	%ecx,%edi
+	xorl	32(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 64 */
+	xorl	52(%esp),%esi
+	addl	%edi,%ebx
+	roll	$1,%esi
+	movl	%ebp,%edi
+	movl	%esi,(%esp)
+	xorl	%ecx,%edi
+	rorl	$2,%ecx
+	leal	3395469782(%eax,%esi,1),%eax
+	movl	4(%esp),%esi
+	xorl	%edx,%edi
+	xorl	12(%esp),%esi
+	addl	%edi,%eax
+	movl	%ebx,%edi
+	xorl	36(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 65 */
+	xorl	56(%esp),%esi
+	addl	%edi,%eax
+	roll	$1,%esi
+	movl	%edx,%edi
+	movl	%esi,4(%esp)
+	xorl	%ebx,%edi
+	rorl	$2,%ebx
+	leal	3395469782(%ebp,%esi,1),%ebp
+	movl	8(%esp),%esi
+	xorl	%ecx,%edi
+	xorl	16(%esp),%esi
+	addl	%edi,%ebp
+	movl	%eax,%edi
+	xorl	40(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 66 */
+	xorl	60(%esp),%esi
+	addl	%edi,%ebp
+	roll	$1,%esi
+	movl	%ecx,%edi
+	movl	%esi,8(%esp)
+	xorl	%eax,%edi
+	rorl	$2,%eax
+	leal	3395469782(%edx,%esi,1),%edx
+	movl	12(%esp),%esi
+	xorl	%ebx,%edi
+	xorl	20(%esp),%esi
+	addl	%edi,%edx
+	movl	%ebp,%edi
+	xorl	44(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 67 */
+	xorl	(%esp),%esi
+	addl	%edi,%edx
+	roll	$1,%esi
+	movl	%ebx,%edi
+	movl	%esi,12(%esp)
+	xorl	%ebp,%edi
+	rorl	$2,%ebp
+	leal	3395469782(%ecx,%esi,1),%ecx
+	movl	16(%esp),%esi
+	xorl	%eax,%edi
+	xorl	24(%esp),%esi
+	addl	%edi,%ecx
+	movl	%edx,%edi
+	xorl	48(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 68 */
+	xorl	4(%esp),%esi
+	addl	%edi,%ecx
+	roll	$1,%esi
+	movl	%eax,%edi
+	movl	%esi,16(%esp)
+	xorl	%edx,%edi
+	rorl	$2,%edx
+	leal	3395469782(%ebx,%esi,1),%ebx
+	movl	20(%esp),%esi
+	xorl	%ebp,%edi
+	xorl	28(%esp),%esi
+	addl	%edi,%ebx
+	movl	%ecx,%edi
+	xorl	52(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 69 */
+	xorl	8(%esp),%esi
+	addl	%edi,%ebx
+	roll	$1,%esi
+	movl	%ebp,%edi
+	movl	%esi,20(%esp)
+	xorl	%ecx,%edi
+	rorl	$2,%ecx
+	leal	3395469782(%eax,%esi,1),%eax
+	movl	24(%esp),%esi
+	xorl	%edx,%edi
+	xorl	32(%esp),%esi
+	addl	%edi,%eax
+	movl	%ebx,%edi
+	xorl	56(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 70 */
+	xorl	12(%esp),%esi
+	addl	%edi,%eax
+	roll	$1,%esi
+	movl	%edx,%edi
+	movl	%esi,24(%esp)
+	xorl	%ebx,%edi
+	rorl	$2,%ebx
+	leal	3395469782(%ebp,%esi,1),%ebp
+	movl	28(%esp),%esi
+	xorl	%ecx,%edi
+	xorl	36(%esp),%esi
+	addl	%edi,%ebp
+	movl	%eax,%edi
+	xorl	60(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 71 */
+	xorl	16(%esp),%esi
+	addl	%edi,%ebp
+	roll	$1,%esi
+	movl	%ecx,%edi
+	movl	%esi,28(%esp)
+	xorl	%eax,%edi
+	rorl	$2,%eax
+	leal	3395469782(%edx,%esi,1),%edx
+	movl	32(%esp),%esi
+	xorl	%ebx,%edi
+	xorl	40(%esp),%esi
+	addl	%edi,%edx
+	movl	%ebp,%edi
+	xorl	(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 72 */
+	xorl	20(%esp),%esi
+	addl	%edi,%edx
+	roll	$1,%esi
+	movl	%ebx,%edi
+	movl	%esi,32(%esp)
+	xorl	%ebp,%edi
+	rorl	$2,%ebp
+	leal	3395469782(%ecx,%esi,1),%ecx
+	movl	36(%esp),%esi
+	xorl	%eax,%edi
+	xorl	44(%esp),%esi
+	addl	%edi,%ecx
+	movl	%edx,%edi
+	xorl	4(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 73 */
+	xorl	24(%esp),%esi
+	addl	%edi,%ecx
+	roll	$1,%esi
+	movl	%eax,%edi
+	movl	%esi,36(%esp)
+	xorl	%edx,%edi
+	rorl	$2,%edx
+	leal	3395469782(%ebx,%esi,1),%ebx
+	movl	40(%esp),%esi
+	xorl	%ebp,%edi
+	xorl	48(%esp),%esi
+	addl	%edi,%ebx
+	movl	%ecx,%edi
+	xorl	8(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 74 */
+	xorl	28(%esp),%esi
+	addl	%edi,%ebx
+	roll	$1,%esi
+	movl	%ebp,%edi
+	movl	%esi,40(%esp)
+	xorl	%ecx,%edi
+	rorl	$2,%ecx
+	leal	3395469782(%eax,%esi,1),%eax
+	movl	44(%esp),%esi
+	xorl	%edx,%edi
+	xorl	52(%esp),%esi
+	addl	%edi,%eax
+	movl	%ebx,%edi
+	xorl	12(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 75 */
+	xorl	32(%esp),%esi
+	addl	%edi,%eax
+	roll	$1,%esi
+	movl	%edx,%edi
+	movl	%esi,44(%esp)
+	xorl	%ebx,%edi
+	rorl	$2,%ebx
+	leal	3395469782(%ebp,%esi,1),%ebp
+	movl	48(%esp),%esi
+	xorl	%ecx,%edi
+	xorl	56(%esp),%esi
+	addl	%edi,%ebp
+	movl	%eax,%edi
+	xorl	16(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 76 */
+	xorl	36(%esp),%esi
+	addl	%edi,%ebp
+	roll	$1,%esi
+	movl	%ecx,%edi
+	movl	%esi,48(%esp)
+	xorl	%eax,%edi
+	rorl	$2,%eax
+	leal	3395469782(%edx,%esi,1),%edx
+	movl	52(%esp),%esi
+	xorl	%ebx,%edi
+	xorl	60(%esp),%esi
+	addl	%edi,%edx
+	movl	%ebp,%edi
+	xorl	20(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 77 */
+	xorl	40(%esp),%esi
+	addl	%edi,%edx
+	roll	$1,%esi
+	movl	%ebx,%edi
+	xorl	%ebp,%edi
+	rorl	$2,%ebp
+	leal	3395469782(%ecx,%esi,1),%ecx
+	movl	56(%esp),%esi
+	xorl	%eax,%edi
+	xorl	(%esp),%esi
+	addl	%edi,%ecx
+	movl	%edx,%edi
+	xorl	24(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 78 */
+	xorl	44(%esp),%esi
+	addl	%edi,%ecx
+	roll	$1,%esi
+	movl	%eax,%edi
+	xorl	%edx,%edi
+	rorl	$2,%edx
+	leal	3395469782(%ebx,%esi,1),%ebx
+	movl	60(%esp),%esi
+	xorl	%ebp,%edi
+	xorl	4(%esp),%esi
+	addl	%edi,%ebx
+	movl	%ecx,%edi
+	xorl	28(%esp),%esi
+	roll	$5,%edi
+	/* 20_39 79 */
+	xorl	48(%esp),%esi
+	addl	%edi,%ebx
+	roll	$1,%esi
+	movl	%ebp,%edi
+	xorl	%ecx,%edi
+	rorl	$2,%ecx
+	leal	3395469782(%eax,%esi,1),%eax
+	xorl	%edx,%edi
+	addl	%edi,%eax
+	movl	%ebx,%edi
+	roll	$5,%edi
+	addl	%edi,%eax
+	/* Loop trailer */
+	movl	84(%esp),%edi
+	movl	88(%esp),%esi
+	addl	16(%edi),%ebp
+	addl	12(%edi),%edx
+	addl	%ecx,8(%edi)
+	addl	%ebx,4(%edi)
+	addl	$64,%esi
+	addl	%eax,(%edi)
+	movl	%edx,12(%edi)
+	movl	%ebp,16(%edi)
+	cmpl	92(%esp),%esi
+	jb	.L000loop
+	addl	$64,%esp
+	popl	%edi
+	popl	%esi
+	popl	%ebx
+	popl	%ebp
+	ret
+.L_sha1_block_data_order_end:
+.size	sha1_block_data_order,.L_sha1_block_data_order_end-sha1_block_data_order
+.byte	83,72,65,49,32,98,108,111,99,107,32,116,114,97,110,115,102,111,114,109,32,102,111,114,32,120,56,54,44,32,67,82,89,80,84,79,71,65,77,83,32,98,121,32,60,97,112,112,114,111,64,111,112,101,110,115,115,108,46,111,114,103,62,0
diff --git a/x86/sha1.c b/x86/sha1.c
new file mode 100644
index 0000000..4c1a569
--- /dev/null
+++ b/x86/sha1.c
@@ -0,0 +1,81 @@
+/*
+ * SHA-1 implementation.
+ *
+ * Copyright (C) 2005 Paul Mackerras <paulus@samba.org>
+ *
+ * This version assumes we are running on a big-endian machine.
+ * It calls an external sha1_core() to process blocks of 64 bytes.
+ */
+#include <stdio.h>
+#include <string.h>
+#include <arpa/inet.h>	/* For htonl */
+#include "sha1.h"
+
+#define x86_sha1_core sha1_block_data_order
+extern void x86_sha1_core(uint32_t hash[5], const unsigned char *p,
+			  unsigned int nblocks);
+
+void x86_SHA1_Init(x86_SHA_CTX *c)
+{
+	/* Matches prefix of scontext structure */
+	static struct {
+		uint32_t hash[5];
+		uint64_t len;
+	} const iv = {
+		{ 0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0 },
+		0
+	};
+
+	memcpy(c, &iv, sizeof iv);
+}
+
+void x86_SHA1_Update(x86_SHA_CTX *c, const void *p, unsigned long n)
+{
+	unsigned pos = (unsigned)c->len & 63;
+	unsigned long nb;
+
+	c->len += n;
+
+	/* Initial partial block */
+	if (pos) {
+		unsigned space = 64 - pos;
+		if (space > n)
+			goto end;
+		memcpy(c->buf + pos, p, space);
+		p += space;
+		n -= space;
+		x86_sha1_core(c->hash, c->buf, 1);
+	}
+
+	/* The big impressive middle */
+	nb = n >> 6;
+	if (nb) {
+		x86_sha1_core(c->hash, p, nb);
+		p += nb << 6;
+		n &= 63;
+	}
+	pos = 0;
+end:
+	/* Final partial block */
+	memcpy(c->buf + pos, p, n);
+}
+
+void x86_SHA1_Final(unsigned char *hash, x86_SHA_CTX *c)
+{
+	unsigned pos = (unsigned)c->len & 63;
+
+	c->buf[pos++] = 0x80;
+	if (pos > 56) {
+		memset(c->buf + pos, 0, 64 - pos);
+		x86_sha1_core(c->hash, c->buf, 1);
+		pos = 0;
+	}
+	memset(c->buf + pos, 0, 56 - pos);
+	/* Last two words are 64-bit *bit* count */
+	*(uint32_t *)(c->buf + 56) = htonl((uint32_t)(c->len >> 29));
+	*(uint32_t *)(c->buf + 60) = htonl((uint32_t)c->len << 3);
+	x86_sha1_core(c->hash, c->buf, 1);
+
+	for (pos = 0; pos < 5; pos++)
+		((uint32_t *)hash)[pos] = htonl(c->hash[pos]);
+}
diff --git a/x86/sha1.h b/x86/sha1.h
new file mode 100644
index 0000000..8988da9
--- /dev/null
+++ b/x86/sha1.h
@@ -0,0 +1,21 @@
+/*
+ * SHA-1 implementation.
+ *
+ * Copyright (C) 2005 Paul Mackerras <paulus@samba.org>
+ */
+#include <stdint.h>
+
+typedef struct {
+	uint32_t hash[5];
+	uint64_t len;
+	unsigned char buf[64];	/* Keep this aligned */
+} x86_SHA_CTX;
+
+void x86_SHA1_Init(x86_SHA_CTX *c);
+void x86_SHA1_Update(x86_SHA_CTX *c, const void *p, unsigned long n);
+void x86_SHA1_Final(unsigned char *hash, x86_SHA_CTX *c);
+
+#define git_SHA_CTX	x86_SHA_CTX
+#define git_SHA1_Init	x86_SHA1_Init
+#define git_SHA1_Update	x86_SHA1_Update
+#define git_SHA1_Final	x86_SHA1_Final
