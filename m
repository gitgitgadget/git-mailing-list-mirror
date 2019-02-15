Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23D791F453
	for <e@80x24.org>; Fri, 15 Feb 2019 20:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbfBOUhb (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 15:37:31 -0500
Received: from p3plsmtpa12-05.prod.phx3.secureserver.net ([68.178.252.234]:42383
        "EHLO p3plsmtpa12-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727198AbfBOUhb (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 Feb 2019 15:37:31 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id ukEggAsEDnlazukEjge1Ip; Fri, 15 Feb 2019 13:37:30 -0700
Date:   Fri, 15 Feb 2019 22:37:26 +0200
From:   Max Kirillov <max@max630.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        'Max Kirillov' <max@max630.net>
Subject: Re: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results)
Message-ID: <20190215203726.GG3064@jessie.local>
References: <001501d4c476$a94651d0$fbd2f570$@nexbridge.com>
 <nycvar.QRO.7.76.6.1902142234070.45@tvgsbejvaqbjf.bet>
 <20190215130213.GK1622@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190215130213.GK1622@szeder.dev>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfCoWlyAYaNCwyW9i3DUSVR30MDkv/l+rNwP8NRkB0MSGVOlJxX8sA+q83wSg2uAVCju2+TTFywKekQmLcuDoqGOPirdttVOgbbq5QMHt0rFOEjHCflXJ
 624SUAofaxvNGeKnB38YZU9aQuZ6LhvKCqF7ZCLWHmLGEnuDSridVtyKOdXTTkdFfFn1sa0vP38vThhecjqahO3s1VeNrvgG0kl/gdKVPNHuyYmkMnBRFFZu
 NpRoqGBwx0BawdOOpv9+0drWCMK+tHW5WAX+r08rQVeI8OCXNunkFLNbAFy7D7qhlp+rzP05hfgMZ3tReRxmF18KkPRNXrCIxoxr3UrO5Is=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 15, 2019 at 02:02:13PM +0100, SZEDER Gábor wrote:
> I haven't yet seen that hang in the wild and couldn't reproduce it on
> purpose, but there is definitely something fishy with t5562 even on
> Linux and even without that perl generate_zero_bytes helper.
> 
> It won't show most of the processes run in the tests, because they are
> just too fast and short-lived.  However, occasionally it does show a
> stuck git process, which is shown as <defunct> in regular 'ps aux'
> output:
> 
>   szeder   5722  0.0  0.0      0     0 pts/16   Z+   13:36   0:00 [git] <defunct>
> 
> Note that this is not a "proper" hang, in the sense that this process
> is not stuck forever, but only for about 1 minute

This is probably because of SIGCHILD comes before "sleep". I believe this is
unrelated to the hang issue. The hang issue looks like something is wrong with
cleanu_children(), or maybe in the child which it tries to kill and wait, not in
tests.

As for this zombie issue, could be fixed with, for example, more busy wait like
the following. It may with some bigger probability miss SIGCHILD to the first
sleep because there is a bit more to do before it. But the penalty is only 1
second now, and as it still happens rarely there seems to be no visible
degradation.

--- 8< -----------
diff --git a/t/t5562/invoke-with-content-length.pl b/t/t5562/invoke-with-content-length.pl
index 0943474af2..257e280e3b 100644
--- a/t/t5562/invoke-with-content-length.pl
+++ b/t/t5562/invoke-with-content-length.pl
@@ -29,7 +29,12 @@
 }
 print $out $body_data or die "Cannot write data: $!";
 
-sleep 60; # is interrupted by SIGCHLD
+my $counter = 0;
+while (not $exited and $counter < 60) {
+        sleep 1;
+        $counter = $counter + 1;
+}
+
 if (!$exited) {
         close($out);
         die "Command did not exit after reading whole body";
