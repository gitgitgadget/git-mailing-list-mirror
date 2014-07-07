From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 03/10] replace: add test for --graft
Date: Mon, 07 Jul 2014 15:16:33 -0700
Message-ID: <xmqqmwckbyri.fsf@gitster.dls.corp.google.com>
References: <20140707063342.3708.83493.chriscool@tuxfamily.org>
	<20140707063540.3708.9611.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 00:16:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4HDI-00010o-Vg
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 00:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbaGGWQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 18:16:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54908 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbaGGWQk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 18:16:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D289227F95;
	Mon,  7 Jul 2014 18:16:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=35TXg//yw1Az08laCzHyCMKXfOk=; b=gFIWtq
	bu37tdwzOlS768U+UuIXAcW4xKJDPGO+r8MfX1R9GYsG2glNeUyocxol9IXXvww2
	F7HuKJWIdlBWK41tF9HBjHPYZPII4xU8es6D/9jDAN/ZjuQLTaAzd2IsyVNCJpHp
	3n+d6wuEv29r++UurTmadquJgyUA9ZC1P59rU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qAbxz/B33J5jN5jQZKq3WJ00TcqqYR75
	C0vTtbs+LpmNrfFhmHNN8y9vacD4qUv//j5IMoJsm3WCR5oTIDeRTwSFB7zjU+SR
	Vw58JLPnEExQBtnR2l9XyK99XbZPOScCbYGeuW1kHlMh263rbB75z0AdNEW6NbLm
	eHAM30i4Rbw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C7CCC27F94;
	Mon,  7 Jul 2014 18:16:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8E67A27F8A;
	Mon,  7 Jul 2014 18:16:21 -0400 (EDT)
In-Reply-To: <20140707063540.3708.9611.chriscool@tuxfamily.org> (Christian
	Couder's message of "Mon, 07 Jul 2014 08:35:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5372A782-0624-11E4-B033-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252992>

Christian Couder <chriscool@tuxfamily.org> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t6050-replace.sh | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> index fb07ad2..d80a89e 100755
> --- a/t/t6050-replace.sh
> +++ b/t/t6050-replace.sh
> @@ -18,6 +18,33 @@ add_and_commit_file()
>      git commit --quiet -m "$_file: $_msg"
>  }
>  
> +commit_buffer_contains_parents()

SP before (), perhaps?

> +{
> +    git cat-file commit "$1" >payload &&
> +    sed -n -e '/^$/q' -e '/^parent /p' <payload >actual &&
> +    shift &&
> +    : >expected &&
> +    for _parent
> +    do
> +	echo "parent $_parent" >>expected || return 1
> +    done &&

You can redirect the entire loop to simplify the above 5 lines,
which would read better, no?

	for _parent
        do
		echo "parent $_parent"
	done >expect

> +    test_cmp actual expected

As "test_cmp" normally runs "diff", it is better to compare expect
with actual, not the other way around; running the test verbosely,
i.e. "t6050-replace.sh -v", shows how the actual output differs from
what is expected when diagnosing breakage and would be more useful
that way.

If your goal is to test both the object contents with this code
*and* the overall system behaviour with the "$child^$parent" below,
perhaps they should be in the same "commit_has_parents" function,
without forcing the caller to choose between the two or call both,
no?

> +test_expect_success '--graft with and without already replaced object' '
> +	test $(git log --oneline | wc -l) = 7 &&
> +	git replace --graft $HASH5 &&
> +	test $(git log --oneline | wc -l) = 3 &&
> +	commit_buffer_contains_parents $HASH5 &&
> +	commit_has_parents $HASH5 &&
> +	test_must_fail git replace --graft $HASH5 $HASH4 $HASH3 &&
> +	git replace --force -g $HASH5 $HASH4 $HASH3 &&
> +	commit_buffer_contains_parents $HASH5 $HASH4 $HASH3 &&
> +	commit_has_parents $HASH5 $HASH4 $HASH3 &&
> +	git replace -d $HASH5
> +'
> +
>  test_done
