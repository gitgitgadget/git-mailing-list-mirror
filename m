Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E57401F403
	for <e@80x24.org>; Sun, 10 Jun 2018 15:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeFJPNn (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 11:13:43 -0400
Received: from p3plsmtpa06-05.prod.phx3.secureserver.net ([173.201.192.106]:52079
        "EHLO p3plsmtpa06-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753375AbeFJPNm (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jun 2018 11:13:42 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id S1v9flq10xappS1vBflh3T; Sun, 10 Jun 2018 08:06:23 -0700
Date:   Sun, 10 Jun 2018 18:06:19 +0300
From:   Max Kirillov <max@max630.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] http-backend: respect CONTENT_LENGTH for
 receive-pack
Message-ID: <20180610150619.GD27650@jessie.local>
References: <20180602212749.21324-1-max@max630.net>
 <20180602212749.21324-3-max@max630.net>
 <20180604044408.GD14451@sigill.intra.peff.net>
 <20180604221807.GC27650@jessie.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604221807.GC27650@jessie.local>
From2:  "Maksim Kirillov" <max630@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfMaKhDJEkhUnLpilBUxB/9sSzwEl9b0YByIEdYOQKFN/4PEncpfjKr+8C0hvxHKXPcD8iQVAeDL7PYNGn5EU6tBQbzlI1oVM8lB2ciQR+JzAB3+8ExrW
 FLYGEANLIYxlpcG3EAmt+johFQVheG3gPgj5GMivvfO5zjsXR1/j97TH3j/POR/XQMOUjFLz54nZjOE1Fv9hIPoHGcMvYZ3DfUBdMrbJc9FvlwEBnfHWtsB9
 dYKJFz8TxWdEY35phZo6p6ZWUIsyJfC5YHKQnWcxdsTrMjScmPIN0arUrRY3yDnBEDpCm50ewW5mz8N1mGWuzDll+KB0FPZ9/nfNQdWo3wHS4uSiwO9kC+Mo
 MA66JuJKq7zoTq+tdiOBtmzOiTMh7lVoQcP7j5nzLnhIWxGzfXs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 05, 2018 at 01:18:08AM +0300, Max Kirillov wrote:
> On Mon, Jun 04, 2018 at 12:44:09AM -0400, Jeff King wrote:
>> Since this is slightly less efficient, and because it only matters if
>> the web server does not already close the pipe, should this have a
>> run-time configuration knob, even if it defaults to
>> safe-but-slightly-slower?
> 
> Personally, I of course don't want this. Also, I don't think
> the difference is much noticeable. But you can never be sure
> without trying. I'll try to measure some numbers.

It seems to be challenging to see any effect at my system.
At least not with any real operation because changing
references needs IO and index-pack needs CPU so. I'll try
it some more.

>> We should probably say something more generic like:
>> 
>>   die_errno("unable to write to '%s'");
>> 
>> or similar.
> 
> Actually, it is already 3rd same error in this file. Maybe
> deserve some refactoring. I will change the message also.

Extracted the writing and refactoring to a single function,
also fixed the message.

>>> +cat >fetch_body <<EOF
>>> +0032want $hash_head
>>> +00000032have $hash_prev
>>> +0009done
>>> +EOF
>> 
>> This depends on the size of the hash. That's always 40 for now, but is
>> something that may change soon.
>> 
>> We already have a packetize() helper; could we use it here?

> Could you point me to it? I cannot find it.

Sorry, misread it as packetSize. Found and used.

>> Also, do we need to protect ourselves against other signals being
>> delivered? E.g., if I resize my xterm and this process gets SIGWINCH, is
>> it going to erroneously end the sleep and say "nope, no exited signal"?

> I'll check, but what could I do? Should I add blocking other
> signals there?

In my Linux I don't see the signal. Except that, there seem to
be not that many ignored signals. Anyway, I don't see what
could be done bout it.
