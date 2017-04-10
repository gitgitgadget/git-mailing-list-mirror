Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E15F20966
	for <e@80x24.org>; Mon, 10 Apr 2017 15:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753637AbdDJPA6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 11:00:58 -0400
Received: from 5.itsy.de ([188.40.84.14]:51288 "EHLO 5.itsy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753297AbdDJPAA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 11:00:00 -0400
Received: from [192.168.0.13] (84-72-0-73.dclient.hispeed.ch [84.72.0.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 5.itsy.de (Postfix) with ESMTPSA id A45AE64790
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 16:59:57 +0200 (CEST)
Subject: Re: [PATCH 2/2] test-lib: exhaustively insert non-alnum ASCII into
 the TRASH_DIRECTORY name
References: <20170409191117.25175-3-avarab@gmail.com>
 <20170410014712.26716-1-szeder.dev@gmail.com>
 <CACBZZX6M2YnbOT6btqLf2RacNT0Th3Hx2jf5QR7g+KFS_DKtVQ@mail.gmail.com>
 <CAM0VKjnwbCgCjEBr895068k4veoSGZMf8Cu7neoH=oofgWS2Cw@mail.gmail.com>
 <CACBZZX7kMcTgKFkFN3OvVKVHU693PYhRFe6gyO4AirihNsUYmg@mail.gmail.com>
 <20170410133856.qbmcif2it2gc6kdw@sigill.intra.peff.net>
To:     Git Mailing List <git@vger.kernel.org>
From:   Joachim Durchholz <jo@durchholz.org>
Message-ID: <64121361-6f91-5988-b5e2-9278cc84067f@durchholz.org>
Date:   Mon, 10 Apr 2017 16:59:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170410133856.qbmcif2it2gc6kdw@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.04.2017 um 15:38 schrieb Jeff King:
> Are those bugs? Maybe. Certainly they are limitations. But are they ones
> anybody _cares_ about?  I think this may fall under "if it hurts, don't
> do it".

It's not always possible to avoid that.

URLs, for example, may contain "funny characters", including multi-byte 
characters of which the second byte is 0x0a. If they are guaranteed to 
always be URL-encoded this isn't a problem, but then we still need to 
make sure that URL-encoding does happen.

Next source of funny characters that comes to my mind is submodules. 
They derive their name from the URL by default, and the subdirectory 
name as well. Again, consider the multibyte name where the second 
character is 0x0a. Or 0x80: À (uppercase A with accent grave) happens to 
have that byte in UTF-8 encoding, Ẁ is U+1E80 which would be encoded as 
0x80 0x1e on an NTFS filesystem (barring additional coding steps in APIs 
or webservices, which further complicate the situation but don't usually 
eliminate the problem, they just shift it around).

 > If there are security bugs where a malicious input can cause us
> to do something bad, that's something to care about. But that's very
> different than asking "do these tests run to completion with a funny
> input".

If the tests do not complete, git is doing something unexpected.
That in itself is not a security hole, but there's a pretty good chance 
that at least one of these ~230 unexpected things can be turned into 
one, given enough time and motivation. The risk multiplies as this is 
shell scripting, where the path from "string is misinterpreted" to 
"string is run as a command" is considerably shorter than in other 
languages.
