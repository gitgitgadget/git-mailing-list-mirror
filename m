Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46F8C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 17:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiGRRXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 13:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiGRRXW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 13:23:22 -0400
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Jul 2022 10:23:19 PDT
Received: from mail-108-mta10.mxroute.com (mail-108-mta10.mxroute.com [136.175.108.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C13124BFF
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 10:23:19 -0700 (PDT)
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta10.mxroute.com (ZoneMTA) with ESMTPSA id 182125150040000261.001
 for <git@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Mon, 18 Jul 2022 17:18:15 +0000
X-Zone-Loop: 45134e70ac3b64323297b0d8c6a374b0d6ed5fe1a746
X-Originating-IP: [140.82.40.27]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=that.guru;
        s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:To:From:
        Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uMVhDqpO1GIKb2q5MB/HMcbcbkDXbp0qtoIBmKLsF70=; b=BL8kz+Gwj0rDOiTw14zbHinPLM
        TlvjTsp+8veIPl1C/LXRhZlXT/CjI4DEEnacdRmbPHRul4V0v6crb9lDW69fYWwQ6N19eyLf8PAwS
        tbh49kjTXTTsLCeWow7i0B7TWGx0zZ7cRgiAuVXSFE/OpRfVeADb/+xrafnpp2ujEy/vas6/jGnp/
        0CkMnpqX1M61bCaOoP8DQlcGqvsTVzG5uObLaqY7BJZmvm4rjtqINAYzYU3bDOD403Om5lDXK8p/q
        iRNOmXY9Fd3uJkKQTD1FE/XxQPcs9siwx3fhf8YCDKUjGNs+ACWl31bufBBmOHDMg72oTHHaC92TD
        0LM2SLTA==;
Message-ID: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
Subject: Feature request: provide a persistent IDs on a commit
From:   Stephen Finucane <stephen@that.guru>
To:     git@vger.kernel.org
Date:   Mon, 18 Jul 2022 18:18:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-AuthUser: stephen@that.guru
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

...to track evolution of a patch through time.

tl;dr: How hard would it be to retrofit an 'ChangeID' concept =C3=A0 la the=
 'Change-
ID' trailer used by Gerrit into git core?

Firstly, apologies in advance if this is the wrong forum to post a feature
request. I help maintain the Patchwork project [1], which a web-based tool =
that
provides a mechanism to track the state of patches submitted to a mailing l=
ist
and make sure stuff doesn't slip through the crack. One of our long-term go=
als
has been to track the evolution of an individual patch through multiple
revisions. This is surprisingly hard goal because oftentimes there isn't a =
whole
lot to work with. One can try to guess whether things are the same by inspe=
cting
the metadata of the commit (subject, author, commit message, and the diff
itself) but each of these metadata items are subject to arbitrary changes a=
nd
are therefore fallible.

One of the mechanisms I've seen used to address this is the 'Change-ID' tra=
iler
used by Gerrit. For anyone that hasn't seen this, the Gerrit server provide=
s a
git commit hook that you can install locally. When installed, this appends =
a
'Change-ID' trailer to each and every commit message. In this way, the evol=
ution
of a patch (or a "change", in Gerrit parlance) can be tracked through time =
since
the Change ID provides an authoritative answer to the question "is this sti=
ll
the same patch". Unfortunately, there are still some obvious downside to th=
is
approach. Not only does this additional trailer clutter your commit message=
s but
it's also something the user must install themselves. While Gerrit can insi=
st
that this is installed before pushing a change, this isn't an option for an=
y of
the common forges nor is it something git-send-email supports.

I imagine most people working with mailing list based workflows have their =
own
client side tooling to support this while software forges like GitHub and G=
itLab
simply don't bother tracking version history between individual commits in =
a
pull/merge request. IMO though, it would be fantastic if third party tools
weren't necessary though. What I suspect we want is a persistent ID (or rat=
her
UUID) that never changes regardless of how many times a patch is cherry-pic=
ked,
rebased, or otherwise modified, similar to the Author and AuthorDate fields=
.
Like Author and AuthorDate, it would be part of the core git commit metadat=
a
rather than something in the commit message like Signed-Off-By or Change-ID=
.

Has such an idea ever been explored? Is it even possible? Would it be broad=
ly
useful?

Cheers,
Stephen

[1] github.com/getpatchwork/patchwork/
