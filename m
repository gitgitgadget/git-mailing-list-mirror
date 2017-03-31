Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 924DC1FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 14:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755025AbdCaOev (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 10:34:51 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:56800 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754871AbdCaOeu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 10:34:50 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
        by mailhub.007spb.ru (8.14.4/8.14.4/Debian-4+deb7u1) with SMTP id v2VEYZQP010108;
        Fri, 31 Mar 2017 17:34:36 +0300
Date:   Fri, 31 Mar 2017 17:34:35 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     git@jessiehernandez.com
Cc:     "David Shrader" <dshrader@lanl.gov>, git@vger.kernel.org,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: ttk error when starting git gui
Message-Id: <20170331173435.c822389c9fc7ebe15c20ed00@domain007.com>
In-Reply-To: <2db3bf6de4e169f0c116ba77b74998b4.squirrel@mail.jessiehernandez.com>
References: <0fc69c73-73aa-5355-264b-a7c55377eec2@lanl.gov>
        <916067befdc828e5d33dd3c1817989e7.squirrel@mail.jessiehernandez.com>
        <20170331103330.5d7c414b6a0273cefb8508f2@domain007.com>
        <ff7628d7c69ecd3d212b29fec33f6ba1.squirrel@mail.jessiehernandez.com>
        <7447cca107bbc922877f8b80e9f3d934.squirrel@mail.jessiehernandez.com>
        <20170331105803.814cef2ce06b9171901206f4@domain007.com>
        <2db3bf6de4e169f0c116ba77b74998b4.squirrel@mail.jessiehernandez.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 31 Mar 2017 13:29:04 +0200
"Jessie Hernandez" <git@jessiehernandez.com> wrote:

> > On Fri, 31 Mar 2017 09:53:38 +0200
> > "Jessie Hernandez" <git@jessiehernandez.com> wrote:
> >
> > [...]
> >> >> It's possible to have ttk with 8.5 as well (say, here on Debian
> >> >> 8.5 ships with ttk enabled).
> >> >>
> >> >> A proper patch would be
> >> >>
> >> >> -set default_config(gui.usettk) 1
> >> >> +set default_config(gui.usettk) [namespace exists ::ttk]
> >> >>
> >> >> Could you please test it on your system?
> >> >>
> >> >
> >> > Yeah that seems to work.
> >> > Thanks for this.
> >> >
> >> > I have tried it with git 2.12.2
> > [...]
> >> I spoke to soon. :(
> >> It does not work. I forgot to do a install when testing.
> >> Sorry for the confusion.
> >
> > Care to elaborate on the exact error, please?
> >
> 
> The error I get is the following
> 
> Error in startup script: wrong # args: should be "ttk::style theme
> use theme" while executing
> "ttk::style theme use"
>     (procedure "ttext" line 4)
>     invoked from within
> "ttext $ui_workdir -background white -foreground black \
> 	-borderwidth 0 \
> 	-width 20 -height 10 \
> 	-wrap none \
> 	-takefocus 1 -highlightthickness 1\
> 	..."
>     (file "/usr/libexec/git-core/git-gui" line 3190)

Too bad: the git-gui relies on the [ttk::style theme use] command --
that is, the two-argument invocation of [ttk::style] -- to return
the theme being currently in use, and this feature was implemented
on 2008-05-27 [1] by Pat Thoyts.

Judging from the output of

  fossil descendants e83b7dd29ddae998f96538584afb518849ac1e2c

the first Tk release to have this change was 8.6b2.

So the proper fix appears to be more involved:

 set default_config(gui.usettk) \
   [expr {[package vcompare [info patchlevel] 8.6b2] >= 0}]

(The slash+newline sequence is not needed -- it's here mostly
for pretty-printing.)

1. http://core.tcl.tk/tk/info/e83b7dd29ddae998
