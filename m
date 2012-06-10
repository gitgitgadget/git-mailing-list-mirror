From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Sanity Check: scrum teams, shared 'story branches', rebasing shared branches
Date: Sun, 10 Jun 2012 04:35:40 -0000
Message-ID: <f02de4149bf84cd78e41c22088413b31-mfwitten@gmail.com>
References: <3EA7D039-9D6E-4945-A982-43DB53AAE43A@gmail.com>
Cc: git@vger.kernel.org
To: Christofer Jennings <boz.lists@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 06:44:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sda0j-00046d-Cz
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 06:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768Ab2FJEoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 00:44:16 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:60485 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab2FJEoP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 00:44:15 -0400
Received: by wgbds11 with SMTP id ds11so2375864wgb.1
        for <git@vger.kernel.org>; Sat, 09 Jun 2012 21:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=ltybzMefphxtrRV8gduBEB73EwbeyVwIOzikvroPIYs=;
        b=LoVOBRFVbtDQVY1lqxHZRq0cDOh6Ia1vV5Lm0VyZiGvEV4mYWSjYdtbadW2kA7cg82
         B0gFaxycGEgopjuE9uLt8RgGQsFjdHVwru4YX1OAv3uY7FN71GL2vBYIoqKnj5KMgYkd
         o7wya9058U34o+yhMRiBr1jwuLE0tP5ZMBeG9E5jfigCAa+E4QkinbDl1JVZ6WaCy4Fe
         EZQfYvFvWyheM51U1ZU8WkgTIMC0hQXkoPugreZAn6FXGpDkrlTggQUxa0d+gutLCfOG
         YoG5MWT62MQZmZUJ8QWLqUWnRU8P6Ka3sHnJ8nIwvM2h9mdiutojPfUNsLZ1/E743APh
         M6Jw==
Received: by 10.180.78.228 with SMTP id e4mr11538160wix.4.1339303454607;
        Sat, 09 Jun 2012 21:44:14 -0700 (PDT)
Received: from gmail.com ([89.248.172.227])
        by mx.google.com with ESMTPS id j4sm14030017wiz.1.2012.06.09.21.44.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Jun 2012 21:44:13 -0700 (PDT)
In-Reply-To: <3EA7D039-9D6E-4945-A982-43DB53AAE43A@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199566>

On Sat, 9 Jun 2012 16:51:28 -0700, Christofer Jennings wrote:

> I've been using Git and GitHub for ~6 months. Working on a SCM plan
> for a Scrum project with 50+ developers in ~8 dev. teams. Each team
> will be working on one or two stories simultaneously, so expect ~16
> 'story branches' (and master) at any given time. We've got GitHub
> Enterprise and are working out how to manage story development on
> shared branches that get merged to master only after going through
> acceptance & peer review. We hope stories will only be 3 - 5 days to
> complete, but may take 2 weeks. We're promoting frequent pushes to
> story branches.
>
> After a number of experiments and doing online research, we're
> thinking to use rebase to keep the story branches up-to-date with
> master while the story branches are in development. This seems to be
> the best approach because it will allow us to use bisect to isolate
> issues, and it will give us the most linear history graph.

You can use bisect to isolate issues regardless of merges. Also, linear
histories are not always better histories; for one, merge commits can
usefully encode the way that something was actually developed.

> So, here's my question: Can we use "rebase -s recursive -Xtheirs" as
> shown below?
>
> In this experiment, we're on 'story' branch 's1'. It's behind master
> because another story has been merged to master. We need to rebase
> to master and then rebase to origin/s1 to be up-to-date. So we...
>
>   git fetch -v
>   git rebase origin/master
>   ... resolve stuff ...
>   git rebase -s recursive -Xtheirs origin/s1

Let's expand that a bit for the sake of discussion:

  git fetch -v
  git branch -f s1_0            # Additional line
  git rebase origin/master
  ... resolve stuff ...
  git branch -f s1_1            # Additional line
  git rebase -s recursive -Xtheirs origin/s1

So:

  * The first rebase applies all the commits in `origin/master..s1_0'
    on top of the commit to which `origin/master' points; the branch
    heads `s1' and `s1_1' are then set to point to the youngest of
    the resulting commits.

  * The second rebase applies all the commits in `origin/s1..s1_1'
    on top of the commit to which `origin/s1' points; the branch
    heads `s1' and `s1_2' are then set to point to the youngest of
    the resulting commits.

In that second rebase, the range:

  origin/s1..s1_1

is equivalent to:

  ^origin/s1 s1_1

which is equivalent to:

  ^origin/s1 origin/master s1_1

because `origin/master' is reachable from `s1_1'. This in turn is
equivalent to:

  origin/s1..origin/master origin/s1..s1_1

In other words, the second rebase applies all the commits in
`origin/s1..origin/master' (namely, possibly the commits from
the other story) ON TOP of the commit pointed to by `origin/s1',
which is probably not what you want; the code might be correct,
but the history is probably not.

To see for yourself, try this small example:

  $ git init origin; cd origin
  $ echo 0 > a; git add a; git commit -m Initial
  $ git branch s1
  $ echo 1 > a; git commit -am 'Other Story'
  $ cd ..; git clone origin local
  $ cd origin; git checkout s1
  $ echo 0 > b; git add b; git commit -m 'Shared s1 update'
  $ cd ../local
  $ git checkout -b s1 origin/s1
  $ echo 0 > c; git add c; git commit -m 'Local s1 work'
  $ git fetch
  $ git rebase origin/master
  $ git rebase origin/s1
  First, rewinding head to replay your work on top of it...
  Applying: Other Story
  Applying: Local s1 work
  $ git log --format=%s --graph
  * Local s1 work
  * Other Story
  * Shared s1 update
  * Initial

> The "-s recursive -Xtheirs" part seems to result in all the right code
> at the end. We only had to "git add && git rebase --continue" for
> deleted files.

Two points:

  * I think it's dangerous to ignore any conflicts, let alone when mixing
    code from multiple upstreams.

  * Be certain that you don't want -Xours. IIRC, during a rebase, the commits
    that have already been placed in the new history (which includes the
    upstream) are considered `ours' during a rebase.

Basically, you need to define more strictly what "upstream" means in your
project, and you need to be less afraid of merging, a fundamental process
around which git was designed.

Sincerely,
Michael Witten
