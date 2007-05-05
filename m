From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] git-parse-remote: fix ambiguous shell bug in expand_refs_wildcard
Date: Sat, 5 May 2007 18:03:13 +1000
Message-ID: <20070505080313.GA12170@gondor.apana.org.au>
References: <20061218080941.GA3857@coredump.intra.peff.net> <7v4prtx9hu.fsf@assigned-by-dhcp.cox.net> <20061218224505.GB13034@coredump.intra.peff.net> <20061219003557.GA17799@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 05 10:04:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkFFH-0007k4-Ml
	for gcvg-git@gmane.org; Sat, 05 May 2007 10:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030811AbXEEIDj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 04:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754541AbXEEIDj
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 04:03:39 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:1392 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754146AbXEEIDh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 04:03:37 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 4.50 #1 (Debian))
	id 1HkFEm-0005m3-4M; Sat, 05 May 2007 18:03:28 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1HkFEX-0003Ao-00; Sat, 05 May 2007 18:03:13 +1000
Content-Disposition: inline
In-Reply-To: <20061219003557.GA17799@gondor.apana.org.au>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46250>

On Tue, Dec 19, 2006 at 11:35:57AM +1100, herbert wrote:
> On Mon, Dec 18, 2006 at 05:45:05PM -0500, Jeff King wrote:
> > 
> > but doing it inside an interpolated string doesn't:
> > 
> > $ foo=bar}
> > $ echo "${foo%'}'}"
> > bar}'}
> 
> Yes it's a bug in dash.  Both quote marks (" and ') are represented
> by the same char internally before processing which is where the
> mix-up occurs.
> 
> I'll work on a fix.

Sorry for the delay.  I've finally looked at fixing this.  It turns out
that dash's behaviour is actually correct and POSIX compliant.

It's correct because dash treats all single quotes within double
quotes (except those within command substitutions) as literals.
This interpretation is also supported by POSIX.

In fact the rationale (C.2.2.3) in the POSIX document explicitly
disallows the aformentioned usage as it violates the rule that an
even number of single quotes if any can occur in an ${...} expression
enclosed by double quotes.

So the correct and portable expression in this case would be either

echo "${foo%\}}"

or

brace=}
echo "${foo%$brace}"

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
