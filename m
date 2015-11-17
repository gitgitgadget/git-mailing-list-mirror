From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Optimize usage of grep by passing -q
Date: Tue, 17 Nov 2015 17:37:11 -0500
Message-ID: <20151117223711.GC27862@sigill.intra.peff.net>
References: <1447710209-13117-1-git-send-email-sbeller@google.com>
 <CAHYJk3S-pBQGDk_PPXw5mgzuXhdKqifRB4Vwz1Nu0TecXz4JQg@mail.gmail.com>
 <CAGZ79kYCNdDV2cDZSiugx6EuY_0BEgGMJJVm8EBWqPEE77sqbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mikael Magnusson <mikachu@gmail.com>,
	Andrey Rybak <rybak.a.v@gmail.com>, git <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 23:37:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyosL-0006L7-SO
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 23:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbbKQWhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 17:37:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:58982 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932317AbbKQWhO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 17:37:14 -0500
Received: (qmail 14171 invoked by uid 102); 17 Nov 2015 22:37:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Nov 2015 16:37:13 -0600
Received: (qmail 30785 invoked by uid 107); 17 Nov 2015 22:37:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Nov 2015 17:37:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Nov 2015 17:37:11 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ79kYCNdDV2cDZSiugx6EuY_0BEgGMJJVm8EBWqPEE77sqbw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281423>

On Mon, Nov 16, 2015 at 05:04:24PM -0800, Stefan Beller wrote:

> >> This is true for the gnu version of grep. I am not sure if all
> >> versions of grep support this optimization. In case it is not,
> >> we'd revert this patch.
> >
> > POSIX specifies -q, so you should be fine.
> > http://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html
> >
> 
> From http://www.gnu.org/software/grep/manual/grep.html :
> [...]
> Portability note: unlike GNU grep, 7th Edition Unix grep did not
> conform to POSIX, because it lacked -q and its -s option behaved like
> GNU grep's -q option.1
> USG-style grep also lacked -q but its -s option behaved like GNU
> grep's. Portable shell scripts should avoid both -q and -s and should
> redirect standard and error output to /dev/null instead. (-s is
> specified by POSIX.)

I wonder what the current state of "most" systems is. 7th Edition Unix
is probably old enough for us not to worry about. :)

For the git project, being in POSIX is not an automatic pass for a
feature. We care about real systems. I note that we do have quite a bit
of "grep -q" in the test scripts, but not in the actual git-scripts.

This came up as recently as 2008 (e.g., aadbe44), but I don't recall
anybody complaining recently. Perhaps Solaris grep finally grew a "-q"
option. Or maybe nobody runs the tests there anymore.

Since this is an optimization, I'd be more interested if we had numbers
for the improvement. Are these files really big enough that grepping the
rest of the file is noticeable versus the cost of starting grep in the
first place?

If this is something measurable, we might be able to make it a build
flag (e.g., by wrapping these grep invocations in a shell function in
git-sh-setup.sh, and picking the implementation at build time).

-Peff
