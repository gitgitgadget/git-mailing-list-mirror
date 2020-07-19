Return-Path: <SRS0=m+L4=A6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D9AC433E0
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 17:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB39F207EA
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 17:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgGSRX2 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 19 Jul 2020 13:23:28 -0400
Received: from elephants.elehost.com ([216.66.27.132]:33449 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSRX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jul 2020 13:23:27 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 06JHNNHD091504
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 19 Jul 2020 13:23:24 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'Martin_=C3=85gren'?=" <martin.agren@gmail.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Denton Liu'" <liu.denton@gmail.com>, <git@vger.kernel.org>
References: <00d001d65c80$3519c960$9f4d5c20$@nexbridge.com> <20200718094840.31269-1-martin.agren@gmail.com> <011401d65def$54ae8a20$fe0b9e60$@nexbridge.com>
In-Reply-To: <011401d65def$54ae8a20$fe0b9e60$@nexbridge.com>
Subject: RE: [PATCH] t3200: don't grep for `strerror()` string
Date:   Sun, 19 Jul 2020 13:23:13 -0400
Message-ID: <011501d65df1$4b8d47e0$e2a7d7a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKxrwJhbsUyly04+CdORB3ARF6ligFrNkMrAdqS5JqnPlXicA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 19, 2020 1:09 PM, I wrote:
> On July 18, 2020 5:49 AM, Martin Ågren Wrote:
> > In 6b7093064a ("t3200: test for specific errors", 2020-06-15), we
> > learned to grep stderr to ensure that the failing `git branch`
> > invocations fail for the right reason. In two of these tests, we grep
> > for "File exists", expecting the string to show up there since
> > config.c calls `error_errno()`, which ends up including `strerror(errno)` in
> the error message.
> >
> > But as we saw in 4605a73073 ("t1091: don't grep for `strerror()`
> > string", 2020-03-08), there exists at least one implementation where
> > `strerror()` yields a slightly different string than the one we're
> > grepping for. In particular, these tests fail on the NonStop platform.
> >
> > Similar to 4605a73073, grep for the beginning of the string instead to
> > avoid relying on `strerror()` behavior.
> >
> > Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
> > Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> > ---
> >  Hi Randall,
> >
> >  Does this fix the test for you?
> >
> >  Martin
> >
> >  t/t3200-branch.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh index
> > b6aa04bbec..4c0734157b 100755
> > --- a/t/t3200-branch.sh
> > +++ b/t/t3200-branch.sh
> > @@ -870,7 +870,7 @@ test_expect_success '--set-upstream-to fails on
> > locked config' '
> >  	>.git/config.lock &&
> >  	git branch locked &&
> >  	test_must_fail git branch --set-upstream-to locked 2>err &&
> > -	test_i18ngrep "could not lock config file .git/config: File exists" err
> > +	test_i18ngrep "could not lock config file .git/config" err
> >  '
> >
> >  test_expect_success 'use --set-upstream-to modify HEAD' '
> > @@ -901,7 +901,7 @@ test_expect_success '--unset-upstream should fail
> > if config is locked' '
> >  	git branch --set-upstream-to locked &&
> >  	>.git/config.lock &&
> >  	test_must_fail git branch --unset-upstream 2>err &&
> > -	test_i18ngrep "could not lock config file .git/config: File exists" err
> > +	test_i18ngrep "could not lock config file .git/config" err
> >  '
> >
> >  test_expect_success 'test --unset-upstream on HEAD' '
> 
> It should work, yes. You could go as far as the ':' if you were worried about
> the path of the .git/config file.

Yup, our Jenkins pipeline picked it up before I had a chance to the run the test myself. Passes. (We're up to t3311 on the current HEAD on master).

Thanks,
Randall

