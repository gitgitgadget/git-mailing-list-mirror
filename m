From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5541: don't call start_httpd after sourcing lib-terminal.sh
Date: Fri, 14 Mar 2014 14:47:14 -0700
Message-ID: <xmqqtxb0fo65.fsf@gitster.dls.corp.google.com>
References: <53237228.10809@web.de>
	<20140314213715.GA10299@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 22:47:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOZwu-0005UD-Hx
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 22:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581AbaCNVrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 17:47:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54214 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754820AbaCNVrW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 17:47:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D72B575EF0;
	Fri, 14 Mar 2014 17:47:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uSeJ5KJtn96+Tz5EudrnwQdpd88=; b=uVemVs
	iyLhQ/L/5aP/Qkg6O1/kzixThekqvthk1P2HZjahHrG7qUxA4pk8uF81F8WtvU7G
	B+M6/D5SvkXXXsRzh/jlMtLno9s8YhtMOIjCgyiEeatJS33NgrsszeyMd5ElsEmA
	qOsDrT6A5ZaDXDE2wl6OFJoGRaL7s6YrTHRIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yvsp0ToMwqQFR5awSVWXMepX3XNwUVQI
	jkrbPTIG2X+HpaFiY3t7jE1FsZFk+sYc1zbQHw7YIW6z3ozda13LEBthzmG5vmXN
	5zK3YrLxpx88t8rti1iZZh60m5q3McNpBMpwaSk/mDA+KbtJsJUp/AlAl5vSyUof
	vkFMeuvJM3o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C54D975EEF;
	Fri, 14 Mar 2014 17:47:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94D6875ED8;
	Fri, 14 Mar 2014 17:47:16 -0400 (EDT)
In-Reply-To: <20140314213715.GA10299@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 14 Mar 2014 17:37:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 35D1FE42-ABC2-11E3-B621-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244116>

Jeff King <peff@peff.net> writes:

> One option would be to _always_ define test_terminal....

That looks like the right direction to go.

> Something like the patch below (looks like we should be using $PERL_PATH
> instead of "perl", too).

;-)  Also a SP between test_terminal and (), perhaps.

> diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
> index 9a2dca5..55b708f 100644
> --- a/t/lib-terminal.sh
> +++ b/t/lib-terminal.sh
> @@ -1,35 +1,36 @@
>  # Helpers for terminal output tests.
>  
> -test_expect_success PERL 'set up terminal for tests' '
> +# Catch tests which should depend on TTY but forgot to. There's no need
> +# to check that TTY is set here. If the test declared it and we are running
> +# it, then it is set.
> +test_terminal() {
> +	if ! test_declared_prereq TTY
> +	then
> +		echo >&4 "test_terminal: need to declare TTY prerequisite"
> +		return 127
> +	fi
> +	perl "$TEST_DIRECTORY"/test-terminal.perl "$@"
> +}
> +
> +test_lazy_prereq TTY '
> +	test_have_prereq PERL &&
> +
>  	# Reading from the pty master seems to get stuck _sometimes_
>  	# on Mac OS X 10.5.0, using Perl 5.10.0 or 5.8.9.
>  	#
>  	# Reproduction recipe: run
>  	#
>  	#	i=0
>  	#	while ./test-terminal.perl echo hi $i
>  	#	do
>  	#		: $((i = $i + 1))
>  	#	done
>  	#
>  	# After 2000 iterations or so it hangs.
>  	# https://rt.cpan.org/Ticket/Display.html?id=65692
>  	#
> -	if test "$(uname -s)" = Darwin
> -	then
> -		:
> -	elif
> -		perl "$TEST_DIRECTORY"/test-terminal.perl \
> -			sh -c "test -t 1 && test -t 2"
> -	then
> -		test_set_prereq TTY &&
> -		test_terminal () {
> -			if ! test_declared_prereq TTY
> -			then
> -				echo >&4 "test_terminal: need to declare TTY prerequisite"
> -				return 127
> -			fi
> -			perl "$TEST_DIRECTORY"/test-terminal.perl "$@"
> -		}
> -	fi
> +	test "$(uname -s)" != Darwin &&
> +
> +	perl "$TEST_DIRECTORY"/test-terminal.perl \
> +		sh -c "test -t 1 && test -t 2"
>  '
