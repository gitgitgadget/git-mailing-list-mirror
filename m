Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A1FC432BE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 14:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CF260F39
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 14:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238003AbhHQObS convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 17 Aug 2021 10:31:18 -0400
Received: from elephants.elehost.com ([216.66.27.132]:22834 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhHQObR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 10:31:17 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 17HEUecG051865
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Aug 2021 10:30:40 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <009101d7904e$a3703e50$ea50baf0$@nexbridge.com> <YRaYnDR6RlgJRr/P@coredump.intra.peff.net> <01b501d792cc$f4071ed0$dc155c70$@nexbridge.com> <YRqwIAL/JgJp+RyI@coredump.intra.peff.net> <01c501d792df$5fcb24b0$1f616e10$@nexbridge.com> <YRrSXhbaZMLMq+1/@coredump.intra.peff.net> <01d001d792e9$55f45470$01dcfd50$@nexbridge.com> <YRrlQwLENaWs8zWm@coredump.intra.peff.net> <YRrm5odz3WhcUQS9@coredump.intra.peff.net>
In-Reply-To: <YRrm5odz3WhcUQS9@coredump.intra.peff.net>
Subject: RE: [ANNOUNCE] Git v2.33.0-rc2 (Build/Test Report)
Date:   Tue, 17 Aug 2021 10:30:34 -0400
Message-ID: <01f901d79374$73e759b0$5bb60d10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQMBTs001OO8pWyP/FbVHKiIK4dspwGtgrwqAxbvBFwBEWuByQH2kUqUAce4wogCG03ybQI0aYL9Alz/b3CookQe8A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 16, 2021 6:30 PM, Jeff King wrote:
>To: Randall S. Becker <rsbecker@nexbridge.com>
>Cc: 'Junio C Hamano' <gitster@pobox.com>; git@vger.kernel.org
>Subject: Re: [ANNOUNCE] Git v2.33.0-rc2 (Build/Test Report)
>
>On Mon, Aug 16, 2021 at 06:22:59PM -0400, Jeff King wrote:
>
>> Yeah, I think we are better to get a consistent exit code from perl.
>> There are a few options here:
>
>So concretely, the patch below works for me (my tests are not failing, but with some instrumenting, I see that the case in question is
>exiting with code 25 before this patch, and 255 after. So it really is just that my errno values are lower than yours).
>
>It's ugly, and I kind of wonder if we'd want to do it for every script to get consistent exit codes. But it does work.
>
>diff --git a/git-send-email.perl b/git-send-email.perl index e65d969d0b..c82336c2e8 100755
>--- a/git-send-email.perl
>+++ b/git-send-email.perl
>@@ -35,8 +35,15 @@ sub readline {
> 	my $self = shift;
> 	die "Cannot use readline on FakeTerm: $$self";  }
>+
> package main;
>
>+$SIG{__DIE__} = sub {
>+	CORE::die @_ if $^S; # in an eval; use regular die
>+	CORE::die @_ if !defined $^S; # in perl's parser
>+	print STDERR "fatal: @_\n";
>+	exit 255;
>+};
>
> sub usage {
> 	print <<EOT;

Not as ugly as my suggestion (previous email).
-Randall

