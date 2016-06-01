From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4014: shell portability fix
Date: Wed, 1 Jun 2016 01:33:25 -0400
Message-ID: <20160601053325.GA20797@sigill.intra.peff.net>
References: <xmqqbn3l3kmc.fsf@gitster.mtv.corp.google.com>
 <20160531225628.GA4585@sigill.intra.peff.net>
 <CAPig+cR989yU4+JNTFREaeXqY61nusUOhufeBGGVCi29tR1P5w@mail.gmail.com>
 <20160601023159.GA5411@sigill.intra.peff.net>
 <20160601033139.GB5411@sigill.intra.peff.net>
 <20160601034413.GC5411@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 07:33:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7ymb-0000gd-Ug
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 07:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbcFAFd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 01:33:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:46960 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751195AbcFAFd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 01:33:29 -0400
Received: (qmail 19127 invoked by uid 102); 1 Jun 2016 05:33:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 01:33:28 -0400
Received: (qmail 30070 invoked by uid 107); 1 Jun 2016 05:33:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 01:33:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2016 01:33:25 -0400
Content-Disposition: inline
In-Reply-To: <20160601034413.GC5411@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296051>

On Tue, May 31, 2016 at 11:44:13PM -0400, Jeff King wrote:

> So this is gross, but I think it actually _is_ portable, with the
> exception of the "is it exported" check.

Hmm. So after thinking on this, I realized we don't have to do the
clean-up ourselves at all, if we simply operate in a subshell. That
means that any shell functions we call couldn't mutate the state, but
that's probably an acceptable compromise, if the goal is to behave like
env except for being able to call shell functions.

Here is the "final" version of the more complicated scheme I came up
with. That I think should be fairly portable, but the subshell thing is
probably way less gross.

-- >8 --
test_var_is_set () {
	eval "test -n \"\${$1+set}\""
}

test_var_is_exported () {
	sh -c "test -n \"\${$1+set}\""
}

# set var named by $1 to contents of $2
test_set_var () {
	eval "$1=\$2"
}

# set var named by $1 to contents of var named by $2
test_copy_var () {
	eval "test_set_var \$1 \"\$$2\""
}

# just a syntactic convenience
add_to () {
	eval "$1=\"\$$1
		\$2\""
}

test_env () {
	test_env_restore_=
	while test $# -gt 0
	do
		case "$1" in
		*=*)
			# this whole thing is not safe when the var name has
			# spaces or other meta-characters, but since the names
			# all come from our test scripts, that should be OK
			test_env_var_=${1%%=*}
			test_env_orig_=test_env_orig_$test_env_var_
			test_copy_var $test_env_orig_ $test_env_var_
			test_env_val_=${1#*=}
			shift

			# unset value and clear export flag...
			add_to test_env_restore_ "unset $test_env_var_"
			# ...and then restore what was there, if anything
			if test_var_is_set "$test_env_var_"
			then
				add_to test_env_restore_ \
					"test_copy_var $test_env_var_ $test_env_orig_"
				if test_var_is_exported "$test_env_var_"
				then
					add_to test_env_restore_ \
						"export $test_env_var_"
				fi
			fi
			# and then clean up our temp variable
			add_to test_env_restore_ "unset $test_env_orig_"

			test_set_var $test_env_var_ "$test_env_val_"
			eval "export $test_env_var_"
			;;
		*)
			"$@"
			test_env_ret_=$?
			eval "$test_env_restore_"
			return $test_env_ret_
			;;
		esac
	done
}

# simple exercise
show () {
	echo >&2 "$1: here=$myvar ${myvar+(set)} sub=$(sh -c 'echo "$myvar ${myvar+(set)}"')"
}

doit () {
	echo "==> $1"
	show before
	test_env myvar="temporary $myvar" show during
	show after
}

unset myvar
doit unset
myvar="horrible \"\\' mess"
doit with-value
export myvar
doit exported-with-value
myvar=
export myvar
doit exported-but-blank
