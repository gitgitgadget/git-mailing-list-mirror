From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH 4/5] tree-walk: unroll get_mode since loop boundaries are well-known
Date: Sat, 2 Apr 2011 12:28:24 -0500
Message-ID: <BANLkTi=MupnQ9Ovy=A0nD+wDaK7wkVDryw@mail.gmail.com>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
	<1301535481-1085-4-git-send-email-dpmcgee@gmail.com>
	<BANLkTi=QK0_P3=rGFLXzZzk7c7JSNxuBmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 19:28:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q64ci-0006L7-S6
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 19:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756162Ab1DBR20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 13:28:26 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46347 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756097Ab1DBR2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 13:28:25 -0400
Received: by wwa36 with SMTP id 36so5142899wwa.1
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 10:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=VbJEDnprZc44nekWLX+yLhQuXUuu8k5VgEXySUlKZOk=;
        b=rVqG++R75xnZ/8QUfgEt9EclRjHOdPBSAWO5LVPcxPHxkGJl8ltetz7jZ66HDg0BlT
         rAXAXFpSJZbj0l9ZfxiwXkEETEkeStDiEI9cqy+lVxrSFmetuEW1V7G2ogpn8lAZHyBB
         HZDHREmAXhlZGDBg9mF6ubc78p6D8nlo72Qms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=r2DBhTY9db+0C7RhHxThpgN9kev9cmrSNMfHYj2Zk8H80B2iyQQmWNJypvzsqFXrW5
         39jhkY2S5jDZq1zXU4puMfqOKpdGOXUb8mJlNRnaldN/Zy1ZlaizlioZcDi8c8JFttyQ
         +t6PvzAEC3/JfSgyOWokO1nPdkD6jIOgHnGM8=
Received: by 10.227.173.4 with SMTP id n4mr5459528wbz.132.1301765304391; Sat,
 02 Apr 2011 10:28:24 -0700 (PDT)
Received: by 10.227.147.16 with HTTP; Sat, 2 Apr 2011 10:28:24 -0700 (PDT)
In-Reply-To: <BANLkTi=QK0_P3=rGFLXzZzk7c7JSNxuBmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170654>

On Sat, Apr 2, 2011 at 4:28 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Thu, Mar 31, 2011 at 8:38 AM, Dan McGee <dpmcgee@gmail.com> wrote:
>> We know our mode entry in our tree objects should be 5 or 6 characters
>> long. This change both enforces this fact and also unrolls the parsing
>> of the information giving the compiler more room for optimization of the
>> operations.
>
> I'm skeptical. Did you measure signficant gain after this patch? I
> looked at asm output with -O3 and failed to see the compiler doing
> anything fancy. Perhaps it's because I'm on x86 with quite small
> register set.

I'm on x86_64 and was just using -O2; -O3 produces the same output
actually. You can see it below. I had taken a look at this before I
submitted, and noticed a few things:
1. We do use multiple registers now since we aren't constrained to a loop.
2. movzbl (for the string parts) and cmb instructions tend to get
clustered first.
3. mozbl (for the mode shifting) and leal instructions tend to get
clustered later.
4. The normal case now involves no conditional jumps until the ' '
(space) comparison.

Call these "trivial", but on my worst case operation times went from
(shown below) 27.41 secs to 26.49 secs. Considering this operation is
called 530,588,868 times (that is not a typo) during this operation,
every saved instruction or non-missed branch prediction does seem to
make a difference.

-Dan

Repo:
http://projects.archlinux.org/svntogit/packages.git/

Old:
$ time ../git/git-log -- zzzzz_not_exist > /dev/null

real	0m27.409s
user	0m27.172s
sys	0m0.230s

.LVL3:
.LBB58:
.LBB59:
	.loc 1 12 0 is_stmt 1
	movzbl	(%rsi), %eax
	cmpb	$32, %al
	je	.L5
.LVL4:
	.loc 1 16 0
	leal	-48(%rax), %edx
.LVL5:
	.loc 1 15 0
	leaq	1(%rsi), %rdi
.LVL6:
	.loc 1 16 0
	cmpb	$7, %dl
	ja	.L5
	xorl	%edx, %edx
	jmp	.L6
.LVL7:
	.p2align 4,,10
	.p2align 3
.L7:
	leal	-48(%rax), %ecx
	cmpb	$7, %cl
	ja	.L5
.LVL8:
.L6:
	.loc 1 18 0
	movzbl	%al, %eax
	leal	-48(%rax,%rdx,8), %edx
.LVL9:
	.loc 1 15 0
	movzbl	(%rdi), %eax
.LVL10:
	addq	$1, %rdi
.LVL11:
	cmpb	$32, %al
	jne	.L7


New:
$ time ../git/git-log -- zzzzz_not_exist > /dev/null

real	0m26.490s
user	0m26.282s
sys	0m0.200s

.LVL3:
.LBB58:
.LBB59:
	.loc 1 19 0 is_stmt 1
	movzbl	(%rsi), %eax
.LVL4:
	.loc 1 20 0
	leal	-48(%rax), %edx
.LVL5:
	cmpb	$7, %dl
	ja	.L5
.LVL6:
	.loc 1 23 0
	movzbl	1(%rsi), %edx
.LVL7:
	.loc 1 24 0
	leal	-48(%rdx), %ecx
	cmpb	$7, %cl
	ja	.L5
.LVL8:
	.loc 1 27 0
	movzbl	2(%rsi), %ecx
.LVL9:
	.loc 1 28 0
	leal	-48(%rcx), %edi
	cmpb	$7, %dil
	ja	.L5
.LVL10:
	.loc 1 31 0
	movzbl	3(%rsi), %edi
.LVL11:
	.loc 1 32 0
	leal	-48(%rdi), %r8d
	cmpb	$7, %r8b
	ja	.L5
.LVL12:
	.loc 1 35 0
	movzbl	4(%rsi), %r8d
.LVL13:
	.loc 1 36 0
	leal	-48(%r8), %r9d
	cmpb	$7, %r9b
	ja	.L5
	.loc 1 21 0
	movzbl	%al, %eax
	.loc 1 25 0
	movzbl	%dl, %edx
	.loc 1 29 0
	movzbl	%cl, %ecx
	.loc 1 25 0
	leal	-432(%rdx,%rax,8), %edx
	.loc 1 33 0
	movzbl	%dil, %edi
	.loc 1 37 0
	movzbl	%r8b, %r8d
	.loc 1 35 0
	leaq	5(%rsi), %rax
	.loc 1 29 0
	leal	-48(%rcx,%rdx,8), %edx
	.loc 1 39 0
	movzbl	5(%rsi), %ecx
	.loc 1 33 0
	leal	-48(%rdi,%rdx,8), %edx
	.loc 1 39 0
	cmpb	$32, %cl
	.loc 1 37 0
	leal	-48(%r8,%rdx,8), %edx
.LVL14:
	.loc 1 39 0
	je	.L7
.LVL15:
	.loc 1 41 0
	leal	-48(%rcx), %eax
	cmpb	$7, %al
	ja	.L5
	.loc 1 45 0
	cmpb	$32, 6(%rsi)
	.loc 1 42 0
	movzbl	%cl, %ecx
	.loc 1 40 0
	leaq	6(%rsi), %rax
	.loc 1 42 0
	leal	-48(%rcx,%rdx,8), %edx
.LVL16:
	.loc 1 45 0
	jne	.L5

diff --git a/tree-walk.c b/tree-walk.c
index 63901f8..dd7bd45 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -4,11 +4,22 @@
 #include "dir.h"
 #include "tree.h"

+static unsigned long hit_ctr = 0;
+
+static void print_hit_ctr(void)
+{
+       fprintf(stderr, "hit_ctr: %lu\n", hit_ctr);
+}
+
 static const char *get_mode(const char *str, unsigned int *modep)
 {
        unsigned char c;
        unsigned int mode = 0;

+       if(hit_ctr == 0) {
+               atexit(print_hit_ctr);
+       }
+       hit_ctr++;
        /*
         * Unroll what looks like a loop since the bounds are
         * well-known. There should be at least 5 and at most 6
