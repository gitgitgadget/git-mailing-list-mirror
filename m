Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 034312036B
	for <e@80x24.org>; Tue,  3 Oct 2017 12:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753894AbdJCMcn (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 08:32:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:58946 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751194AbdJCMcl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 08:32:41 -0400
Received: (qmail 24533 invoked by uid 109); 3 Oct 2017 12:32:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 12:32:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7352 invoked by uid 111); 3 Oct 2017 12:32:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 08:32:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 08:32:39 -0400
Date:   Tue, 3 Oct 2017 08:32:39 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Loic Guelorget <loic@google.com>,
        Stefan Beller <sbeller@google.com>,
        Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Security of .git/config and .git/hooks
Message-ID: <20171003123239.lisk43a2goxtxkro@sigill.intra.peff.net>
References: <20171002234517.GV19555@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171002234517.GV19555@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2017 at 04:45:17PM -0700, Jonathan Nieder wrote:

> This topic has been mentioned on this mailing list before but I had
> trouble finding a relevant reference.  Links welcome.

There were discussions long ago related to the upload-pack hook. One of
the proposed fixes was checking the owner of the hook against the
running user, but in the end we just removed it.

Some of the discussion I have in my mail archive is off-list, but it was
brought up on-list later, too:

  https://public-inbox.org/git/6f8b45101001141001q40d8b746v8385bc6ae37a6af4@mail.gmail.com/

The owner-match thing is intriguing, but I think it only helps with
multi-user systems. For your zipfile case, there's literally no
information on the disk about whether the repo is trusted or not. You'd
have to put Git into an "untrusted" mode.

There's also some prior art in the uploadpack.packObjectsHook, which is
ignored totally in repo-level config.

> Suppose that I add the following to .git/config in a repository on a
> shared computer:
> 
> 	[pager]
> 		log = rm -fr /
> 		fsck = rm -fr /
> 
> ("rm -fr /" is of course a placeholder here.)
> 
> I then tell a sysadmin that git commands are producing strange output
> and I am having trouble understanding what is going on.  They may run
> "git fsck" or "git log"; in either case, the output is passed to the
> pager I configured, allowing me to run an arbitrary command using the
> sysadmin's credentials.

I know you probably didn't mean this to be an exhaustive list, but there
are really a ton of config options that can result in executing
arbitrary commands. External diff, textconv, ssh commands, and so on.

I don't think that changes your point any, but it's something to keep in
mind when evaluating solutions:

  - if individual options need to be annotated as unsafe, there's a high
    risk of missing an option (or introducing a new one incorrectly)

  - any schemes which reduce functionality (e.g., by disallowing certain
    options in repo config by default) are going to affect a lot of
    people

> Proposed fix: because of case (1), I would like a way to tell Git to
> stop trusting any files in .git.  That is:
> 
>  1. Introduce a (configurable) list of "safe" configuration items that
>     can be set in .git/config and don't respect any others.

A whitelist is obviously safer than a blacklist. Though I also feel like
some of the options may give an unexpectedly wide attack surface. I.e.,
I wouldn't be surprised if some innocent-looking option ends up being
used in a tricky way to gain more access. E.g., submodule config
pointing to paths outside of the repository.

Do you plan to run in safe-mode all the time? What if safe-mode was a
lot more extreme, and simply avoided reading repo-level config at all
(except for check_repository_format(), which should be pretty innocent).

I have a feeling there are some features (like submodules) that would
simply be broken in safe-mode.

>  2. But what if I want to set a different pager per-repository?
>     I think we could do this using configuration "profiles".
>     My ~/.config/git/profiles/ directory would contain git-style
>     config files for repositories to include.  Repositories could
>     then contain
> 
> 	[include]
> 		path = ~/.config/git/profiles/fancy-log-pager
> 
>     to make use of those settings.  The facility (1) would
>     special-case this directory to allow it to set "unsafe" settings
>     since files there are assumed not to be under the control of an
>     attacker.

You can do something quite similar already:

  git config --global \
    include.gitdir:/path/to/specific/repo.path
    .gitconfig-fancy-log-pager

The main difference is that the profile inclusion is done by path rather
than riding along with the repository directory if it gets moved. In
practice I doubt that matters much, and I think the security model for
include.gitdir is a lot simpler.

>  3. Likewise for hooks: my ~/.config/git/hooks/ directory would
>     contain hooks for repositories to make use of.  Repositories could
>     symlink to hook files from there to make use of them.
> 
>     That would allow the configured hooks in ~/.config/git/hooks/ to
>     be easy to find and to upgrade in one place.
> 
>     To help users migrate, when a hook is present and executable in
>     .git/hooks/, Git would print instructions for moving it to
>     ~/.config/git/hooks/ and replacing it with a symlink after
>     inspecting it.

I kind of wonder if the path-limited includes from above plus
core.hooksPath would be simpler. The source of authority then is always
outside of the repository, rather than trying to vet some values inside
the repository.

Reading more, I think I just reinvented your 3b.

> For backward compatibility, this facility would be controlled by a
> global configuration setting.  If that setting is not enabled, then
> the current, less safe behavior would remain.

Are config and symlinks everything we need to care about? I can't think
of anything else, but Git really has quite a large attack surface when
accessing a local repo. Right now the safest thing you can do is "git
clone --no-local" an untrusted repo and then look only at the clone. Of
course nobody _actually_ does that, so any "safe" mode seems like it
would be an improvement. But would claiming to have a "safe" mode
encourage people to use it to look at risky repositories, exacerbating
any holes (e.g., exploiting a bug in the index format)? I don't know.

-Peff
