Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36CA51F5FB
	for <e@80x24.org>; Tue, 28 Feb 2017 00:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbdB1AuD (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 19:50:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:35306 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751583AbdB1AuC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 19:50:02 -0500
Received: (qmail 11388 invoked by uid 109); 28 Feb 2017 00:50:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 00:50:00 +0000
Received: (qmail 21988 invoked by uid 111); 28 Feb 2017 00:50:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 19:50:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2017 19:49:57 -0500
Date:   Mon, 27 Feb 2017 19:49:57 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [BUG] branch renamed to 'HEAD'
Message-ID: <20170228004957.xphg6ludprkzo4yh@sigill.intra.peff.net>
References: <20170227045257.yazqlrqlnggosi5t@macbook.local>
 <CAOLa=ZSyQg9uoZWADOMYc90U-5AR9Lfii9mjLre0m0FQCSqfxg@mail.gmail.com>
 <20170227074915.xljfe5jox756rlyv@sigill.intra.peff.net>
 <20170227080158.de2xarctzscfdsp2@sigill.intra.peff.net>
 <20170227090233.uk7dfruggytgmuw2@sigill.intra.peff.net>
 <xmqq60jvnu9y.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xpVt6NtSajqMX8OQ_SKdC9tfHH40JgK=9DgBxo9nMaWLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xpVt6NtSajqMX8OQ_SKdC9tfHH40JgK=9DgBxo9nMaWLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 03:05:37PM -0800, Jacob Keller wrote:

> > Perhaps with s/not_in_refs_heads/not_a_branch_name/ (or swapping
> > polarity, "is_a_branch_name"), the resulting code may not be too
> > hard to read?
> 
> What about changing interpret-branch-name gains a flag to return a
> fully qualified ref rather than returning just the name? That seems
> like it would be more reasonable behavior.

That's not sufficient. If I feed "refs/remotes/origin/master" as a
branch name to git-branch, then as silly as that is, it is the branch
whose ref is "refs/heads/refs/remotes/origin/master".

Since interpret_branch_name() is not fully qualifying everything, but
rather just _sometimes_ replace @-marks with refnames, we cannot tell
from just the string the difference between "the user fed us
refs/remotes/foo" and "the @-mark expanded to a non-branch
refs/remotes/foo". We need one extra bit of information to know whether
an expansion occurred.

You could give a flag that says "do not expand to anything outside of
refs/heads/" that would suppress the @->HEAD mark, as well as
@{upstream} when upstream is outside of refs/heads. That would certainly
be less nasty than the out-parameter, but I wasn't sure that the error
handling was what we wanted.

In strbuf_branchname(), we quietly turn that error into a "0", which
causes us to retain the original text. We then feed that into
check_refname_format() in strbuf_check_branch_ref(). Which I think would
complain, and you'd get "not a valid refname: @{upstream}". If we have
the out-bit, we can say "I understand what @{upstream} means, but it
does not expand to a local branch". That's a more specific error, but
maybe it is not worth the hassle to produce it.

-Peff
