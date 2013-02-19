From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] t/t7502: compare entire commit message with what was
 expected
Date: Tue, 19 Feb 2013 09:24:55 -0800
Message-ID: <7vhal86wt4.fsf@alter.siamese.dyndns.org>
References: <1361247427-438-1-git-send-email-drafnel@gmail.com>
 <20130219050813.GC19757@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 18:25:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7qwU-0003yL-Bw
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 18:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933163Ab3BSRY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 12:24:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34941 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933047Ab3BSRY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 12:24:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E181B3B1;
	Tue, 19 Feb 2013 12:24:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jIZNtwCIDiy3HvIBH6jfKoWAKbA=; b=ozYErU
	VY8xdSDUDPiWOEHEgDZuXgbh/vlEH3nACwE6LjQy5WNVIPLKcmipao2GoMjNceIC
	U7ZmfJqqMKndGDkazOfxQ2wotqAxNZC83qRDtr/Dro1Mh/BkQ97ZyPGyt4TnslPu
	im+K9OI3jWp7xUFI3YOmb1XCVldVc3o27ExLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dN8dTmQyQrSCnXwS/qkeOurSCEYH/D37
	jsZxnffTAxb6/YIrDc3Js/rD7UzKF/dLIKjuRszl5tJzPvCpGhPKEekF5FcdJ8Ec
	Q6qLoHJ8iIzLhYYu8D4vUsnreMYyZnHgeELjQizAihLQISZfyvAZNEE7wvh2GuZ+
	0wQW3/JMRNA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 613CAB3AE;
	Tue, 19 Feb 2013 12:24:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7515B3AA; Tue, 19 Feb 2013
 12:24:56 -0500 (EST)
In-Reply-To: <20130219050813.GC19757@elie.Belkin> (Jonathan Nieder's message
 of "Mon, 18 Feb 2013 21:08:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 47EF22AC-7AB9-11E2-B93D-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216636>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The downside (not a new problem, but a downside nonetheless) is that
> it means the test doesn't demonstrate what --cleanup=verbatim --status
> will do.
>
> How about something like this?

Can't we be a bit more robust by not using a hardcoded block of
lines as the "expect" string?  You could for example use what you
would see in your editor when "git commit" is run without the "-t"
option to form the expected pattern, no?

In any case, I think (1) a test for 'verbatim with status' is worth
doing, and (2) it would be cleaner to do this as a separate step,
perhaps on top of Brandon's 4-patch series.

>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>
> diff --git i/t/t7502-commit.sh w/t/t7502-commit.sh
> index cbd7a459..64162fce 100755
> --- i/t/t7502-commit.sh
> +++ w/t/t7502-commit.sh
> @@ -180,15 +180,37 @@ test_expect_success 'verbose respects diff config' '
>  test_expect_success 'cleanup commit messages (verbatim option,-t)' '
>  
>  	echo >>negative &&
> -	{ echo;echo "# text";echo; } >expect &&
> -	git commit --cleanup=verbatim -t expect -a &&
> -	git cat-file -p HEAD |sed -e "1,/^\$/d" |head -n 3 >actual &&
> +	{
> +		echo &&
> +		echo "# text" &&
> +		echo
> +	} >template &&
> +	{
> +		cat template &&
> +		cat <<-\EOF &&
> +
> +		# Please enter the commit message for your changes. Lines starting
> +		# with '\''#'\'' will be kept; you may remove them yourself if you want to.
> +		# An empty message aborts the commit.
> +		#
> +		# Author:    A U Thor <author@example.com>
> +		#
> +		EOF
> +		git commit -a --dry-run
> +	} >expect &&
> +	git commit --cleanup=verbatim -t template -a &&
> +	git cat-file -p HEAD |sed -e "1,/^\$/d" >actual &&
>  	test_cmp expect actual
>  
>  '
>  
>  test_expect_success 'cleanup commit messages (verbatim option,-F)' '
>  
> +	{
> +		echo &&
> +		echo "# text" &&
> +		echo
> +	} >expect &&
>  	echo >>negative &&
>  	git commit --cleanup=verbatim -F expect -a &&
>  	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
