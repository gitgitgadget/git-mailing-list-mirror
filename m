Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84D6F1FAF4
	for <e@80x24.org>; Tue,  7 Feb 2017 07:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753080AbdBGHa6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 02:30:58 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:39785 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752949AbdBGHa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 02:30:57 -0500
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
        by mailhub.007spb.ru (8.14.4/8.14.4/Debian-4+deb7u1) with SMTP id v177UqL8017286;
        Tue, 7 Feb 2017 10:30:53 +0300
Date:   Tue, 7 Feb 2017 10:30:52 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     Ron Pero <rpero@magnadev.com>
Cc:     Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Request re git status
Message-Id: <20170207103052.d81f8546e6071dced2491f39@domain007.com>
In-Reply-To: <CANOj2JGAaLLEHMs6KBf2PmCipqu-eYSGADzGGBzNVKwP0DTCtg@mail.gmail.com>
References: <CANOj2JG5VuDtS30PfOrZ=4q8pTv_frY7=p+0g=UW3yV6ev+1KQ@mail.gmail.com>
        <CABURp0qbKMfngfsC5pQeO+qyRPxa21vi090hMWDtLd+BBH_3Jg@mail.gmail.com>
        <CANOj2JGAaLLEHMs6KBf2PmCipqu-eYSGADzGGBzNVKwP0DTCtg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 6 Feb 2017 22:46:53 -0800
Ron Pero <rpero@magnadev.com> wrote:

[...]
> Still, one way or another, it was easy to feel tripped up by that and
> some kind of verbal cue could help.
> I wonder if this kind of message would help: Latest fetch: {timestamp}
[...]

Timestamps have little to no sense with regard to histories.

What you should make use of is the concept of "tracking branches".
The basic idea is outlined below.

When you fetch from a named remote, like with

  git fetch origin

Git creates/updates the so-called "remote" branches for that named
remote in your local repository.  They live in a special hierarchy of
branches distinct from your "normal" branches, and you typically refer
to them using short (incomplete in fact) names which include the name
of the remote they came from.

For instance, if the repo known as "origin" to your local one
contains the branches "master", "foo" and "devel" at the time the
command above was run, Git would create remote branches "origin/master",
"origin/foo" and "origin/devel".

The whole "remote branches" thing serves to provide you with sort of
bookmarks to the state of a remote repository it was last seen.

You can't commit your own work on remote branches, and can't push them
either (I'm oversimplifying things now but let's not digress).
That's because they are, well, bookmarks, and they are not "yours" --
as opposed to normal local branches.

Now another thing Git offers is the possibility to "link" any local
branch to any remote branch.  This mechanism is called "tracking".
The remote branch linked to a local branch is then called "an upstream"
for that local branch, and that local branch is said to be tracking
that upstream branch.

Say, if you've just fetched from a remote repository and want to work
on a branch "foo" someone created there, you can do

  git checkout -b foo --track origin/foo

if you have existing local branch which doesn't track any remote branch,
you can call

  git branch --set-upstream-to origin/whatever

when it's checked out to make it track the origin/whatever remote
branch.

Tracking makes many Git commands be extra chatty about the state of the
tracking local branch compared to the state of its upstream branch.
Say, `git status` will tell you how many different commits your local
and its upstream branch have compared to each other -- a clear sign
that you should consider merging or rebasing your local work if you're
about to push it to the upstream branch.

While tracking helps in this case, you must understand that Git is a
DVCS, and "D" in it means "distributed" which, in turn, implies
"disconnected".  You should very well understand, that pushing to a
remote repository is inherently racy in this model.  That is, by the
time your `git fetch origin` completed, the state of the branches it
just fetched might have already changed by someone else's push.
So unless your organization / team employs some policy on pushing (that
is, each push to certain "shared" branches must be discussed first and
receive a go-ahead from everyone) you have to be prepared for your
push being rejected because someone else will have managed to push
faster than you.

What I'm leading you to, is that showing you any sort of "last fetch
time" won't really help anyway.  You just should know the drill:

* Make use of the tracking feature.
* Never use --force with `git push` unless you absolutely positively
  understand what happens and you have discussed this with everyone
  else in the team or whoever is in charge for the project.
* If pushing fails, run `git fetch` and reconcile your local changes
  with whatever changes crept in there into the "upstream" branch,
  re-attempt pushing.  Rinse, repeat, if needed.

You're advised to read at least [1], or -- better -- the whole chapter
on branching (even better just read the whole book).

1. https://git-scm.com/book/en/v2/Git-Branching-Remote-Branches
