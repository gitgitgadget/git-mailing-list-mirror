Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB1E72018A
	for <e@80x24.org>; Fri, 24 Jun 2016 19:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbcFXTft (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 15:35:49 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44616 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876AbcFXTft (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 15:35:49 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E62E2018A;
	Fri, 24 Jun 2016 19:35:48 +0000 (UTC)
Date:	Fri, 24 Jun 2016 19:35:48 +0000
From:	Eric Wong <e@80x24.org>
To:	Jacob Godserv <jacobgodserv@gmail.com>
Cc:	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: git-svn aborts with "Use of uninitialized value $u" when a
 non-svn-backed branch is present in remote
Message-ID: <20160624193548.GA22070@dcvr.yhbt.net>
References: <CALi1mtc8zmOzk-qv4XAg6N=ENasnMAENdJSLHK7EcpxRUk1nTw@mail.gmail.com>
 <CALi1mtdtNF_GtzyPTbfb7N51wwxsFY7zm8hsgwxr3tHcZZboyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALi1mtdtNF_GtzyPTbfb7N51wwxsFY7zm8hsgwxr3tHcZZboyg@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jacob Godserv <jacobgodserv@gmail.com> wrote:
> On Tue, Sep 22, 2015 at 2:48 PM, Jacob Godserv <jacobgodserv@gmail.com> wrote:
> > I found a specific case in which git-svn improperly aborts:
> >
> > 1. I created a git-svn repository, named "git-svn repo", by cloned an
> > svn repository via the git-svn tool.
> > 2. I created a normal git repository, named "configuration repo". I
> > renamed the master branch to "configuration". The initial commit adds
> > a README and some utility scripts.
> > 3. I created a bare repository, named "master repo".
> > 4. I pushed from the git-svn repo to the master repo.
> > 5. I pushed from the configuration repo to the master repo.
> >
> > The idea is the configuration branch, which is detached from any
> > git-svn history, can contain some useful tools, defaults, etc., that I
> > can share with teammates who want to use git on this svn project. It's
> > an odd use of git, but it has been working well.
> >
> > However, a vanilla distribution of Git for Windows 2.5.2 produces the
> > following error when running any git-svn command, such as "git svn
> > info", on the cloned master repo:
> >
> > Use of uninitialized value $u in substitution (s///) at
> > /mingw64/share/perl5/site_perl/Git/SVN.pm line 105.
> > Use of uninitialized value $u in concatenation (.) or string at
> > /mingw64/share/perl5/site_perl/Git/SVN.pm line 105.
> > refs/remotes/origin/configuration: 'svn+ssh://10.0.1.1/repos/projectA'
> > not found in ''
> >
> > In the mentioned SVN.pm file, after the line:
> >
> >                         my $u = (::cmt_metadata("$refname"))[0];
> >
> > I added the following four lines:
> >
> >                         if (not defined $u) {
> >                                 warn "W: $refname does not exist in
> > SVN; skipping";
> >                                 next;
> >                         }

Christian (Cc-ed) also noticed the problem a few weeks ago
and took a more drastic approach by having git-svn die
instead of warning:
http://mid.gmane.org/1462604323-18545-1-git-send-email-chriscool@tuxfamily.org
which landed as commit 523a33ca17c76bee007d7394fb3930266c577c02
in git.git: https://bogomips.org/mirrors/git.git/patch?id=523a33ca17c7

Is dying here too drastic and maybe warn is preferable?

> > git-svn appears to operate correctly with this patch. This is my first
> > time ever editing a perl script, so I apologize if I murdered an
> > adorable animal just now.
> >
> > I'm sending this in so more knowledgeable git-svn developers can
> > comment on this and fix this in the official distribution of git,
> > assuming there is a bug here to fix.
> >
> > --
> >     Jacob
> 
> This e-mail has gone ignored several months. Is the maintainer of
> git-svn on this mailing list? Should I submit this issue elsewhere?

Sorry, I wasn't paying attention to the list at that time.
It is customary to Cc: authors of the code in question
(that also decentralizes our workflow in case vger is down),
and also acceptable to send reminders after a week or two
in case we're overloaded with other work.
