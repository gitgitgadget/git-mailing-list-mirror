Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3751A20248
	for <e@80x24.org>; Tue, 26 Mar 2019 18:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbfCZSkE (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 14:40:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:37028 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732474AbfCZSkE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 14:40:04 -0400
Received: (qmail 18343 invoked by uid 109); 26 Mar 2019 18:40:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Mar 2019 18:40:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22233 invoked by uid 111); 26 Mar 2019 18:40:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Mar 2019 14:40:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2019 14:40:01 -0400
Date:   Tue, 26 Mar 2019 14:40:01 -0400
From:   Jeff King <peff@peff.net>
To:     Daniel Kahn Gillmor <dkg@fifthhorseman.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git tag -v should verify that the tag signer intended the same
 tag name as the user is verifying
Message-ID: <20190326184001.GD24105@sigill.intra.peff.net>
References: <875zsdu41d.fsf@fifthhorseman.net>
 <xmqq5zsduinf.fsf@gitster-ct.c.googlers.com>
 <xmqq1s31ui5s.fsf@gitster-ct.c.googlers.com>
 <87imwbmqpg.fsf@fifthhorseman.net>
 <xmqqpnqgpifu.fsf@gitster-ct.c.googlers.com>
 <87k1goia52.fsf@fifthhorseman.net>
 <xmqqh8brofid.fsf@gitster-ct.c.googlers.com>
 <87ftr9h72a.fsf@fifthhorseman.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ftr9h72a.fsf@fifthhorseman.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 06:35:57PM +0100, Daniel Kahn Gillmor wrote:

> But I don't see how to use --format with "git tag -v" at all.  Can you
> show me what i'm doing wrong?  git-tag(1) says that --format defaults to
> '%(refname:strip=2)', but git tag -v behaves differently when i specify
> that same default explicitly:

Hmm.

I think the documentation is unclear. For a normal listing of tags,
the default format is the stripped refname, and you can override it with
--format.

For "-v", the default is to dump the whole tag contents (i.e.,
traditionally it just ran "verify-tag -v" under the hood, though I think
it is all done internally now).

So this doesn't surprise me:

>     0 dkg@alice:~/src/pkg-gnupg/gnupg2$ git tag -v gnupg-2.2.13
>     object 7922e2dd1c7eee48a8a2cf4799827942489ddd0f
>     type commit
>     tag gnupg-2.2.13
>     tagger Werner Koch <wk@gnupg.org> 1549985965 +0100
> 
>     You may want to watch the Ellsberg/Chomsky discussion
>     at <https://riseuptimes.org/2018/04/25/daniel-ellsberg-and-noam-chomsky-discuss-nuclear-war/>
>     or at <https://theintercept.com/chomsky-ellsberg/>
>     gpg: Signature made Tue 12 Feb 2019 04:41:32 PM CET
>     gpg:                using RSA key D8692123C4065DEA5E0F3AB5249B39D24F25E3B6
>     gpg: Good signature from "Werner Koch (dist sig)" [full]
>     Primary key fingerprint: D869 2123 C406 5DEA 5E0F  3AB5 249B 39D2 4F25 E3B6

But this does:

>     0 dkg@alice:~/src/pkg-gnupg/gnupg2$ git tag -v --format='%(refname:strip=2)' gnupg-2.2.13

I'd expect it to print the tagname here. It looks like we only feed the
partial tagname to the ref-formatting machinery, so the "strip" doesn't
do what you'd expect.

It also doesn't show the gpg output, though it does actually verify the
tag. But AFAIK there's no format specifier in the ref-filter language
for showing the GPG output! What a mess.

-Peff
