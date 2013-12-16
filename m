From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test the commit.gpgsign config option
Date: Mon, 16 Dec 2013 09:05:02 -0800
Message-ID: <xmqq38lsrakh.fsf@gitster.dls.corp.google.com>
References: <xmqqa9g1qrzj.fsf@gitster.dls.corp.google.com>
	<1387202104-17580-1-git-send-email-boklm@mars-attacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Vigier <boklm@mars-attacks.org>
X-From: git-owner@vger.kernel.org Mon Dec 16 18:05:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vsbbt-0002Cd-FP
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 18:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933Ab3LPRFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 12:05:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51018 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754657Ab3LPRFI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 12:05:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 162D159306;
	Mon, 16 Dec 2013 12:05:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jwHbjiFX/NvL5JwQ65IL/Mg9bFc=; b=e/iec2
	1B1JxQLTrQZ3TFFsHGiqdA4Vo7m/+Tfyiygedj3t52eQajRTBH2b8HuVMyPEUhI9
	GfEXGP5+W3E+Jk/YgyD19ud4lupzzoPMj/pepkHxWxJrlJuSPPbr+jmzfMRKQ3XS
	gFPHkce+FQu12J88/IyOXxjtOEEBcu177GLH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mt+H2wDBuyGZPWa8ujC0uNjySY6zi/rF
	cw3k9U3nDzu/1EaQNDGz3nJFvJRDTRN+NsVfO5HCdhJyv66FywoIpzMSj/d/oYpq
	JoPDPMCOAbLVp5lPVF0WJSZU+z3qFkSNtd0Yh7vO3/Ip5ghdwXtZt1cv8iwvBqJ6
	u9jBtaDzKq8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B072459305;
	Mon, 16 Dec 2013 12:05:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE76659304;
	Mon, 16 Dec 2013 12:05:05 -0500 (EST)
In-Reply-To: <1387202104-17580-1-git-send-email-boklm@mars-attacks.org>
	(Nicolas Vigier's message of "Mon, 16 Dec 2013 14:55:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 35E82A8E-6674-11E3-9798-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239338>

Nicolas Vigier <boklm@mars-attacks.org> writes:

> The tests are checking that :
>
> - when commit.gpgsign is true, "git commit" creates signed commits
>
> - when commit.gpgsign is false, "git commit" creates unsigned commits
>
> - when commit.gpgsign is true, "git commit --no-gpg-sign" creates
>   unsigned commits
>
> - when commit.gpgsign is true, "git rebase -f" creates signed commits
>
> Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
> ---
>  t/t7510-signed-commit.sh | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 1d3c56fe61fa..537bfba76ecf 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -25,12 +25,29 @@ test_expect_success GPG 'create signed commits' '
>  	git tag fourth-unsigned &&
>  
>  	test_tick && git commit --amend -S -m "fourth signed" &&
> -	git tag fourth-signed
> +	git tag fourth-signed &&
> +
> +	git config commit.gpgsign true &&
> +	echo 5 >file && test_tick && git commit -a -m "fifth signed" &&
> +	git tag fifth-signed &&
> +
> +	git config commit.gpgsign false &&
> +	echo 6 >file && test_tick && git commit -a -m "sixth" &&
> +	git tag sixth-unsigned &&
> +
> +	git config commit.gpgsign true &&
> +	echo 7 >file && test_tick && git commit -a -m "seventh" --no-gpg-sign &&
> +	git tag seventh-unsigned &&
> +
> +	test_tick && git rebase -f HEAD^^ && git tag sixth-signed HEAD^ &&
> +	git tag seventh-signed &&
> +
> +	git config --unset commit.gpgsign

If any of the above fail, the next test will run with an unknown
random value in commit.gpgsign depending on where the sequence
failed.  Use one test_when_finished with test_unconfig at the very
beginning, perhaps.
