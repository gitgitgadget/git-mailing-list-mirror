From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t1506: more test for @{upstream} syntax
Date: Wed, 27 Jan 2010 05:24:17 -0500
Message-ID: <20100127102417.GD6262@coredump.intra.peff.net>
References: <1263980322-4142-1-git-send-email-gitster@pobox.com>
 <1263980322-4142-2-git-send-email-gitster@pobox.com>
 <20100126130745.GB28179@coredump.intra.peff.net>
 <7vockgzliv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 11:24:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na54U-00086i-My
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 11:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820Ab0A0KYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 05:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753104Ab0A0KYV
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 05:24:21 -0500
Received: from peff.net ([208.65.91.99]:60991 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752170Ab0A0KYU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 05:24:20 -0500
Received: (qmail 4430 invoked by uid 107); 27 Jan 2010 10:24:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 27 Jan 2010 05:24:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jan 2010 05:24:17 -0500
Content-Disposition: inline
In-Reply-To: <7vockgzliv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138125>

On Tue, Jan 26, 2010 at 11:58:00AM -0800, Junio C Hamano wrote:

> > The first one is that @{usptream} silently becomes @{0}. I think
> > we need to double-check whether approxidate found absolutely nothing,
> > and complain if that is the case.
> 
> This is not a new problem introduced by Dscho's @{u} series; it was there
> even before 861f00e (fix reflog approxidate parsing bug, 2008-04-30).

True, though now that there is something besides an approxidate to
misspell, it is slightly worse. :)

> Introduce approxidate_careful() that takes an optional pointer to an
> integer, that gets assigned 1 when the input does not make sense as a
> timestamp.

A minor nit, but wouldn't:

  int approxidate_careful(const char *str, unsigned long *out);

returning an error code be the more usual pattern for a function with
error-plus-output (your approxidate wrapper would have to be a function then,
not a macro)?

> As I am too lazy to fix all the callers that use approxidate(), most of
> the callers do not take advantage of the error checking, but convert the
> code to parse reflog to use it as a demonstration.

I think that is fine, and was the approach I was also going to take.
Approxidate was meant to be "try to make sense of anything". It is
mainly a problem here because we are combining it with other input, and
it is hard to tell a misspelling of that other input from a nonsensical
approxidate. Now that the _careful infrastructure is there, we can fix
other callsites if people care.

> @@ -413,8 +413,11 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>  		} else if (0 <= nth)
>  			at_time = 0;
>  		else {
> +			int errors = 0;
>  			char *tmp = xstrndup(str + at + 2, reflog_len);
> -			at_time = approxidate(tmp);
> +			at_time = approxidate_careful(tmp, &errors);
> +			if (errors)
> +				die("Bogus timestamp '%s'", tmp);
>  			free(tmp);

I was just going to "return -1" here, which yields:

  $ git show @{bogosity}
  fatal: ambiguous argument '@{bogosity}': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions

instead of

  $ git show @{bogosity}
  fatal: Bogus timestamp 'bogosity'

I can't imagine anybody being upset that they had a path '@{usptream}'
in their repository which was prematurely interpreted as a bogus ref
(especially since it is _always_ a ref in the current behavior), but it
just seemed more consistent with the rest of get_sha1_basic, which
generally does not die.

On the other hand, I think the error message the user sees in your case
is probably more helpful.

> +test_expect_success '@{30.years.ago} shows old' '
> +	check_at @{30.years.ago} one

Side note: I chose this because we needed to go back from the current
time beyond where test_tick would place the commit. Which means this
test has a 2035 bug. :)

I had originally had 100.years.ago, but we seem to have some data-type
issues with our date handling. We represent seconds-since-epoch as
unsigned long, which means:

  - even though approxidate handles it internally, we can't represent
    dates earlier than the epoch. If you simply store approxidate's
    output as a signed time_t, as test-date does, it does work back to
    1901. But the reflog code treats it as unsigned, so 100.years.ago,
    though representable, is considered to be far in the future.

  - on many platforms ulong is 32 bits, meaning we have 2038 problems
    (though because it's unsigned, I am not sure if we actually have
    2106 problems; I suspect it may be a mix because of the way
    different parts of the system use time_t versus ulong). Presumably
    time_t will move to 64 bits in the next decade or two, and hopefully
    ulong along with it.

Now obviously neither is a pressing issue. Probably nobody is importing
any pre-epoch commits, and we have a few decades to worry about future
issues. But I did legitimately see the bug when trying to guess a "long
time ago" value. It might be nice to use a signed time_t, and to deal
with the overflow (even if it is just to barf and say "bad time" instead
of silently producing wrong, future results).

-Peff
