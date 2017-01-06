Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3D51FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 20:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932464AbdAFUKI (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 15:10:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:36168 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932439AbdAFUKE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 15:10:04 -0500
Received: (qmail 12470 invoked by uid 109); 6 Jan 2017 20:10:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 20:10:03 +0000
Received: (qmail 19960 invoked by uid 111); 6 Jan 2017 20:10:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 15:10:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2017 15:10:01 -0500
Date:   Fri, 6 Jan 2017 15:10:01 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Ralf Thielow <ralf.thielow@gmail.com>,
        Jake Lambert <jake@onahill.co>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git branch --editdescription fatal error
Message-ID: <20170106201001.pgxo4rl3d36veezs@sigill.intra.peff.net>
References: <MWHPR19MB11357994E6C43DBCC0931CD7BC630@MWHPR19MB1135.namprd19.prod.outlook.com>
 <CAGZ79kaz_hS9P7vqV9EhZazM_g0OUdRfMtFPJ7gFu-h-ku=NKw@mail.gmail.com>
 <CAN0XMO+zzYOXF2gwr=0Tu-7T5BH7f_L+FhfD8RUenDeq3xFHjA@mail.gmail.com>
 <CAGZ79kZOfHWP_pQGN1QcmR71Ft6ib0aPwNKX80YMT7KcK0_Stg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZOfHWP_pQGN1QcmR71Ft6ib0aPwNKX80YMT7KcK0_Stg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 06, 2017 at 11:43:52AM -0800, Stefan Beller wrote:

> >>> When executing "git branch <branch> --edit-description" on a branch with no description set, I get "fatal: could not unset 'branch.<branch>.description". It would seem that the unsetting piece should occur only after checking if it was set in the first place.
> >>
> >> That seems strange. Is it possible that your config is not writable?
> >> (.git/config, ~/gitconfig, you'd need to find out where the <branch>
> >> is configured already via git config --global/--system/--local --list)
> >>
> >
> > Have you actually tried to reproduce this issue? I'm on current next
> > and can reproduce the problem.
> 
> eh, I was on $random_version that I currently have installed
> (with messed up submodule code, but otherwise close to master).

Hmm. I can reproduce, but only in one situation: when the new
description is empty. In which case we try to delete the variable. In
other words:

  [this breaks; the file remains empty and we try to delete the
   nonexistent config]
  $ EDITOR=true git branch --edit-description master
  fatal: could not unset 'branch.master.description'

  [this works; we actually set the variable]
  $ EDITOR='echo foo >' git branch --edit-description master
  $ git config branch.master.description
  foo

  [and now the unsetting works; note we have to truncate here, since
   the file will be prepopulated with "foo" from the existing desc]
  $ EDITOR='>' git branch --edit-description master
  $ git config branch.master.description
  [no output]

The history of this behavior is a bit funny.

In old versions of git, we would return a failing exit code of "1" from
git-branch, with no message.

Then in bd25f89014 (branch: die on config error when editing branch
description, 2016-02-22), we actually started returning "0"! This was
because the config code did not propagate errors from its helper
functions in all cases.

That was fixed by 9c14bb08a4 (git_config_set_multivar_in_file: all
non-zero returns are errors, 2016-04-09), giving the behavior we see
today.

So between v2.7.3 and v2.8.3, we did return 0, but I think that was a
bug (we also returned 0 for a lot of other bogus cases, too).

I could see either behavior as reasonable, but I think the right
solution would be for the branch code from bd25f89014 to use the
"gently" function set the variable, and then decide which cases should
be silently ignored, and which propagated as errors.

-Peff
