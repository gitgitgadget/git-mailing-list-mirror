From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: Apply -q and -v options to rebase mode as well
Date: Sat, 16 Mar 2013 21:53:57 -0700
Message-ID: <7vip4qtymy.fsf@alter.siamese.dyndns.org>
References: <1363314368.14066.3.camel@vanquo.pezone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Eisentraut <peter@eisentraut.org>
X-From: git-owner@vger.kernel.org Sun Mar 17 05:54:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH5cD-0001I0-Eq
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 05:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802Ab3CQEyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 00:54:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50448 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713Ab3CQEx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 00:53:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DF528364;
	Sun, 17 Mar 2013 00:53:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uN1WpjQAimgfJjbU89sIyVv5u+4=; b=LFHYYO
	pfkTPEXTGscIfHKyebcuwwfWKERZirC/Xqn82r/oC7CEjCVuSSzLLrGU/gE6imTe
	2sBSwcJ1v8WZHXDTvxoh9+aw0L1lpOE2BDlZk1M/Rq17bD8qtXCkXR7V4ffLNxdy
	CET6uf++DBDv6hkzQ1ouG9M47doy6/+8iaoec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BNR6UlhTDEdtSzI83pQc3ecjESa11eoG
	q6S9NHRJ9Ia8qGfGVCQrVZYmfs7kGRRaDkEXb6zcpWBOoeeJilJgdF6hfye6sUIU
	geAxmYU2EmWwy6iV6b2DDGjkAxIgCildv+hcd4HIry7Nj+3myxiRiuxvwrIvyBo3
	+56qtxx/9fA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51B398363;
	Sun, 17 Mar 2013 00:53:59 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7D138362; Sun, 17 Mar 2013
 00:53:58 -0400 (EDT)
In-Reply-To: <1363314368.14066.3.camel@vanquo.pezone.net> (Peter Eisentraut's
 message of "Thu, 14 Mar 2013 22:26:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ADE546B8-8EBE-11E2-9993-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218327>

Peter Eisentraut <peter@eisentraut.org> writes:

> git pull passed -q and -v only to git merge, but they can be useful for
> git rebase as well, so pass them there, too.  In particular, using -q
> shuts up the "Already up-to-date." message.  Add test cases to prove it.
>
> Signed-off-by: Peter Eisentraut <peter@eisentraut.org>
> ---

Looks quite straight-forward.

I wouldn't call our test cases "proving" anything, though.  The
reason we add tests is to make sure that others who touch the code
later will not break the feature you add today by documenting the
behaviour we expect out of our code.

> diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
> index 1b06691..aa31abe 100755
> --- a/t/t5521-pull-options.sh
> +++ b/t/t5521-pull-options.sh
> @@ -19,6 +19,17 @@ test_expect_success 'git pull -q' '
>  	test ! -s out)
>  '
>  
> +test_expect_success 'git pull -q --rebase' '
> +	mkdir clonedqrb &&
> +	(cd clonedqrb && git init &&
> +	git pull -q --rebase "../parent" >out 2>err &&
> +	test ! -s err &&
> +	test ! -s out &&
> +	git pull -q --rebase "../parent" >out 2>err &&
> +	test ! -s err &&
> +	test ! -s out)
> +'

Pulling twice is a good thing here, to see how it behaves when there
is something to be fetched, and when you are up to date.  I think it
is a good idea to add it to the normal 'pull -q' test.

Thanks.
