Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5410D1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 17:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfBTR30 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 12:29:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:49698 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbfBTR3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 12:29:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 715FFAD5D;
        Wed, 20 Feb 2019 17:29:23 +0000 (UTC)
Date:   Wed, 20 Feb 2019 18:29:22 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] worktree: fix worktree add race.
Message-ID: <20190220182922.21693fa7@kitsune.suse.cz>
In-Reply-To: <CAPig+cSdA8XRwCJQD3o6DZLwesBLRTys7OV6u0wy9Ve3Hp6XPA@mail.gmail.com>
References: <cover.1550508544.git.msuchanek@suse.de>
        <e134801d570d0a0c85424eb80b41893f4d8383ca.1550679076.git.msuchanek@suse.de>
        <CAPig+cSdA8XRwCJQD3o6DZLwesBLRTys7OV6u0wy9Ve3Hp6XPA@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Feb 2019 11:34:54 -0500
Eric Sunshine <sunshine@sunshineco.com> wrote:

> On Wed, Feb 20, 2019 at 11:17 AM Michal Suchanek <msuchanek@suse.de> wrote:
> > Git runs a stat loop to find a worktree name that's available and then does
> > mkdir on the found name. Turn it to mkdir loop to avoid another invocation of
> > worktree add finding the same free name and creating the directory first.
> >
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > @@ -295,8 +295,12 @@ static int add_worktree(const char *path, const char *refname,
> >         if (safe_create_leading_directories_const(sb_repo.buf))
> >                 die_errno(_("could not create leading directories of '%s'"),
> >                           sb_repo.buf);
> > -       while (!stat(sb_repo.buf, &st)) {
> > +       while (mkdir(sb_repo.buf, 0777)) {
> >                 counter++;
> > +               if ((errno != EEXIST) || !counter /* overflow */)
> > +                       die_errno(_("could not create directory of '%s'"),
> > +                                 sb_repo.buf);
> >                 strbuf_setlen(&sb_repo, len);
> >                 strbuf_addf(&sb_repo, "%d", counter);
> >         }
> > @@ -306,8 +310,6 @@ static int add_worktree(const char *path, const char *refname,
> >         atexit(remove_junk);
> >         sigchain_push_common(remove_junk_on_signal);
> > -       if (mkdir(sb_repo.buf, 0777))
> > -               die_errno(_("could not create directory of '%s'"), sb_repo.buf);
> >         junk_git_dir = xstrdup(sb_repo.buf);
> >         is_junk = 1;  
> 
> Did you audit this "junk" handling to verify that stuff which ought to
> be cleaned up still is cleaned up now that the mkdir() and die() have
> been moved above the atexit(remove_junk) invocation?
> 
> I did just audit it, and I _think_ that it still works as expected,
> but it would be good to hear that someone else has come to the same
> conclusion.

The die() is executed only when mkdir() fails so there is no junk to
clean up in that case.

Thanks

Michal
