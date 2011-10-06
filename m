From: Ben Boeckel <mathstuf@gmail.com>
Subject: Re: [PATCH 0/3] Be more careful when prunning
Date: Thu, 6 Oct 2011 16:51:03 -0400
Message-ID: <20111006205103.GA1271@erythro.kitwarein.com>
References: <1317932385-28604-1-git-send-email-cmn@elego.de>
Reply-To: mathstuf@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Oct 06 22:51:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBuug-0006tC-83
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 22:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759044Ab1JFUvM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 16:51:12 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42714 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755089Ab1JFUvL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 16:51:11 -0400
Received: by ywb5 with SMTP id 5so3008967ywb.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 13:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HQtPmmv9Azu9K+gAYr4hSWKUD9dgn7iaf1Z0MKJz3QI=;
        b=nNcPfK9sjQQJIY+3luIxYv1AbIouv3d/BZnI8NDLhwusnidUYFal28XcwVrLWLY6Ev
         JBPjIsjctvhSZQt36vPDEEk/vpueziv5zriQal9F328EI2ut0M9T01ilnYIkgWuNUClp
         qe0Ka5W7nLANi5CIe7sXrfwV9IZeW29Q6KgjU=
Received: by 10.236.129.242 with SMTP id h78mr5867239yhi.89.1317934270479;
        Thu, 06 Oct 2011 13:51:10 -0700 (PDT)
Received: from erythro (66-194-253-20.static.twtelecom.net. [66.194.253.20])
        by mx.google.com with ESMTPS id u66sm9400021yhu.13.2011.10.06.13.51.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 13:51:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1317932385-28604-1-git-send-email-cmn@elego.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183031>

On Thu, Oct 06, 2011 at 22:19:42 +0200, Carlos Mart=C3=ADn Nieto wrote:
> The first patch is not that big a deal, but it's better if we're
> freeing the refspecs, we might as well free all of them.
>=20
> The second patch teaches get_stale_heads to use the user-provided
> refspecs instead of the ones in the config. For example, running
>=20
>     git fetch --prune origin refs/heads/master:refs/heads/master
>=20
> doesn't remove the other branches anymore. For a more interesting (an=
d
> believable) example, let's take
>=20
>     git fetch --prune origin refs/heads/b/*:refs/heads/b/*
>=20
> because you want to prune the refs inside the b/ namespace
> only. Currently git will delete all the refs that aren't under that
> namespace. With the second patch applied, git won't remove any refs
> outside the b/ namespace.
>=20
> What is probably the most usual case is covered by the third patch,
> which pretends that a "refs/tags/*:refs/tags/*" refspec was given on
> the command-line.

I applied the patches to current master (7f41b6b) and got a segfault
with:

    git fetch -p -t origin master

It does not happen with master.

Backtrace:

(gdb) bt
#0  0x00007ffff7395d18 in __strchr_sse42 () from /lib64/libc.so.6
#1  0x00000000004b2d39 in find_in_refs (query=3D0x7fffffffdb90, ref_cou=
nt=3D2, refs=3D<optimized out>) at remote.c:1709
#2  get_stale_heads_cb (refname=3D0x7a8f31 "refs/heads/a/branch/name", =
sha1=3D0x7a8f09 "\367\343\375C=D9=A9\223u\305OG\233)z\347X\370\333\325"=
, <incomplete sequence \335>, flags=3D0, cb_data=3D0x7fffffffdc50) at r=
emote.c:1740
#3  0x00000000004adf19 in do_for_each_ref (submodule=3D<optimized out>,=
 base=3D0x4ea1c2 "", fn=3D0x4b2ca0 <get_stale_heads_cb>, trim=3D0, flag=
s=3D0, cb_data=3D0x7fffffffdc50) at refs.c:684
#4  0x00000000004b4249 in get_stale_heads (remote=3D<optimized out>, fe=
tch_map=3D<optimized out>, refs=3D<optimized out>, ref_count=3D<optimiz=
ed out>) at remote.c:1777
#5  0x0000000000426cfb in prune_refs (ref_map=3D<optimized out>, n=3D<o=
ptimized out>, refs=3D<optimized out>, transport=3D0x78e040) at builtin=
/fetch.c:511
#6  do_fetch (ref_count=3D<optimized out>, refs=3D<optimized out>, tran=
sport=3D0x78e040) at builtin/fetch.c:711
#7  fetch_one (remote=3D<optimized out>, argc=3D<optimized out>, argv=3D=
<optimized out>) at builtin/fetch.c:894
#8  0x0000000000427550 in cmd_fetch (argc=3D2, argv=3D0x7fffffffe070, p=
refix=3D0x0) at builtin/fetch.c:955
#9  0x0000000000405084 in run_builtin (argv=3D0x7fffffffe070, argc=3D5,=
 p=3D0x731b08) at git.c:308
#10 handle_internal_command (argc=3D5, argv=3D0x7fffffffe070) at git.c:=
466
#11 0x000000000040448b in run_argv (argv=3D0x7fffffffdf10, argcp=3D0x7f=
ffffffdf1c) at git.c:512
#12 main (argc=3D5, argv=3D0x7fffffffe070) at git.c:585

--Ben
