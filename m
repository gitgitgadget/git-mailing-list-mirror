Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4CB71F453
	for <e@80x24.org>; Fri,  8 Feb 2019 18:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfBHSrQ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 8 Feb 2019 13:47:16 -0500
Received: from elephants.elehost.com ([216.66.27.132]:62441 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfBHSrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 13:47:16 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x18IlBIm085947
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Feb 2019 13:47:11 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <000f01d4bf9e$a508eab0$ef1ac010$@nexbridge.com> <20190208165052.GC23461@sigill.intra.peff.net> <001101d4bfd6$b9430230$2bc90690$@nexbridge.com> <20190208180321.GB27673@sigill.intra.peff.net>
In-Reply-To: <20190208180321.GB27673@sigill.intra.peff.net>
Subject: RE: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
Date:   Fri, 8 Feb 2019 13:47:04 -0500
Message-ID: <002501d4bfde$b26e6050$174b20f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE5rFddSF2c8coPnbFiKb9P+8bdAwH0igmPAiNgz5YBSIw846bhVcLg
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 8, 2019 13:03, Jeff King wrote:
> To: Randall S. Becker <rsbecker@nexbridge.com>
> Cc: 'Junio C Hamano' <gitster@pobox.com>; git@vger.kernel.org; 'Linux
> Kernel' <linux-kernel@vger.kernel.org>; git-packagers@googlegroups.com
> Subject: Re: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
> 
> On Fri, Feb 08, 2019 at 12:49:59PM -0500, Randall S. Becker wrote:
> 
> > > We did discuss this at the time of the patch, but it seems we
> > > already use /dev/zero in a bunch of places:
> > >
> > >
> > > https://public-inbox.org/git/xmqqbm57rkg5.fsf@gitster-ct.c.googlers.
> > > com/
> > >
> > > Were you just skipping the other tests before?
> >
> > I did not catch the implications of the review at the time - my bad. We
> were not intentionally skipping the tests. It looks like some are automatically
> skipped. t4153 automatically skips (missing TTY), and t5562 fails also but for
> a different reason (hang - we don't have apache2 to serve up http content).
> >
> > Would you object to something like this:
> >
> > if [ ! -e /dev/zero ]; then
> > 	# use shred or some other mechanism (still trying to figure out a
> > solution) else
> > 	# existing dd
> > fi
> 
> That's fine, as long as it's wrapped up in a function in order to keep the tests
> readable.
> 
> Though I suspect we may be able to just find a solution that works
> everywhere, without having two different implementations. If we know we
> need $count bytes for dd, we could probably just generate a file with that
> many NULs in it.

For this, we could use truncate -s count file instead of dd to get a fixed size file of nulls. This would remove the need for /dev/zero in t5318 (the patch below probably will wrap badly in my mailer so I can submit a real patch separately.

@@ -383,7 +383,7 @@ corrupt_graph_and_verify() {
        cp $objdir/info/commit-graph commit-graph-backup &&
        printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
        dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0 &&
-       dd if=/dev/zero of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=$(($orig_size - $zero_pos)) &&
+       truncate -s $orig_size "$objdir/info/commit-graph" &&
        test_must_fail git commit-graph verify 2>test_err &&
        grep -v "^+" test_err >err &&
        test_i18ngrep "$grepstr" err

This passes on my platform.

> Other cases don't seem to actually care that they're getting NULs, and are
> just redirecting stdin from /dev/zero to get an infinite amount of input. They
> could probably use "yes" for that.

What about reading from /dev/null?

Regards,
Randall

