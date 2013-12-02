From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: git-blame segfault
Date: Mon, 2 Dec 2013 16:05:41 +0100
Message-ID: <20131202150541.GB275@x4>
References: <20131202125748.GA275@x4>
 <CALWbr2w8sRRPJdjnpEwiGYe+T4KnvmRtV2n3yTesz8869q_=zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 16:06:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnV4T-0007uE-BX
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 16:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954Ab3LBPFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 10:05:44 -0500
Received: from ud10.udmedia.de ([194.117.254.50]:56544 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab3LBPFn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 10:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=mail.ud10.udmedia.de; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=beta; bh=xr18MzLcTxtmy3UkOrbCrXQpRU
	Y7bs85TQUqmSf4o7E=; b=qdpTcQhhzYCkPabWZUnJCjc7mXkolCHav760Ru8nKr
	094s0iTbdb6l6imeugrKfp8qQ0QPgmtdNiGBwHAQHPwiOf8NJPN0njRQvlwLwkn3
	nMWYPyBqn5WWkFQVRbnMXT+PneTqzFkDeKFc7Q54w3BoOpHdw64qpxUaaOX6tX9j
	U=
Received: (qmail 30427 invoked from network); 2 Dec 2013 16:05:42 +0100
Received: from unknown (HELO x4) (ud10?360p3@91.64.96.185)
  by mail.ud10.udmedia.de with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 2 Dec 2013 16:05:42 +0100
Content-Disposition: inline
In-Reply-To: <CALWbr2w8sRRPJdjnpEwiGYe+T4KnvmRtV2n3yTesz8869q_=zA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238633>

On 2013.12.02 at 15:15 +0100, Antoine Pelisse wrote:
> On Mon, Dec 2, 2013 at 1:57 PM, Markus Trippelsdorf
> <markus@trippelsdorf.de> wrote:
> > When git is compiled with current gcc and "-march=native"
> > git-blame segfaults:
> >
> > For example:
> >
> >  % gdb --args /var/tmp/git/git-blame gcc/tree-object-size.c
> > ...
> > Program received signal SIGSEGV, Segmentation fault.
> > 0x0000000000000000 in ?? ()
> > (gdb) bt
> > #0  0x0000000000000000 in ?? ()
> > #1  0x000000000051240d in xdl_emit_hunk_hdr (s1=s1@entry=30, c1=<optimized out>, s2=s2@entry=30, c2=c2@entry=6, func=func@entry=0x7fffffffd2d8 "", funclen=0,
> >     ecb=ecb@entry=0x7fffffffd580) at xdiff/xutils.c:460
> > #2  0x0000000000512af7 in xdl_emit_diff (xe=0x7fffffffd390, xscr=<optimized out>, ecb=0x7fffffffd580, xecfg=0x7fffffffd590) at xdiff/xemit.c:237
> 
> xdl_emit_diff() should not be called, because xecfg->hunk_func should
> be non-null and called instead. xld_emit_diff() is the one that needs
> outf to be set.
> 
> > #3  0x0000000000510a5d in xdl_diff (mf1=mf1@entry=0x7fffffffd510, mf2=mf2@entry=0x7fffffffd520, xpp=xpp@entry=0x7fffffffd570, xecfg=xecfg@entry=0x7fffffffd590,
> >     ecb=ecb@entry=0x7fffffffd580) at xdiff/xdiffi.c:601
> 
> Here we decide that xecfg->hunk_func is empty, and ef is set to xdl_emit_diff.
> 
> > #4  0x000000000050b005 in xdi_diff (mf1=<optimized out>, mf2=<optimized out>, xpp=xpp@entry=0x7fffffffd570, xecfg=xecfg@entry=0x7fffffffd590, xecb=xecb@entry=0x7fffffffd580)
> >     at xdiff-interface.c:136
> > #5  0x00000000004104df in diff_hunks (file_a=<optimized out>, file_b=<optimized out>, ctxlen=ctxlen@entry=0, hunk_func=hunk_func@entry=0x411320 <blame_chunk_cb>,
> >     cb_data=cb_data@entry=0x7fffffffd830) at builtin/blame.c:105
> 
> As we can see in your code below, ecb.outf is not set here, because
> it's not needed by hunk_func.
> hunk_func is set to blame_chunck_cb, passed by the function below.
> 
> > #6  0x0000000000412b54 in pass_blame_to_parent (parent=0x11da810, target=0x11dab50, sb=0x7fffffffd6e0) at builtin/blame.c:815
> 
> diff_hunks() is called with blame_chunck_cb as hunk_func.
> 
> I think the best thing to do is to find out where xecfg->hunk_func
> loses the blame_chunck_cb value to NULL. You could start with a
> watchpoint.

It happens in diff_hunks (from builtin/blame.c):

(gdb) up
#5  0x00000000004104df in diff_hunks (file_a=<optimized out>, file_b=<optimized out>, ctxlen=ctxlen@entry=0, hunk_func=hunk_func@entry=0x411320 <blame_chunk_cb>, 
    cb_data=cb_data@entry=0x7fffffffd830) at builtin/blame.c:105
105             return xdi_diff(file_a, file_b, &xpp, &xecfg, &ecb);
(gdb) l
100
101             xpp.flags = xdl_opts;
102             xecfg.ctxlen = ctxlen;
103             xecfg.hunk_func = hunk_func;
104             ecb.priv = cb_data;
105             return xdi_diff(file_a, file_b, &xpp, &xecfg, &ecb);
106     }
107
108     /*
109      * Prepare diff_filespec and convert it using diff textconv API
(gdb) p hunk_func
$1 = (xdl_emit_hunk_consume_func_t) 0x411320 <blame_chunk_cb>
(gdb) p xecfg.hunk_func
$2 = (xdl_emit_hunk_consume_func_t) 0x0
(gdb) p xecfg
$3 = {
  ctxlen = 0, 
  interhunkctxlen = 0, 
  flags = 0, 
  find_func = 0x0, 
  find_func_priv = 0x0, 
  hunk_func = 0x0
}
> 
> Would that mean that gcc is doing some steps in the wrong order ? That
> is setting xecfg.hunk_func and then emptying the structure ? I've
> already had a similar bug, but that's very unfortunate.

Yes. I think this might be the case:

(gdb) disass
Dump of assembler code for function diff_hunks:
   0x0000000000410460 <+0>:     sub    $0x58,%rsp
   0x0000000000410464 <+4>:     xor    %eax,%eax
   0x0000000000410466 <+6>:     mov    %eax,%r9d
   0x0000000000410469 <+9>:     add    $0x20,%eax
   0x000000000041046c <+12>:    cmp    $0x20,%eax
   0x000000000041046f <+15>:    movq   $0x0,0x20(%rsp,%r9,1)
   0x0000000000410478 <+24>:    movq   $0x0,0x28(%rsp,%r9,1)
   0x0000000000410481 <+33>:    movq   $0x0,0x30(%rsp,%r9,1)
   0x000000000041048a <+42>:    movq   $0x0,0x38(%rsp,%r9,1)
   0x0000000000410493 <+51>:    jb     0x410466 <diff_hunks+6>
   0x0000000000410495 <+53>:    lea    0x20(%rsp),%r10
   0x000000000041049a <+58>:    mov    %rdx,0x20(%rsp)
   0x000000000041049f <+63>:    mov    %rcx,0x48(%rsp)
   0x00000000004104a4 <+68>:    add    %r10,%rax
   0x00000000004104a7 <+71>:    mov    %r8,0x10(%rsp)
   0x00000000004104ac <+76>:    mov    %rsp,%rdx
   0x00000000004104af <+79>:    movq   $0x0,(%rax)
   0x00000000004104b6 <+86>:    movq   $0x0,0x8(%rax)
   0x00000000004104be <+94>:    lea    0x10(%rsp),%r8
   0x00000000004104c3 <+99>:    movslq 0x171882(%rip),%rax        # 0x581d4c <xdl_opts>
   0x00000000004104ca <+106>:   mov    %r10,%rcx
   0x00000000004104cd <+109>:   movq   $0x0,0x18(%rsp)
   0x00000000004104d6 <+118>:   mov    %rax,(%rsp)
   0x00000000004104da <+122>:   callq  0x50aee0 <xdi_diff>
=> 0x00000000004104df <+127>:   add    $0x58,%rsp
   0x00000000004104e3 <+131>:   retq   
End of assembler dump.


-- 
Markus
