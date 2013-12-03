From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: git-blame segfault
Date: Tue, 3 Dec 2013 09:45:40 +0100
Message-ID: <20131203084540.GA276@x4>
References: <20131202125748.GA275@x4>
 <CALWbr2w8sRRPJdjnpEwiGYe+T4KnvmRtV2n3yTesz8869q_=zA@mail.gmail.com>
 <20131202150541.GB275@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 09:45:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnlc4-0003rR-Qr
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 09:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726Ab3LCIpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 03:45:45 -0500
Received: from ud10.udmedia.de ([194.117.254.50]:58272 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab3LCIpo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 03:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=mail.ud10.udmedia.de; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=beta; bh=W3tb1VB+YqgoNbbVZJLf8H5hu6
	N4YqY2/uHsf+zbBeY=; b=JR50iiHho/rDrP6s7khX4ywIW7WxOIQByhn2wpTb9g
	iqN2AAxCOxTn0qozI3X8xjE128YXmbftDzc7KMcXE4Wqh0MBbYTo4pakCSFIo2os
	R8BdqH8fLS29ZWSfhDBxJ5M2HGpmk6v5a7KUDoZwUGtaGM7FZtfBoI5IR2qH7vKu
	k=
Received: (qmail 17979 invoked from network); 3 Dec 2013 09:45:41 +0100
Received: from unknown (HELO x4) (ud10?360p3@91.64.96.185)
  by mail.ud10.udmedia.de with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 3 Dec 2013 09:45:41 +0100
Content-Disposition: inline
In-Reply-To: <20131202150541.GB275@x4>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238676>

On 2013.12.02 at 16:05 +0100, Markus Trippelsdorf wrote:
> On 2013.12.02 at 15:15 +0100, Antoine Pelisse wrote:
> > Would that mean that gcc is doing some steps in the wrong order ? That
> > is setting xecfg.hunk_func and then emptying the structure ? I've
> > already had a similar bug, but that's very unfortunate.
> 
> Yes. I think this might be the case:
> 
> (gdb) disass
> Dump of assembler code for function diff_hunks:
>    0x0000000000410460 <+0>:     sub    $0x58,%rsp
>    0x0000000000410464 <+4>:     xor    %eax,%eax
>    0x0000000000410466 <+6>:     mov    %eax,%r9d
>    0x0000000000410469 <+9>:     add    $0x20,%eax
>    0x000000000041046c <+12>:    cmp    $0x20,%eax
>    0x000000000041046f <+15>:    movq   $0x0,0x20(%rsp,%r9,1)
>    0x0000000000410478 <+24>:    movq   $0x0,0x28(%rsp,%r9,1)
>    0x0000000000410481 <+33>:    movq   $0x0,0x30(%rsp,%r9,1)
>    0x000000000041048a <+42>:    movq   $0x0,0x38(%rsp,%r9,1)
>    0x0000000000410493 <+51>:    jb     0x410466 <diff_hunks+6>
>    0x0000000000410495 <+53>:    lea    0x20(%rsp),%r10
>    0x000000000041049a <+58>:    mov    %rdx,0x20(%rsp)
>    0x000000000041049f <+63>:    mov    %rcx,0x48(%rsp)
>    0x00000000004104a4 <+68>:    add    %r10,%rax
>    0x00000000004104a7 <+71>:    mov    %r8,0x10(%rsp)
>    0x00000000004104ac <+76>:    mov    %rsp,%rdx
>    0x00000000004104af <+79>:    movq   $0x0,(%rax)
>    0x00000000004104b6 <+86>:    movq   $0x0,0x8(%rax)
>    0x00000000004104be <+94>:    lea    0x10(%rsp),%r8
>    0x00000000004104c3 <+99>:    movslq 0x171882(%rip),%rax        # 0x581d4c <xdl_opts>
>    0x00000000004104ca <+106>:   mov    %r10,%rcx
>    0x00000000004104cd <+109>:   movq   $0x0,0x18(%rsp)
>    0x00000000004104d6 <+118>:   mov    %rax,(%rsp)
>    0x00000000004104da <+122>:   callq  0x50aee0 <xdi_diff>
> => 0x00000000004104df <+127>:   add    $0x58,%rsp
>    0x00000000004104e3 <+131>:   retq   
> End of assembler dump.

Should be fixed in gcc soon. For the curious, here is the assembler diff
(bad vs. good):

        .type   diff_hunks, @function
 diff_hunks:
 .LFB104:
        .cfi_startproc
        subq    $88, %rsp
        .cfi_def_cfa_offset 96
        xorl    %eax, %eax
 .L31:
        movl    %eax, %r9d
        addl    $32, %eax
        cmpl    $32, %eax
        movq    $0, 32(%rsp,%r9)
        movq    $0, 40(%rsp,%r9)
        movq    $0, 48(%rsp,%r9)
        movq    $0, 56(%rsp,%r9)
        jb      .L31
        leaq    32(%rsp), %r10
        movq    %rdx, 32(%rsp)
-       movq    %rcx, 72(%rsp)
-       addq    %r10, %rax
        movq    %r8, 16(%rsp)
+       addq    %r10, %rax
+       leaq    16(%rsp), %r8
        movq    %rsp, %rdx
-       movq    $0, (%rax)
        movq    $0, 8(%rax)
-       leaq    16(%rsp), %r8
+       movq    $0, (%rax)
        movslq  xdl_opts(%rip), %rax
+       movq    %rcx, 72(%rsp)
        movq    %r10, %rcx
        movq    $0, 24(%rsp)
        movq    %rax, (%rsp)
        call    xdi_diff
        addq    $88, %rsp
        .cfi_def_cfa_offset 8

-- 
Markus
