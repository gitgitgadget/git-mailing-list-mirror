From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] t/lib-terminal: make TTY a lazy prerequisite
Date: Fri, 14 Mar 2014 23:13:01 +0100
Message-ID: <53237EED.3060508@web.de>
References: <53237228.10809@web.de> <20140314213715.GA10299@sigill.intra.peff.net> <xmqqtxb0fo65.fsf@gitster.dls.corp.google.com> <20140314215723.GB10299@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 23:13:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOaLq-0002eX-SU
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 23:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017AbaCNWNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 18:13:10 -0400
Received: from mout.web.de ([212.227.15.14]:62041 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753732AbaCNWNI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 18:13:08 -0400
Received: from [192.168.178.41] ([84.132.148.173]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MEmOw-1WLlzQ0qUc-00G31u; Fri, 14 Mar 2014 23:13:02
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <20140314215723.GB10299@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:YNZK8hFxOqLgByWVIIK47jiFidhvkuW6L9I0meGQh6qN4PB/fo4
 85iFbdruQ9sxPdYJVwAKHE7TMqDvgOAPgySMds7IvgL2SahHNW1VDNVRqNju8t/K6XMbNsY
 h8SfiPJzBJkmoBaBwLz6GPzhuetTaHYE25FLALWtSa4IIY0ssq+mJNtaEiWtnx7t+MvI+1A
 TvvJiifL3umuHJ3bE7JwQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244121>

Am 14.03.2014 22:57, schrieb Jeff King:
> On Fri, Mar 14, 2014 at 02:47:14PM -0700, Junio C Hamano wrote:
> 
>>> Something like the patch below (looks like we should be using $PERL_PATH
>>> instead of "perl", too).
> 
> Actually, we don't need to do this, as of 94221d2 (t: use perl instead
> of "$PERL_PATH" where applicable, 2013-10-28). If only the author of
> that commit were here to correct me...
> 
>> ;-)  Also a SP between test_terminal and (), perhaps.
> 
> Fixed below. Here it is with a commit message.

Thanks, this fixes the problem for me :-)

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
> 
