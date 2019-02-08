Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ACFC1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 22:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfBHWyP convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 8 Feb 2019 17:54:15 -0500
Received: from elephants.elehost.com ([216.66.27.132]:36259 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfBHWyP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 17:54:15 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x18Ms0hu098317
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Feb 2019 17:54:01 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <000f01d4bf9e$a508eab0$ef1ac010$@nexbridge.com> <20190208165052.GC23461@sigill.intra.peff.net> <001101d4bfd6$b9430230$2bc90690$@nexbridge.com> <20190208180321.GB27673@sigill.intra.peff.net> <002501d4bfde$b26e6050$174b20f0$@nexbridge.com> <20190208191519.GF27673@sigill.intra.peff.net> <002b01d4bfe4$2d617f40$88247dc0$@nexbridge.com> <20190208193157.GA30952@sigill.intra.peff.net> <20190208220714.GG11927@genre.crustytoothpaste.net> <005901d4bffb$6d0c34c0$47249e40$@nexbridge.com> <20190208223512.GA2135@sigill.intra.peff.net>
In-Reply-To: <20190208223512.GA2135@sigill.intra.peff.net>
Subject: RE: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
Date:   Fri, 8 Feb 2019 17:53:53 -0500
Message-ID: <006601d4c001$2de3a160$89aae420$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE5rFddSF2c8coPnbFiKb9P+8bdAwH0igmPAiNgz5YBSIw84wKJiaU9Aj0+V9MB8y1xFgJaeDVqApzvLgABsopuUQKjTm1tpmFndgA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 8, 2019 17:35, Jeff King wrote:
> On Fri, Feb 08, 2019 at 05:12:43PM -0500, Randall S. Becker wrote:
> > On February 8, 2019 17:07, brian m. carlson wrote:
> > > On Fri, Feb 08, 2019 at 02:31:57PM -0500, Jeff King wrote:
> > > > > It is available AFAIK on Linux, POSIX, and Windows under Cygwin.
> > > > > That's more than /dev/zero has anyway. I have the patch ready if
> > > > > you want it.
> > > >
> > > > Is it POSIX? Certainly truncate() is, but I didn't think the
> > > > command-line tool was. If it really is available everywhere, then
> > > > yeah, I'd be fine with it.
> > >
> > > It's not. POSIX doesn't specify the command, and macOS lacks it, I
> believe.
> >
> > I'm happy to modify the test (it is in one spot), to make a decision based
> on:
> > a) whether /dev/zero exists
> > b) whether the system is a NonStop
> > c) something else
> >
> > What would you all prefer? It doesn't matter to me one way or another,
> > as long as I can get the dependency to /dev/zero removed so tests will
> > run here.
> 
> For the case in t5318, I think we can just put the NULs in a file. Does this
> work on your platform?

Yes, should work just fine.

> 
> ---
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh index
> 16d10ebce8..6d0ccc7eba 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -383,7 +383,8 @@ corrupt_graph_and_verify() {
>  	cp $objdir/info/commit-graph commit-graph-backup &&
>  	printf "$data" | dd of="$objdir/info/commit-graph" bs=1
> seek="$pos" conv=notrunc &&
>  	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0
> &&
> -	dd if=/dev/zero of="$objdir/info/commit-graph" bs=1
> seek="$zero_pos" count=$(($orig_size - $zero_pos)) &&
> +	gen_zero_bytes $(($orig_size - $zero_pos)) >zeroes &&
> +	dd if=zeroes of="$objdir/info/commit-graph" bs=1 seek="$zero_pos"
> &&
>  	test_must_fail git commit-graph verify 2>test_err &&
>  	grep -v "^+" test_err >err &&
>  	test_i18ngrep "$grepstr" err
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh index
> 92cf8f812c..4afab14431 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1302,3 +1302,8 @@ test_set_port () {
>  	port=$(($port + ${GIT_TEST_STRESS_JOB_NR:-0}))
>  	eval $var=$port
>  }
> +
> +# Generate an output of $1 bytes of all zeroes (NULs, not ASCII zeroes).
> +gen_zero_bytes () {
> +	perl -e 'print "\0" x $ARGV[0]' "$@"
> +}

This function does work on platform, so it's good.

> For the others that need infinite zeroes, I think using "yes" makes more
> sense, though we could also teach this function to accept an "infinity"
> parameter.

You could be sneaky about it, I suppose
+# Generate an output of $1 bytes of all zeroes (NULs, not ASCII zeroes).
+ gen_zero_bytes () {
+ 	if [ $1 -eq -1 ]; then
+ 	        yes | tr 'y' '\0'
+ 	else
+ 	        perl -e 'print "\0" x $ARGV[0]' "$@"
+ }
Or something alone those lines. It's not even slightly elegant, though. It would be better inside perl, so just

+# Generate an output of $1 bytes of all zeroes (NULs, not ASCII zeroes). If $1 is < 0, output forever.
+ gen_zero_bytes () {
+ 	perl -e ' if ($ARGV[0] < 0) { while (-1) { print "\0" } } else { print "\0" x $ARGV[0] }' "$@"
+ }

Cheers,
Randall

