From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/11] tests: at-combinations: check ref names directly
Date: Tue, 07 May 2013 22:55:40 -0700
Message-ID: <7vfvxyggmb.fsf@alter.siamese.dyndns.org>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
	<1367963711-8722-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 08 07:56:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZxM8-0001l8-4S
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 07:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647Ab3EHFzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 01:55:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55932 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107Ab3EHFzo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 01:55:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1ED5D1487B;
	Wed,  8 May 2013 05:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=hmyw28eBlCoA7R6XgiSVip768mY=; b=MgIxVTbXkhomBO26iwrQ
	nniaHkqmHhxtoKtj0ymm6E084m1S1uNS1BqTAVKFPA6l/4YQ8T43/lyQ5kRmnr2x
	hklS6EKfYtX7MsX2ZNhSXW+bhATM395swWWldJU/OF2i6SN7wekPBbZ2dIje966w
	lBott6wVBq6t1BqgKstHM14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=RdXhnJ9k7SyiQTyJqGlX6Er1vRdj2p9Q2WKpB13sH+6E71
	Q6CtDihwD/jaqHbGh159DiAdEqewG8kRB80T3sPgtpZg74loffmcAH8OSUj2/qsL
	3EtsjJmAAeFSOgm0fOdwiaBqWi0LSx4DsAP0waOzBuRfcZhHDyYZH/K3wQ4q4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12D141487A;
	Wed,  8 May 2013 05:55:43 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 715F314876;
	Wed,  8 May 2013 05:55:42 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB009D32-B7A3-11E2-9BB6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223640>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Some committishes might point to the same commit, but through a
> different ref, that's why it's better to check directly for the ref,
> rather than the commit message.
>
> We can do that by calling rev-parse --symbolic-full-name, and to
> differentiate the old from the new behavior we add an extra argument to
> the check() helper.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

It is signed-off by Ram first but who is the author?  You, or him?

>  t/t1508-at-combinations.sh | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
> index 46e3f16..bd2d2fe 100755
> --- a/t/t1508-at-combinations.sh
> +++ b/t/t1508-at-combinations.sh
> @@ -4,9 +4,14 @@ test_description='test various @{X} syntax combinations together'
>  . ./test-lib.sh
>  
>  check() {
> -test_expect_${3:-success} "$1 = $2" "
> -	echo '$2' >expect &&
> -	git log -1 --format=%s '$1' >actual &&
> +test_expect_${4:-success} "$1 = $3" "
> +	if [ '$2' == 'commit' ]; then
> +		echo '$3' >expect &&
> +		git log -1 --format=%s '$1' >actual
> +	else
> +		echo '$3' >expect &&
> +		git rev-parse --symbolic-full-name '$1' >actual
> +	fi &&

Move the echo outside of if, and match the overall style.

	echo '$3' >expect &&
        if test '$2' = commit
	then
		git log ...
	else
		git rev-parse ...
	fi &&


>  	test_cmp expect actual
>  "
>  }
> @@ -35,14 +40,14 @@ test_expect_success 'setup' '
>  	git branch -u upstream-branch new-branch
>  '
>  
> -check HEAD new-two
> -check "@{1}" new-one
> -check "@{-1}" old-two
> -check "@{-1}@{1}" old-one
> -check "@{u}" upstream-two
> -check "@{u}@{1}" upstream-one
> -check "@{-1}@{u}" master-two
> -check "@{-1}@{u}@{1}" master-one
> +check HEAD ref refs/heads/new-branch
> +check "@{1}" commit new-one
> +check "@{-1}" ref refs/heads/old-branch
> +check "@{-1}@{1}" commit old-one
> +check "@{u}" ref refs/heads/upstream-branch
> +check "@{u}@{1}" commit upstream-one
> +check "@{-1}@{u}" ref refs/heads/master
> +check "@{-1}@{u}@{1}" commit master-one
>  nonsense "@{u}@{-1}"
>  nonsense "@{1}@{u}"
