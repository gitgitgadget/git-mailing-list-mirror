Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 547D81F462
	for <e@80x24.org>; Wed, 29 May 2019 15:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfE2PCb (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 11:02:31 -0400
Received: from resqmta-po-05v.sys.comcast.net ([96.114.154.164]:49206 "EHLO
        resqmta-po-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726012AbfE2PCb (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 May 2019 11:02:31 -0400
Received: from resomta-po-19v.sys.comcast.net ([96.114.154.243])
        by resqmta-po-05v.sys.comcast.net with ESMTP
        id VzNFhpgIhF9fpW062h4uwO; Wed, 29 May 2019 15:02:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559142150;
        bh=+lJa9KDgf1Iw/VRpq5zJg3f4UnXQImhuLPnZqlQ+BdQ=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=5EcNehQUShjCuEzgXr5KvZ2kLdUDFkA0IIm2ArsN1yS193ejSR7ByYxdtr6bLx2O1
         FvyjmP548m2M3DSRM4d8q6Oa/aaizlpphJLc73Wr8pdn0oXzi0Y74BVD4u4My8ixuk
         SQCSyDyN9JnwuzNdZpu54SHjDCNqQ/R/hAOMxA+ipiSNq/nCM3QPOBNgrroM/p0Qm+
         tvz8GPVTW35kwGkGZOI8U6MUurbo+jNxfKeCQTLBLOSCxQ4pCA3alXDSf9FsBQVRk6
         QCHC2IEOKFCqJo+mIeCaHwswX8sN+7MmfRatrn94PJF0hoT2Eaqu/O0AC1JIeVL7tL
         qRr5vfsekiWeg==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:fc46:edea:c698:2e7a])
        by resomta-po-19v.sys.comcast.net with ESMTPSA
        id W060hGPF7mPHJW061hTfxM; Wed, 29 May 2019 15:02:29 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Wed, 29 May 2019 08:02:28 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v1 3/5] list-objects-filter: implement composite filters
Message-ID: <20190529150228.GC4700@comcast.net>
References: <cover.1558484115.git.matvore@google.com>
 <1f95597eedc4c651868601c0ff7c4a4d97ca4457.1558484115.git.matvore@google.com>
 <2b47d4b1-ea62-d59e-77e0-d95dfad084e0@jeffhostetler.com>
 <xmqqh89e31fg.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh89e31fg.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 28, 2019 at 10:59:31AM -0700, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
> > In the RFC version, there was discussion [2] of the wire format
> > and the need to be backwards compatible with existing servers and
> > so use the "combine:" syntax so that we only have a single filter
> > line on the wire.  Would it be better to have compliant servers
> > advertise a "filters" (plural) capability in addition to the

This is a good idea and I hadn't considered it. It does seem to make the
repeated filter lines a safer bet than I though.

> > existing "filter" (singular) capability?  Then the client would
> > know that it could send a series of filter lines using the existing
> > syntax.  Likewise, if the "filters" capability was omitted, the
> > client could error out without the extra round-trip.
> 
> All good ideas.

After hacking the code halfway together to make the above idea work, and
learning quite a lot in the process, I saw set_git_option in transport.c and
realized that all existing transport options are assumed to be ? (0 or 1) rather
than * (0 or more). So "filter" would be the first transport option that is
repeated.

Even though multiple reviewers have weighed in supporting repeated filter lines,
I'm still conflicted about it. It seems the drawback to the + syntax is the
requirement for encoding the individual filters, but this encoding is no longer
required since the sparse:path=... filter no longer has to be supported. And the
URL encoding, if it is ever reintroduced, is just boilerplate and is unlikely to
change later or cause a significant maintainance burden.

The essence of the repeated filter line is that we need additional high-level
machinery just for the sake of making the lower-level machinery... marginally
simpler, hopefully? And if we ever need to add new filter combinations (like OR
or XOR rather than AND) this repeated filter line thing will be a legacy
annoyance (users will wonder why does repeated "filter" mean AND rather than
one of the other supported combination methods?). Repeating filter lines seems
like a leaky abstraction to me.

I would be helped if someone re-iterated why the repeated filter lines are a
good idea in light of the fact that URL escaping is no longer required to make
it work.
