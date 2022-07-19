Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B43C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 10:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbiGSKsL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 06:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbiGSKsF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 06:48:05 -0400
Received: from mail-108-mta89.mxroute.com (mail-108-mta89.mxroute.com [136.175.108.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6AA21824
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 03:48:03 -0700 (PDT)
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta89.mxroute.com (ZoneMTA) with ESMTPSA id 1821612660e0000261.002
 for <git@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Tue, 19 Jul 2022 10:48:00 +0000
X-Zone-Loop: 5aefb20475ab2ed86d61b06293c709815c8b1367c9f9
X-Originating-IP: [140.82.40.27]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=that.guru;
        s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XKj26ecOF//3sugbKasXvu+5fkRD2WAHx8L/6RCC1pY=; b=IV4EHIBwiJRby4EPrjOGwReA3w
        Y4nZ4akdJY5G04QMo8hEZIG3PXS5GDd9BAUkeyWyk/hVCHy1KXLSlC4yfOtQh8kaHe5WW6xnmXhzF
        lOX0z5dHBvtUuTs65E69gD/OScDq6+K2sYrz2KbVO49tbBYu2VRH8JVl5th59P/WTxmcVC67vuU/C
        PLqGAUk6G74mw025z5mp/7FKSaDewhPjl/1UpO6wWVtFYywcEJIEQ2hn4ydRVeIAn05XpCbodQNfX
        hoU8BJD60kHE3V+5b/HCPl9Z3amBf+M5qDBQBqFyZ6JmBNpdRZcmpIJgxyQe7/d2+Rol8wxMjegv4
        HmgPMC0A==;
Message-ID: <61333be26339440d9bae8f12fd1a4faeb5e68ab6.camel@that.guru>
Subject: Re: Feature request: provide a persistent IDs on a commit
From:   Stephen Finucane <stephen@that.guru>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Date:   Tue, 19 Jul 2022 11:47:55 +0100
In-Reply-To: <220718.86ilnuw8jo.gmgdl@evledraar.gmail.com>
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
         <220718.86ilnuw8jo.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-AuthUser: stephen@that.guru
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2022-07-18 at 20:50 +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason w=
rote:
> On Mon, Jul 18 2022, Stephen Finucane wrote:
>=20
> > ...to track evolution of a patch through time.
> >=20
> > tl;dr: How hard would it be to retrofit an 'ChangeID' concept =C3=A0 la=
 the 'Change-
> > ID' trailer used by Gerrit into git core?
> >=20
> > Firstly, apologies in advance if this is the wrong forum to post a feat=
ure
> > request. I help maintain the Patchwork project [1], which a web-based t=
ool that
> > provides a mechanism to track the state of patches submitted to a maili=
ng list
> > and make sure stuff doesn't slip through the crack. One of our long-ter=
m goals
> > has been to track the evolution of an individual patch through multiple
> > revisions. This is surprisingly hard goal because oftentimes there isn'=
t a whole
> > lot to work with. One can try to guess whether things are the same by i=
nspecting
> > the metadata of the commit (subject, author, commit message, and the di=
ff
> > itself) but each of these metadata items are subject to arbitrary chang=
es and
> > are therefore fallible.
> >=20
> > One of the mechanisms I've seen used to address this is the 'Change-ID'=
 trailer
> > used by Gerrit. For anyone that hasn't seen this, the Gerrit server pro=
vides a
> > git commit hook that you can install locally. When installed, this appe=
nds a
> > 'Change-ID' trailer to each and every commit message. In this way, the =
evolution
> > of a patch (or a "change", in Gerrit parlance) can be tracked through t=
ime since
> > the Change ID provides an authoritative answer to the question "is this=
 still
> > the same patch". Unfortunately, there are still some obvious downside t=
o this
> > approach. Not only does this additional trailer clutter your commit mes=
sages but
> > it's also something the user must install themselves. While Gerrit can =
insist
> > that this is installed before pushing a change, this isn't an option fo=
r any of
> > the common forges nor is it something git-send-email supports.
>=20
> git format-patch+send-email will send your trailers along as-is, how
> doesn't it support Change-Id. Does it need some support that any other
> made-up trailer doesn't?

It supports sending the trailers, sure. What it doesn't support is insistin=
g you
send this specific trailer (Change-Id). Only Gerrit can do this (server sid=
e,
thankfully, which means you don't need to ask all contributors to install t=
his
hook if you want to rely on it for tooling, CI, etc.).

> > I imagine most people working with mailing list based workflows have th=
eir own
> > client side tooling to support this while software forges like GitHub a=
nd GitLab
> > simply don't bother tracking version history between individual commits=
 in a
> > pull/merge request.
>=20
> It's far from ideal, but at least GitLab shows a diff on a push to a MR,
> including if it's force-pushed. I'm not sure about GitHub.

GitHub does not. Simply piling multiple additional "fix" commits onto the P=
R
branch results in a less horrible review experience since you can maintain
context, alas at the cost of a rotten git log. We don't need to debate the =
pros
and cons of the various forges though :)

>=20
> > IMO though, it would be fantastic if third party tools
> > weren't necessary though. What I suspect we want is a persistent ID (or=
 rather
> > UUID) that never changes regardless of how many times a patch is cherry=
-picked,
> > rebased, or otherwise modified, similar to the Author and AuthorDate fi=
elds.
> > Like Author and AuthorDate, it would be part of the core git commit met=
adata
> > rather than something in the commit message like Signed-Off-By or Chang=
e-ID.
> >=20
> > Has such an idea ever been explored? Is it even possible? Would it be b=
roadly
> > useful?
>=20
> This has come up a bunch of times. I think that the thing git itself
> should be doing is to lean into the same notion that we use for tracking
> renames. I.e. we don't, we analyze history after-the-fact and spot the
> renames for you.

Any idea where I'd find previous discussions on this? I did look, and the o=
nly
proposal I found was an old one that seemed to suggest including the Change=
-Id
commit-msg hook with git itself which is not what I'm suggesting here.

> We have some of that in git already, as git-patch-id, and more recently
> git-range-diff. Both are flawed in a bunch of ways, and it's easy to run
> into edge cases where they don't spot something that they "should"
> have. Where "should" exists in the mind of the user.

That's a fair point and is of course what we (Patchwork) have to do current=
ly.
Patchwork can track relations between individual patches but doesn't attemp=
t to
generate these relations itself. Instead, we rely on third-party tooling. T=
he
PaStA tool was one such example of a tool that could do this [1]. I can't
imagine a tool like Gerrit would ever work without this concept of an
authoritative (and arbitrary) identifier to track a patch's identity throug=
h
time, hence its reliance on the Change-Id trailer.

Perhaps we could flip this on its head. What would be the _downsides_ of
providing a persistent, arbitrary identifier on a commit similar to Author =
and
AuthorDate fields? There's obviously some work involved in implementing it =
but
assuming that was already done, what would break/be worse as a result?

Stephen

[1] https://rsarky.github.io/2020/08/10/pasta-patchwork.html
