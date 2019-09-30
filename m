Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDB361F464
	for <e@80x24.org>; Mon, 30 Sep 2019 10:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbfI3KBi (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 06:01:38 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55994 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbfI3KBi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 06:01:38 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 1D6811F463;
        Mon, 30 Sep 2019 10:01:38 +0000 (UTC)
Date:   Mon, 30 Sep 2019 10:01:38 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH v2 00/19] hashmap bug/safety/ease-of-use fixes
Message-ID: <20190930100137.GB24511@dcvr>
References: <20190924010324.22619-1-e@80x24.org>
 <nycvar.QRO.7.76.6.1909261032520.15067@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1909261032520.15067@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi Eric,
> 
> On Tue, 24 Sep 2019, Eric Wong wrote:
> 
> > Patches 1-11 are largely unchanged from the original series with the
> > exception of 2, which is new and posted at:
> >
> > 	https://public-inbox.org/git/20190908074953.kux7zz4y7iolqko4@whir/
> >
> > 12-17 take further steps to get us away from hashmap_entry being
> > the first element, but they're also a bit ugly because __typeof__
> > isn't portable
> >
> > 18-19 finally brings me to the APIs I want to expose without
> > relying on __typeof :)
> 
> I won't have time to review this patch series, but I wanted to throw out
> the idea of storing the offset in `struct hashmap`, i.e. the offset of
> the `struct hashmap_entry` in the actual entry struct?
> 
> Example:
> 
> 	struct erics_entry {
> 		const char *i_want_this_to_be_the_first_field;
> 		struct hashmap_entry e;
> 		[...]
> 	};
> 
> 	[...]
> 
> 	struct erics_entry *dummy = NULL;
> 	size_t offset = ((char *)dummy->e) - ((char *)dummy);
> 	[... store that offset in the hashmap and subtract it from the
> 	stored pointers before returning an entry...]
> 
> IOW rather than assuming that it is the first field, we could allow an
> offset other than 0. I'm just not sure how to implement this elegantly,
> but it should be much easier to do this portably than the `typeof()`
> approach.

Yeah, that needs to be &dummy->e, but that's the OFFSETOF_VAR
macro in patch 18.  I think it's quite elegant, but I need to
fix a clang warning for it...
