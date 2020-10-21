Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EA9C388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 17:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 231C6208B3
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 17:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503368AbgJURKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 13:10:09 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.99]:24529 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503365AbgJURKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 13:10:09 -0400
Received: from [84.175.187.233] (helo=[192.168.2.222])
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1kVHZT-0004FO-La; Wed, 21 Oct 2020 19:06:43 +0200
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: Questions about partial clone with '--filter=tree:0'
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        jonathantanmy@google.com, Marc Strapetz <marc.strapetz@syntevo.com>
References: <aa7b89ee-08aa-7943-6a00-28dcf344426e@syntevo.com>
 <20201020222934.GB93217@nand.local>
Message-ID: <a4a20c67-4ee3-77b2-8d57-f30843572aa4@syntevo.com>
Date:   Wed, 21 Oct 2020 19:10:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201020222934.GB93217@nand.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21.10.2020 0:29, Taylor Blau wrote:
> Oops. That can happen sometimes, but thanks for re-sending. I'll try to
> answer the basic points below.

Thanks for stepping in!

>> (1) Is it even considered a realistic use case?
>> -----------------------------------------------
>> Summary: is '--filter=tree:0' a realistic or "crazy" scenario that is
>> not considered worthy of supporting?
>
> It's not an unrealistic scenario, but it might be for what you're trying
> to build. If your UI needs to run, say, 'git log --patch' to show a
> historical revision, then you're going to need to fault in a lot of
> missing objects.
>
> If that's not something that you need to do often or ever, then having
> '--filter=tree:0' is a good way to get the least amount of data possible
> when using a partial clone. But if you're going to be performing
> operations that need those missing objects, you're probably better eat
> the network/storage cost of it all at once, rather than making the user
> wait for Git to fault in the set of missing objects that it happens to
> need.

We currently do not intend to use '--filter=tree:0' ourself, but we are 
trying to support all kinds of user repositories with our UI. So we 
basically have these choices:

A) Declare '--filter=tree:0' repos as completely wrong and unsupported
    in out UI, also giving an option to "un-partial" them.

B) Support '--filter=tree:0' repos, but don't support operations such
    as blame and file log

C) Use some magic to efficiently download objects that will be needed
    for a command such as Blame, while keeping the rest of the repository
    partial. This is where the command described in (3) will help a lot.

We would of course prefer (C) if it's reasonably possible.

>> (2) A command to enrich repo with trees
>> ---------------------------------------
>> There is no good way to "un-partial" repository that was cloned with
>> '--filter=tree:0' to have all trees, but no blobs.
>
> There is no command to do that directly, but it is something that Git is
> capable of.
>
> It would look something like:
>
>    $ git config remote.origin.partialclonefilter 'blob:none'
>
> Now your repository is in a state where it has no blobs or trees, but
> the filter does not prohibit it from getting the trees, so you can ask
> it to grab everything you're missing with:
>
>    $ git fetch origin
>
> This should even be a pretty fast operation for repositories that have
> bitmaps due to some topics that Peff and I sent to the list a while ago.
> If it isn't, please let me know.

Unfortunately this does not work as expected. Try the following steps:

A) Clone repo with '--filter=tree:0'
    $ git clone --bare --filter=tree:0 --branch master 
https://github.com/git/git.git

B) Change filter to 'blob:none'
    $ cd git.git
    $ git config remote.origin.partialclonefilter 'blob:none'

C) fetch
    $ git fetch origin
    Note that there is no 'Receiving objects:' output.

D) Verify that trees were downloaded
    $ git cat-file -p HEAD | grep tree
      tree ee5b5b41305cda618862beebc9c94859ae276e5a
    $ git cat-file -t ee5b5b41305cda618862beebc9c94859ae276e5a
      Note that 1 object gets downloaded. This confirms that (C) didn't
      achieve the goal.

It happens due to 'check_exist_and_connected()' test in 'fetch_refs()'.
Since the tip of the ref is already available locally (even though it
is missing all trees), nothing is downloaded.

>> There seems to be a dirty way of doing that by abusing 'fetch --deepen'
>> which happens to skip "ref tip already present locally" check, but
>> it will also re-download all commits, which means extra ~0.5gb network
>> in case of Linux repo.
>
> Mmm, this is probably not what you're looking for. You may be confusing
> shallow clones (of which --deepen is relevant) with partial clones
> (to which --deepen is irrelevant).

Yes, '--deepen' is intended for shallow clones. But abusing it for
partial clones allows to skip 'check_exist_and_connected()' test.
However, I did more testing today, and in many cases server itself
refuses to send objects, probably due to sent 'HAVE' or something
else. So even '--deepen' doesn't really help.

> I think what you probably want is a step 1.5 to tell Git "I'm not going
> to ask for or care about the entirety of my working copy, I really just
> want objects in path...", and you can do that with sparse checkouts. See
> https://git-scm.com/docs/git-sparse-checkout for more.

For simplicity of discussion, let's focus on the problem of running
Blame efficiently in a repo that was cloned with '--filter=tree:0'. In
order to blame file '/1/2/Foo.txt', we will need the following:

* Trees '/1'
* Trees '/1/2'
* Blobs '/1/2/Foo.txt'

All of these will be needed to unknown commit depth. For simplicity,
the proposed command will download these for all commits. Specifying
a range of revisions could be nice, but I feel that it's not worth the
complexity.

Correct me if I'm wrong: I think that sparse checkout will not help to
achieve the goal?

This is why I suggest a command that will accept paths and send
requested objects, also forcing server to assume that all of them are
missing in client's repository.
