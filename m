From: Jeff King <peff@peff.net>
Subject: Re: Git compile warnings (under mac/clang)
Date: Fri, 23 Jan 2015 07:23:18 -0500
Message-ID: <20150123122317.GA12517@peff.net>
References: <CAO2U3Qi6Xf1RrbxyVW3cHNe1-ZwxFHDVskGLZguWS=b38pgaXQ@mail.gmail.com>
 <CAGZ79kaFWL5HWdctLzTWf6D4nTP19sPZbcOg9fiRx7RQrWjY7Q@mail.gmail.com>
 <b2cbad0d8e59a0c4eb0565608f3f90bc@www.dscho.org>
 <20150122220140.GB6695@peff.net>
 <315bf23981813799d16fdd9b533444f3@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Michael Blume <blume.mike@gmail.com>, peter@lekensteyn.nl,
	eungjun.yi@navercorp.com, Git List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 23 13:23:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEdGo-0002bf-00
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 13:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbbAWMXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 07:23:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:37798 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753270AbbAWMXV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 07:23:21 -0500
Received: (qmail 1652 invoked by uid 102); 23 Jan 2015 12:23:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jan 2015 06:23:21 -0600
Received: (qmail 19523 invoked by uid 107); 23 Jan 2015 12:23:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jan 2015 07:23:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jan 2015 07:23:18 -0500
Content-Disposition: inline
In-Reply-To: <315bf23981813799d16fdd9b533444f3@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262917>

On Fri, Jan 23, 2015 at 12:48:29PM +0100, Johannes Schindelin wrote:

> This is what I have currently in the way of attempting to "fix" it (I
> still believe that Clang is wrong to make this a warning, and causes
> more trouble than it solves):

I agree. It is something we as the programmers cannot possibly know (the
compiler is free to decide which type however it likes) and its decision
does not impact the correctness of the code (the check is either useful
or tautological, and we cannot know which, so we are being warned about
being too careful!).

I guess you could argue that the standard defines enum-numbering to
start at 0, and increment by 1.  Therefore we should know that no valid
enum value is less than 0.  IOW, "msg_id < 0" being true must be the
result of a bug somewhere else in the program, where we assigned a value
outside of the enum range to the enum.

>     Pointed out by Michael Blume. Jeff King provided the pointer to a commit
>     fixing the same issue elsewhere in the Git source code.

It may be useful to reference the exact commit (3ce3ffb8) to help people
digging in the history (e.g., if we decide there is a better way to shut
up this warning and we need to find all the places to undo the
brain-damage).

> -	for (i = 0; i < FSCK_MSG_MAX; i++) {
> +	for (i = FSCK_MSG_MIN + 1; i < FSCK_MSG_MAX; i++) {

Ugh. It is really a shame how covering up this warning requires
polluting so many places. I don't think we have a better way, though,
aside from telling people to use -Wno-tautological-compare (and I can
believe that it _is_ a useful warning in some other circumstances, so it
seems a shame to lose it).

Unless we are willing to drop the ">= 0" check completely. I think it is
valid to do so regardless of the compiler's representation decision due
to the numbering rules I mentioned above. It kind-of serves as a
cross-check that we haven't cast some random int into the enum, but I
think we would do better to find those callsites (since they are not
guaranteed to work, anyway; in addition to signedness, it might choose a
much smaller representation).

I do not see either side of the bounds check here:

> +	if (options->msg_severity &&
> +			msg_id > FSCK_MSG_MIN && msg_id < FSCK_MSG_MAX)

as really doing anything. Any code which triggers it must already cause
undefined behavior, I think (with the exception of "msg_id == FSCK_MSG_MAX",
but presumably that is something we never expect to happen, either).

-Peff
