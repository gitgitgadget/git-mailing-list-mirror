Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1414421845
	for <e@80x24.org>; Mon, 30 Apr 2018 12:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753399AbeD3Mvo (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 08:51:44 -0400
Received: from ao2.it ([92.243.12.208]:54901 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752430AbeD3Mvn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 08:51:43 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fD8Fw-0001wb-C5; Mon, 30 Apr 2018 14:50:12 +0200
Date:   Mon, 30 Apr 2018 14:51:14 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [RFC 00/10] Make .the gitmodules file path configurable
Message-Id: <20180430145114.3c68c026b1e2844aaa9d4b6d@ao2.it>
In-Reply-To: <20180423174709.GA25128@aiede.svl.corp.google.com>
References: <20180412222047.5716-1-ao2@ao2.it>
        <20180423174709.GA25128@aiede.svl.corp.google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 23 Apr 2018 10:47:09 -0700
Jonathan Nieder <jrnieder@gmail.com> wrote:

> Hi,
>

Hi Jonathan, thank you for your comment.

> Antonio Ospite wrote:
> 
> > vcsh[1] uses bare git repositories and detached work-trees to manage
> > *distinct* sets of configuration files directly into $HOME.
> 
> Cool!  I like the tooling you're creating for this, though keep in mind
> that Git has some weaknesses as a tool for deployment.
>

I am not the author BTW, just a user trying to address the remaining
corner cases.

> In particular, keep in mind that when git updates a file, there is a
> period of time while it is missing from the filesystem, which can be
> problematic for dotfiles.
>

Thanks for the reminder, it may be worth mentioning this in vcsh
documentation, however I don't have knowledge of users experiencing
problems related to that.

> [...]
> > However when multiple repositories take turns using the same directory
> > as their work-tree, and more than one of them want to use submodules,
> > there could still be conflicts about the '.gitmodules' file because git
> > hardcodes this path.
> >
> > For comparison, in case of '.gitignore' a similar conflict might arise,
> > but git has alternative ways to specify exclude files, so vcsh solves
> > this by setting core.excludesFile for each repository and track ignored
> > files somewhere else (in ~/.gitignore.d/$VCSH_REPO_NAME).
> 
> For reference:
> 
> 	core.excludesFile
> 		Specifies the pathname to the file that contains
> 		patterns to describe paths that are not meant to be
> 		tracked, in addition to .gitignore (per-directory) and
> 		.git/info/exclude. Defaults to
> 		$XDG_CONFIG_HOME/git/ignore. If $XDG_CONFIG_HOME is
> 		either not set or empty, $HOME/.config/git/ignore is
> 		used instead. See gitignore(5).
> 
> Using this as a substitute for <worktree>/.gitignore is a bit of a
> hack.  It happens to work, though, so reading on. :)
> 
> [...]
> > So this series proposes a mechanism to set an alternative path for the
> > submodules configuration file (from now on "gitmodules file").
> 
> I am nervous about this.  I wonder if there is another way to
> accomplish the goal.
>
> One possibility would be to handle the case where .gitmodules is
> excluded by a sparse checkout specification and use .gitmodules from
> the index in that case.  Would that work for you?
> 

Since part of the problem is that .gitmodules *collide* between
repositories, a sparse-checkout approach make sense indeed.

As discussed[1] with Stefan Beller having git use .gitmodules from the
index without the need to have it checked out should work for us.

[1] https://www.spinics.net/lists/git/msg329153.html

Ideally git should also be able to write to that file when it's not
checked out (e.g. when running "git submodule add"), to save the
user from tedious sparse/unsparse rounds when operating with submodules.

As suggested by Stefan I'll first try to remove the hardcoded references
to .gitmodules in git-submodule.sh adding a helper sub-command to
access .gitmodules in a more robust way, and after that git could
be taught to use the file from the index, but this second part
is currently beyond my current git knowledge.

If this mechanism of using unchecked-out files from the index could be
extended to .gitignore (and .gitattributes), then vcsh might even stop
abusing core.excludesFile; sparse checkouts seem the more natural git
way to deal with colliding files in a shared-workdir scenario.

However, having users *write* to .gitignore and .gitattributes while
they are not checked out still sounds quite problematic to me, but maybe
this could be handled by vcsh itself, similarly to what is done for the
file pointed by core.excludesFile.

Ciao,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
