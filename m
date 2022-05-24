Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4656C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 15:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbiEXPGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 11:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238670AbiEXPGH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 11:06:07 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE93B53
        for <git@vger.kernel.org>; Tue, 24 May 2022 08:06:05 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D9DD53F481F;
        Tue, 24 May 2022 11:06:04 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 77A923F481B;
        Tue, 24 May 2022 11:06:04 -0400 (EDT)
Subject: Re: [PATCH v7 27/30] t/lib-unicode-nfc-nfd: helper prereqs for
 testing unicode nfc/nfd
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
 <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
 <6a8308699543faaea760d4605babe50a0e478f41.1653336765.git.gitgitgadget@gmail.com>
 <xmqq5ylworwy.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <cef019a1-47c1-8f45-5018-bf0c2b4bfad4@jeffhostetler.com>
Date:   Tue, 24 May 2022 11:06:03 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq5ylworwy.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/23/22 5:33 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +	ls | test-tool hexdump | grep "63 5f c3 a9"
> 
> A few comments:
> 
>   * Not folding output lines at arbitrary place like "od", "hd",
>     etc. does, is a good design decision made by "hexdump" here.
>     Depending on where in the pathname the 4-byte sequence appears,
>     tools from other people may split the sequence across output
>     lines, making grep ineffective.  But our hexdump would work fine
>     here.
> 
>   * For the narrow purpose of the tests in this script, output that
>     is a single long line produced by hexdump might be sufficient,
>     but I wonder if it makes the tool more useful if we at least
>     placed the hexified output for each line on separate output
>     lines.


Yeah, having tools arbitrarily wrap every 16 or whatever bytes
(and including offset line prefixes) makes it difficult to use
when looking for specific patterns that might span a boundary.

I could see having a command line option to emit a '\n' (in addition
to or in place of) each LF in the input.  I suppose it depends on the
type of data we are dumping. (That also gets into issues about CRLFs,
however.)

I'm using hexdump for unicode text here, soit could make sense.  But
if I were using it to dump .git/index it wouldn't.

So having the default be one very long line is a good start.
We can teach it more later.

> 
>   * Purist in us may find it a bit disturbing that exit status from
>     test-tool is hidden by the pipe.  I do not care too deeply about
>     it, as it is very unlikely that we care about segfault after
>     hexdump successfully shows the substring the downstream grep is
>     looking for, but it does make us feel dirty.

Given the simplicity of the current version of the helper, I'm not
really worried about such problems.  I suppose that we could do the
usual trick of writing the hex dump to a file and grepping it, but
I'm not sure it's worth the bother right now.

> 
> A devil's advocate suggestion is to go in the completely opposite
> side of the spectrum.  Perhaps if we are willing to limit the tool's
> utility to the tests done in this script file, it might be a good
> idea to combine the latter two elements in the pipeline, i.e.
> 
> 	ls | test-tool hexgrep 63 5f c3 a9
> 
> that exits with 0 when the output from "ls" has the 4-byte sequence,
> exits with 1 when it does not, and exits with 139 when it segfauls ;-)
> 

I was a little afraid to suggest a hex version of grep.  That would
be interesting project to work on, but has lots of hard problems in
it and is too much to tack on to this series.  Johannes raises some
interesting questions in a later response in this thread that suggest
that this could be a seriously non-trivial task.  So again, I'd like
to not attempt this.

Thanks
Jeff
