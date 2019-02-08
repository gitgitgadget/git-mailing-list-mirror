Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EBC11F453
	for <e@80x24.org>; Fri,  8 Feb 2019 20:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfBHUiS convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 8 Feb 2019 15:38:18 -0500
Received: from elephants.elehost.com ([216.66.27.132]:49204 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfBHUiS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 15:38:18 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x18KcB00091756
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Feb 2019 15:38:12 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <000f01d4bf9e$a508eab0$ef1ac010$@nexbridge.com> <20190208165052.GC23461@sigill.intra.peff.net> <001101d4bfd6$b9430230$2bc90690$@nexbridge.com> <20190208180321.GB27673@sigill.intra.peff.net> <002501d4bfde$b26e6050$174b20f0$@nexbridge.com> <20190208191519.GF27673@sigill.intra.peff.net> <002b01d4bfe4$2d617f40$88247dc0$@nexbridge.com> <20190208193157.GA30952@sigill.intra.peff.net>
In-Reply-To: <20190208193157.GA30952@sigill.intra.peff.net>
Subject: RE: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
Date:   Fri, 8 Feb 2019 15:38:05 -0500
Message-ID: <003a01d4bfee$349245b0$9db6d110$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE5rFddSF2c8coPnbFiKb9P+8bdAwH0igmPAiNgz5YBSIw84wKJiaU9Aj0+V9MB8y1xFgJaeDVqppjcFxA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: Jeff King <peff@peff.net>
> Sent: February 8, 2019 14:32
> To: Randall S. Becker <rsbecker@nexbridge.com>
> Cc: 'Junio C Hamano' <gitster@pobox.com>; git@vger.kernel.org; 'Linux
> Kernel' <linux-kernel@vger.kernel.org>; git-packagers@googlegroups.com
> Subject: Re: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
> 
> On Fri, Feb 08, 2019 at 02:26:17PM -0500, Randall S. Becker wrote:
> 
> > > > For this, we could use truncate -s count file instead of dd to get
> > > > a fixed size file of nulls. This would remove the need for
> > > > /dev/zero in
> > > > t5318 (the patch below probably will wrap badly in my mailer so I
> > > > can submit a real patch separately.
> > >
> > > I don't think "truncate" is portable, though.
> >
> > It is available AFAIK on Linux, POSIX, and Windows under Cygwin.
> > That's more than /dev/zero has anyway. I have the patch ready if you
> > want it.
> 
> Is it POSIX? Certainly truncate() is, but I didn't think the command-line tool
> was. If it really is available everywhere, then yeah, I'd be fine with it.
> 
> > > > > Other cases don't seem to actually care that they're getting
> > > > > NULs, and are just redirecting stdin from /dev/zero to get an
> > > > > infinite amount of input. They could probably use "yes" for that.
> > > >
> > > > What about reading from /dev/null?
> > >
> > > That would yield zero bytes, not an infinite number of them.
> >
> > So something like: yes | tr 'y' '\0' | stuff?
> 
> Exactly (if we even care about them being NULs; otherwise, we can omit the
> "tr" invocation).

I'm a bit perplexed about this... Obviously added some debugging info, but why we're getting No REQUEST_METHOD is perplexing. Is this a lack of an apache2 instance?

expecting success:
        NOT_FIT_IN_SSIZE=$(ssize_b100dots) &&
        env \
                CONTENT_TYPE=application/x-git-upload-pack-request \
                QUERY_STRING=/repo.git/git-upload-pack \
                PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
                GIT_HTTP_EXPORT_ALL=TRUE \
                REQUEST_METHOD=POST \
                CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
                yes | tr "y" "\\0" | git http-backend 2>err &&
        echo "Err is" &&
        cat err &&
        grep "fatal:.*CONTENT_LENGTH" err

Status: 500 Internal Server Error
Expires: Fri, 01 Jan 1980 00:00:00 GMT
Pragma: no-cache
Cache-Control: no-cache, max-age=0, must-revalidate

Err is
fatal: No REQUEST_METHOD from server
not ok 15 - CONTENT_LENGTH overflow ssite_t

Cheers,
Randall

