From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] tests: make test_must_fail more verbose
Date: Tue, 31 Aug 2010 14:06:18 -0400
Message-ID: <20100831180618.GB15020@sigill.intra.peff.net>
References: <20100831155457.GB11014@sigill.intra.peff.net>
 <20100831155636.GA11530@sigill.intra.peff.net>
 <20100831171055.GO2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 20:06:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqVDj-0005UN-Ip
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 20:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409Ab0HaSGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 14:06:01 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54806 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754352Ab0HaSGA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 14:06:00 -0400
Received: (qmail 29413 invoked by uid 111); 31 Aug 2010 18:06:00 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 31 Aug 2010 18:06:00 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Aug 2010 14:06:18 -0400
Content-Disposition: inline
In-Reply-To: <20100831171055.GO2315@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154950>

On Tue, Aug 31, 2010 at 12:10:55PM -0500, Jonathan Nieder wrote:

> > -	test $? -gt 0 -a $? -le 129 -o $? -gt 192
> [...]
> Can the exit status (e.g. from a shell function) be negative?

I don't believe so. Both bash and dash complain about "return -1" (and
POSIX says the number must be "an unsigned decimal integer"). More
importantly, though, is how shells interpret an exit status from a
command that has high bits set. Both bash and dash truncate it to 8-bits
and treat it as unsigned. I would think any reasonable shell would do
that (no, I don't have a Solaris 8 box handy to test on. :) ).

> Though your patch does not affect this, a command interrupted by a
> signal will receive exit status > 192 in shells like ksh93.

Yeah, that is from 5a26973 (t/test-lib.sh: exit with small negagive int
is ok with test_must_fail, 2008-07-12). I'm not sure I agree with the
intent of that commit. We should perhaps just eliminate all the places
where we use negative exit codes.

> Posix says:
> 	As explained in other sections, certain exit status values
> 	have been reserved for special uses and should be used by
> 	applications only for those purposes:
> 
> 	126
> 		A file to be executed was found, but it was not an
> 		executable utility.
> 	127
> 		A utility to be executed was not found.
> 	>128
> 		A command was interrupted by a signal.

Yup, that's what I have always assumed to be the case.

> Unfortunately that does not agree with git usage.
> 
> 	129
> 		Incorrect command-line usage, or help requested
> 		(rather than SIGHUP).

Yeah, we might consider changing that. We indeed confuse it with SIGHUP:

  $ git log -h 2>/dev/null; echo $?
  129
  $ git log -p >/dev/null; echo $? [now killall -HUP git elsewhere]
  129

We also use 128 for our generic die. I don't know if this is ever
problematic. It has the high bit set like a signal, but you don't
actually check the bits in the shell. And the actual representation at
the C level is not the same.

So part of me is in favor of changing these to something more "normal".
I am slightly worried, though, about breaking some caller. It is a
user-visible interface, though I suspect 99% of callers only ever cared
whether it was 0 or not.

> Here's a test_might_fail patch for consistency.

I didn't even know about that one. :)

They should definitely be kept in sync. I wonder if it is worth
implemening must_fail in terms of might_fail.

>  test_might_fail () {
>  	"$@"
> -	test $? -ge 0 -a $? -le 129 -o $? -gt 192
> +	exit_code=$?
> +	if test $exit_code -gt 129 -a $exit_code -le 192; then
> +		echo >&2 "test_might_fail: died by signal: $*"
> +		return 1
> +	fi
> +	return 0

I wonder if 2/2 would need the "missing command" bit, too. Hrm.

-Peff
