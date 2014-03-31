From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/27] parse_arg(): Really test that argument is properly terminated
Date: Mon, 31 Mar 2014 14:36:20 -0700
Message-ID: <xmqqlhvq3vaj.fsf@gitster.dls.corp.google.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
	<1395683820-17304-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 31 23:36:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUjsd-0005Lq-1j
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 23:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbaCaVgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 17:36:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54472 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946AbaCaVgW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 17:36:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7133179189;
	Mon, 31 Mar 2014 17:36:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ito4NKtXj2nFF79ffyZY9vuGX9k=; b=em7lv9
	9pAteIOHZxP5PIcwgcc0BuBxLp4YRcvwLTGKTXn/SowgsUOqCV9fU78jWFtZpWx3
	3LPSJLyQJ7OK5JT58I29bRhKlHE4hLiOJa5oLNgmYTrVuuhIXitkKAQN4Om64EP2
	RfpkkzLg/CS6WK92O4E3Z8s4NppcRUrpkZJ94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WdUzw7nYbjdxSiRmEUdeaSmUQBJE758D
	5QGvcFnwxqLwP/7V98xqZy9uON6YTQ462VzwUKUZCwJqmTm1z5yCQdvyQ25bry8E
	HWhaDFRy8j0gOd51uU9B3Ak/LeekK2o8sAS3eW2/c9gBGV/mqAUWWo4QCdwqOH2N
	y7x4Fg2xwSI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6017A79186;
	Mon, 31 Mar 2014 17:36:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BE5A79183;
	Mon, 31 Mar 2014 17:36:21 -0400 (EDT)
In-Reply-To: <1395683820-17304-4-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Mon, 24 Mar 2014 18:56:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 80687FD2-B91C-11E3-A039-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245536>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Test that the argument is properly terminated by either whitespace or
> a NUL character, even if it is quoted, to be consistent with the
> non-quoted case.  Adjust the tests to expect the new error message.
> Add a docstring to the function, incorporating the comments that were
> formerly within the function plus some added information.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/update-ref.c  | 20 +++++++++++++++-----
>  t/t1400-update-ref.sh |  4 ++--
>  2 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 1292cfe..02b5f95 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -62,16 +62,26 @@ static void update_store_old_sha1(struct ref_update *update,
>  	update->have_old = *oldvalue || line_termination;
>  }
>  
> +/*
> + * Parse one whitespace- or NUL-terminated, possibly C-quoted argument
> + * and append the result to arg.  Return a pointer to the terminator.
> + * Die if there is an error in how the argument is C-quoted.  This
> + * function is only used if not -z.
> + */
>  static const char *parse_arg(const char *next, struct strbuf *arg)
>  {
> -	/* Parse SP-terminated, possibly C-quoted argument */
> -	if (*next != '"')
> +	if (*next == '"') {
> +		const char *orig = next;
> +
> +		if (unquote_c_style(arg, next, &next))
> +			die("badly quoted argument: %s", orig);
> +		if (*next && !isspace(*next))
> +			die("unexpected character after quoted argument: %s", orig);
> +	} else {
>  		while (*next && !isspace(*next))
>  			strbuf_addch(arg, *next++);
> -	else if (unquote_c_style(arg, next, &next))
> -		die("badly quoted argument: %s", next);
> +	}
>  
> -	/* Return position after the argument */
>  	return next;
>  }
>  
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 29391c6..774f8c5 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -356,10 +356,10 @@ test_expect_success 'stdin fails on badly quoted input' '
>  	grep "fatal: badly quoted argument: \\\"master" err
>  '
>  
> -test_expect_success 'stdin fails on arguments not separated by space' '
> +test_expect_success 'stdin fails on junk after quoted argument' '
>  	echo "create \"$a\"master" >stdin &&
>  	test_must_fail git update-ref --stdin <stdin 2>err &&
> -	grep "fatal: expected SP but got: master" err
> +	grep "fatal: unexpected character after quoted argument: \\\"$a\\\"master" err
>  '

Interesting.

I would have expected that "We used to check only one of the two
codepaths and the other was loose, fix it" to be accompanied by "So
here is an _addition_ to the test suite to validate the other case
that used to be loose, now tightened", not "We update one existing
case".  The test before and after the patch is about a c-quoted
string, so I am not sure if we are still testing the right thing.

The code in update-ref.c after the patch does look reasonable,
though.
