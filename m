Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 392BE202D7
	for <e@80x24.org>; Tue,  7 Mar 2017 09:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754731AbdCGJY7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 04:24:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:39616 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754884AbdCGJX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 04:23:58 -0500
Received: (qmail 3058 invoked by uid 109); 7 Mar 2017 09:23:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Mar 2017 09:23:56 +0000
Received: (qmail 24200 invoked by uid 111); 7 Mar 2017 09:24:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Mar 2017 04:24:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Mar 2017 04:23:54 -0500
Date:   Tue, 7 Mar 2017 04:23:54 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     tom@oxix.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [Request for Documentation] Differentiate signed
 (commits/tags/pushes)
Message-ID: <20170307092353.ibirvitsxhzn3apz@sigill.intra.peff.net>
References: <CAGZ79kYxD9B_+3vBgO+Z-wh2GMg_REazA-xpTSAqe3_64VMV3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYxD9B_+3vBgO+Z-wh2GMg_REazA-xpTSAqe3_64VMV3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2017 at 11:59:24AM -0800, Stefan Beller wrote:

> What is the difference between signed commits and tags?
> (Not from a technical perspective, but for the end user)

I think git has never really tried to assign any _meaning_ to the
signatures. It implements the technical bits and leaves it up to the
user and their workflows to decide what a given signature means.

People generally seem to take tag signatures to mean one (or both) of:

  1. Certifying that the tree contents at that tag are the official,
     signed release contents (i.e., this is version 1.0, and I'm the
     maintainer, so believe me).

  2. Certifying that all the history leading up to that tag is
     "official" in some sense (i.e., I'm the maintainer, and this was
     the tip of my git tree at the time I tagged the release).

Signing individual commits _could_ convey meaning (2), but "all history
leading up" part is unlikely to be something that the signer needs to
enforce on every commit.

In my opinion, the most useful meaning for commit-signing is simply to
cryptographically certify the identity of the committer. We don't
compare the GPG key ident to the "committer" field, but IMHO that would
be a reasonable optional feature for verify-commit (I say optional
because we're starting to assign semantics now).

I think one of the reasons kernel (and git) developers aren't that
interested in signed commits is that they're not really that interesting
in a patch workflow. You're verifying the committer, who in this project
is invariably Junio, and we just take his word that whatever is in the
"author" field is reasonable.

But for a project whose workflow is based around pushing and pulling
commits, I think it does make sense. The author field may not always
match the committer (e.g., in a cherry-pick), but it still lets you
trace that attestation of the author back to the committer. And it's up
to UI to make that distinction clear (e.g., if you push a signed
cherry-pick to GitHub, the commit is labeled with something like "A U
Thor committed with C O Mitter", and then you get a little "Verified"
tag for C O Mitter that gives you more information about the signature).

So I don't think it's just a checkbox feature. It's a useful thing for
certain workflows that really want to be able to attribute individual
commits with cryptographic strength.

-Peff
