Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48A551F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 21:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbcHOVfg (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 17:35:36 -0400
Received: from mta02.prd.rdg.aluminati.org ([94.76.243.215]:43604 "EHLO
	mta02.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752962AbcHOVff (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2016 17:35:35 -0400
Received: from mta02.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id 01FA3232BA;
	Mon, 15 Aug 2016 22:35:34 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTP id E7F5633E0;
	Mon, 15 Aug 2016 22:35:33 +0100 (BST)
X-Quarantine-ID: <xSbf2gHZtFO6>
X-Virus-Scanned: Debian amavisd-new at mta02.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta02.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xSbf2gHZtFO6; Mon, 15 Aug 2016 22:35:31 +0100 (BST)
Received: from john.keeping.me.uk (unknown [10.2.0.9])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 9494033DB;
	Mon, 15 Aug 2016 22:35:27 +0100 (BST)
Date:	Mon, 15 Aug 2016 22:35:26 +0100
From:	John Keeping <john@keeping.me.uk>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"Tom Tanner (BLOOMBERG/ LONDON)" <ttanner2@bloomberg.net>,
	davvid@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] difftool: always honor "command not found" exit code
Message-ID: <20160815213526.6m7gu2v3fhtmx6wj@john.keeping.me.uk>
References: <57B19B9F0205070000390238_0_29566@p057>
 <xmqqa8gdhjgd.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa8gdhjgd.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.2 (2016-06-11)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 01:21:22PM -0700, Junio C Hamano wrote:
> "Tom Tanner (BLOOMBERG/ LONDON)" <ttanner2@bloomberg.net> writes:
> 
> > From: gitster@pobox.com
> > To: john@keeping.me.uk
> > Cc: Tom Tanner (BLOOMBERG/ LONDON), davvid@gmail.com, git@vger.kernel.org
> > At: 08/14/16 04:21:18
> >
> > John Keeping <john@keeping.me.uk> writes:
> > ...
> >> POSIX specifies 127 as the exit status for "command not found" and 126
> >> for "command found but is not executable" [1] and at least bash and dash
> >> follow this specification, while diff utilities generally use "1" for
> >> the exit status we want to ignore.
> >>
> >> Handle 126 and 127 as special values, assuming that they always mean
> >> that the command could not be executed.
> >
> > Sounds like a reasonable thing to do.  Will queue; thanks.
> 
> > Would it be possible to also treat signals (128 and above) as
> > 'special' values as well (as I've seen some merge tools self
> > destruct like that from time to time)
> 
> Certainly, it feels safer to notice an unusual exit status code and
> error out to force the user to take notice, but that reasoning
> assumes that "128 and above" are noteworthy exceptions.

Reading further in POSIX:

	The exit status of a command that terminated because it received
	a signal shall be reported as greater than 128.

I think if we accept the argument above about diff utilities generally
using low numbers for the status values we're ignoring intentionally,
then we can just treat any value above 125 as a fatal error.
