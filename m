Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E45F1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 19:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753293AbeC1Thc (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 15:37:32 -0400
Received: from vsmx009.vodafonemail.xion.oxcs.net ([153.92.174.87]:42640 "EHLO
        vsmx009.vodafonemail.xion.oxcs.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753267AbeC1Thc (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Mar 2018 15:37:32 -0400
Received: from vsmx001.vodafonemail.xion.oxcs.net (unknown [192.168.75.191])
        by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id 638D8C071D;
        Wed, 28 Mar 2018 19:37:26 +0000 (UTC)
Received: from [10.0.0.19] (unknown [91.115.64.165])
        by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 0C0173001FF;
        Wed, 28 Mar 2018 19:37:19 +0000 (UTC)
Subject: Re: git submodule deinit resulting in BUG:
 builtin/submodule--helper.c:1045: module_list_compute should not choke on
 empty pathspec
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Prathamesh Chavan <pc44800@gmail.com>
References: <9e22b49e-6732-17c7-76fe-0ce241787db9@arcor.de>
 <CAGZ79kYGY5bjh0WPQh7xkXQxLkB9EQ-OcJhVuGE8YUnwmvk2Fg@mail.gmail.com>
From:   Peter Oberndorfer <kumbayo84@arcor.de>
Message-ID: <9ead5ee1-9d4a-38f6-0fa3-ca4c982b33f5@arcor.de>
Date:   Wed, 28 Mar 2018 21:37:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYGY5bjh0WPQh7xkXQxLkB9EQ-OcJhVuGE8YUnwmvk2Fg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-VADE-STATUS: LEGIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-03-28 00:56, Stefan Beller wrote:
> On Tue, Mar 27, 2018 at 12:55 PM Peter Oberndorfer <kumbayo84@arcor.de>
> wrote:

Hi,

as expected your patch fixed the BUG output.
Thanks!

>> 2) Should "git submodule deinit" work on submodules that were removed by
> upstream already?
> 
> To answer the question "Is this a submodule that upstream removed
> (recently)?"
> we'd have to put in some effort, essentially checking if that was ever a
> submodule
> (and not a directory or file).
> 

Hmm, yeah looks a bit more complicated than I initially imagined
since submodules can have a name that's different from their path.
And after the rebase, the name <-> path mapping via .gitmodules is not available anymore.

Naively I think it could work the following way:
* Either iterate over all submodules in .git/modules/ and check their config
  has a worktree = "../../path" that resolves to the submodule path we want to remove.
* Or check the "gitlink:" path in submodule/.git if it points to our .git/modules/
Then if .git/config contains a [submodule "name"] entry
we should have a pretty good idea if this folder contains a stale submodule.

> When using "git pull --recurse-submodules" the submodule ought to be removed
> automatically.
> 
> When doing a fetch && merge manually, we may want to teach merge to remove
> a submodule that we have locally upon merge, too.
> 

Yeah that would be nice :-)
In my case I updated the repository via a rebase, so that would also have to be covered.

> I view the git-submodule command as a bare bones plumbing helper, that we'd
> want
> to deprecate eventually as all other higher level commands will know how to
> deal
> with submodules.
> 
> So I think we do not want to teach "git submodule deinit" to remove dormant
> repositories, that were submodules removed by upstream already.
> 

My gut feeling makes me expect the following:
* It would be nice if such stale submodules showed up in "git submodule status" or "git status"
  Now "git submodule" shows nothing related to this stale submodule
  Now "git status" shows  Untracked files: src/rt which is a bit confusing as the actual submodule is in src/rt/hoedown
  Now "Git gui" shows src/rt/hoedown as untracked git repository
* There should be an easy(and safe) way for the user to deinit such a submodule
  if if the automatic submodule updating during a merge/rebase was not enabled or somehow failed.
(Minus the problem of somebody having to actually do the work...)

>> ~/src/rust/rust$ git submodule status
> ...
>>   b87873eaceb75cf9342d5273f01ba2c020f61ca8 src/tools/lld ((null))
> 
>> -> strangely I get (null) for the current branch/commit in some
> submodules?
> 
> This sounds like (3). Looking into that.

Sorry, what do you mean by (3)?

Thanks,
Greetings Peter
