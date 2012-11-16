From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] completion: refactor __gitcomp related tests
Date: Fri, 16 Nov 2012 11:13:52 -0800
Message-ID: <7v8va1mkcv.fsf@alter.siamese.dyndns.org>
References: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
 <1352644558-9410-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 20:14:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZRMf-0003v6-K0
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 20:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154Ab2KPTN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 14:13:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35723 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501Ab2KPTNz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 14:13:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E09E9516;
	Fri, 16 Nov 2012 14:13:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/sHpAuV27XLXyOKHho/EdZwymlo=; b=TTiGH9
	1zU55vJzoMGnOINMfzJEefO1hqCWo4IxoI2PW83f1i6/RjItAG0bZXB5NS/BozOo
	YO8ryLB9t4u+pr9MCefpkLWz0sHOxdPZ1F+nqDRD2IYlZBABSiollhtzIZopTO1K
	zk+ABCsT/UxxZ9zk4s0Ybdr/uJIeMOpInnE4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gn5IN22WnqK63Ev5k8r5XDMujyXIZXEM
	PFalnCaL1g/fxNaS8yA/AUL0sgFNn++TMCi0IQX1qplDKi534PzF7bKpOT24uDUH
	aZgYXmPmbymAVdzHQo2sKMJxhw/nXpw578eql3d5XTvzCsISJGLAjhcneuPFflfG
	nlNgt63+gLA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B4109513;
	Fri, 16 Nov 2012 14:13:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3FAF950A; Fri, 16 Nov 2012
 14:13:53 -0500 (EST)
In-Reply-To: <1352644558-9410-6-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sun, 11 Nov 2012 15:35:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3138794-3021-11E2-9AB7-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209896>

Not asking for a re-roll but am asking for clarification so that I
can locally update before queuing.

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Lots of duplicated code!

... removed, you mean?

> No functional changes.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t9902-completion.sh | 76 ++++++++++++++++++---------------------------------
>  1 file changed, 27 insertions(+), 49 deletions(-)
>
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 59cdbfd..66c7af6 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -71,87 +71,65 @@ test_completion ()
>  
>  newline=$'\n'
>  
> -test_expect_success '__gitcomp - trailing space - options' '
> -	sed -e "s/Z$//" >expected <<-\EOF &&
> -	--reuse-message=Z
> -	--reedit-message=Z
> -	--reset-author Z
> -	EOF
> +# Test __gitcomp.
> +# Arguments are:
> +# 1: typed text so far (cur)
> +# *: arguments to pass to __gitcomp

s/\*/remainder/, perhaps?  I think you shift $1 out and do not pass
it to __gitcomp.

And expected output is from the standard input just like
test_completion?

> +test_gitcomp ()
> +{
> +	sed -e 's/Z$//' > expected &&
>  	(
>  		local -a COMPREPLY &&
> -		cur="--re" &&
> -		__gitcomp "--dry-run --reuse-message= --reedit-message=
> -				--reset-author" &&
> +		cur="$1" &&
> +		shift &&
> +		__gitcomp "$@" &&
>  		IFS="$newline" &&
>  		echo "${COMPREPLY[*]}" > out
>  	) &&
>  	test_cmp expected out
> +}
> +
> +test_expect_success '__gitcomp - trailing space - options' '
> +	test_gitcomp "--re" "--dry-run --reuse-message= --reedit-message=
> +		--reset-author" <<-EOF
> +	--reuse-message=Z
> +	--reedit-message=Z
> +	--reset-author Z
> +	EOF
>  '

Nice shrinkage.
