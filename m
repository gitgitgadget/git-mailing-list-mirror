From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Don't fflush(stdout) when it's not helpful
Date: Fri, 29 Jun 2007 02:38:19 -0400
Message-ID: <20070629063819.GA23138@coredump.intra.peff.net>
References: <alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org> <alpine.LFD.0.98.0706251536240.8675@woody.linux-foundation.org> <alpine.LFD.0.98.0706251607000.8675@woody.linux-foundation.org> <20070626171127.GA28810@thunk.org> <alpine.LFD.0.98.0706261024210.8675@woody.linux-foundation.org> <20070628190406.GC29279@thunk.org> <20070628213451.GB22455@coredump.intra.peff.net> <20070628235319.GD29279@thunk.org> <20070629010507.GL12721@planck.djpig.de> <20070629034838.GF29279@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 29 08:38:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4A7c-0004kw-7S
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 08:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757524AbXF2GiW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 02:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756285AbXF2GiW
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 02:38:22 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2846 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732AbXF2GiV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 02:38:21 -0400
Received: (qmail 21513 invoked from network); 29 Jun 2007 06:38:40 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 29 Jun 2007 06:38:40 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jun 2007 02:38:19 -0400
Content-Disposition: inline
In-Reply-To: <20070629034838.GF29279@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51156>

On Thu, Jun 28, 2007 at 11:48:38PM -0400, Theodore Tso wrote:

> +void maybe_flush_or_die(FILE *f, const char *desc)
> +{
> +	static int stdout_is_file = -1;
> +	struct stat st;
> +	char *cp;
> +
> +	if (f == stdout) {
> +		if (stdout_is_file < 0) {
> +			cp = getenv("GIT_FLUSH");
> +			if (cp)
> +				stdout_is_file = (atoi(cp) == 0);
> +			else if ((fstat(fileno(stdout), &st) == 0) &&
> +				 S_ISREG(st.st_mode))
> +				stdout_is_file = 1;
> +			else
> +				stdout_is_file = 0;
> +		}
> +		if (stdout_is_file)
> +			return;
> +	}

Looks much better to me, but I have one minor nit: stdout_is_file is a
poor name, since it can mean either that stdout is a file, or that
flushing was explicitly turned off. Naming it something like
stdout_wants_flush would make much more sense. Though it's not a huge
deal since the function is fairly short, I think it makes things a
little easier to read (I had to double-check the negation on atoi(cp) ==
0 before I convinced myself the code was correct).

-Peff
