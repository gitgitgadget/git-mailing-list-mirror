Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDF151F453
	for <e@80x24.org>; Fri,  8 Feb 2019 20:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfBHUXi (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 15:23:38 -0500
Received: from ikke.info ([178.21.113.177]:41040 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfBHUXi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 15:23:38 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 7FCD34400CB; Fri,  8 Feb 2019 21:23:36 +0100 (CET)
Date:   Fri, 8 Feb 2019 21:23:36 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Rich Felker <dalias@libc.org>, git@vger.kernel.org,
        larsxschneider@gmail.com
Subject: Re: t0028-working-tree-encoding.sh failing on musl based systems
 (Alpine Linux)
Message-ID: <20190208202336.GA5284@alpha>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Rich Felker <dalias@libc.org>, git@vger.kernel.org,
        larsxschneider@gmail.com
References: <20190207215935.GA31515@alpha>
 <20190208001705.GC11927@genre.crustytoothpaste.net>
 <20190208060403.GA29788@brightrain.aerifal.cx>
 <20190208114502.GD11927@genre.crustytoothpaste.net>
 <20190208115511.GA30779@alpha>
 <20190208135137.GE11927@genre.crustytoothpaste.net>
 <xmqqr2cikw4w.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr2cikw4w.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 09:50:07AM -0800, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> >> So would you suggest that we just skip this test on Alpine Linux?
> >
> > That's not exactly what I said. If Alpine Linux users are never going to
> > use this functionality and don't care that it's broken, then that's a
> > fine solution.
> >
> > As originally mentioned, musl could change its libiconv to write a BOM,
> > which would make it compatible with other known iconv implementations.
> >
> > There's also the possibility of defining NO_ICONV. That basically means
> > that your system won't support encodings, and then this test shouldn't
> > matter.
> >
> > Finally, you could try applying a patch to the test to make it write the
> > BOM for UTF-16 since your iconv doesn't. I expect that the test will
> > fail again later on once you've done that, though.
> 
> Sorry for being late to the party, but is the crux of the issue this
> piece early in the test?
> 
>     printf "$text" | iconv -f UTF-8 -t UTF-16 >test.utf16.raw &&
>     ...
>     cp test.utf16.raw test.utf16 &&
>     ...
>     git add .gitattributes test.utf16 test.utf16lebom &&
> 
> where we expect "iconv -t UTF-16" means "write UTF16 in whatever
> byteorder of your choice, but do write BOM", and iconv
> implementations we have seen so far are in line with that
> expectation, but the one on Apline writes UTF16 in big endian
> without BOM?

Firstly, the tests expect iconv -t UTF-16 to output a BOM, which it
indeed does not do on Alpine. Secondly, git itself also expects the BOM
to be present when the encoding is set to UTF-16, otherwise it will
complain.

> 
> If that is the case, I think it is our expectation that is at fault
> in this case, as I think the most natural interpretation of "UTF-16"
> without any modifiers (like "BE") ought to be "UTF16 stream
> expressed in any way of writers choice, as long as it is readable by
> standard compliant readers", in other words, "write UTF16 in
> whatever byteorder of your choice, with or without BOM, but if you
> omit BOM, you SHOULD write in big endian".  So
> 
>  - If our later test assumes that test.utf16 is UTF16 with BOM, that
>    already assumes too much;
> 
>  - If our later test assumes that test.utf16 is UTF16 in big endian,
>    that assumes too much, too.
> 
> As suggested earlier in the thread, the easiest workaround would be
> to update the preparation of test.utf16.raw may to force big endian
> with BOM by preprending BE-BOM by hand before "iconv -t UTF-32BE"
> output (I am assuming that UTF-32BE will stay to be "big endian
> without BOM" in the future).  That would make sure that the
> assumption later tests have on test.utf16 is held true.

I tried change the test to manually inject a BOM to the file (and
setting iconv to UTF-16LE / UTF16-BE, which lets the first test go
through, but test 3 then fails, because git itself output the file
without BOM, presumably because it's passed through iconv.

So I'm not sure if it's a matter of just fixing the tests.

