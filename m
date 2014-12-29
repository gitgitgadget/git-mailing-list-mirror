From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] bisect: parse revs before passing them to check_expected_revs()
Date: Mon, 29 Dec 2014 11:33:49 -0800
Message-ID: <xmqqegriz1wi.fsf@gitster.dls.corp.google.com>
References: <20141225182534.32540.83491.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Dec 29 20:33:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5g4j-0004HO-38
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 20:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbaL2Tdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 14:33:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750833AbaL2Tdw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 14:33:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E7A429CD0;
	Mon, 29 Dec 2014 14:33:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iVSfwfc+y8RIf4rVBmosGzh3QCo=; b=Pd46nz
	GERUCYKUKphzDGGiv2QVqeSIvGQ4z+3KRKOK8KuBm72jR3+DKPqIjX+72/uownjc
	t8r3Z6EQhDhxVWbBmg/eT0Df+MepHztNXFU9Bu+VjGvIK6W5h22PHwWJ0WYlNx6v
	xCa7yEHNB0JA385D9Rxv/4VWg7YVnmBylgACE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DpsoPEnjVaaProFdc2n5Cr34OJBj87Rf
	I6yZV06RRAy0mfz+HLw8C1SpvejWuI8UbQ8JlVFe+M42d+/STiuFAqxQ8uZp1+SN
	NYKCd9REnUWrB2NEMUFXoWmoxoHGODRxel5GFm7h+G9hEObrNCKxgJNUnzpUlMPE
	jo7NmuV7i/w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 353B129CCF;
	Mon, 29 Dec 2014 14:33:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF3B329CCD;
	Mon, 29 Dec 2014 14:33:50 -0500 (EST)
In-Reply-To: <20141225182534.32540.83491.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 25 Dec 2014 19:25:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9DBB0784-8F91-11E4-83F8-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261874>

Christian Couder <chriscool@tuxfamily.org> writes:

> When running for example "git bisect bad HEAD" or
> "git bisect good master", the parameter passed to
> "git bisect (bad|good)" has to be parsed into a
> commit hash before checking if it is the expected
> commit or not.

Hmm, is that because you wrote commit object name in 40-hex in the
EXPECTED_REV and you need to compare with what the user gave you
which could be symbolic?

The conversion makes sense, but why is it a bad thing to say

	git bisect bad maint

when 'maint' is not what you checked out in the current bisect run
in the first place (perhaps you checked if it is good or bad manually
before you started bisecting)?

> diff --git a/git-bisect.sh b/git-bisect.sh
> index 6cda2b5..2fc07ac 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -237,15 +237,18 @@ bisect_state() {
>  		check_expected_revs "$rev" ;;
>  	2,bad|*,good|*,skip)

This part accepts arbitrary number of revs when running good and
skip, e.g.

	git bisect good maint master next

and it loops

>  		shift
> -		eval=''
> +		hash_list=''
>  		for rev in "$@"
> ...
> +		for rev in $hash_list
> +		do
> +			bisect_write "$state" "$rev"
> +		done
> +		check_expected_revs $hash_list ;;

But check_expected_revs loops and leaves the loop early when it
finds anything that is not expected.

... goes and looks ...

Hmph, I think the logic in check_expected_revs is not wrong, but
this helper function is grossly misnamed.  It is not checking and
rejecting the user input---it is checking to see if it can bypass
check_good_are_ancestors_of_bad() which is expensive, so when it
sees any one of the input is not what it checked out, it just
disables the "optimization".

OK, will queue.

Thanks.
