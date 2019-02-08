Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE7671F453
	for <e@80x24.org>; Fri,  8 Feb 2019 06:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfBHGPr (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 01:15:47 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:59690 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfBHGPr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 01:15:47 -0500
X-Greylist: delayed 697 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Feb 2019 01:15:47 EST
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1grzGd-0007mO-00; Fri, 08 Feb 2019 06:04:03 +0000
Date:   Fri, 8 Feb 2019 01:04:03 -0500
From:   Rich Felker <dalias@libc.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kevin Daudt <git@lists.ikke.info>, git@vger.kernel.org,
        larsxschneider@gmail.com
Subject: Re: t0028-working-tree-encoding.sh failing on musl based systems
 (Alpine Linux)
Message-ID: <20190208060403.GA29788@brightrain.aerifal.cx>
References: <20190207215935.GA31515@alpha>
 <20190208001705.GC11927@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208001705.GC11927@genre.crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 12:17:05AM +0000, brian m. carlson wrote:
> [Please skip using Reply-To and instead of Mail-Followup-To so that
> responses also go to the list.]
> 
> On Thu, Feb 07, 2019 at 10:59:35PM +0100, Kevin Daudt wrote:
> > I'm trying to get the git test suite passing on Alpine Linux, which is
> > based on musl libc.
> > 
> > All tests in t0028-working-tree-encoding.sh are currently failing,
> > because musl iconv does not support statefull output of UTF-16/32 (eg,
> > it does not output a BOM), while git is expecting that to be present:
> > 
> > > hint: The file 'test.utf16' is missing a byte order mark (BOM). Please
> > > use UTF-16BE or UTF-16LE (depending on the byte order) as
> > > working-tree-encoding.
> > > fatal: BOM is required in 'test.utf16' if encoded as utf-16
> > 
> > Because adding the file to get fails, all the other tests fail as well
> > as they expect the file to be present in the repository.
> > 
> > Any idea how to get around this?
> 
> I think musl needs to patch their libc. RFC 2781 says that if there's no
> BOM in UTF-16, then "the text SHOULD be interpreted as being
> big-endian."
> 
> Unfortunately for all of us, many Windows-based programs have chosen to
> ignore that advice (technically, it's only a SHOULD) and interpret it as
> little-endian instead. Git can't safely assume anything about the
> endianness of a UTF-16 stream that doesn't contain a BOM. Technically,
> since the RFC doesn't specify a MUST requirement, musl can't, either.
> 
> Even if Git were to produce a BOM to work around this issue, then we'd
> still have the problem that any program using musl will write data in
> UTF-16 without a BOM. Moreover, because musl, in violation of the RFC,
> doesn't read and process BOMs, someone using little-endian UTF-16 (with
> a proper BOM) with musl and Git will have their data corrupted,
> according to my reading of the musl website.

That information is outdated and someone from our side should update
it; since 1.1.19, musl treats "UTF-16" input as ambiguous endianness
determined by BOM, defaulting to big if there's no BOM. However output
is always big endian, such that processes conforming to the Unicode
SHOULD clause will interpret it correctly.

The portable way to get little endian with a BOM is to open a
conversion descriptor for "UTF-16LE" (which should not add any BOM)
and write a BOM manually.

In any case, this test seems mainly relevant to Windows users wanting
to store source files in UTF-16LE with BOM. This doesn't really make
sense to do on a Linux/musl system, so I'm not sure any action is
needed here from either side.

Rich
