Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F019C10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 14:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008D220848
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 14:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgCJOko (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:40:44 -0400
Received: from elephants.elehost.com ([216.66.27.132]:12901 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgCJOko (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 10:40:44 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 02AEefVf063495
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 10:40:42 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Git'" <git@vger.kernel.org>
References: 
In-Reply-To: 
Subject: RE: [Test] t1901 - sparse checkout file when lock is taken fails (subtest 19)
Date:   Tue, 10 Mar 2020 10:40:34 -0400
Message-ID: <011401d5f6e9$de7eea50$9b7cbef0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdXzA4JCphsLzbqhTjSWmFiauycMuQD5GXxg
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Randall S. Becker <rsbecker@nexbridge.com>
On March 5, 2020 10:45 AM, I wrote:
> This one has me confused. It fails 100% of the time on NonStop. The test
> looks reasonable, as do the messages. I am not certain that test_i18ngrep
> works properly - it falls down to the return 1 statement which causes the
test
> to fail. The error message generated is "File already exists" not "File
exists"
> as is required in the test. We should not be testing for specific text
content
> originating from strerror - I thought we had this decision in a different
> thread. https://public-inbox.org/git/xmqq36intlpj.fsf@gitster-
> ct.c.googlers.com/
> 
> Thoughts?
> 
> expecting success of 1091.19 'fail when lock is taken':
>         test_when_finished rm -rf repo/.git/info/sparse-checkout.lock &&
>         touch repo/.git/info/sparse-checkout.lock &&
>         test_must_fail git -C repo sparse-checkout set deep 2>err &&
>         test_i18ngrep "File exists" err
> 
> error: 'grep File exists err' didn't find a match in:
> fatal: Unable to create '/home/ituglib/randall/git/t/trash
directory.t1091-
> sparse-checkout-builtin/repo/.git/info/sparse-checkout.lock': File already
> exists.   <----- this is the test issue
> 
> Another git process seems to be running in this repository, e.g.
> an editor opened by 'git commit'. Please make sure all processes are
> terminated then try again. If it still fails, a git process may have
crashed in
> this repository earlier:
> remove the file manually to continue.
> not ok 19 - fail when lock is taken
> #
> #               test_when_finished rm -rf
repo/.git/info/sparse-checkout.lock &&
> #               touch repo/.git/info/sparse-checkout.lock &&
> #               test_must_fail git -C repo sparse-checkout set deep 2>err
&&
> #               test_i18ngrep "File exists" err
> #

This situation still occurs at 2.26.0-rc0. As above, this results from a
text compare to a platform-specific message that should not be used. To hack
around it, a possible fix (which I don't like) could be as follows:

index b4c9c32a03..d1fd225dad 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -305,7 +305,7 @@ test_expect_success 'fail when lock is taken' '
        test_when_finished rm -rf repo/.git/info/sparse-checkout.lock &&
        touch repo/.git/info/sparse-checkout.lock &&
        test_must_fail git -C repo sparse-checkout set deep 2>err &&
-       test_i18ngrep "File exists" err
+       test_i18ngrep "File \(already \)*exists" err
 '

This does not remove the problem of platform error compares, but does allow
the test to temporarily pass.

Randall

