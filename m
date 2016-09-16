Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F8651FCA9
	for <e@80x24.org>; Fri, 16 Sep 2016 09:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757285AbcIPJfE (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 05:35:04 -0400
Received: from smtprelay01.ispgateway.de ([80.67.29.23]:38919 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757104AbcIPJfD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 05:35:03 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bkpXu-0002XR-Nq; Fri, 16 Sep 2016 11:34:58 +0200
Date:   Fri, 16 Sep 2016 11:34:57 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Jens Lehmann <jens.lehmann@web.de>
Subject: Re: [RFC] extending pathspec support to submodules
Message-ID: <20160916093456.GA1488@book.hvoigt.net>
References: <1473897473-154528-1-git-send-email-bmwill@google.com>
 <20160915115752.GA37903@book.hvoigt.net>
 <CAKoko1rtEydwbWoEq9MBW41qqa10Bm+x0d6zS+Bptk51RjMOMA@mail.gmail.com>
 <xmqqr38klst6.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZJUQhY_bEi1G3zMYR2iGq5gosfVsBP_CFoaMydXP6QUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZJUQhY_bEi1G3zMYR2iGq5gosfVsBP_CFoaMydXP6QUw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Sep 15, 2016 at 03:28:21PM -0700, Stefan Beller wrote:
> On Thu, Sep 15, 2016 at 3:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Brandon Williams <bmwill@google.com> writes:
> >
> >> You're right that seems like the best course of action and it already falls
> >> inline with what I did with a first patch to ls-files to support submodules.
> >> In that patch I did exactly as you suggest and pass in the prefix to the
> >> submodule and make the child responsible for prepending the prefix to all of
> >> its output.  This way we can simply pass through the whole pathspec (as apposed
> >> to my original idea of stripping the prefix off the pathspec prior to passing
> >> it to the child...which can get complicated with wild characters) to the
> >> childprocess and when checking if a file matches the pathspec we can check if
> >> the prefix + file path matches.
> >
> > That's brilliant.  A few observations.
> >
> >  * With that change to tell the command that is spawned in a
> >    submodule directory where the submodule repository is in the
> >    context of the top-level superproject _and_ require it to take a
> >    pathspec as relative to the top-level superproject, you no longer
> >    worry about having to find where to cut the pathspec given at the
> >    top-level to adjust it for the submodule's context.  That may
> >    simplify things.
> 
> I wonder how this plays together with the prefix in the superproject, e.g.
> 
>     cd super/unrelated-path
>     # when invoking a git command the internal prefix is "unrelated-path/"
>     git ls-files ../submodule-*
>     # a submodule in submodule-A would be run in  submodule-A
>     # with a superproject prefix of super/ ? but additionally we nned
> to know we're
>     # not at the root of the superproject.

Do we need to know that? The internal prefix is internal to each
repository and can be treated as such. I would expect that the prefix is
only prefixed when needed. E.g. when we display output to the user,
match files, ...

How about "../submodule-A" as the submodule prefix in the situation you
describe? The wildcard would be resolved by the superproject since the
directory is still in its domain.

I would think of the submodule prefix as the path relative to the
command that started everything. E.g. if we have a tree like this:

        *--subA
       /
super *--subB--subsubB
       \
        *--dirC

where subA, subB and subsubB are submodules and dirC is just a
directory inside super.

We would get the following prefixes when issuing a command in dirC that
has a pathspec for subsubB:

  subB: ../subB
  subsubB: ../subB/subsubB

An interesting case is when we issue a command in subA:

  super:   ..
  subB:    ../subB
  subsubB: ../subB/subsubB

A rule for the prefix option could be: Always specified when crossing a
repository boundary with the pathspec (including upwards).

I have not completely thought this through though so just take this as
some food for thought. Since I am not sure what Junio's rationale behind
making the prefix relative to the toplevel superproject was, but I guess
finding it could be a challenge in some situations. I.e. is the
repository in home directory tracking all the dot-files really the
superproject or was it that other one I found before?

> >    So we may have to rethink what this option name should be.  "You
> >    are running in a repository that is used as a submodule in a
> >    larger context, which has the submodule at this path" is what the
> >    option tells the command; if any existing command already has
> >    such an option, we should use it.  If we are inventing one,
> >    perhaps "--submodule-path" (I didn't check if there are existing
> >    options that sound similar to it and mean completely different
> >    things, in which case that name is not usable)?
> 
> Would it make sense to add the '--submodule-path' to a more generic
> part of the code? It's not just ls-files/grep that have to solve exactly this
> problem. Up to now we just did not go for those commands, though.

Yes I think so, since it should also handle starting from a submodule
with a pathspec to the superproject or other submodule. In case we
go with my above suggestion I would suggest a more generic name since
the option could also be passed to processes handling the superproject.
E.g. something like --module-prefix or --repository-prefix comes to my
mind, not checked though.

Cheers Heiko
