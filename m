From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4014: shell portability fix
Date: Tue, 31 May 2016 23:31:40 -0400
Message-ID: <20160601033139.GB5411@sigill.intra.peff.net>
References: <xmqqbn3l3kmc.fsf@gitster.mtv.corp.google.com>
 <20160531225628.GA4585@sigill.intra.peff.net>
 <CAPig+cR989yU4+JNTFREaeXqY61nusUOhufeBGGVCi29tR1P5w@mail.gmail.com>
 <20160601023159.GA5411@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 05:31:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7wsn-0003k8-1L
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 05:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186AbcFADbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 23:31:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:46919 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756857AbcFADbo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 23:31:44 -0400
Received: (qmail 14046 invoked by uid 102); 1 Jun 2016 03:31:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 23:31:43 -0400
Received: (qmail 29468 invoked by uid 107); 1 Jun 2016 03:31:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 23:31:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 May 2016 23:31:40 -0400
Content-Disposition: inline
In-Reply-To: <20160601023159.GA5411@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296046>

On Tue, May 31, 2016 at 10:31:59PM -0400, Jeff King wrote:

> On Tue, May 31, 2016 at 08:09:43PM -0400, Eric Sunshine wrote:
> 
> > I was under the impression that the project was moving toward 'env' to
> > deal[1] with this sort of issue.
> > 
> > [1]: 512477b (tests: use "env" to run commands with temporary env-var
> > settings, 2014-03-18)
> 
> We can use it with test_must_fail, because it takes a command name:
> 
>   test_must_fail env FOO=BAR whatever-you-would-have-run
> 
> But I don't think it works in the general case, as test_commit does not
> run its arguments. So you'd want something like:
> 
>   env FOO=BAR test_commit exotic
> 
> but of course that doesn't work because "env" can't find the shell
> function. I think with bash you could do:
> 
>   export test_commit
>   env FOO=BAR bash -c test_commit exotic
> 
> but we can't rely on that.

I wondered if we could implement our own "env" in the shell, but it's a
little non-trivial, because:

  - our basic tool for setting variable-named variables is "eval", which
    means we need an extra layer of quoting

  - we have to restore the variables after. That means telling the
    difference between unset and empty (possible with "-" versus ":-", I
    think), but also the difference between unexported and exported
    (maybe possible by parsing "export -p", but I'd be shocked if that
    doesn't run into portability problems).

Here's what I came up with, which does seem to work. It's pretty gnarly,
though.

-- >8 --
# possible without a sub-program?
# portability issues with no-newline and sed?
shellquote () {
	printf "'"
	printf '%s' "$1" | sed "s/'/'\\\\''/g"
	printf "'"
}

# is there a simpler way, even when the contents are "unset"?
is_unset () {
	eval "test -z \"\${$1}\" && test unset = \"\${$1-unset}\""
}

# probably not portable; also, possible without sub-program?
is_exported () {
	export -p | grep "^declare -x $1="
}

# just a syntactic convenience
add_to () {
	eval "$1=\"\$$1
		\$2\""
}

fake_env () {
	fake_env_restore_=
	while test $# -gt 0
	do
		case "$1" in
		*=*)
			# this whole thing is not safe when the var name has
			# spaces or other meta-characters, but since the names
			# all come from our test scripts, that should be OK
			fake_env_var_=${1%%=*}
			eval "fake_env_orig_=\$$fake_env_var_"
			fake_env_val_=${1#*=}
			shift

			# unset value and clear export flag...
			add_to fake_env_restore_ "unset $fake_env_var_"
			# ...and then restore what was there, if anything
			if ! is_unset "$fake_env_var_"
			then
				add_to fake_env_restore_ \
					"$fake_env_var_=$(shellquote "$fake_env_orig_")"
				if is_exported "$fake_env_var_"
				then
					add_to fake_env_restore_ \
						"export $fake_env_var_"
				fi
			fi

			eval "$fake_env_var_=$(shellquote "$fake_env_val_")"
			eval "export $fake_env_var_"
			;;
		*)
			"$@"
			fake_env_ret_=$?
			eval "$fake_env_restore_"
			return $fake_env_ret_
			;;
		esac
	done
}

# simple exercise
show() {
	echo >&2 "$1: myvar=$myvar"
}

myvar="horrible \"\\' mess"
show before
fake_env myvar="temporary $myvar" show during
show after

-Peff
