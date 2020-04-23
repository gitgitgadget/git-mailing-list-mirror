Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6DFC2BA19
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 04:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9BBD2073A
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 04:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgDWECT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 00:02:19 -0400
Received: from mailgw-01.dd24.net ([193.46.215.41]:45572 "EHLO
        mailgw-01.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgDWECS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 00:02:18 -0400
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.27])
        by mailgw-01.dd24.net (Postfix) with ESMTP id 99D7560029;
        Thu, 23 Apr 2020 04:02:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-02.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.35])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10235)
        with ESMTP id 9mEzrH7Cbno3; Thu, 23 Apr 2020 04:02:14 +0000 (UTC)
Received: from heisenberg.fritz.box (ppp-88-217-42-14.dynamic.mnet-online.de [88.217.42.14])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA;
        Thu, 23 Apr 2020 04:02:13 +0000 (UTC)
Message-ID: <29351ce9763fe8ed1fa591874be961b041848e2d.camel@scientia.net>
Subject: Re: how to (integrity) verify a whole git repo
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Thu, 23 Apr 2020 06:02:13 +0200
In-Reply-To: <xmqqftcwodma.fsf@gitster.c.googlers.com>
References: <acb9a2da98bce7ea3044cbf37c92163497f7e9e2.camel@scientia.net>
         <xmqqftcwodma.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio.


On Tue, 2020-04-21 at 12:14 -0700, Junio C Hamano wrote:
> You can compute the commits that are not reachable from any of the
> signed tags.
> 
>     git rev-list --all --not $list_tags_and_commits_you_trust_here
> 
> will enumerate all the commits that are not reachable from those
> tags.

And with reachable you mean: "commits which were not before the commits
I trust" ("before obviously again not in terms of their date, but their
position in the tree").



> But your "have everything dropped" is a fuzzy notion and you must be
> more precise to define what you want.  Imagine this history:
> 
> 
>     ----o-----o-----L-----x----x-----x-----x-----x----x HEAD (master)
>                                           /
>                                          /
>                                         /
>                    ... ------o----o----G
> 
> where you have two people you trust (Linus and Greg), HEAD is the
> tip of your 'master' branch, probably you fetched from Linus, L and
> G are the two recent tags Linus and Greg signed.
> 
> If you enumerate commits that are not reachable from L or G, you'll
> get all commits that are marked with 'x'.  Commits marked with 'o'
> are reachable from either 'L' or 'G', and you would want to keep
> them.

That seems to be more or less what I'd want.


> Now, you need to define what you mean by "have everything dropped".
> You can remove commits 'x' but then after that where would your
> 'master' branch point at?  There is no good answer to that question.

Hmm well naively I'd have said master should point to L, assuming
Greg's branch was merged into it and assuming git knows which branch
was the one merged into.

Of course that would leave Greg's branch possibly dangling at G.

Maybe one could handle such cases like this:
    ----o-----o-----L-----x----x-----x-----x-----x----x HEAD (master)
                                          /
                                         /
                                        /
                    ... -----t----o----G

If the former branch name can be determined (from the commit message?),
recreate it.
If not, the commits from Greg's branch could be either left 
unreachable or maybe, with some special option, could be pointed at by
some newly created branch-name foo-1 or whatever.
If Greg's branch contains a commit pointed to by tag (here named t), at
least this would be reachable anyway.

But I guess for the use case I'm thinking about, unreachable commits
wouldn't be that much of a problem.

 

> What you could do is remove all branches and tags except for the
> signed tags you trust from your repository and then use "git repack"
> the repository.  Then there will be tags that point at L and G but
> you'd be discarding 'master' (which is not signed) and repack will
> discard all 'x' in the sample history illustrated above.

Well one could probably just manually set master to some reasonable
commit, i.e. the one which was likely anyway master at some point in
time, until Linus added further commits.


Is there an easy (like for people who don't dream in git ;-) ) and
ideally fast way to do all this.


I would have guessed that a command which does this more or less out of
the box, might be quite helpful for security conscious people. The
scenario shouldn't be so rare:

- one clones a repo, where commits are usually not signed, but tags are
- one has a number of trusted people and can even securely retrieve
  their keys (in my case, Debian ships Linus' and Greg's key in the
  source package of the kernel)
- one needs to work with the repo, including any older states in the
  history (in my case it's trying to bisect the - for me - showstopper
  bug: https://bugzilla.kernel.org/show_bug.cgi?id=207245 )
- one doesn't want to use anything which is not signed by trusted
  people, so basically one wants a repo, as if it would have just been
  cloned when all branches/etc. were at the state of a signed tag (or
  commit).

So I have something like the (stable)kernel repo which looks a bit like
(with (L) and (G) indicating who signed):
               x---x---x--- foo
              /
    ----o-----v.5.5(L)----o----o-----v.5.6(L)----x-----x----x master
               \                     \
                \                     o----v.5.6.1(G)---o----v.5.6.1(G)
                 \
                  o----o----v.5.5.1(G)---o---o---v.5.5.1(G)---x---x


A command like:
git drop-unsigned-stuff --trusted-key 00411886 --trusted-key 6092693E

would end up in this (and even garbage-collect all unreachable stuff
already, unless one uses some special option):

    ----o-----v.5.5(L)----o----o-----v.5.6(L) master
               \                     \
                \                     o----v.5.6.1(G)---o----v.5.6.1(G)
                 \
                  o----o----v.5.5.1(G)---o---o---v.5.5.1(G)

So with that repo, unless I fetch something new, I could be sure,
everything I have or I could potentially checkout was at some time
trusted by someone I trust.

In the example above, a branch (foo) which is completely unsigned would
consequentially be dropped completely.


In earlier days, most projects released their (signed) sources as some
tarball,...many nowadays just set (and sometimes even sign) some git
tag (which is great)... but with the old tarball one could have been
sure that everything in it is trusted (if one trusts the signer), which
git this is of course less simple.
So such cases I would have liked a simple way to get rid of everything
untrusted.


But probably my use case is just too exotic, otherwise git would
already have a helper command for it ^^


Cheers,
Chris.

