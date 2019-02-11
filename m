Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 546151F453
	for <e@80x24.org>; Mon, 11 Feb 2019 14:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfBKOJl convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 11 Feb 2019 09:09:41 -0500
Received: from elephants.elehost.com ([216.66.27.132]:44418 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfBKOJl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 09:09:41 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1BE9ct2081576
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 11 Feb 2019 09:09:38 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Duy Nguyen'" <pclouds@gmail.com>
Cc:     "'Git Mailing List'" <git@vger.kernel.org>
References: <000801d4c174$05b76860$11263920$@nexbridge.com> <CACsJy8Bn+2zY6y_QqCjbB3qWM-F=3d0H5vgWj4az=md2FZ8RhA@mail.gmail.com>
In-Reply-To: <CACsJy8Bn+2zY6y_QqCjbB3qWM-F=3d0H5vgWj4az=md2FZ8RhA@mail.gmail.com>
Subject: RE: [Breakage] 2.20.0-rc0 t1404: test_i18ngrep reports 1 instead of 0 on NonStop in one case
Date:   Mon, 11 Feb 2019 09:09:32 -0500
Message-ID: <000601d4c213$6c7ee650$457cb2f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQNDD1TD3hXIgmvW3x+/7VSnrDKF3gHnalkaou7ILAA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 11, 2019 4:57, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Feb 11, 2019 at 2:09 AM Randall S. Becker
> <rsbecker@nexbridge.com> wrote:
> >
> > Hi All,
> >
> > I tracked down a breakage in t1404 subtest 52. The line
> >
> > test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q: File exists"
> > err
> 
> The message does not match, does it? Here we grep for "File exists"
> but the message you showed says "File already exists"

So if I understand this correctly, it means that NonStop is reporting a different textual error that other platforms, but is still sane. Would a fix as follows be appropriate?

@@ -614,7 +614,12 @@ test_expect_success 'delete fails cleanly if packed-refs file is locked' '
        test_when_finished "rm -f .git/packed-refs.lock" &&
        test_must_fail git update-ref -d $prefix/foo >out 2>err &&
        git for-each-ref $prefix >actual &&
-       test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q: File exists" err &&
+       # Handle a difference in error reporting text on NonStop
+       if [ `uname` != "NONSTOP_KERNEL" ]; then \
+               test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q: File exists" err ; \
+       else \
+               test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q: File already exists" err ; \
+       fi &&
        test_cmp unchanged actual

I'm not at all confident that the committers will like a hack like this but it does work.

Regards,
Randall

