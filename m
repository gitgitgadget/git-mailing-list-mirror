Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50C1420179
	for <e@80x24.org>; Mon,  4 Jul 2016 14:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbcGDOeD (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 10:34:03 -0400
Received: from plane.gmane.org ([80.91.229.3]:59368 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942AbcGDOeA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2016 10:34:00 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bK4wg-0004Rb-EU
	for git@vger.kernel.org; Mon, 04 Jul 2016 16:33:58 +0200
Received: from ewv108.neoplus.adsl.tpnet.pl ([83.20.245.108])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Jul 2016 16:33:58 +0200
Received: from jnareb by ewv108.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Jul 2016 16:33:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH] diff compaction heuristic: favor shortest neighboring
 blank lines
Date:	Mon, 4 Jul 2016 16:33:48 +0200
Message-ID: <577A73CC.1050200@gmail.com>
References: <20160616174620.1011-1-sbeller@google.com>
 <20160617153637.GA9314@sigill.intra.peff.net>
 <CAGZ79kZgdbqnWW9uqeBHNDbyGVfc0x5gTJbyD0Nyi1i3SNvENQ@mail.gmail.com>
 <576C1803.5050905@alum.mit.edu> <57752478.1000302@alum.mit.edu>
 <xmqq8txlz19e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@ger.gmane.org
Cc:	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>
X-Gmane-NNTP-Posting-Host: ewv108.neoplus.adsl.tpnet.pl
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <xmqq8txlz19e.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-01 o 20:01, Junio C Hamano pisze:
> Michael Haggerty <mhagger@alum.mit.edu> writes:

>> It often fails to get C preprocessor directives right:
>>
>>> a08595f76159b09d57553e37a5123f1091bb13e7:http.c aeff8a61216bf6e0d663c08c583bc8552fa3c344:http.c + 429
>>> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>>>                >		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
>>>                >#endif
>>>                >#if LIBCURL_VERSION_NUM >= 0x070908
>>>                >	if (ssl_capath != NULL)
>>>                >		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
>>>       -1 |   i >#endif
>>>        0 || ci >#if LIBCURL_VERSION_NUM >= 0x072c00
>>>          || ci >	if (ssl_pinnedkey != NULL)
>>>          || ci >		curl_easy_setopt(result, CURLOPT_PINNEDPUBLICKEY, ssl_pinnedkey);
>>>           | c  >#endif
> 
> Yes, this is "non-human do not know 'end' is likely to be at the end
> of a logical block".

I wonder if taking into account xfuncname match to adjust heuristics
(or to change "slider") would help there.  I think good heuristic
would be to break before xfuncname match (before new section).
 
>> And it gets confused by unusual blank line placement:
>>
>>> ed55169834a3ce16a271def9630c858626ded34d:tools/eslint/node_modules/doctrine/lib/doctrine.js 2d441493a4a46a511ba1bdf93e442c3288fbe92d:tools/eslint/node_modules/doctrine/lib/doctrine.js + 330
>>> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>>>                >                        name === 'external' ||
>>>                >                        name === 'event')) {
>>>                >                    name += advance();
>>>                >                    name += scanIdentifier(last);
>>>                >
>>>       -1 |   i >                }
>>>        0 || ci >                if(source.charCodeAt(index) === 0x5B  /* '[' */ && source.charCodeAt(index + 1) === 0x5D  /* ']' */){
>>>          || ci >                    name += advance();
>>>          || ci >                    name += advance();
>>>           | c  >                }
> 
> Likewise, this is showing that a "non-human not knowing } is a closing
> and { is an opening token".

If not encoding heuristic that [,{,( are opening token, and ],},) are
closing token into heuristics, perhaps length of the line could be
a consideration about where to start a diff chunk?

-- 
Jakub Narębski


