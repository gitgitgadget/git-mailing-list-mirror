Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62061203E3
	for <e@80x24.org>; Mon, 25 Jul 2016 07:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbcGYH1r (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 03:27:47 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48332 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbcGYH1q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 03:27:46 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37E71203C1;
	Mon, 25 Jul 2016 07:27:45 +0000 (UTC)
Date:	Mon, 25 Jul 2016 07:27:45 +0000
From:	Eric Wong <e@80x24.org>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	jnareb@gmail.com,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
Message-ID: <20160725072745.GB11634@starla>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160722154900.19477-4-larsxschneider@gmail.com>
 <20160723081447.GA24318@starla>
 <121F8453-3A12-47AE-AE10-021EADC4D995@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <121F8453-3A12-47AE-AE10-021EADC4D995@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> wrote:
> On 23 Jul 2016, at 10:14, Eric Wong <e@80x24.org> wrote:
> > larsxschneider@gmail.com wrote:
> >> +static struct cmd2process *start_protocol_filter(const char *cmd)
> >> +{
> >> +	int ret = 1;
> >> +	struct cmd2process *entry = NULL;
> >> +	struct child_process *process = NULL;
> > 
> > These are unconditionally set below, so initializing to NULL
> > may hide future bugs.
> 
> OK. I thought it is generally a good thing to initialize a pointer with 
> NULL. Can you explain to me how this might hide future bugs?
> I will remove the initialization.

Compilers complain about uninitialized variables.  Blindly
setting them to NULL can allow them to be dereferenced;
triggering segfaults; especially if it's passed to a different
compilation unit the compiler can't see.

> >> +static int apply_protocol_filter(const char *path, const char *src, size_t len,
> >> +						int fd, struct strbuf *dst, const char *cmd,
> >> +						const char *filter_type)
> >> +{

<snip>

> >> +			if (fd >= 0 && !src) {
> >> +				ret &= fstat(fd, &fileStat) != -1;
> >> +				len = fileStat.st_size;
> > 
> > There's a truncation bug when sizeof(size_t) < sizeof(off_t)
> 
> OK. What would you suggest to do in that case? Should we just let the
> filter fail? Is there anything else we could do?

Anything which refers to something on disk (or will eventually
stored there, such as blobs) should evolve towards off_t rather
than size_t.  We just discovered a bunch of 32-bit truncation
bugs the other week:

https://public-inbox.org/git/1466807902.28869.8.camel@gmail.com/

If the protocol/ABI is frozen, it should probably fail;
and a 64-bit-off_t version for 32-bit systems should be defined.
