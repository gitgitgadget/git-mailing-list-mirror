Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAC7C433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 21:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F0C020795
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 21:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgL3VGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 16:06:34 -0500
Received: from ikke.info ([178.21.113.177]:47122 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgL3VGd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 16:06:33 -0500
X-Greylist: delayed 32428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Dec 2020 16:06:33 EST
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id A4F6F44012C; Wed, 30 Dec 2020 22:05:51 +0100 (CET)
Date:   Wed, 30 Dec 2020 22:05:51 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t4129: don't fail if setgid is set in the parent
 directory
Message-ID: <X+zrryp6ndOa5rOM@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>,
        Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
References: <X+xtAR87vWuNiLoE@alpha>
 <88398ff952a68e8d134dcd50ef0772bb6fc3b456.1609339792.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88398ff952a68e8d134dcd50ef0772bb6fc3b456.1609339792.git.matheus.bernardino@usp.br>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 30, 2020 at 11:52:25AM -0300, Matheus Tavares wrote:
> The last test of t4129 creates a directory and expects its setgid bit
> (g+s) to be off. But this makes the test fail when the parent directory
> has the bit set, as setgid's state is inherited by newly created
> subdirectories. Make the test more robust by accepting the presence of
> the setgid bit on the created directory. We only allow 'S' (setgid on
> but no executable permission) and not 's' (setgid on with executable
> permission) because the previous 'umask 0077' shouldn't allow the second
> scenario to happen.
> 
> Note that only subdirectories inherit this bit, so we don't have to make
> the same change for the regular file that is also created by this test.
> But checking the permissions using grep instead of test_cmp makes the
> test a little simpler, so let's use it for the regular file as well.
> 
> Also note that the sticky bit (+t) and the setuid bit (u+s) are not
> inherited, so we don't have to worry about those.
> 
> Reported-by: Kevin Daudt <me@ikke.info>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  t/t4129-apply-samemode.sh | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
> index 41818d8315..3818398ca9 100755
> --- a/t/t4129-apply-samemode.sh
> +++ b/t/t4129-apply-samemode.sh
> @@ -90,12 +90,10 @@ test_expect_success POSIXPERM 'do not use core.sharedRepository for working tree
>  		rm -rf d f1 &&
>  		git apply patch-f1-and-f2.txt &&
>  
> -		echo "-rw-------" >f1_mode.expected &&
> -		echo "drwx------" >d_mode.expected &&
> -		test_modebits f1 >f1_mode.actual &&
> -		test_modebits d >d_mode.actual &&
> -		test_cmp f1_mode.expected f1_mode.actual &&
> -		test_cmp d_mode.expected d_mode.actual
> +		test_modebits f1 >f1_mode &&
> +		test_modebits d >d_mode &&
> +		grep "^-rw-------$" f1_mode &&
> +		grep "^drwx--[-S]---$" d_mode
>  	)
>  '
>  
> -- 
> 2.29.2
> 

Tested-by: Kevin Daudt <me@ikke.info>
