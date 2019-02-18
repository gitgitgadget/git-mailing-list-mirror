Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 403B21F453
	for <e@80x24.org>; Mon, 18 Feb 2019 20:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbfBRU7F (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 15:59:05 -0500
Received: from p3plsmtpa08-04.prod.phx3.secureserver.net ([173.201.193.105]:53556
        "EHLO p3plsmtpa08-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729486AbfBRU7F (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 15:59:05 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id vq0CggvElBUaqvq0EggJyM; Mon, 18 Feb 2019 13:59:04 -0700
Date:   Mon, 18 Feb 2019 22:59:00 +0200
From:   Max Kirillov <max@max630.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Max Kirillov' <max@max630.net>,
        'SZEDER =?utf-8?Q?G=C3=A1bor'?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
        'Junio C Hamano' <gitster@pobox.com>
Subject: Re: [PATCH] t5562: chunked sleep to avoid lost SIGCHILD
Message-ID: <20190218205900.GC3373@jessie.local>
References: <20190215130213.GK1622@szeder.dev>
 <20190218205028.32486-1-max@max630.net>
 <005101d4c7cc$26a3c5b0$73eb5110$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <005101d4c7cc$26a3c5b0$73eb5110$@nexbridge.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfIdi6EnSNaPZwRfiUIKtkPnaaevzfPxx73olKwd0DJdT/YedES/pgjT7GhON2E0mHnke3/6fKmkfr360mNq5vq7uUZ7zNerPDniQlxBotMb+mqAHKjVA
 xLt5dwvG173tvzAGgoSSnIPR5eu1TIT3w5vyjqy1DbKojTCbxy4nWjgcbtFylVw8FRwPo0YrYgLdkIYkhZAZagvwiMifFZevBe4TK8aCQUgp3B/qBXetGq7w
 hcLqBMQN2e+/OAfw395MC2I0b2/PQ1PrkIVa2zPKjA5+38dH8Bn9vNj0ThUkV6TYH0DbV1izfyCHSFc1DYNJZdUqfVfo3nZgY3oRDKjbht8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 18, 2019 at 03:54:27PM -0500, Randall S. Becker wrote:
> On February 18, 2019 15:50, Max Kirillov wrote:
> > To: SZEDER Gábor <szeder.dev@gmail.com>; git@vger.kernel.org
> > Cc: Max Kirillov <max@max630.net>; Johannes Schindelin
> > <Johannes.Schindelin@gmx.de>; Randall S. Becker
> > <rsbecker@nexbridge.com>; 'Junio C Hamano' <gitster@pobox.com>
> > Subject: [PATCH] t5562: chunked sleep to avoid lost SIGCHILD
> > 
> > If was found during stress-test run that a test may hang by 60 seconds.
> > It supposedly happens because SIGCHILD was received before sleep has
> > started.
> > 
> > Fix by looping by smaller chunks, checking $exited after each of them.
> > Then lost SIGCHILD would not cause longer delay than 1 second.
> > 
> > Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
> > Signed-off-by: Max Kirillov <max@max630.net>
> > ---
> > Submitting as proper patch. Note: I believe it does not relate to other issues
> > discussed in this thread.
> >  t/t5562/invoke-with-content-length.pl | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/t/t5562/invoke-with-content-length.pl b/t/t5562/invoke-with-
> > content-length.pl
> > index 0943474af2..257e280e3b 100644
> > --- a/t/t5562/invoke-with-content-length.pl
> > +++ b/t/t5562/invoke-with-content-length.pl
> > @@ -29,7 +29,12 @@
> >  }
> >  print $out $body_data or die "Cannot write data: $!";
> > 
> > -sleep 60; # is interrupted by SIGCHLD
> > +my $counter = 0;
> > +while (not $exited and $counter < 60) {
> > +        sleep 1;
> > +        $counter = $counter + 1;
> > +}
> > +
> >  if (!$exited) {
> >          close($out);
> >          die "Command did not exit after reading whole body";
> 
> I tried this fix and it made no difference to the hang on
> NonStop. I do not think this fixes the root cause as sleep
> was never an issue and SIGCHLD was not missed in any test
> I conducted. Maybe on another platform it is required.

Correct, as I said it should not be related.
