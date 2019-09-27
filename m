Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75D341F463
	for <e@80x24.org>; Fri, 27 Sep 2019 13:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfI0NFo (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 09:05:44 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:58503 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfI0NFo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 09:05:44 -0400
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id ED69C100016;
        Fri, 27 Sep 2019 13:05:41 +0000 (UTC)
Date:   Fri, 27 Sep 2019 18:35:39 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] respect core.hooksPath, falling back to .git/hooks
Message-ID: <20190927130539.52oir56byuedqmm3@yadavpratyush.com>
References: <pull.361.git.gitgitgadget@gmail.com>
 <eca193f91b85fc4ffea453bc3adb64bc5c8831a8.1569532628.git.gitgitgadget@gmail.com>
 <20190926223638.6tk2qhc4e62hs2wt@yadavpratyush.com>
 <CAKPyHN1P713bTb2TYXFuXcM5Dg=7vXBVgchwvJUrNsQ6EcP5Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPyHN1P713bTb2TYXFuXcM5Dg=7vXBVgchwvJUrNsQ6EcP5Rg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/09/19 08:10AM, Bert Wesarg wrote:
> On Fri, Sep 27, 2019 at 12:40 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
> >
> > Hi,
> >
> > On 26/09/19 02:17PM, Johannes Schindelin via GitGitGadget wrote:
> > > From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > >
> > > Since v2.9.0, Git knows about the config variable core.hookspath
> > > that allows overriding the path to the directory containing the
> > > Git hooks.
> > >
> > > Since v2.10.0, the `--git-path` option respects that config
> > > variable, too, so we may just as well use that command.
> > >
> > > For Git versions older than v2.5.0 (which was the first version to
> > > support the `--git-path` option for the `rev-parse` command), we
> > > simply fall back to the previous code.
> > >
> > > This fixes https://github.com/git-for-windows/git/issues/1755
> > >
> > > Initial-patch-by: Philipp Gortan <philipp@gortan.org>
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > >  git-gui.sh | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/git-gui.sh b/git-gui.sh
> > > index fd476b6999..b2c6e7a1db 100755
> > > --- a/git-gui.sh
> > > +++ b/git-gui.sh
> > > @@ -623,7 +623,11 @@ proc git_write {args} {
> > >  }
> > >
> > >  proc githook_read {hook_name args} {
> > > -     set pchook [gitdir hooks $hook_name]
> > > +     if {[package vcompare $::_git_version 2.5.0] >= 0} {
> > > +             set pchook [git rev-parse --git-path "hooks/$hook_name"]
> > > +     } else {
> > > +             set pchook [gitdir hooks $hook_name]
> > > +     }
> >
> > gitdir is used in a lot of places, and I think all those would also
> > benefit from using --git-path. So I think it is a better idea to move
> > this to the procedure gitdir. It would have to be refactored to take any
> > number of arguments, instead of the two it takes here.
> 
> gitdir already takes an arbitrary number of arguments and joins them
> to a path. The more imminent challenge is, that gitdir caches the
> GIT_DIR, thus it tries to avoid calling "git rev-parse". Which works
> for most, but not for hooks.

What I was thinking of was something like this:

  - If no args are passed, then just directly return $_gitdir. This is 
    already being done. I assume the GIT_DIR relocation is already 
    handled by `git rev-parse --git-dir`, so this would point to the 
    correct location.
  - If args are passed, then we want a subdirectory of GIT_DIR In this 
    case, it is possible that this subdirectory has also been relocated 
    (hooks/ being one of those subdirectories). So in this case, use 
    `git rev-parse --git-path` instead.

So the gitdir procedure would look something like:

  proc gitdir {args} {
  	global $_gitdir
  	if {$args eq {}} {
  		# Return the cached GIT_DIR
  		return $_gitdir
  	}
  
  	# Use `git rev-parse --git-path` to get the path instead of 
  	# using the cached value.
  }

Am I missing something? Or does this fix the issue you describe?
 
> We could either maintain a blacklist, for what we cache the result
> too, or always call "git rev-parse --git-dir".
> 
> This blacklist would need to be in sync with the one in Git's
> path.c::adjust_git_path() than.

Is caching GIT_DIR that important in terms of performance? Otherwise, 
I'd say calling `git rev-parse --git-path` for _every_ subdirectory of 
GIT_DIR is a much simpler solution.

-- 
Regards,
Pratyush Yadav
