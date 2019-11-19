Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 347511F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 14:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfKSO4i (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 09:56:38 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:56403 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbfKSO4i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 09:56:38 -0500
X-Originating-IP: 1.186.12.29
Received: from localhost (unknown [1.186.12.29])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 5F81DE0011;
        Tue, 19 Nov 2019 14:56:34 +0000 (UTC)
Date:   Tue, 19 Nov 2019 20:26:32 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] wt-status: show amended content when verbose
Message-ID: <20191119145632.xi6zebglzu4lbgcq@yadavpratyush.com>
References: <20191116161856.28883-1-me@yadavpratyush.com>
 <xmqqd0dp3lfv.fsf@gitster-ct.c.googlers.com>
 <xmqq4kz13k8p.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4kz13k8p.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/11/19 01:02PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Pratyush Yadav <me@yadavpratyush.com> writes:
> >
> >> I am working on a simple little feature which shows the "amended
> >> content" when running 'git-commit -v'. Currently, only the changes in
> >> the _entire_ commit are shown. In a large commit, it is difficult to
> >> spot a line or two that were amended. So, show just the amended content
> >> in a different section.
> >
> > [jc: even though the diff generation is done before the final commit
> > is made, let me refer to the commits with refs _after_ the amend is
> > done].
> >
> > You want to show changes between HEAD@{1}..HEAD (which is what the
> > "amend" did) in addition to changes between HEAD^..HEAD (which is
> > what the "amended commit" does) separately.

Yes, that is what the patch does. It shows _both_ the entire diff and 
the "amended diff".

> > The reason why "git commit -v" lets you see the diff since HEAD^ is
> > to help you write the commit log message.  So it is wrong to show
> > only "what the amend did", as the message you would be writing while
> > amending is to explain the entire "why the amended commit does what
> > it does" and by definition the log message for "amend" should not
> > talk about "why the amend did what it did"---the readers would not
> > even have access to the older version before the amend.
> >
> > It too makes quite a lot of sense to allow readers to see what the
> > 'amend' did, but that is not something that would help write the log
> > message.

It would help _amend_ the log message though. This is the use-case which 
motivated me to write this patch. When I make some changes to a commit 
(like when re-rolling), I often want to update the commit message too. 
If the commit content is a lot, then it becomes difficult to easily see 
what exactly I changed, and in turn makes it difficult to quickly spot 
what parts of the log message need updating.

> > And that is why "git commit -v --amend" does not show it.
> > It should be inspected even _before_ the user contemplates to run
> > "git commit --amend" (e.g. "git diff HEAD" before starting to amend).
> >
> > So, I am not enthused with this change---it sends a wrong message
> > (i.e. what the diff in the editor "commit -v" gives the user for).
> 
> Having said that, I also wonder two things.  Assuming that it may be
> a good idea to show "what the amend does" in addition to "what the
> amended commit does",
>  1. would it make sense to show a combined diff to show the
>     differences among the state being recorded in the amended commit
>     as if it were a merge between the state in the original commit
>     and the state in the parent commit?

I'm afraid I don't follow what exactly this would do, and how it would 
help differentiate between the "what the amend does" and "what the 
amended commit does". Wouldn't the diff of a merge between the original 
commit and the parent be exactly the diff (iow, the output of 'git 
show') of the original commit, since the merge is a fast-forward?
 
>  2. would it make sense to show the differences between
>     HEAD^..HEAD@{1} and between HEAD^..HEAD using the range-diff
>     machinery.

I considered using range-diff, but didn't go with it because of my 
personal dislike for range-diff. But if you strongly think that 
range-diff is a better idea, then I can do that too.
 
> I think #1 may turn out to be more useful (I haven't tried it,
> though) because we already show a moral equivalent elsewhere, namely
> in "git stash show".
> 
> Conceptually, it would be similar to showing a stash entry that
> records the state where some changes have been already added to the
> index and some other changes are still in the working tree---the
> base commit of such a stash entry corresponds to the parent commit
> of the commit being amended, the contents from the index of such a
> stash entry corresponds to the commit being amended, and the
> contents from the working tree of such a stash entry corresponds to
> the final contents you are trying to record as an amended commit.
> 

-- 
Regards,
Pratyush Yadav
