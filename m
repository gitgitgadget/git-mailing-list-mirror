Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 841F31F453
	for <e@80x24.org>; Mon, 18 Feb 2019 20:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfBRUyl convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 18 Feb 2019 15:54:41 -0500
Received: from elephants.elehost.com ([216.66.27.132]:53527 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfBRUyk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 15:54:40 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1IKsYRN081076
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 18 Feb 2019 15:54:35 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Max Kirillov'" <max@max630.net>,
        "=?UTF-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>,
        <git@vger.kernel.org>
Cc:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <20190215130213.GK1622@szeder.dev> <20190218205028.32486-1-max@max630.net>
In-Reply-To: <20190218205028.32486-1-max@max630.net>
Subject: RE: [PATCH] t5562: chunked sleep to avoid lost SIGCHILD
Date:   Mon, 18 Feb 2019 15:54:27 -0500
Message-ID: <005101d4c7cc$26a3c5b0$73eb5110$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHW7yigT9jr+f4N2aodUqJvfezIPaXhuRXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 18, 2019 15:50, Max Kirillov wrote:
> To: SZEDER Gábor <szeder.dev@gmail.com>; git@vger.kernel.org
> Cc: Max Kirillov <max@max630.net>; Johannes Schindelin
> <Johannes.Schindelin@gmx.de>; Randall S. Becker
> <rsbecker@nexbridge.com>; 'Junio C Hamano' <gitster@pobox.com>
> Subject: [PATCH] t5562: chunked sleep to avoid lost SIGCHILD
> 
> If was found during stress-test run that a test may hang by 60 seconds.
> It supposedly happens because SIGCHILD was received before sleep has
> started.
> 
> Fix by looping by smaller chunks, checking $exited after each of them.
> Then lost SIGCHILD would not cause longer delay than 1 second.
> 
> Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
> Submitting as proper patch. Note: I believe it does not relate to other issues
> discussed in this thread.
>  t/t5562/invoke-with-content-length.pl | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t5562/invoke-with-content-length.pl b/t/t5562/invoke-with-
> content-length.pl
> index 0943474af2..257e280e3b 100644
> --- a/t/t5562/invoke-with-content-length.pl
> +++ b/t/t5562/invoke-with-content-length.pl
> @@ -29,7 +29,12 @@
>  }
>  print $out $body_data or die "Cannot write data: $!";
> 
> -sleep 60; # is interrupted by SIGCHLD
> +my $counter = 0;
> +while (not $exited and $counter < 60) {
> +        sleep 1;
> +        $counter = $counter + 1;
> +}
> +
>  if (!$exited) {
>          close($out);
>          die "Command did not exit after reading whole body";

I tried this fix and it made no difference to the hang on NonStop. I do not think this fixes the root cause as sleep was never an issue and SIGCHLD was not missed in any test I conducted. Maybe on another platform it is required.

