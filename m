From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4014: shell portability fix
Date: Tue, 31 May 2016 23:44:13 -0400
Message-ID: <20160601034413.GC5411@sigill.intra.peff.net>
References: <xmqqbn3l3kmc.fsf@gitster.mtv.corp.google.com>
 <20160531225628.GA4585@sigill.intra.peff.net>
 <CAPig+cR989yU4+JNTFREaeXqY61nusUOhufeBGGVCi29tR1P5w@mail.gmail.com>
 <20160601023159.GA5411@sigill.intra.peff.net>
 <20160601033139.GB5411@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 05:44:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7x50-0003dx-GO
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 05:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757069AbcFADoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 23:44:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:46924 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755805AbcFADoW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 23:44:22 -0400
Received: (qmail 14587 invoked by uid 102); 1 Jun 2016 03:44:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 23:44:17 -0400
Received: (qmail 29504 invoked by uid 107); 1 Jun 2016 03:44:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 23:44:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 May 2016 23:44:13 -0400
Content-Disposition: inline
In-Reply-To: <20160601033139.GB5411@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296047>

On Tue, May 31, 2016 at 11:31:40PM -0400, Jeff King wrote:

> I wondered if we could implement our own "env" in the shell, but it's a
> little non-trivial, because:
> [...]
> Here's what I came up with, which does seem to work. It's pretty gnarly,
> though.

Here's a revised version that drops the shellquoting by using extra
layers of "eval" indirection. You may have heard of 3-star C
programmers. I think I just became a 2-dollar shell programmer.

So this is gross, but I think it actually _is_ portable, with the
exception of the "is it exported" check.

-- >8 --
# is there a simpler way, even when the contents are "unset"?
is_unset () {
	eval "test -z \"\${$1}\" && test unset = \"\${$1-unset}\""
}

# probably not portable; also, possible without sub-program?
is_exported () {
	export -p | grep "^declare -x $1="
}

# set var named by $1 to contents of $2
set_var () {
	eval "$1=\$2"
}

# set var named by $1 to contents of var named by $2
copy_var () {
	eval "set_var \$1 \"\$$2\""
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
			fake_env_orig_=fake_env_orig_$fake_env_var_
			copy_var $fake_env_orig_ $fake_env_var_
			fake_env_val_=${1#*=}
			shift

			# unset value and clear export flag...
			add_to fake_env_restore_ "unset $fake_env_var_"
			# ...and then restore what was there, if anything
			if ! is_unset "$fake_env_var_"
			then
				add_to fake_env_restore_ \
					"copy_var $fake_env_var_ $fake_env_orig_"
				if is_exported "$fake_env_var_"
				then
					add_to fake_env_restore_ \
						"export $fake_env_var_"
				fi
			fi
			# and then clean up our temp variable
			add_to fake_env_restore_ "unset $fake_env_orig_"

			set_var $fake_env_var_ "$fake_env_val_"
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
foo() {
	echo >&2 "$1: bar=$bar"
}

bar="horrible \"\\' mess"
foo before
fake_env bar="temporary $bar" foo during
foo after
