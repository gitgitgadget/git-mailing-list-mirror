Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15F4D1F406
	for <e@80x24.org>; Fri, 11 May 2018 22:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbeEKWVi (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 18:21:38 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:58004 "EHLO
        homiemail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750876AbeEKWVh (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 May 2018 18:21:37 -0400
Received: from homiemail-a11.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a11.g.dreamhost.com (Postfix) with ESMTP id 62617314C06D;
        Fri, 11 May 2018 15:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=BLn5Z
        KVoLJBPgYKbeBWNg/9Nbeg=; b=rhGPExS4qHcoZSmosVm4NoNKvo8zbFJqDEq8p
        hMIJ+5/FvZyXkcphCnUbw9DjDzZIpbJ/KCYckyn4bmDZI1vj84mzSkzfPgdbZEcB
        DcMR9j0/80/lb0b0rYAtTaIHyVwyJkDtC0JRiV0zeY0VZvYPzUI4xgv+zhkIc9R7
        nemFqQ=
Received: from corey (unknown [38.27.161.17])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a11.g.dreamhost.com (Postfix) with ESMTPSA id 7C118314C069;
        Fri, 11 May 2018 15:21:35 -0700 (PDT)
Message-ID: <1526077294.16035.33.camel@novalis.org>
Subject: Re: Implementing reftable in Git
From:   David Turner <novalis@novalis.org>
To:     mhagger@alum.mit.edu, Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Date:   Fri, 11 May 2018 18:21:34 -0400
In-Reply-To: <CAMy9T_H=_+9Z=CpX85Ma4gCyUuvNAPR7fSBHi2J=4nC1XzF2sg@mail.gmail.com>
References: <CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com>
         <CAMy9T_H=_+9Z=CpX85Ma4gCyUuvNAPR7fSBHi2J=4nC1XzF2sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2018-05-11 at 11:31 +0200, Michael Haggerty wrote:
> On Wed, May 9, 2018 at 4:33 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
> > I might start working on implementing reftable in Git soon.
> > [...]
> 
> Nice. It'll be great to have a reftable implementation in git core
> (and ideally libgit2, as well). It seems to me that it could someday
> become the new default reference storage method. The file format is
> considerably more complicated than the current loose/packed scheme,
> which is definitely a disadvantage (for example, for other Git
> implementations). But implementing it *with good performance and
> without races* might be no more complicated than the current scheme.

I am somewhat concerned about perf, because as I recall, we have a
bunch of code which effectively load all refs, which will be more
expensive with reftable than packed-refs (though maybe cheaper than
loose refs).  But maybe we have eliminated this code or can work around
it.

> Testing will be important. There are already many tests specifically
> about testing loose/packed reference storage. These will always have
> to run against repositories that are forced to use that reference
> scheme. And there will need to be new tests specifically about the
> reftable scheme. Both classes of tests should be run every time. That
> much is pretty obvious.
> 
> But currently, there are a lot of tests that assume the loose/packed
> reference format on disk even though the tests are not really related
> to references at all. ISTM that these should be converted to work at
> a
> higher level, for example using `for-each-ref`, `rev-parse`, etc. to
> examine references rather than reading reference files directly. That
> way the tests should run correctly regardless of which scheme is in
> use.

I agree with that, and I think some of my patches from years ago
attempted to do that.  I probably should have broken those out into a
separate series so that they could have been applied separately.

> And since it's too expensive to run the whole test suite with both
> reference storage schemes, it seems to me that the reference storage
> scheme that is used while running the scheme-neutral tests should be
> easy to choose at runtime.

I ran the whole suite with both schemes during my testing, and I think
it was quite valuable in flushing out bugs.

> David Turner did some analogous work for wiring up and testing his
> proposed LMDB ref storage backend that might be useful [1]. I'm CCing
> him, since he might have thoughts on this topic.

Inline, above.
