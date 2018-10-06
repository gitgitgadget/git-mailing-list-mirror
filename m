Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CDA51F97E
	for <e@80x24.org>; Sat,  6 Oct 2018 22:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbeJGFg1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 01:36:27 -0400
Received: from ikke.info ([178.21.113.177]:46156 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbeJGFg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 01:36:27 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id A185D4400AC; Sun,  7 Oct 2018 00:31:26 +0200 (CEST)
Date:   Sun, 7 Oct 2018 00:31:26 +0200
From:   Kevin Daudt <me@ikke.info>
To:     git <git@vger.kernel.org>
Subject: Re: Understanding Index Header
Message-ID: <20181006223126.GA3627@alpha>
References: <CAFd4kYC5psSkXxrHVU11b5bufFFVr-qP=S_Fn9AegCyADLw+HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd4kYC5psSkXxrHVU11b5bufFFVr-qP=S_Fn9AegCyADLw+HA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 06, 2018 at 05:13:45PM -0400, Farhan Khan wrote:
> Hi all,
> 
> I am writing a program that parses out the .git/index file. I am
> reading the git index header documentation, but I seem to be getting
> jibberish data.
> https://github.com/git/git/blob/master/Documentation/technical/index-format.txt
> 
> The first 12 bytes are the signature, version and entries. Great so far.
> 
> Afterwards, I try to read the extension signature, which the
> documentation says: "4-byte extension signature. If the first byte is
> 'A'..'Z' the
> extension is optional and can be ignored.". I am getting jibberish. Is
> this expected?
> 
> Then, the extension size comes back as 35560000 (after ntohl()). That
> seems extremely high. My structure is as follows:
> 
> struct _indexfile_hdr {
>         unsigned char   sig[4];         /* Always "DIRC" */
>         uint32_t        version;        /* Version Number */
>         uint32_t        entries;        /* Number of extensions */
>         unsigned char   extsig[4];      /* Extension signature */
>         uint32_t        extsize;        /* Size of the extension */
>         uint8_t         sha[8];         /* SHA1 of index before checksum */
> } __packed;
> 
> Am I doing something wrong? Is there some offset or padding that I missed?
> 
> Thanks,
> --
> Farhan Khan

Hello Farhan

Between the index header and the extensions there are index entries. So
you have 4 sections:

1. Header (fixed size)
2. Index entries (dynamic size, amount stored in the index)
3. Extensions (dynamic size)
4. hash

So you cannot capture the index with just a single struct. Also what you
call the 'entries' field is not the number of extensions, but the number
of index entries.

I'm not sure why you are seeing so many index entries. I've just tested
it myself on the git repository and I got 3419 entries when reading in
network (big-endian) order.

Hope this helps a bit.

Kevin

