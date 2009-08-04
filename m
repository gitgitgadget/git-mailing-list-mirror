From: "George Spelvin" <linux@horizon.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: 4 Aug 2009 04:01:47 -0400
Message-ID: <20090804080147.15201.qmail@science.horizon.com>
References: <alpine.LFD.2.01.0908032326440.3270@localhost.localdomain>
Cc: git@vger.kernel.org
To: linux@horizon.com, torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Tue Aug 04 10:02:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYEyH-0008L1-Bm
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 10:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbZHDIBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 04:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbZHDIBv
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 04:01:51 -0400
Received: from science.horizon.com ([71.41.210.146]:41640 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932164AbZHDIBt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 04:01:49 -0400
Received: (qmail 15202 invoked by uid 1000); 4 Aug 2009 04:01:47 -0400
In-Reply-To: <alpine.LFD.2.01.0908032326440.3270@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124770>

> Now, I agree that it would be wonderful to get rid of the linker startup, 
> but the startup costs of openssl are very low compared to the equivalent 
> curl ones. So we can't lose _too_ much performance - especially for 
> long-running jobs where startup costs really don't even matter - in the 
> quest to get rid of those.
>
> That said, your numbers are impressive. Improving fsck by 1.1-2.2% is very 
> good. That means that you not only avodied the startup costs, you actually 
> improved on the openssl code. So it's a win-win situation.

Er, yes, that *is* what the subject line is advertising.  I started
with the OpenSSL core SHA1 code (which is BSD/GPL dual-licensed by its
author) and tweaked it some more for more recent processors.

> That said, it would be even better if the SHA1 code was also somewhat 
> portable to other environments (it looks like your current patch is very 
> GNU as specific), and if you had a solution for x86-64 too ;)

Done and will be done.

The code is *actually* written (see the first e-mail in this thread)
in the perl-preprocessor that OpenSSL uses, which can generate quite a
few output syntaxes (including Intel).  I just included the preprocessed
version to reduce the complexity of the rough-draft patch.

The one question I have is that currently perl is not a critical
compile-time dependency; it's needed for some extra stuff, but AFAIK you
can get most of git working without it.  Whether to add that dependency
or what is a Junio question.

As for x86-64, I haven't actually *written* it yet, but it'll be a very
simple adaptation.  Mostly it's just a matter of using the additional
registers effectively.

> Yeah, I'm a whiny little b*tch, aren't I?

Not at all; I expected all of that.  Getting rid of OpenSSL kind of
requires those things.

> Hmm. Does it really help to do the bswap as a separate initial phase?
> 
> As far as I can tell, you load the result of the bswap just a single time 
> for each value. So the initial "bswap all 64 bytes" seems pointless.

>> +	/* 00_15 0 */
>> +	movl	%edx,%edi
>> +	movl	(%esp),%esi

> Why not do the bswap here instead?
>
> Is it because you're running out of registers for scheduling, and want to 
> use the stack pointer rather than the original source?

Exactly.  I looked hard at it, but that means that I'd have to write the
first 16 rounds with only one temp register, because the other is being
used as an input pointer.

Here's the pipelined loop for the first 16 rounds (when in[i] is the
stack buffer), showing parallel operations on the same line.
(Operations in parens belong to adjacent rounds.)
#                       movl D,S        (roll 5,T)      (addl S,A)      //
#       mov in[i],T     xorl C,S        (addl T,A)
#                       andl B,S                        rorl 2,B
#       addl T+K,E      xorl D,S        movl A,T
#                       addl S,E        roll 5,T        (movl C,S)      //
#       (mov in[i],T)   (xorl B,S)      addl T,E        

which translates in perl code to:

sub BODY_00_15
{
        local($n,$a,$b,$c,$d,$e)=@_;

        &comment("00_15 $n");
                &mov($S,$d) if ($n == 0);
        &mov($T,&swtmp($n%16));         #  V Load Xi.
                &xor($S,$c);            # U  Continue F() = d^(b&(c^d))
                &and($S,$b);            #  V
                        &rotr($b,2);    # NP
        &lea($e,&DWP(K1,$e,$T));        # U  Add Xi and K
    if ($n < 15) {
                        &mov($T,$a);    #  V
                &xor($S,$d);            # U 
                        &rotl($T,5);    # NP
                &add($e,$S);            # U 
                &mov($S,$c);            #  V Start of NEXT round's F()
                        &add($e,$T);    # U 
    } else {
        # This version provides the correct start for BODY_20_39
                &xor($S,$d);            #  V
        &mov($T,&swtmp(($n+1)%16));     # U  Start computing mext Xi.
                &add($e,$S);            #  V Add F()
                        &mov($S,$a);    # U  Start computing a<<<5
        &xor($T,&swtmp(($n+3)%16));     #  V
                        &rotl($S,5);    # U 
        &xor($T,&swtmp(($n+9)%16));     #  V
    }
}

Anyway, the round is:

#define K1 0x5a827999
e += bswap(in[i]) + K1 + (d^(b&(c^d))) + ROTL(a,5).
b = ROTR(b,2);

Notice how I use one temp (T) for in[i] and ROTL(a,5), and the other (S)
for F1(b,c,d) = d^(b&(c^d)).

If I only had one temporary, I'd have to seriously un-overlap it:
	mov	S[i],T
	bswap	T
	mov	T,in[i]
	lea	K1(T,e),e
	  mov	  d,T
	  xor	  c,T
	  and	  b,T
	  xor	  d,T
	  add	  T,e
	mov	a,T
	roll	5,T
	add	T,e

Current processors probably have enough out-of-order scheduling resources to
find the parallelism there, but something like an Atom would be doomed.

I just cobbled together a test implementation, and it looks pretty similar
on my Phenom here (minimum of 30 runs):

Separate copy loop: 1.355603
In-line:            1.350444 (+0.4% faster)

A hint of being faster, but not much.

It is a couple of percent faster on a P4:
Separate copy loop: 3.297174
In-line:            3.237354 (+1.8% faster)

And on an i7:
Separate copy loop: 1.353641
In-line:            1.336766 (+1.2% faster)

but I worry about in-order machines.  An Athlon XP:
Separate copy loop: 3.252682
In-line:            3.313870 (-1.8% slower)

H'm... it's not bad.  And the code is smaller.  Maybe I'll work on
it a bit.

If you want to try it, the modified sha1-x86.s file is appended.

--- /dev/null	2009-05-12 02:55:38.579106460 -0400
+++ sha1-x86.s	2009-08-04 03:42:31.073284734 -0400
@@ -0,0 +1,1359 @@
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
+	movl	8(%edi),%ecx
+	movl	4(%edi),%ebx
+	movl	(%edi),%eax
+.align	16
+.L000loop:
+	movl	%esi,88(%esp)
+	/* 00_15 0 */
+	movl	(%esi),%edi
+	bswap	%edi
+	movl	%edi,(%esp)
+	leal	1518500249(%ebp,%edi,1),%ebp
+	movl	%edx,%edi
+	xorl	%ecx,%edi
+	andl	%ebx,%edi
+	rorl	$2,%ebx
+	xorl	%edx,%edi
+	addl	%edi,%ebp
+	movl	%eax,%edi
+	roll	$5,%edi
+	addl	%edi,%ebp
+	/* 00_15 1 */
+	movl	4(%esi),%edi
+	bswap	%edi
+	movl	%edi,4(%esp)
+	leal	1518500249(%edx,%edi,1),%edx
+	movl	%ecx,%edi
+	xorl	%ebx,%edi
+	andl	%eax,%edi
+	rorl	$2,%eax
+	xorl	%ecx,%edi
+	addl	%edi,%edx
+	movl	%ebp,%edi
+	roll	$5,%edi
+	addl	%edi,%edx
+	/* 00_15 2 */
+	movl	8(%esi),%edi
+	bswap	%edi
+	movl	%edi,8(%esp)
+	leal	1518500249(%ecx,%edi,1),%ecx
+	movl	%ebx,%edi
+	xorl	%eax,%edi
+	andl	%ebp,%edi
+	rorl	$2,%ebp
+	xorl	%ebx,%edi
+	addl	%edi,%ecx
+	movl	%edx,%edi
+	roll	$5,%edi
+	addl	%edi,%ecx
+	/* 00_15 3 */
+	movl	12(%esi),%edi
+	bswap	%edi
+	movl	%edi,12(%esp)
+	leal	1518500249(%ebx,%edi,1),%ebx
+	movl	%eax,%edi
+	xorl	%ebp,%edi
+	andl	%edx,%edi
+	rorl	$2,%edx
+	xorl	%eax,%edi
+	addl	%edi,%ebx
+	movl	%ecx,%edi
+	roll	$5,%edi
+	addl	%edi,%ebx
+	/* 00_15 4 */
+	movl	16(%esi),%edi
+	bswap	%edi
+	movl	%edi,16(%esp)
+	leal	1518500249(%eax,%edi,1),%eax
+	movl	%ebp,%edi
+	xorl	%edx,%edi
+	andl	%ecx,%edi
+	rorl	$2,%ecx
+	xorl	%ebp,%edi
+	addl	%edi,%eax
+	movl	%ebx,%edi
+	roll	$5,%edi
+	addl	%edi,%eax
+	/* 00_15 5 */
+	movl	20(%esi),%edi
+	bswap	%edi
+	movl	%edi,20(%esp)
+	leal	1518500249(%ebp,%edi,1),%ebp
+	movl	%edx,%edi
+	xorl	%ecx,%edi
+	andl	%ebx,%edi
+	rorl	$2,%ebx
+	xorl	%edx,%edi
+	addl	%edi,%ebp
+	movl	%eax,%edi
+	roll	$5,%edi
+	addl	%edi,%ebp
+	/* 00_15 6 */
+	movl	24(%esi),%edi
+	bswap	%edi
+	movl	%edi,24(%esp)
+	leal	1518500249(%edx,%edi,1),%edx
+	movl	%ecx,%edi
+	xorl	%ebx,%edi
+	andl	%eax,%edi
+	rorl	$2,%eax
+	xorl	%ecx,%edi
+	addl	%edi,%edx
+	movl	%ebp,%edi
+	roll	$5,%edi
+	addl	%edi,%edx
+	/* 00_15 7 */
+	movl	28(%esi),%edi
+	bswap	%edi
+	movl	%edi,28(%esp)
+	leal	1518500249(%ecx,%edi,1),%ecx
+	movl	%ebx,%edi
+	xorl	%eax,%edi
+	andl	%ebp,%edi
+	rorl	$2,%ebp
+	xorl	%ebx,%edi
+	addl	%edi,%ecx
+	movl	%edx,%edi
+	roll	$5,%edi
+	addl	%edi,%ecx
+	/* 00_15 8 */
+	movl	32(%esi),%edi
+	bswap	%edi
+	movl	%edi,32(%esp)
+	leal	1518500249(%ebx,%edi,1),%ebx
+	movl	%eax,%edi
+	xorl	%ebp,%edi
+	andl	%edx,%edi
+	rorl	$2,%edx
+	xorl	%eax,%edi
+	addl	%edi,%ebx
+	movl	%ecx,%edi
+	roll	$5,%edi
+	addl	%edi,%ebx
+	/* 00_15 9 */
+	movl	36(%esi),%edi
+	bswap	%edi
+	movl	%edi,36(%esp)
+	leal	1518500249(%eax,%edi,1),%eax
+	movl	%ebp,%edi
+	xorl	%edx,%edi
+	andl	%ecx,%edi
+	rorl	$2,%ecx
+	xorl	%ebp,%edi
+	addl	%edi,%eax
+	movl	%ebx,%edi
+	roll	$5,%edi
+	addl	%edi,%eax
+	/* 00_15 10 */
+	movl	40(%esi),%edi
+	bswap	%edi
+	movl	%edi,40(%esp)
+	leal	1518500249(%ebp,%edi,1),%ebp
+	movl	%edx,%edi
+	xorl	%ecx,%edi
+	andl	%ebx,%edi
+	rorl	$2,%ebx
+	xorl	%edx,%edi
+	addl	%edi,%ebp
+	movl	%eax,%edi
+	roll	$5,%edi
+	addl	%edi,%ebp
+	/* 00_15 11 */
+	movl	44(%esi),%edi
+	bswap	%edi
+	movl	%edi,44(%esp)
+	leal	1518500249(%edx,%edi,1),%edx
+	movl	%ecx,%edi
+	xorl	%ebx,%edi
+	andl	%eax,%edi
+	rorl	$2,%eax
+	xorl	%ecx,%edi
+	addl	%edi,%edx
+	movl	%ebp,%edi
+	roll	$5,%edi
+	addl	%edi,%edx
+	/* 00_15 12 */
+	movl	48(%esi),%edi
+	bswap	%edi
+	movl	%edi,48(%esp)
+	leal	1518500249(%ecx,%edi,1),%ecx
+	movl	%ebx,%edi
+	xorl	%eax,%edi
+	andl	%ebp,%edi
+	rorl	$2,%ebp
+	xorl	%ebx,%edi
+	addl	%edi,%ecx
+	movl	%edx,%edi
+	roll	$5,%edi
+	addl	%edi,%ecx
+	/* 00_15 13 */
+	movl	52(%esi),%edi
+	bswap	%edi
+	movl	%edi,52(%esp)
+	leal	1518500249(%ebx,%edi,1),%ebx
+	movl	%eax,%edi
+	xorl	%ebp,%edi
+	andl	%edx,%edi
+	rorl	$2,%edx
+	xorl	%eax,%edi
+	addl	%edi,%ebx
+	movl	%ecx,%edi
+	roll	$5,%edi
+	addl	%edi,%ebx
+	/* 00_15 14 */
+	movl	56(%esi),%edi
+	movl	60(%esi),%esi
+	bswap	%edi
+	movl	%edi,56(%esp)
+	leal	1518500249(%eax,%edi,1),%eax
+	movl	%ebp,%edi
+	xorl	%edx,%edi
+	andl	%ecx,%edi
+	rorl	$2,%ecx
+	xorl	%ebp,%edi
+	addl	%edi,%eax
+	movl	%ebx,%edi
+	roll	$5,%edi
+	addl	%edi,%eax
+	/* 00_15 15 */
+	movl	%edx,%edi
+	bswap	%esi
+	xorl	%ecx,%edi
+	movl	%esi,60(%esp)
+	andl	%ebx,%edi
+	rorl	$2,%ebx
+	xorl	%edx,%edi
+	leal	1518500249(%ebp,%esi,1),%ebp
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
+	addl	8(%edi),%ecx
+	addl	4(%edi),%ebx
+	addl	(%edi),%eax
+	addl	$64,%esi
+	movl	%ebp,16(%edi)
+	movl	%edx,12(%edi)
+	cmpl	92(%esp),%esi
+	movl	%ecx,8(%edi)
+	movl	%ebx,4(%edi)
+	movl	%eax,(%edi)
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
