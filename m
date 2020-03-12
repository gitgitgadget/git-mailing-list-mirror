Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7D8C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 15:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC92206E7
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 15:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgCLPIq convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 12 Mar 2020 11:08:46 -0400
Received: from elephants.elehost.com ([216.66.27.132]:29920 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgCLPIq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 11:08:46 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 02CF8e0G011464
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 12 Mar 2020 11:08:40 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Git'" <git@vger.kernel.org>
References: <011401d5f6e9$de7eea50$9b7cbef0$@nexbridge.com> <xmqqwo7qfswu.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwo7qfswu.fsf@gitster.c.googlers.com>
Subject: RE: [Test] t1901 - sparse checkout file when lock is taken fails (subtest 19)
Date:   Thu, 12 Mar 2020 11:08:34 -0400
Message-ID: <020c01d5f880$1cf7c580$56e75080$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJjcEY91UqiPzBXPqu0VHJv8x4I4AD99uAGpyIvT1A=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 11, 2020 6:06 PM, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> > This situation still occurs at 2.26.0-rc0. As above, this results from
> > a text compare to a platform-specific message that should not be used.
> > To hack around it, a possible fix (which I don't like) could be as follows:
> 
> Martin's fix 4605a730 (t1091: don't grep for `strerror()` string,
> 2020-03-08) was merged to 'next' on the 9th and then down to 'master'
> today, and will be in the final (unless there is some issues with it, which I do
> not think will be the case).
> 
> Thanks.
> 
> -- >8 --
> From: Martin Ågren <martin.agren@gmail.com>
> Subject: [PATCH] t1091: don't grep for `strerror()` string
> 
> We grep for "File exists" in stderr of the failing `git sparse-checkout` to make
> sure that it failed for the right reason. We expect the string to show up there
> since we call `strerror(errno)` in `unable_to_lock_message()` in lockfile.c.
> 
> On the NonStop platform, this fails because the error string is "File already
> exists", which doesn't match our grepping.
> 
> See 9042140097 ("test-dir-iterator: do not assume errno values",
> 2019-07-30) for a somewhat similar fix. There, we patched a test helper,
> which meant we had access to `errno` and could investigate it better in the
> test helper instead of just outputting the numerical value and evaluating it in
> the test script. The current situation is different, since (short of modifying the
> lockfile machinery, e.g., to be more
> verbose) we don't have more than the output from `strerror()` available.
> 
> Except we do: We prefix `strerror(errno)` with `_("Unable to create
> '%s.lock': ")`. Let's grep for that part instead. It verifies that we were indeed
> unable to create the lock file. (If that fails for some other reason than the file
> existing, we really really should expect other tests to fail as well.)

I'm hoping that that error message matches. Will test it as soon as it is final is out there.

> An alternative fix would be to loosen the expression a bit and grep for
> "File.* exists" instead. There would be no guarantee that some other
> implementation couldn't come up with another error string, That is, that
> could be the first move in an endless game of whack-a-mole. Of course, it
> could also take us from "99" to "100" percent of the platforms and we'd
> never have this problem again. But since we have another way of addressing
> this, let's not even try the "loosen it up a bit" strategy.
> 
> Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> Acked-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t1091-sparse-checkout-builtin.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-
> builtin.sh
> index b4c9c32a03..44a91205d6 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -305,7 +305,7 @@ test_expect_success 'fail when lock is taken' '
>  	test_when_finished rm -rf repo/.git/info/sparse-checkout.lock &&
>  	touch repo/.git/info/sparse-checkout.lock &&
>  	test_must_fail git -C repo sparse-checkout set deep 2>err &&
> -	test_i18ngrep "File exists" err
> +	test_i18ngrep "Unable to create .*\.lock" err
>  '
> 
>  test_expect_success '.gitignore should not warn about cone mode' '
> --
> 2.26.0-rc1-6-ga56d361f66

This still really helps stabilize things for the NonStop platform.

Thanks!
Randall

