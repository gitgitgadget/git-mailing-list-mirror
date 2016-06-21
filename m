Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 928A91FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 23:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbcFUXGs (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 19:06:48 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:56659 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbcFUXGp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 19:06:45 -0400
Received: from homiemail-a119.g.dreamhost.com (caibbdcaaahg.dreamhost.com [208.113.200.76])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 4566AA9D37
	for <git@vger.kernel.org>; Tue, 21 Jun 2016 16:06:45 -0700 (PDT)
Received: from homiemail-a119.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a119.g.dreamhost.com (Postfix) with ESMTP id 70A0D6000082B;
	Tue, 21 Jun 2016 16:06:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=eagerm.com; h=subject:to
	:references:cc:from:message-id:date:mime-version:in-reply-to
	:content-type:content-transfer-encoding; s=eagerm.com; bh=2XuhnP
	JezuRXsV4Uq0JO9ReMVto=; b=vvpO1zxEUw/QVWe4T0zgQxnAuLt9Q7YbAAwCVW
	6qLR6bgupFKTcSJUZUiB9mGkkhE4DzWLfxsD8JVSIlcNmOf0O3Zq5kVzGJr/ytSo
	kM9r8peH6DthcXRtmTtsF4auAsIciT38IgFe++TxAlt4/seEbyOGqj9Co67IjiF3
	LYSTY=
Received: from vm-fedora21.eagercon.com (c-71-202-23-94.hsd1.ca.comcast.net [71.202.23.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: eager@eagerm.com)
	by homiemail-a119.g.dreamhost.com (Postfix) with ESMTPSA id 5743E60000829;
	Tue, 21 Jun 2016 16:06:44 -0700 (PDT)
Subject: Re: Managing sub-projects
To:	Stefan Beller <sbeller@google.com>
References: <5765D752.4000404@eagerm.com>
 <CAGZ79kYqtLGHjEirP=6ssiUf2fuHirtKDXr117bjwomho2uf3A@mail.gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
From:	Michael Eager <eager@eagerm.com>
Message-ID: <5769C883.3060103@eagerm.com>
Date:	Tue, 21 Jun 2016 16:06:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYqtLGHjEirP=6ssiUf2fuHirtKDXr117bjwomho2uf3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Stephan!

On 06/19/2016 07:01 PM, Stefan Beller wrote:
> On Sat, Jun 18, 2016 at 4:20 PM, Michael Eager <eager@eagerm.com> wrote:
>>
>> Any other ways to do what I want without creating a separate forked
>> repo for each of the sub-projects?  Or have I misunderstood one of
>> these schemes?
>
> I think forking is the way to go here, as you want to have new code
> and maintain that.

This was my conclusion.

What I originally wanted was a repo with two origins, the upstream for
the master and public branches, and my repo for my branches.  Git may
be able to do all kinds of magic, but this two-origin scheme sounded
strange after I thought about it for a while.

> Personally I would try out submodules.

I've used submodules on another project.  There are some odd quirks,
and lots of web pages which say to avoid submodules like the plague, but I
didn't have lots of trouble.  (After an initial bit of confusion while
getting familiar with submodules, which is what I can say about every
feature in Git.)

>> Git submodule:  Branches created in the sub-projects are pushed to the
>> upstream repo, not to my repo.  I tried to change origin and created an
>> upstream reference, but was not able to get changes pushed to my repo.
>
> Beware that there are 2 areas you need to look at. First the submodule repo
> needs to have a remote that points away from the projects origin (to your
> private fork).

I'll create an "upstream" remote to the project repo, so I can pull/rebase
from the upstream into my forked repo.  The "origin" will point to my repo.

> Then you have to look at the superproject that
> 1) records the sha1 for the submodules internally
> 2) all other information except the tracking sha1s must be user provided,
>      where the .gitmodules file contains recommendations (i.e. the url where to
>      obtain the submodule from, whether to clone it shallowly,
>      if we have a specific branch in mind). The contents of that file
>      are not binding, e.g. if the url provided in the .gitmodules file becomes
>      outdated later, it is still possible to setup the
> submodule/superproject correctly.
>
> However for your business purpose, you would put the url of the private forks
> in the recommended URL of the submodules.
>
> As the superproject only tracks the sha1, and has this recommended pointer
> where to get the submodule repository from, you need to take special care
> in a rebase workflow, because the old rebased commits fall out of the
> reachability
> of the graph of objects, e.g.:
>
> Say you have a version `abc` in a submodule that is one commit on top of
> canonical projects history, and `abc` is recorded as the sha1 in the
> superproject.
>
> Then you rebase the commit in the submodule to a newer version of the upstream,
> which then becomes a new commit `def` and `abc` is not referenced any more,
> so it can be garbage collected.
>
> This is bad for the history of the superproject as it then points to
> an unreachable
> commit in its history.
>
> To preserve the historic non-rebased `abc` commit, you could have a
> set of branches
> (or tags) that maintain all the old non rebased versions.

Sounds like every time I rebase, I should tag the repo to annotate this,
and (as a side effect) retain the history.

> This problem comes up with submodules with any workflow that requires
> non fast forward changes (forced pushes), I think.
>
> So maybe you need to have an alias in the submodule for rebasing, that
> is roughly:
>
> rebase:
>      if rebased history is published
>          create a tag, e.g.: "$(date -I)-${sha1}"
>          (and push that tag here or later?)
>      rebase as normal
>      carry on with life

What do you mean "if rebased history is published".

Generally I'd apply a tag after the rebase was completed successfully,
then push both the updated branch and tags to my repo.

> To get back to your complaint:
>
>>   I tried to change origin and created an
>> upstream reference, but was not able to get changes pushed to my repo.
>
> I would imagine this to be
>
>       (cd submodule && git remote set-url origin <your fork> && git push origin)
>
> for plain pushing in the submodule and then
>
>      $EDIT .gitmodules
>      # edit submodule.<name>.url to point at <your fork>
>
> to get the superproject correct.

Thanks.


-- 
Michael Eager	 eager@eagercon.com
1960 Park Blvd., Palo Alto, CA 94306  650-325-8077
