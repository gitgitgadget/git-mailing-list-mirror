From: Jeff King <peff@peff.net>
Subject: Re: Possible bug: "git log" ignores "--encoding=UTF-8" option if
	--pretty=format:%e%n%s%n is used
Date: Wed, 12 Nov 2008 05:43:18 -0500
Message-ID: <20081112104318.GA20120@coredump.intra.peff.net>
References: <85647ef50811111112o5449c12elfc571e46e607cfd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 11:45:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0DDB-0002OJ-3H
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 11:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbYKLKnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 05:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbYKLKnW
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 05:43:22 -0500
Received: from peff.net ([208.65.91.99]:1552 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbYKLKnV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 05:43:21 -0500
Received: (qmail 18430 invoked by uid 111); 12 Nov 2008 10:43:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Nov 2008 05:43:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Nov 2008 05:43:18 -0500
Content-Disposition: inline
In-Reply-To: <85647ef50811111112o5449c12elfc571e46e607cfd0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100739>

On Tue, Nov 11, 2008 at 10:12:46PM +0300, Constantine Plotnikov wrote:

> is encoded using Windows-1251 and the second one using UTF-8. However
> in the description of the %s %b options nothing is said about which
> encoding is used and implied behavior is that they are affected by
> --encoding option.
> 
> I suggest documenting that the placeholders %s and %b use native
> commit encoding and introducing the placeholders %S and %B options
> that use encoding specified on the command line or the default log
> encoding.

I don't actually use any encodings except UTF-8, so maybe there is some
subtle reason not to do so that I don't understand, but I would have
expected all of the format placeholders to respect any --encoding
parameter.

If that is the desired behavior, this should not be too hard to make a
patch for:

  1. in pretty_print_commit, move the code path for userformat to just
     after the re-encoding

  2. pass the re-encoded buffer to format_commit_message, where it will
     be put into the context struct

  3. use the re-encoded buffer in parse_commit_header

Maybe it would make a good exercise for somebody who wants to dig into
git a little deeper? Volunteers?

> I also suggest adding %g and %G placeholders (%m placeholder is
> already occupied) that print the entire commit message instead of just
> the subject or the body. Currently the tools have to join the entire
> message from two parts when they are just interested in the entire
> message.

This actually annoyed me earlier today. What got me was that '%s%n%n%b'
doesn't necessarily give you the exact commit message; if it's a
one-liner (i.e., body is blank), then you end up with an extra newline.

Again, this should be a pretty easy exercise to add. Volunteers?

-Peff
