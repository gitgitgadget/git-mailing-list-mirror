From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Need help deciding between subtree and submodule
Date: Wed, 18 Mar 2015 21:20:58 +1300
Message-ID: <CAFOYHZCCUUjLnv3qpMBVPExR+4jdu09y5c8BcN8SNT0HWzqpHw@mail.gmail.com>
References: <CAHd499DN1FUzxGYBtUmZ_gKcCvXWJdR6-6XYXsN6BRn0LVO84g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 09:21:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY9Dw-0003FJ-CO
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 09:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755319AbbCRIVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 04:21:03 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36221 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755303AbbCRIU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 04:20:58 -0400
Received: by pdbcz9 with SMTP id cz9so36100548pdb.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 01:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=j4J8QDaoTJRcA0YPYoKFR7CpNxZnVilToKi274Y7KPM=;
        b=xVNvsFrhiOkb581Nr7Yvfc+VJp54yC5tyPQ2AmnBc5THt2OASbB2d2FAw80tE63ppW
         E/AV21gQMuidLMQhRVpwWsHEZlR0w1PCFuY3a7sFx6QpVqs9njAx+S9Z9iSmIdisdfqS
         6sMJvxw5fBtdPVNf/JwT6OMd2ys/vPmoyOQg+BeNruUI+6pQ6T3Qm1VdLgCaJiOE+D/n
         oL0qKnF1jzu3EMkhRvQ0y9gNrnMGhmfPYvoFNlrgd9/2R/LC0TQ0atYQdkrtI3oWSRcN
         liwrxK+VEZhKP+WXYklQPhYch3cZnneqgLyX7VqQ9R10JqM+8YssTZoBRTmD7Ofq4Xx6
         TZuw==
X-Received: by 10.70.118.134 with SMTP id km6mr155528127pdb.162.1426666858389;
 Wed, 18 Mar 2015 01:20:58 -0700 (PDT)
Received: by 10.70.0.171 with HTTP; Wed, 18 Mar 2015 01:20:58 -0700 (PDT)
In-Reply-To: <CAHd499DN1FUzxGYBtUmZ_gKcCvXWJdR6-6XYXsN6BRn0LVO84g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265693>

My $0.02 based on $dayjob

(disclaimer I've never used subtree)

On Wed, Mar 18, 2015 at 11:14 AM, Robert Dailey
<rcdailey.lists@gmail.com> wrote:
> At my workplace, the team is using Atlassian Stash + git
>
> We have a "Core" library that is our common code between various
> projects. To avoid a single monolithic repository and to allow our
> apps and tools to be modularized into their own repos, I have
> considered moving Core to a subtree or submodule.

Our environment is slightly different. Our projects are made up
entirely of submodules, we don't embed submodules within a repo with
actual code (side note: I know syslog-ng does so it might be worth
having a look around there).

Day to day development is done at the submodule level. A developer
working on a particular feature is generally only touching one repo
notwithstanding a little bit of to-and-fro as they work on the UI
aspects. When changes do touch multiple submodules the pushes can
generally be ordered in a sane manner. Things get a little complicated
when there are interdependent changes, then those pushes require
co-operation between submodule owners.

The key to making this work is our build system. It is the thing that
updates the project repo. After a successful build for all targets (we
hope to add unit/regression tests one day) the submodules sha1s are
updated and a new baseline (to borrow a clearcase term) is published.
Developers can do "git pull && git submodule update" to get the latest
stable baseline, but they can also run git pull in a submodule if they
want to be on the bleeding edge.

> I tried subtree and this is definitely far more transparent and simple
> to the team (simplicity is very important), however I notice it has
> problems with unnecessary conflicts when you do not do `git subtree
> push` for each `git subtree pull`. This is unnecessary overhead and
> complicates the log graph which I don't like.
>
> Submodule functionally works but it is complicated. We make heavy use
> of pull requests for code reviews (they are required due to company
> policy). Instead of a pull request being atomic and containing any app
> changes + accompanying Core changes, we now need to create two pull
> requests and manage them in proper order. Things also become more
> difficult when branching. All around it just feels like submodule
> would interfere and add more administration overhead on a day to day
> basis, affecting productivity.

We do have policies around review etc. With submodules it does
sometimes require engaging owners/reviewers from multiple
repositories. Tools like Gerrit can help, particularly where multiple
changes and reviewers are involved.

> Is there a third option here I'm missing? If only that issue with
> subtree could be addressed (the conflicts), it would be perfect enough
> for us I think. I have done all the stackoverflow reading and research
> I can manage at this point. I would really love some feedback from the
> actual git community on what would be a practical solution and
> structure here from a company perspective.

There's the thing google use for android, I think it's called "repo".
There's a few googlers around here so mybe one of them will chime in.
