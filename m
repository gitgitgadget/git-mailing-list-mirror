Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23BA91F42D
	for <e@80x24.org>; Sun, 25 Mar 2018 09:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeCYJuM (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 05:50:12 -0400
Received: from sender-of-o51.zoho.eu ([31.186.226.243]:21093 "EHLO
        sender-of-o51.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbeCYJuK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 05:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1521971406;
        s=zoho; d=feusi.co; i=jeremy@feusi.co;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=4773; bh=U8Q9q3+/1B2U44z8UiPkr6SF8O0NsMroLkpCJtIgMOU=;
        b=O6AwmS7KZsTOUZXbcR7pDeB50W08yk/pfTHjjI2rDbZm+YhU2I79xi6snhtF9Sa7
        5JBOPhK3Joff/Ir+2UiMwI8cSY1UJ1X9wrIcJxWTFty7tghUtK1pu1W7X2Idt7USoZm
        t/H9dXf9Vgmnum652OGOp03hNJGNmp4DxAKbPMeg=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zoho; d=feusi.co; 
  h=date:from:to:cc:subject:message-id:mime-version:content-type:user-agent; 
  b=dKtqfdPo5gjAo5GPddEfXo+hBYZFwg4BPpNswBhmIQ9cdbtDvNHOO7fydBug+U+v8gnkiaFznh60
    CXT6d7YbFtJFoXQmRlwdlrGyIQsOdO7mvlY7g8HEqvdmmnQ16WUM8Rd8mkEWq13FsHTTmSKLtLpr
    Cz8QgPc51DN8RrHEwkI=  
Received: from feusi.co (194.191.224.221 [194.191.224.221]) by mx.zoho.eu
        with SMTPS id 1521971406146741.4922262524224; Sun, 25 Mar 2018 11:50:06 +0200 (CEST)
Date:   Sun, 25 Mar 2018 11:50:46 +0200
From:   Jeremy Feusi <jeremy@feusi.co>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Prathamesh Chavan <pc44800@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Null pointer dereference in git-submodule
Message-ID: <20180325095046.GA687@feusi.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Reply-To: 

Hmm... That's weird. I can reproduce it on 3 independant systems with
versions 2.16.2 up, although it does not work with version 2.11.0.
Anyway, I figured out how to reproduce this bug. It is caused when a
submodule is added and then the directory it resides in is moved or
deleted without commiting. For example:

git init
git submodule add https://github.com/git/git git
mv git git.BAK
git submodule status #this command segfaults

cheers
Jeremy

In-Reply-To: <a7ad9dbf-1b0f-efc6-3a17-51cf25381ce5@web.de>

On Sat, Mar 24, 2018 at 09:42:57PM +0100, René Scharfe wrote:
> Am 24.03.2018 um 18:42 schrieb Jeremy Feusi:
> > Hi,
> > While bootstrapping a gnu repository I noticed that git segfaulted when
> > called as "git submodule status". After compiling git with address
> > sanitizer and minimizing the directory I finally narrowed it down to the
> > files which I have attached as a tar archive. Here is a detailed backtrace:
> > 
> > AddressSanitizer:DEADLYSIGNAL
> > =================================================================
> > ==63400==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000000 (pc 0x000000c27a93 bp 0x7ffdcb4eec10 sp 0x7ffdcb4eeb80 T0)
> > ==63400==The signal is caused by a READ memory access.
> > ==63400==Hint: address points to the zero page.
> >      #0 0xc27a92 in refs_read_raw_ref /home/jfe/git/refs.c:1451:20
> >      #1 0xc174a6 in refs_resolve_ref_unsafe /home/jfe/git/refs.c:1493:7
> >      #2 0xc1826a in refs_read_ref_full /home/jfe/git/refs.c:224:6
> >      #3 0xc26d53 in refs_head_ref /home/jfe/git/refs.c:1314:7
> >      #4 0x8071e6 in status_submodule /home/jfe/git/builtin/submodule--helper.c:658:7
> >      #5 0x806a89 in status_submodule_cb /home/jfe/git/builtin/submodule--helper.c:699:2
> >      #6 0x80523e in for_each_listed_submodule /home/jfe/git/builtin/submodule--helper.c:438:3
> >      #7 0x7f7e9a in module_status /home/jfe/git/builtin/submodule--helper.c:732:2
> >      #8 0x7efd69 in cmd_submodule__helper /home/jfe/git/builtin/submodule--helper.c:1859:11
> >      #9 0x51e024 in run_builtin /home/jfe/git/git.c:346:11
> >      #10 0x5192c2 in handle_builtin /home/jfe/git/git.c:554:8
> >      #11 0x51d0f0 in run_argv /home/jfe/git/git.c:606:4
> >      #12 0x518600 in cmd_main /home/jfe/git/git.c:683:19
> >      #13 0x8501d6 in main /home/jfe/git/common-main.c:43:9
> >      #14 0x7f49fdaf2f29 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x20f29)
> >      #15 0x41f4b9 in _start (/home/jfe/git/inst/libexec/git-core/git+0x41f4b9)
> > 
> > AddressSanitizer can not provide additional info.
> > SUMMARY: AddressSanitizer: SEGV /home/jfe/git/refs.c:1451:20 in refs_read_raw_ref
> > ==63400==ABORTING
> > 
> > As mentioned above, this bug is triggered by issuing the command
> > "git submodule status" while in the attached directory.
> > 
> > This bug was confirmed on Debian with version 2.16.1 and
> > 2.17.0.rc1.35.g90bbd502d as well as on Arch Linux with version 2.16.2
> > where further output is given by git:
> > 
> > /usr/lib/git-core/git-submodule: line 979:  8119 Segmentation fault      (core dumped) git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper status ${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive} "$@"
> > 
> 
> You may have minimized too much.  With the patch below I get:
> 
> 	fatal: no ref store in submodule 'gnulib'
> 
> I guess you'll get a different one in your original repo.
> 
> The patch seems like a good idea in any case, though.
> 
> -- >8 --
> Subject: [PATCH] submodule: check for NULL return of get_submodule_ref_store()
> 
> refs_head_ref() requires a valid ref_store pointer to be given as its
> first argument.  get_submodule_ref_store() can return NULL.  Exit and
> report the failure to find a ref store in that case instead of
> segfaulting.
> 
> Reported-by: Jeremy Feusi <jeremy@feusi.co>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/submodule--helper.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index ee020d4749..0f74e81005 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -654,9 +654,11 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
>  			     displaypath);
>  	} else if (!(flags & OPT_CACHED)) {
>  		struct object_id oid;
> +		struct ref_store *refs = get_submodule_ref_store(path);
>  
> -		if (refs_head_ref(get_submodule_ref_store(path),
> -				  handle_submodule_head_ref, &oid))
> +		if (!refs)
> +			die(_("no ref store in submodule '%s'"), path);
> +		if (refs_head_ref(refs, handle_submodule_head_ref, &oid))
>  			die(_("could not resolve HEAD ref inside the "
>  			      "submodule '%s'"), path);
>  
> -- 
> 2.16.3

