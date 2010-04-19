From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0001: check syntax of sample hooks
Date: Mon, 19 Apr 2010 13:52:05 -0700
Message-ID: <7v633nqi6i.fsf@alter.siamese.dyndns.org>
References: <20100419084132.GA25901@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 22:52:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3xx8-0002at-G1
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 22:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373Ab0DSUwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 16:52:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab0DSUwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 16:52:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CEC6AC017;
	Mon, 19 Apr 2010 16:52:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FEOfrzHmoQ6EguSVKzwvwtc2P8o=; b=AEqJct
	bIwH8jpEzwBsuPAK6MDYm8QffgskAHvFmS+qe5UzQ2gNyRiUxqFhLwE5VGjwW4PF
	tldfCChTOsVc8836af4uxxJU+8rYbnY4k3OIFgGmGKBRkEM0LM6RlZv2VkJuQm63
	m+sJjZ623eiGAisH1n8WarwK77N7+t0uWqiz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fu/CsDO/lCbzjqhI3cnup/2M+/iOvHap
	E6vfAeIu5Tf5+dX5Wg/afQLrCCezh3YlGyC8Xz7DiEZbofSuYKSlIzAuhQacp1ui
	yH+7ywji0JGj55E4uGharMGx1OOeEFWM11IBCxLkftB+15Bwi9IHc/2GmlihC+Qc
	//X03gfmHdk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 49DBAAC010;
	Mon, 19 Apr 2010 16:52:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D4E0AC00F; Mon, 19 Apr
 2010 16:52:06 -0400 (EDT)
In-Reply-To: <20100419084132.GA25901@progeny.tock> (Jonathan Nieder's message
 of "Mon\, 19 Apr 2010 03\:41\:33 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6C6FC67C-4BF5-11DF-AB6B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145328>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 6757734..3e6e1ed 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -141,6 +141,21 @@ test_expect_success 'reinit' '
>  	test_cmp again/empty again/err2
>  '
>  
> +test_expect_success 'sample hooks use acceptable syntax' '
> +	mkdir boring &&
> +	git init boring &&
> +	test -d boring/.git/hooks &&
> +	fail=f &&
> +	for i in boring/.git/hooks/*.sample
> +	do
> +		read shebang <"$i" &&
> +		shell=${shebang#"#!"} &&
> +		$shell -n "$i" ||

"#!/Program  Files/bin/shell"???

I think, after observing what this outputs,

    $ echo 'a  b c' | (read shebang; echo "<$shebang>")

you would need something like this:

	shell=$(sed -e '1{
        	s/^#!//p
                q
	}' "$i") &&
        "$shell" -n "$i"

> diff --git a/templates/hooks--pre-rebase.sample b/templates/hooks--pre-rebase.sample
> index 053f111..22a9f07 100755
> --- a/templates/hooks--pre-rebase.sample
> +++ b/templates/hooks--pre-rebase.sample
> @@ -91,6 +91,7 @@ fi
>  exit 0
>  
>  ################################################################
> +cat <<\EOF

No need to meow here; just say ":" instead.

>  This sample hook safeguards topic branches that have been
>  published from being rewound.
> @@ -167,3 +168,5 @@ To compute (2):
>  	git rev-list master..topic
>  
>  	if this is empty, it is fully merged to "master".
> +
> +EOF
> -- 
> 1.7.1.rc1
