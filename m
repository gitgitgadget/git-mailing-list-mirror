From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/21] t6030: generalize test to not rely on current implementation
Date: Fri, 15 Apr 2016 14:07:41 -0700
Message-ID: <xmqqpotqa8de.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-6-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 23:07:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arAy1-0001nn-J0
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 23:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbcDOVHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 17:07:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751337AbcDOVHp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 17:07:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D1B613B3E;
	Fri, 15 Apr 2016 17:07:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+g+BF+9tj722cACo1mPK9OgV6As=; b=CSPHOL
	UZ7CTbCHkHyYDhBuGgW19KQiF80kAN/5Jj44+GYI+dURSgzPaSUb7B+UDJZiecmb
	TcJrkswTf4GCJ8tIVC+QooI7DffnNndnhiK3mDqIgGxRvp8gqpVlVczWKkAJUiCS
	2QKbvTrDOXmsgU07Lv3U41pbQ6HU7mToy431M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XzRblNejJBKwUNh5cjg5vivBspBcI6bj
	tGINCfcyFAC0H38EwtnMg8HKI4ZHxth1EIB1MpOwIL8M1PCdmFqKcwXJeyfOCLgX
	5Xdyx1+8WPxVswDsiibmqntO2kXqNHp3y7COeeLkFxNGakFXOu1ksHuoTjBLJiuD
	fyd0JlbieX4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5381413B3D;
	Fri, 15 Apr 2016 17:07:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF97713B3C;
	Fri, 15 Apr 2016 17:07:42 -0400 (EDT)
In-Reply-To: <1460294354-7031-6-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Sun, 10 Apr 2016 15:18:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 180E9CB8-034E-11E6-AAA4-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291660>

Stephan Beyer <s-beyer@gmx.net> writes:

> The bisect algorithm allows different outcomes if, for example,
> the number of commits between a good and a bad commit is even.
> The current test relies on a specific behavior (for example,
> the behavior of the halfway() implementation). By disabling
> halfway(), some skip tests fail although the algorithm works.
>
> This commit generalizes the test t6030 such that it works
> even if the bisect algorithm uses its degree of freedom to
> choose another commit.
>
> While at it, fix some indentation issues: use tabs instead of
> 4 spaces.

While style fixes are very much welcome, it makes the patch
unnecessary noisy.  We typically do so as a preparatory clean-up.

And if you do style fixes, please fix other style issues, such as

 - use of "if [ ... ]; then", which should be spelled as

	if test ...
        then

 - unnecessasry space between redirection operator and the filename,
   and lack of double-quoting around such a filename in a variable
   to work around certain vintage of bash that gives unnecessary
   warnings, e.g. 'echo foo > $file' must be spelled as

	echo foo >"$file"

etc.

> @@ -84,9 +82,8 @@ test_expect_success 'bisect fails if given any junk instead of revs' '
>  
>  test_expect_success 'bisect reset: back in the master branch' '
>  	git bisect reset &&
> -	echo "* master" > branch.expect &&
>  	git branch > branch.output &&
> -	cmp branch.expect branch.output
> +	grep "^* master" branch.output

This is not a style fix, and it is not a "possibly multiple valid
outcomes", either.

If the purpose of change is "to do the right thing", checking the
output from "git symbolic-ref HEAD" against "refs/heads/master" is
the kosher way to check what test is trying to do.

> @@ -180,14 +175,15 @@ test_expect_success 'bisect start: no ".git/BISECT_START" if checkout error' '
>  	git checkout HEAD hello
>  '
>  
> -# $HASH1 is good, $HASH4 is bad, we skip $HASH3
> +# $HASH1 is good, monday is bad, we skip $HASH3

I am not sure this s/$HASH4/monday/ is adding value.  Certainly it
breaks consistency, which you could keep by defining SIDE_HASH5 or
something when you added the "Ok Monday, let's do it" commit.  On
the other hand, you could choose to consistently use branch-relative
names by turning $HASH3 to master~1, etc.

>  # but $HASH2 is bad,
>  # so we should find $HASH2 as the first bad commit
> ...

> +test_expect_success '"git bisect run" simple case' '
> +	echo "#"\!"/bin/sh" > test_script.sh &&
> +	echo "grep Another hello > /dev/null" >> test_script.sh &&
> +	echo "test \$? -ne 0" >> test_script.sh &&
> +	chmod +x test_script.sh &&

Use write_script in the "style fix" preparatory clean-up patch?

> +	git bisect start &&
> +	git bisect good $HASH1 &&
> +	git bisect bad $HASH4 &&
> +	git bisect run ./test_script.sh > my_bisect_log.txt &&
> +	grep "$HASH3 is the first bad commit" my_bisect_log.txt &&
> +	git bisect reset
> +'
> ...
> +test_expect_success '"git bisect run" with more complex "git bisect start"' '
> +	echo "#"\!"/bin/sh" > test_script.sh &&
> +	echo "grep Ciao hello > /dev/null" >> test_script.sh &&
> +	echo "test \$? -ne 0" >> test_script.sh &&
> +	chmod +x test_script.sh &&

Likewise.
