From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/lib-terminal: make TTY a lazy prerequisite
Date: Fri, 14 Mar 2014 15:05:45 -0700
Message-ID: <xmqqpplofnba.fsf@gitster.dls.corp.google.com>
References: <53237228.10809@web.de>
	<20140314213715.GA10299@sigill.intra.peff.net>
	<xmqqtxb0fo65.fsf@gitster.dls.corp.google.com>
	<20140314215723.GB10299@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 23:05:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOaEk-0004jj-KC
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 23:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451AbaCNWFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 18:05:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42806 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753732AbaCNWFt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 18:05:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76E80713F3;
	Fri, 14 Mar 2014 18:05:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x8qg1Jq6qhxib2O5rkMIZyO3efc=; b=ojVOm3
	2KZR9YcF/OxJ5LVzPA1G3CfBcOt0ybv12CVtLrTUtziVqg9qQIajzsspGBJzv4Af
	mno3C4Z/bZzJQAQWYirAZf/rQfPE5FXa3PVdH4YkhsZdtAukFxY0GYEDbxR2xykx
	7/thyOFd/+qDZ9GF0MXKjSxU6eQfNYHaM593Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nHwF/UvYCUAuYhKu8FfmV6QTdY89Mf5y
	n0xD54+gBBqdlcMYWjy4aH8OxDavkbMaJCsHjxa5/PjFV8psmltmFWr6t5DsKH0Y
	TBLLQiNZvfCnbPka/Yb9BBJt1KJHewSXCaiWDktFiDQHWN7sVhzMa8owIpV6bzQX
	udXay65JgQk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61D7B713F1;
	Fri, 14 Mar 2014 18:05:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A41A9713EB;
	Fri, 14 Mar 2014 18:05:47 -0400 (EDT)
In-Reply-To: <20140314215723.GB10299@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 14 Mar 2014 17:57:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CC106D60-ABC4-11E3-B663-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244119>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 14, 2014 at 02:47:14PM -0700, Junio C Hamano wrote:
>
>> > Something like the patch below (looks like we should be using $PERL_PATH
>> > instead of "perl", too).
>
> Actually, we don't need to do this, as of 94221d2 (t: use perl instead
> of "$PERL_PATH" where applicable, 2013-10-28). If only the author of
> that commit were here to correct me...

Yuck. I forgot all about that, too.

I wonder if that commit (actually the one before it) invites subtle
bugs by tempting us to say

	sane_unset VAR &&
	VAR=VAL perl -e 0 &&
        test "${VAR+isset}" != "isset"

> -- >8 --
> Subject: t/lib-terminal: make TTY a lazy prerequisite
>
> When lib-terminal.sh is sourced by a test script, we
> immediately set up the TTY prerequisite. We do so inside a
> test_expect_success, because that nicely isolates any
> generated output.
>
> However, this early test can interfere with a script that
> later wants to skip all tests (e.g., t5541 then goes on to
> set up the httpd server, and wants to skip_all if that
> fails). TAP output doesn't let us skip everything after we
> have already run at least one test.
>
> We could fix this by reordering the inclusion of
> lib-terminal.sh in t5541 to go after the httpd setup.  That
> solves this case, but we might eventually hit a case with
> circular dependencies, where either lib-*.sh include might
> want to skip_all after the other has run a test.  So
> instead, let's just remove the ordering constraint entirely
> by doing the setup inside a test_lazy_prereq construct,
> rather than in a regular test.  We never cared about the
> test outcome anyway (it was written to always succeed).
>
> Note that in addition to setting up the prerequisite, the
> current test also defines test_terminal. Since we can't
> affect the environment from a lazy_prereq, we have to hoist
> that out. We previously depended on it _not_ being defined
> when the TTY prereq isn't set as a way to ensure that tests
> properly declare their dependency on TTY. However, we still
> cover the case (see the in-code comment for details).
>
> Reported-by: Jens Lehmann <Jens.Lehmann@web.de>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Thanks.

>  t/lib-terminal.sh | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
> index 9a2dca5..5184549 100644
> --- a/t/lib-terminal.sh
> +++ b/t/lib-terminal.sh
> @@ -1,6 +1,20 @@
>  # Helpers for terminal output tests.
>  
> -test_expect_success PERL 'set up terminal for tests' '
> +# Catch tests which should depend on TTY but forgot to. There's no need
> +# to aditionally check that the TTY prereq is set here.  If the test declared
> +# it and we are running the test, then it must have been set.
> +test_terminal () {
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
> @@ -15,21 +29,8 @@ test_expect_success PERL 'set up terminal for tests' '
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
