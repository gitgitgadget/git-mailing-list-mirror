From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0005: add test for trap handling from deeply nested
 function calls
Date: Fri, 26 Mar 2010 13:10:16 -0700
Message-ID: <7v7hoykfo7.fsf@alter.siamese.dyndns.org>
References: <vm2zHZjrZOha7LnIM_9fAEAvwVZrJtZlAI9f2XI_VUsdqr51ihAMW68a5BT9tvMdRDSqk6GYlSE@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Mar 26 21:10:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvFrU-0006k6-Ue
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 21:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133Ab0CZUK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 16:10:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113Ab0CZUK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 16:10:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C582AA598E;
	Fri, 26 Mar 2010 16:10:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cb5v/9kM6DZ6EYlcVLuaqyN3Z3g=; b=cfYd6+
	5WlPJ1mm0y7j/Jw4h1EYmofJF2bbC8mAUsWabXhEkGI58fH3mOulCWPqDVaeKn1v
	Q3pUMGnR7alTetlJV2z+DIKiwyVG8kH+aJF2LYTbcPQv+aGyJFdDJLA/ijIsr6ms
	WJ/rxj3xNRxYgRjesCmKWnYLsPAseUUXotRw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mJaeyfEWfz+TGLjdtDtBirR33cm5YK8p
	coWLHT14uyq9hWv4saRsYmDRbfRERS1kH5UChwGykY2u8UvrvXCYq4e765Q1zD2N
	Cz/HNV76ijmT6yQwRY2k1iASM0jVrj1DlNp/QNqxaT31Q46URnHWmv6+5KAr6TBP
	Bb1tCGQGauk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 76740A598A;
	Fri, 26 Mar 2010 16:10:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3D4EA5985; Fri, 26 Mar
 2010 16:10:17 -0400 (EDT)
In-Reply-To: <vm2zHZjrZOha7LnIM_9fAEAvwVZrJtZlAI9f2XI_VUsdqr51ihAMW68a5BT9tvMdRDSqk6GYlSE@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Fri\, 26 Mar 2010 11\:34\:05 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9B25D14A-3913-11DF-86AF-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143277>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> From: Brandon Casey <drafnel@gmail.com>
>
> The /usr/xpg4/bin/sh shell on Solaris only executes a trap handler set
> within a function from the first-level function call made from within the
> function that set the trap.  In other words, if func1 sets a trap, then
> calls func2 which triggers the trap, then the trap handler will be executed
> correctly.  If instead of exiting, func2 calls func3, and func3 satisfies
> the conditions for triggering the trap, the trap handler will NOT be
> executed.
>
> This trap sequence exists in git-bisect.sh and is exercised by tests
> t6030.12 and t6030.13 which fail when the /usr/xpg4/bin/sh shell is used.
>
> Add a test that will fail sooner and more precisely than the t6030 tests.

That would be useful if you run all the tests in sequence.

It smells like the real solution is to fix git-bisect.sh not to do that
trap trick, if we can.

Or perhaps have this not as an individual test but as a code to set a test
prerequiste token (e.g. NESTED_TRAP) to run tests of bisect conditionally?

>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>
>
> Improvements to the commit message are welcome.
>
> -brandon
>
>
>  t/t0005-signals.sh |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
> index 09f855a..cb68d1f 100755
> --- a/t/t0005-signals.sh
> +++ b/t/t0005-signals.sh
> @@ -19,4 +19,12 @@ test_expect_success 'sigchain works' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'trap triggered in deeply nested function works correctly' '
> +	(atrap () { exit 0; }
> +	 func3 () { exit 1; }
> +	 func2 () { func3; }
> +	 func1 () { trap atrap EXIT; func2; }
> +	 func1)
> +'
> +
>  test_done
> -- 
> 1.6.6.2
