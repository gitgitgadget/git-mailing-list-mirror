From: Jeff King <peff@peff.net>
Subject: Re: infinite loop in git-send-email with alias files
Date: Thu, 23 Jul 2009 09:54:09 -0400
Message-ID: <20090723135408.GA22317@coredump.intra.peff.net>
References: <8bd0f97a0907161810w22726ffdye5c8d64719b77b53@mail.gmail.com>
 <20090723110928.GC4247@coredump.intra.peff.net>
 <4A6857FF.5070401@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Frysinger <vapier.adi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jul 23 15:54:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTykZ-0005sx-Gj
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 15:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbZGWNyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 09:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbZGWNyM
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 09:54:12 -0400
Received: from peff.net ([208.65.91.99]:42834 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751587AbZGWNyL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 09:54:11 -0400
Received: (qmail 10938 invoked by uid 107); 23 Jul 2009 13:56:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 23 Jul 2009 09:56:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jul 2009 09:54:09 -0400
Content-Disposition: inline
In-Reply-To: <4A6857FF.5070401@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123870>

On Thu, Jul 23, 2009 at 02:30:55PM +0200, Johannes Sixt wrote:

> Jeff King schrieb:
> > +my %EXPANDED_ALIASES;
> > +sub expand_one_alias {
> > +	my $alias = shift;
> > +	if ($EXPANDED_ALIASES{$alias}) {
> > +		die "fatal: alias '$alias' expands to itself\n";
> > +	}
> > +	local $EXPANDED_ALIASES{$alias} = 1;
> > +	return $aliases{$alias} ? expand_aliases(@{$aliases{$alias}}) : $alias;
> 
> What does 'local' make local here? Only the assignment of the slot
> $EXPANDED_ALIASES{$alias}? Or the whole %EXPANDED_ALIASES? If the latter,
> does this copy the existing %EXPANDED_ALIASES before the assignment is
> made; otherwise, how can this work if only ever a single slot of
> %EXPANDED_ALIASES is filled in?

It localizes just that slot. But remember that 'local' is about
_dynamic_ scoping, not _lexical_ scoping. So that slot is now set for
the duration of the expand_one_alias call, and is visible to its
subroutines (i.e., the recursive calls). So each level of recursion sets
one more field in $EXPANDED_ALIASES, and when we leave the function,
perl automatically restores it to its previous value.

-Peff
