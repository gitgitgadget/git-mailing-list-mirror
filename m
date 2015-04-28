From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/3] Improve robustness of putty detection
Date: Tue, 28 Apr 2015 00:15:21 -0400
Message-ID: <20150428041521.GB24580@peff.net>
References: <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>
 <1430080212-396370-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqq4mo2zgtz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 06:17:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmwxL-0005bd-Ib
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 06:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbbD1EPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 00:15:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:50935 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750758AbbD1EPY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 00:15:24 -0400
Received: (qmail 15072 invoked by uid 102); 28 Apr 2015 04:15:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Apr 2015 23:15:24 -0500
Received: (qmail 11225 invoked by uid 107); 28 Apr 2015 04:15:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 00:15:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Apr 2015 00:15:21 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4mo2zgtz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267891>

On Sun, Apr 26, 2015 at 03:04:56PM -0700, Junio C Hamano wrote:

> The test scripts are expected to take either 3 or 4 parameters, and
> the extra parameter when it takes 4 is the comma separated list of
> prerequisites.  "bracketed hostnames are still ssh" does not look
> like prerequisites at all to us humans, and the framework should
> also be able to notice that and barf, I would think.
> 
> Perhaps something like this?

I like it. I wondered if we could even recognize a known set of prereqs
(e.g., say "I don't know about the FOO prereq; did you forget to
test_lazy_prereq it?"), but I don't think we can. Some of the prereqs
are set by arbitrary code, and when they are not set, we don't call a
"test_do_not_set_prereq FOO".  Enforcing a sane syntax is almost as
good, and seems pretty easy to implement.

> +test_verify_prereq () {
> +	test -z "$test_prereq" ||
> +	expr >/dev/null "$test_prereq" : '^[A-Z0-9_,!]*$' ||
> +	error "bug in the test script: '$test_prereq' does not look like a prereq"
> +}

The leading "^" is unnecessary in an expr regexp, as such expressions
are always left-anchored. And according to POSIX, even undesirable
due to hysterical raisins. You do still need the '$' to anchor the end.

I was surprised that the regexp does not match the empty string itself
(making the initial "test -z" redundant), but it does not seem to with
my version of expr. Weird. I think it is because the exit value is not
"did it match" but "is the return value of the expression non-zero", and
of course we matched zero characters.

At any rate, we are probably much better off having the initial "test
-z" there as an optimization, anyway. "expr" is not usually a built-in,
and otherwise we add an extra fork to each test invocation (not
something I expect matters under Linux, but I know Windows folks are
very sensitive to it).

-Peff
