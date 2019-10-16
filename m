Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 056DB1F4C1
	for <e@80x24.org>; Wed, 16 Oct 2019 15:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389892AbfJPPA1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 11:00:27 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:35797 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388424AbfJPPA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 11:00:27 -0400
X-Originating-IP: 1.186.12.12
Received: from localhost (unknown [1.186.12.12])
        (Authenticated sender: me@yadavpratyush.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id AC34524001E;
        Wed, 16 Oct 2019 15:00:23 +0000 (UTC)
Date:   Wed, 16 Oct 2019 20:30:20 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191016150020.cr6jgfpd2c6fyg7t@yadavpratyush.com>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Vegard,

On 16/10/19 12:22PM, Vegard Nossum wrote:
> (cross-posted to git, LKML, and the kernel workflows mailing lists.)
> 
> Hi all,
> 
> I've been following Konstantin Ryabitsev's quest for better development
> and communication tools for the kernel [1][2][3], and I would like to
> propose a relatively straightforward idea which I think could bring a
> lot to the table.
> 
> Step 1:
> 
> * git send-email needs to include parent SHA1s and generally all the
>   information needed to perfectly recreate the commit when applied so
>   that all the SHA1s remain the same
> 
> * git am (or an alternative command) needs to recreate the commit
>   perfectly when applied, including applying it to the correct parent
> 
> Having these two will allow a perfect mapping between email and git;
> essentially email just becomes a transport for git. There are a lot of
> advantages to this, particularly that you have a stable way to refer to
> a patch or commit (despite it appearing on a mailing list), and there
> is no need for "changeset IDs" or whatever, since you can just use the
> git SHA1 which is unique, unambiguous, and stable.
 
FWIW, I like the idea.

> As a rough proof of concept I've attached 3 git patches which implement
> this. There are issues to work out like exact format, encodings, mail
> mangling, error handling, etc., but hopefully the git community can
> help out here. (Improvement suggestions are welcome!)
> 
> Step 2:
> 
> * A bot that follows LKML (and other lists) and imports patchsets into
>   a git repository hosted on git.kernel.org
> 
> * The bot can add git notes with URLs to lore (and/or other mailing
>   list archives) and store them in e.g. refs/notes/lore,
>   refs/notes/lkml, etc.
> 
>   (For those who don't use git notes yet: they are essentially small
>   bits of information you can add to a commit without changing its SHA1,
>   and you can configure tools like 'git log' to show these at the bottom
>   of a commit. Notes can also exist in a repo completely separate from
>   the commits they attach data to, so there is _zero_ overhead for those
>   who don't want to use this.)
> 
> * Maintainers can either pull patchsets directly from this bot-
>   maintained repo OR they can continue to apply patches from their inbox
>   (the result should be the same either way) OR they can continue in the
>   old-style process (at least for a while) and just not have the
>   benefits of the new process.
> 
> Step 3:
> 
> * Instead of describing a patchset in a separate introduction email, we
>   can create a merge commit between the parent of the first commit in
>   the series and the last and put the patchset description in the merge
>   commit [5]. This means the patchset description also gets to be part
>   of git history.
> 
>   (This would require support for git send-email/am to be able to send
>   and apply merge commits -- at least those which have the same tree as
>   one of the parents. This is _not_ yet supported in my proposed git
>   patches.)

Can sending merge commits via email work with your proposed '--exact'? 
Say I'm the maintainer, and you fork off a feature branch off my master, 
add a few commits that introduce your new feature, and then merge it 
into my master, and then send those commits, including the merge.

Now in that scenario, say the tip of your feature branch was X and the 
tip of my 'master' was Y when you sent your patches. Now while your 
patches are still being reviewed, I merge in some other branch creating 
a merge commit Z on my master.

Now your merge's first parent was Y and second parent was X. But now the 
tip of my master is Z, so the first parent of your merge needs to be Z, 
not Y. Changing the first parent would mean a different commit hash.

So, the way I see it, your proposed merge commits via email can't work 
with '--exact'. Do I understand this situation correctly? Am I missing 
something?

Maybe a better idea would be to allow 'am' to create these merges 
locally when applying the patches. That would mean having to merge the 
separate branch along with applying the patches, otherwise the cover 
letter text is lost. This might not be something everyone wants. I for 
one don't. When I apply patches via 'am', I first keep them on a 
separate branch, test them out, and then merge them into 'master'.

So a yet another alternative could be to save the cover letter as the 
branch description. This branch description can then be used to generate 
the merge message. IIRC, Denton Liu is working on generating the cover 
letter text from branch description, so this feature would be like its 
inverse.
 
> * stable SHA1s means we can refer to previous versions of a patchset by
>   SHA1 rather than archive links. I propose a new changelog tag for
>   this, maybe "Previous:" or maybe even a full list of "v1:", "v2:",
>   etc. with a SHA1 or ref. Note that these SHA1s do *not* need to exist
>   in Linus's repo, but those who want can pull those branches from the
>   bot-maintained repo on git.kernel.org.
> 
> Advantages:
> 
> - we can keep using email to post patches/patchsets
> 
> - the process is opt-in (but should be encouraged) for both authors and
>   maintainers, and the transition can happen over time
> 
> - there is a central repo for convenience, but it is not necessary for
>   development to happen and is not a single point of failure -- it's
>   more like Linus's repo and can be moved or even replicated from
>   scratch by somebody else simply by having mailing list archives
> 
> - allows quick lookup of patch/patchset <-> email discussion within git
> 
> - allows diffing between versions of a single logical patchset
> 
> - patchset descriptions naturally become part of the changelog that ends
>   up in Linus's tree
> 
> Disadvantages:
> 
> - requires patching git
> 
> - requires a bot to continuously create branches for patchsets sent to
>   mailing lists
> 
> - increased storage/bandwidth for git.kernel.org (?)
> 
> - may need a couple of new wrapper scripts to automate patchset
>   construction/versioning

Just to play the devil's advocate, even though I'm in favor of something 
like this, I'll add in another disadvantage:

- The maintainer can't make small edits before pushing the changes out. 

I do that every now and then for git-gui, and Junio does that sometimes 
for Git. I don't know if the folks over at Linux do something like this, 
but using '--exact' would mean that contributors would have to send a 
re-roll for even minor changes. Its mostly an inconvenience instead of a 
problem, but I thought I'd point it out.
 
> Thoughts?

One more question, not strictly related to your proposal: right now, 
when I apply patches from contributors, I pass '-s' to 'am', so the 
applied commit would have my sign-off. The way I see it, that sign-off 
is supposed to signify that I have the right to push out the commit to 
the "main" repo, just like the author's sign-off means that they have 
the right to send me that commit.

Looking at git.git, I notice that Junio does the same. The new '--exact' 
would be incompatible with '-s', correct (since the commit message has 
changed, the SHA1 would also change)? So firstly, make sure you account 
for something like that if you haven't already (I haven't found the time 
to read your patches yet). Secondly, is it all right for the maintainer 
to just not sign-off on the commits they push out?

-- 
Regards,
Pratyush Yadav
