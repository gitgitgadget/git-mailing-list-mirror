Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 789D51F855
	for <e@80x24.org>; Fri, 29 Jul 2016 23:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbcG2XLr (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 19:11:47 -0400
Received: from plane.gmane.org ([80.91.229.3]:40456 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753442AbcG2XLq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 19:11:46 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bTGwT-0006RW-67
	for git@vger.kernel.org; Sat, 30 Jul 2016 01:11:45 +0200
Received: from ddi132.neoplus.adsl.tpnet.pl ([83.23.86.132])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 01:11:45 +0200
Received: from jnareb by ddi132.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 01:11:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 5/5] convert: add filter.<driver>.process option
Date:	Sat, 30 Jul 2016 01:11:24 +0200
Message-ID: <1a009e19-8830-7dea-2811-d475cf482ea3@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160727000605.49982-1-larsxschneider@gmail.com>
 <20160727000605.49982-6-larsxschneider@gmail.com>
 <57994436.4080308@gmail.com> <7F1F1A0E-8FC3-4FBD-81AA-37786DE0EF50@gmail.com>
 <xmqqshusny86.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
Cc:	Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Eric Wong <e@80x24.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
X-Gmane-NNTP-Posting-Host: ddi132.neoplus.adsl.tpnet.pl
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
In-Reply-To: <xmqqshusny86.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-29 o 19:35, Junio C Hamano pisze:
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> I think sending it upfront is nice for buffer allocations of big files
>> and it doesn't cost us anything to do it.
> 
> While I do NOT think "total size upfront" MUST BE avoided at all costs,
> I do not think the above statement to justify it makes ANY sense.
> 
> Big files are by definition something you cannot afford to hold its
> entirety in core, so you do not want to be told that you'd be fed 40GB
> and ask xmalloc to allocate that much.

I don't know much how filter driver work internally, but in some cases
Git reads or writes from file (file descriptor), in other cases it reads
or writes from str+len pair (it probably predates strbuf) - I think in
those cases file needs to fit in memory (in size_t).  So in some cases
Git reads file into memory.  Whether it uses xmalloc or mmap, I don't
know.

> 
> It allows the reader to be lazy for buffer allocations as long as
> you know the file fits in-core, at the cost of forcing the writer to
> somehow come up with the total number of bytes even before sending a
> single byte (in other words, if the writer cannot produce and hold
> the data in-core, it may even have to spool the data in a temporary
> file only to count, and then play it back after showing the total
> size).

For some types of filters you can know the size upfront:
 - for filters such as rot13, with 1-to-1 transformation, you know
   that the output size is the same as the input size
 - for block encodings, and for constant-width to constant-width
   encoding conversion, filter can calculate output size from the
   input size (e.g. <output size> = 2*<input size>)
 - filter may have get size from somewhere, for example LFS filter
   stub is constant size, and files are stored in artifactory with
   their length 

> 
> It is good that you allow both mode of operations and the size of
> the data can either be given upfront (which allows a single fixed
> allocation upfront without realloc, as long as the data fits in
> core), or be left "(atend)".

I think the protocol should be either: <size> + <contents>, or
<size unknown> + <contents> + <flush>, that is do not use flush
packet if size is known upfront -- it would be a second point
of truth (SPOT principle).
 
> I just don't want to see it oversold as a "feature" that the size
> has to come before data.  That is a limitation, not a feature.
> 
> Thanks.
> 


