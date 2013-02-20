From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] t7800: modernize tests
Date: Tue, 19 Feb 2013 23:05:44 -0800
Message-ID: <7vip5nzcqf.fsf@alter.siamese.dyndns.org>
References: <1361338528-17835-1-git-send-email-davvid@gmail.com>
 <1361338528-17835-2-git-send-email-davvid@gmail.com>
 <1361338528-17835-3-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 08:06:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U83kq-0000Aq-LT
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 08:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933252Ab3BTHFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 02:05:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53109 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933074Ab3BTHFq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 02:05:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EA0B8A18;
	Wed, 20 Feb 2013 02:05:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aZwsEOeGJhsb7qooIoZsABHKSwM=; b=kmpqFV
	DAfzazXk6uYnQ/W8jNwVpHd2WxYi67iYjfBYb7PYVE0PIiUEvHX08JY5+N7mnnQh
	tNo17MUHflZ6qYl1btRi/iLrvZ2zY19d8h+en9KBifv4urgIQLWw/ZY9GkYVh3hg
	Wml7pGFxob9RBAfBQ5RHAUEPJZpBUHVYrBl/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RBUKJmZ/ycyDbY9Kv7m6jsoOhgitLuvo
	u7Hu/HBIjuvwtesYKcSdb1Sd0RL+zJTGQuEEQnpYy8rs0MFK05wLiMkzK73RCFOh
	otPcAH7naNnLjRGKMjZUCLlykZU8BjnZG5UsvJ13pEacPqO9nCqLZUnYwnIv5+9U
	/4dT6bDrvFg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C1CB8A17;
	Wed, 20 Feb 2013 02:05:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85A748A16; Wed, 20 Feb 2013
 02:05:45 -0500 (EST)
In-Reply-To: <1361338528-17835-3-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Tue, 19 Feb 2013 21:35:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F26CA0FC-7B2B-11E2-8FD2-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216685>

David Aguilar <davvid@gmail.com> writes:

> Eliminate a lot of redundant work by using test_config().
> Catch more return codes by more use of temporary files
> and test_cmp.
>
> The original tests relied upon restore_test_defaults()
> from the previous test to provide the next test with a sane
> environment.  Make the tests do their own setup so that they
> are not dependent on the success of the previous test.
> The end result is shorter tests and better test isolation.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> We no longer export variables into the environment per Jonathan's
> suggestion.  This covers all of the review notes.
>
>  t/t7800-difftool.sh | 360 ++++++++++++++++++++++++----------------------------
>  1 file changed, 165 insertions(+), 195 deletions(-)
>
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 5b5939b..b577c01 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -10,29 +10,11 @@ Testing basic diff tool invocation
>  
>  . ./test-lib.sh
>  
> +difftool_test_setup()
>  {
> +	test_config diff.tool test-tool &&
> +	test_config difftool.test-tool.cmd 'cat $LOCAL' &&
> +	test_config difftool.bogus-tool.cmd false
>  }

Cute.

Are we sure that $LOCAL is free of $IFS, or is it safer to say 'cat
"$LOCAL"' or something?

> @@ -324,26 +294,26 @@ test_expect_success PERL 'setup with 2 files different' '
>  '
>  
>  test_expect_success PERL 'say no to the first file' '
> -	diff=$( (echo n; echo) | git difftool -x cat branch ) &&
> -
> -	echo "$diff" | stdin_contains m2 &&
> -	echo "$diff" | stdin_contains br2 &&
> -	echo "$diff" | stdin_doesnot_contain master &&
> -	echo "$diff" | stdin_doesnot_contain branch
> +	(echo n && echo) >input &&
> +	git difftool -x cat branch <input >output &&
> +	cat output | stdin_contains m2 &&
> +	cat output | stdin_contains br2 &&
> +	cat output | stdin_doesnot_contain master &&
> +	cat output | stdin_doesnot_contain branch

Do you need these pipes?  In other words, wouldn't

	stdin_contains whatever <output

be more straight-forward way to say these?
