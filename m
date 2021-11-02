Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4B6C43219
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 20:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA67660720
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 20:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhKBUK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 16:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhKBUKy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 16:10:54 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47223C061203
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 13:08:18 -0700 (PDT)
Date:   Tue, 2 Nov 2021 21:08:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1635883697; bh=5vaxMYzvl5hd1DdMFCSOq0jIdl6n2ErKzOf4Bd/HAXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nteTu9XmvfLKBbNl+CWZH3btC1vc/KHNUFdrt96yohHT/9+xUrrQxwdKtdZkLQPWQ
         q0JDqS8Ld2FMstIVZFM11hOnZy6cduDUPTDkzasl7FcrP6jfGrpUiwDN1v199Q8tdS
         nkzc6exS9Eygb3oAFJ9B6RM1+/dzX3Nc+ebUKZjs=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] var: add GIT_DEFAULT_BRANCH variable
Message-ID: <5a64a438-07c3-489a-aca5-d677ae15c3ca@t-8ch.de>
References: <nycvar.QRO.7.76.6.2111021433010.56@tvgsbejvaqbjf.bet>
 <20211102164434.1005707-1-thomas@t-8ch.de>
 <211102.86czni1o72.gmgdl@evledraar.gmail.com>
 <06095eb4-df18-4f23-8e72-26882c49f25c@t-8ch.de>
 <211102.868ry61hy3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211102.868ry61hy3.gmgdl@evledraar.gmail.com>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-11-02 20:14+0100, Ævar Arnfjörð Bjarmason wrote:
> On Tue, Nov 02 2021, Thomas Weißschuh wrote:
> 
> > On 2021-11-02 17:53+0100, Ævar Arnfjörð Bjarmason wrote:
> >> On Tue, Nov 02 2021, Thomas Weißschuh wrote:
> >> 
> >> > Introduce the builtin variable GIT_DEFAULT_BRANCH which represents the
> >> > the default branch name that will be used by git-init.
> >> >
> >> > Currently this variable is equivalent to
> >> >     git config init.defaultbranch || 'master'
> >> >
> >> > This however will break if at one point the default branch is changed as
> >> > indicated by `default_branch_name_advice` in `refs.c`.
> >> >
> >> > By providing this command ahead of time users of git can make their
> >> > code forward-compatible.
> >> >
> >> > Co-developed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> >> > Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
> >> > ---
> >> >
> >> > Changes from v1 ( https://lore.kernel.org/git/20211030140112.834650-1-thomas@t-8ch.de/ ):
> >> > * Replaced the custom subcommand with an internal variable
> >> > * Cleaned up the tests
> >> >
> >> > @Johannes: I replaced BUG() with die() from your example because that seems to be
> >> > nicer for user facing messages.
> >> >
> >> >  Documentation/git-var.txt |  3 +++
> >> >  builtin/var.c             | 13 +++++++++++++
> >> >  t/t0007-git-var.sh        | 19 +++++++++++++++++++
> >> >  3 files changed, 35 insertions(+)
> >> >
> >> >  
> >> > +static const char *default_branch(int flag)
> >> > +{
> >> > +	const char *name = repo_default_branch_name(the_repository, 1);
> >> > +
> >> > +	if (!name)
> >> > +		die("could not determine the default branch name");
> >> 
> >> Isn't this die() unrechable given the similar logic in
> >> repo_default_branch_name()? Hence the previous BUG(...)?
> >
> > Ok. Good point.
> >
> >> I really don't see how it makes sense to add this to "git var", we have
> >> that to correspond to environment variables we use.
> >> 
> >> *Maybe* if we renamed GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME to
> >> GIT_INITIAL_BRANCH_NAME and made it a non-test thing like
> >> GIT_TEMPLATE_DIR, but even then shouldn't we be adding
> >> "GIT_TEMPLATE_DIR" and any number of other things to this as well?
> >> 
> >> I'm not saying that your patch needs to do that, but we really should
> >> think about the interface & future implications if we're going in this
> >> direction.
> >> 
> >> The reason I suggested extending "git config" in [1] is because it seems
> >> like a natural thing for "git config" to learn to spew out our idea of
> >> default hardcoded config values to the user.
> >> 
> >> But creating a variable form of that existing config just so we can have
> >> "git var" spew it out just seems weird.
> >> 
> >> We don't have or need such a variable now for anything else, so why go
> >> through that indirection, instead of something that closes the feature
> >> gap of asking what a config variable default is?
> >> 
> >> In any case whatever we do here this really should be updating the
> >> documentation of init.defaultbranch & the relevant bits in the "git
> >> init" manpage to add cross-references, similar to how we discuss
> >> GIT_TEMPLATE_DIR now.
> >>
> >> 1. https://lore.kernel.org/git/211030.86ilxe4edm.gmgdl@evledraar.gmail.com/
> >
> > I'll then wait for a consensus of the git devs. The actual implementation
> > shouldn't be the issue afterwards.
> >
> > Thanks for looking into this!
> 
> Please don't take that message as me or anyone else "pulling rank" just
> because we've got some previous commits in git.git. That applies to both
> me and Johannes, and clearly we disagree on this minor bit of UX
> direction.

This was not my impression, although my message has a bit of a resignated
tone. That was not the intention.

> I'd think if anything the opinion of someone who's not overly familiar
> with the system would be more valuable, i.e. yours, especially since you
> tried & failed to find a way to do this recently. Would you find it more
> intuitive to look in say "git var" over "git config" for this sort of
> information?

To be honest I was not aware of "git var" before Johannes before proposed it.
And I am still not sure how to understand the "logical" aspect of "git-var".
(git-var - Show a Git logical variable)

A "git config" variable using a generic config default framework looks like the
generally cleanest interface.
The appeal of "git var" was the easy and quick implementation.

> A further weirdness is that another effective source of config for this
> is the "unborn" ls-refs feature[1]. I'm not sure what that means for any
> query interface, i.e. would a user want to know what branch a freshly
> cloned repo would end up with in advance, taking into account all of the
> local config, remote "unborn" etc?

I have no idea how that should work.

> 1. https://lore.kernel.org/git/878s8apthr.fsf@evledraar.gmail.com/

If you and Johannes think it would help the design-process I would also
volunteer to implement your original proposal:

    git config --get-or-git-default init.defaultBranch

Please note that I'm not doing (primarily) doing this to get commits into
git.git, so if somebody with more knowledge about the git architecture wants to
bring this forward, please feel free.
