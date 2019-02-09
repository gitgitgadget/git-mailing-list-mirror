Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF9AA1F453
	for <e@80x24.org>; Sat,  9 Feb 2019 14:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfBIO5e (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 09:57:34 -0500
Received: from ikke.info ([178.21.113.177]:52106 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbfBIO5d (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 09:57:33 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 360C14400DA; Sat,  9 Feb 2019 15:57:32 +0100 (CET)
Date:   Sat, 9 Feb 2019 15:57:32 +0100
From:   Kevin Daudt <me@ikke.info>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Rich Felker <dalias@libc.org>, git@vger.kernel.org,
        larsxschneider@gmail.com
Subject: Re: t0028-working-tree-encoding.sh failing on musl based systems
 (Alpine Linux)
Message-ID: <20190209145732.GA14229@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Rich Felker <dalias@libc.org>,
        git@vger.kernel.org, larsxschneider@gmail.com
References: <20190207215935.GA31515@alpha>
 <20190208001705.GC11927@genre.crustytoothpaste.net>
 <20190208060403.GA29788@brightrain.aerifal.cx>
 <20190208114502.GD11927@genre.crustytoothpaste.net>
 <20190208115511.GA30779@alpha>
 <20190208135137.GE11927@genre.crustytoothpaste.net>
 <xmqqr2cikw4w.fsf@gitster-ct.c.googlers.com>
 <20190208202336.GA5284@alpha>
 <20190208204219.GF11927@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208204219.GF11927@genre.crustytoothpaste.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 08:42:19PM +0000, brian m. carlson wrote:
> On Fri, Feb 08, 2019 at 09:23:36PM +0100, Kevin Daudt wrote:
> > Firstly, the tests expect iconv -t UTF-16 to output a BOM, which it
> > indeed does not do on Alpine. Secondly, git itself also expects the BOM
> > to be present when the encoding is set to UTF-16, otherwise it will
> > complain.
> 
> Yeah, we definitely want to require a BOM for UTF-16. As previously
> mentioned, it isn't safe for us to assume big-endian when it's missing.
> 
> > I tried change the test to manually inject a BOM to the file (and
> > setting iconv to UTF-16LE / UTF16-BE, which lets the first test go
> > through, but test 3 then fails, because git itself output the file
> > without BOM, presumably because it's passed through iconv.
> > 
> > So I'm not sure if it's a matter of just fixing the tests.
> 
> I think something like the following will likely work in this scenario:
> 
> [..]
> 
> This passes for me on glibc, but only on a little-endian system. If this
> works for musl folks, then I'll add a config option for those people who
> have UTF-16 without BOM.
> -- 
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204

I tried your patch. The pre-requisite is broken in it's current form,
this would fix the prerequisite:

    diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
    index ff02d03bad..734c5a7dbb 100755
    --- a/t/t0028-working-tree-encoding.sh
    +++ b/t/t0028-working-tree-encoding.sh
    @@ -7,8 +7,7 @@ test_description='working-tree-encoding conversion via gitattributes'
     GIT_TRACE_WORKING_TREE_ENCODING=1 && export GIT_TRACE_WORKING_TREE_ENCODING

     test_lazy_prereq NO_BOM '
    -       printf abc | iconv -f UTF-8 -t UTF-16 &&
    -       test $(wc -c) = 6
    +       test $(printf abc | iconv -f UTF-8 -t UTF-16 | wc -c) = 6
     '

     write_utf16 () {

But test 3 still fails, because now the output from git is converted to
UTF16-LE, which is different from the input, which is UTF16-BE.
