Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 955152018B
	for <e@80x24.org>; Mon, 18 Jul 2016 21:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbcGRVTz (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 17:19:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50324 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366AbcGRVTw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 17:19:52 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07E352018B;
	Mon, 18 Jul 2016 21:19:52 +0000 (UTC)
Date:	Mon, 18 Jul 2016 21:19:51 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-lib: stricter unzip(1) check
Message-ID: <20160718211951.GA62657@plume>
References: <20160718064431.GA10819@starla>
 <20160718130405.GA19751@sigill.intra.peff.net>
 <xmqqshv6ivfk.fsf@gitster.mtv.corp.google.com>
 <20160718200351.GA61232@plume>
 <xmqqk2giitrn.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk2giitrn.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> > Junio C Hamano <gitster@pobox.com> wrote:
> >> +test_lazy_prereq UNZIP_AUTOTEXT '
> >> +	(
> >> +		mkdir unzip-autotext &&
> >> +		cd unzip-autotext
> >> +		"$GIT_UNZIP" -a "$TEST_DIRECTORY"/t5003/infozip-text.zip &&
> >> +		test -f text
> >> +	)
> >
> > /usr/bin/unzip actually takes -a on FreeBSD, just not in the
> > same way the Info-ZIP version does, so I suspect "test -f"
> > here is not enough.
> 
> Hmph.  So it only and always does "CRLF -> LF", while Info-ZIP
> version does something like autocrlf?

No, it does CRLF -> LF based on the absence of non-ASCII
characters and ignoring metadata set in the zipfile.
The unzip manpage states:

     Normally, the -a option should only affect files which are
     marked as text files in the zipfile's central directory.  Since
     the archive(3) library reads zipfiles sequentially, and does
     not use the central directory, that information is not available
     to the unzip utility.  Instead, the unzip utility will assume
     that a file is a text file if no non-ASCII characters are
     present within the first block of data decompressed for that
     file.  If non-ASCII characters appear in subsequent blocks of
     data, a warning will be issued.

https://www.freebsd.org/cgi/man.cgi?query=unzip&sektion=1&manpath=FreeBSD+10.3-RELEASE

> Heh.  It was created like so:
> 
> 	$ printf 'text\r\n' >text && zip -ll infozip-text.zip text
> 	$ zipinfo infozip-text.zip text
>         -rw-r-----  3.0 unx        5 tx stor 16-Jul-18 13:12 text
> 

Thanks, but I think the test file is too small.  I tried
setting up a test to store the text file as binary in the
zip to check for inadvertant CRLF conversions:

  printf 'text\r\n' >binary && zip -B infozip-binary.zip binary

But zip -B/--binary only works on VM/CMS and MVS...

So I'm inclined to go with Dscho's patch.


(apologies for messing up René's name in my previous email;
 on my new FreeBSD setup: mutt displays it fine, as does vim when
 taking it from .mailmap, but something gets lost when mutt
 populates the file for vim.  Perhaps some Debian patch didn't
 make it upstream...)
