Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC5EA207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 14:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934635AbcIPOMO (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 10:12:14 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.32]:45900 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935172AbcIPOLv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 10:11:51 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bktrk-0002Sn-N9; Fri, 16 Sep 2016 16:11:44 +0200
Date:   Fri, 16 Sep 2016 16:11:43 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Yaroslav Halchenko <yoh@onerussian.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [wishlist?] make submodule commands robust to having
 non-submodule Subprojects
Message-ID: <20160916141143.GA47240@book.hvoigt.net>
References: <20160915130233.GC9833@onerussian.com>
 <CAGZ79kZLdsKcf0t=dDB24VVe+V=uqQCW_VNQwSJ638m5Keu2nQ@mail.gmail.com>
 <xmqqwpidniry.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbYEqbr0h_0U=Ed-NRrsjb4XmznL8C45gTyJCVx+X-LTQ@mail.gmail.com>
 <xmqqsht1nhlh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsht1nhlh.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 15, 2016 at 11:27:54AM -0700, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> > So how about this fictional work flow:
> >
> >          $ git init top
> >          $ cd top
> >          $ git commit --allow-empty -m 'initial in top'
> >          $ git init sub
> >          $ git -C sub commit --allow-empty -m 'initial in sub'
> >          $ git add sub
> >         You added a gitlink, but no corresponding entry in
> >         .gitmodules is found. This is fine for gits core functionality, but
> >         the submodule command gets confused by this unless you add 'sub'
> >         to your .gitmodules via `git submodule add --already-in-tree \
> >         --reuse-submodules-origin-as-URL sub`. Alternatively you can make this
> >         message disappear by configuring advice.gitlinkPitfalls.
> 
> I am not sure if I agree with that direction.
> 
> If the trend in Git community collectively these days is to make
> usage of submodules easier and smoother, I'd imagine that you would
> want to teach "git add" that was given a submodule to "git submodule
> add" instead by default, with an option "git add --no-gitmodules
> sub" to disable it, or something like that.
> 
> >          $ git submodule add --fixup-modules-file ./sub sub
> >          Adding .gitmodule entry only for `sub` to use `git -C remote
> > show origin` as URL.
> 
> I agree that a feature like this is needed regardless of what
> happens at "git add" time.

How about just

   git submodule add <submodulepath>

? I remember back in the days when I started with submodules thats the
way I imagined submodules would work:

1. clone the submodule into a directory
2. git submodule add it
3. git commit everything

Because that how you basically work with files.  So instead of adding
another option I would rather like to autodetect that:

 * its a relative path inside this repo that is passed to
   'git submodule add'
 * there is no .gitmodules entry
 * and no .git/config
==> create those from a remote in the submodule

Corner cases:

 * If there is more than one remote we could tell the user to use an
   option to specify which one to use.
 * Barf in case there is no remote (not adding the submodule except -f
   is used).
 * If the gitlink is already there but no .gitmodules entry, 'git
   submodule add' will just add the entry as if it was initially added.

Instead of giving an error message that the submodule is already added
we could actually be nicer to the user and try to fix things for him
instead.

Cheers Heiko
