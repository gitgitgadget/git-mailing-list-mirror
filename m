From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: git-blame segfault
Date: Mon, 2 Dec 2013 15:15:38 +0100
Message-ID: <CALWbr2w8sRRPJdjnpEwiGYe+T4KnvmRtV2n3yTesz8869q_=zA@mail.gmail.com>
References: <20131202125748.GA275@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Markus Trippelsdorf <markus@trippelsdorf.de>
X-From: git-owner@vger.kernel.org Mon Dec 02 15:15:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnUHo-0003YR-PG
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 15:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510Ab3LBOPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 09:15:40 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:36375 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab3LBOPj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 09:15:39 -0500
Received: by mail-pb0-f52.google.com with SMTP id uo5so18871490pbc.25
        for <git@vger.kernel.org>; Mon, 02 Dec 2013 06:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DZtXDqOXAPOd7jUdVxlfLRjwCSHqWvOAXCX0KXYiEE8=;
        b=H50Sqwf1c/0BLW/9vLRwmrdW7Qce4p89ME54ON/o+4Clg/o1HxFZIhb/K2PKD9qsxP
         5pOyP08zz6qEfOWkuHlI+zHS5LSorkgbLMzEiLQUxHZEqsP2cS/5WNtFF2UqcW1O+H2E
         6BaawV4XQp3mOERsH8OJ0RoMN0D6pb+JAzixN8n1+giMZAXK656y+D2R+4DLKR3BjKWC
         tbk5M4aNksT70f+xzwYPtFQOchJMnB3MJ4yn7R1ojk1uD2eh34b99k074kFPWKc/PG1m
         6AoPPa1KX0jEQVm0TrddqwodSLYa/lERV2pE5SqDUnuJ76+BORoccRlqe6VTUv5DF/x/
         sR7g==
X-Received: by 10.66.2.66 with SMTP id 2mr68730631pas.72.1385993738950; Mon,
 02 Dec 2013 06:15:38 -0800 (PST)
Received: by 10.70.93.35 with HTTP; Mon, 2 Dec 2013 06:15:38 -0800 (PST)
In-Reply-To: <20131202125748.GA275@x4>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238631>

On Mon, Dec 2, 2013 at 1:57 PM, Markus Trippelsdorf
<markus@trippelsdorf.de> wrote:
> When git is compiled with current gcc and "-march=native"
> git-blame segfaults:
>
> For example:
>
>  % gdb --args /var/tmp/git/git-blame gcc/tree-object-size.c
> ...
> Program received signal SIGSEGV, Segmentation fault.
> 0x0000000000000000 in ?? ()
> (gdb) bt
> #0  0x0000000000000000 in ?? ()
> #1  0x000000000051240d in xdl_emit_hunk_hdr (s1=s1@entry=30, c1=<optimized out>, s2=s2@entry=30, c2=c2@entry=6, func=func@entry=0x7fffffffd2d8 "", funclen=0,
>     ecb=ecb@entry=0x7fffffffd580) at xdiff/xutils.c:460
> #2  0x0000000000512af7 in xdl_emit_diff (xe=0x7fffffffd390, xscr=<optimized out>, ecb=0x7fffffffd580, xecfg=0x7fffffffd590) at xdiff/xemit.c:237

xdl_emit_diff() should not be called, because xecfg->hunk_func should
be non-null and called instead. xld_emit_diff() is the one that needs
outf to be set.

> #3  0x0000000000510a5d in xdl_diff (mf1=mf1@entry=0x7fffffffd510, mf2=mf2@entry=0x7fffffffd520, xpp=xpp@entry=0x7fffffffd570, xecfg=xecfg@entry=0x7fffffffd590,
>     ecb=ecb@entry=0x7fffffffd580) at xdiff/xdiffi.c:601

Here we decide that xecfg->hunk_func is empty, and ef is set to xdl_emit_diff.

> #4  0x000000000050b005 in xdi_diff (mf1=<optimized out>, mf2=<optimized out>, xpp=xpp@entry=0x7fffffffd570, xecfg=xecfg@entry=0x7fffffffd590, xecb=xecb@entry=0x7fffffffd580)
>     at xdiff-interface.c:136
> #5  0x00000000004104df in diff_hunks (file_a=<optimized out>, file_b=<optimized out>, ctxlen=ctxlen@entry=0, hunk_func=hunk_func@entry=0x411320 <blame_chunk_cb>,
>     cb_data=cb_data@entry=0x7fffffffd830) at builtin/blame.c:105

As we can see in your code below, ecb.outf is not set here, because
it's not needed by hunk_func.
hunk_func is set to blame_chunck_cb, passed by the function below.

> #6  0x0000000000412b54 in pass_blame_to_parent (parent=0x11da810, target=0x11dab50, sb=0x7fffffffd6e0) at builtin/blame.c:815

diff_hunks() is called with blame_chunck_cb as hunk_func.

I think the best thing to do is to find out where xecfg->hunk_func
loses the blame_chunck_cb value to NULL. You could start with a
watchpoint.

>[...]
> 460             if (ecb->outf(ecb->priv, &mb, 1) < 0)
> (gdb) l
> 455             }
> 456             buf[nb++] = '\n';
> 457
> 458             mb.ptr = buf;
> 459             mb.size = nb;
> 460             if (ecb->outf(ecb->priv, &mb, 1) < 0)
> 461                     return -1;
> 462
> 463             return 0;
> 464     }
> (gdb) p *ecb
> $1 = {
>   priv = 0x7fffffffd830,
>   outf = 0x0
> }
>
> If I leave xecfg uninitialized in the following function the issue goes
> away.

Would that mean that gcc is doing some steps in the wrong order ? That
is setting xecfg.hunk_func and then emptying the structure ? I've
already had a similar bug, but that's very unfortunate.

> From builtin/blame.c:
>   94 static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b, long ctxlen,
>   95                       xdl_emit_hunk_consume_func_t hunk_func, void *cb_data)
>   96 {
>   97         xpparam_t xpp = {0};
>   98         xdemitconf_t xecfg = {0};
>   99         xdemitcb_t ecb = {NULL};
>  100
>  101         xpp.flags = xdl_opts;
>  102         xecfg.ctxlen = ctxlen;
>  103         xecfg.hunk_func = hunk_func;
>  104         ecb.priv = cb_data;
>  105         return xdi_diff(file_a, file_b, &xpp, &xecfg, &ecb);
>  106 }
>  107
