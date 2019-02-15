Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B60681F453
	for <e@80x24.org>; Fri, 15 Feb 2019 21:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391837AbfBOVNb convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 15 Feb 2019 16:13:31 -0500
Received: from elephants.elehost.com ([216.66.27.132]:19218 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387600AbfBOVNa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 16:13:30 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1FLDKc3053399
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 16:13:21 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Max Kirillov'" <max@max630.net>,
        "=?UTF-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>
Cc:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <001501d4c476$a94651d0$fbd2f570$@nexbridge.com> <nycvar.QRO.7.76.6.1902142234070.45@tvgsbejvaqbjf.bet> <20190215130213.GK1622@szeder.dev> <20190215203726.GG3064@jessie.local>
In-Reply-To: <20190215203726.GG3064@jessie.local>
Subject: RE: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results)
Date:   Fri, 15 Feb 2019 16:13:15 -0500
Message-ID: <002a01d4c573$4784e670$d68eb350$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQLvzwUmvPaRP6545mvVYB21mmRPlwI+2omYAcZBZ6kBiY0Z/aN+0ABQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 15, 2019 15:37, Max Kirillov wrote:
> On Fri, Feb 15, 2019 at 02:02:13PM +0100, SZEDER Gábor wrote:
> > I haven't yet seen that hang in the wild and couldn't reproduce it on
> > purpose, but there is definitely something fishy with t5562 even on
> > Linux and even without that perl generate_zero_bytes helper.
> >
> > It won't show most of the processes run in the tests, because they are
> > just too fast and short-lived.  However, occasionally it does show a
> > stuck git process, which is shown as <defunct> in regular 'ps aux'
> > output:
> >
> >   szeder   5722  0.0  0.0      0     0 pts/16   Z+   13:36   0:00 [git] <defunct>
> >
> > Note that this is not a "proper" hang, in the sense that this process
> > is not stuck forever, but only for about 1 minute
> 
> This is probably because of SIGCHILD comes before "sleep". I believe this is
> unrelated to the hang issue. The hang issue looks like something is wrong
> with cleanu_children(), or maybe in the child which it tries to kill and wait,
> not in tests.
> 
> As for this zombie issue, could be fixed with, for example, more busy wait
> like the following. It may with some bigger probability miss SIGCHILD to the
> first sleep because there is a bit more to do before it. But the penalty is only
> 1 second now, and as it still happens rarely there seems to be no visible
> degradation.
> 
> --- 8< -----------
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

From the trace I found in perl, we have gone past sleep and are hung at 
          close($out);

Commenting out the close() does nothing because perl still hangs on an implied close resulting from the exception thrown by die(). See my other post on adding GIT_TRACE and the changes resulting from that.

Sadly, the fix does not change the results. In fact, it makes the hang far more likely. Subtest 6,7,8 fails here, at close()
  waitpid + 0x130 (SLr)
  $n_EnterPriv + 0x280 (Milli)
  Perl_wait4pid + 0x130 (UCr)
  Perl_my_pclose + 0x4C0 (UCr)
  Perl_io_close + 0x180 (UCr)
  Perl_do_close + 0x620 (UCr)
  Perl_pp_close + 0xA70 (UCr)
  Perl_runops_standard + 0xF0 (UCr)
  S_run_body + 0x870 (UCr)
  perl_run + 0x2D0 (UCr)
  main + 0x3D0 (UCr)



