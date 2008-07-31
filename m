From: Jeff King <peff@peff.net>
Subject: Re: git blame not respecting --find-copies-harder ?
Date: Thu, 31 Jul 2008 05:03:49 -0400
Message-ID: <20080731090348.GB20691@sigill.intra.peff.net>
References: <20080730093903.GA14330@cuci.nl> <20080730150123.GB9758@atjola.homenet> <bd6139dc0807300843l1d42d6fep95f6c99fe6e0ea0@mail.gmail.com> <20080731064814.GA32431@sigill.intra.peff.net> <7vfxpq3559.fsf@gitster.siamese.dyndns.org> <20080731072149.GA2304@sigill.intra.peff.net> <7v8wvi33ok.fsf@gitster.siamese.dyndns.org> <20080731082553.GA19522@sigill.intra.peff.net> <7v8wvizc16.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sverre@rabbelier.nl,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 11:04:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOU5b-0000C4-8M
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 11:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbYGaJDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 05:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752437AbYGaJDu
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 05:03:50 -0400
Received: from peff.net ([208.65.91.99]:1732 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751455AbYGaJDu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 05:03:50 -0400
Received: (qmail 22361 invoked by uid 111); 31 Jul 2008 09:03:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 31 Jul 2008 05:03:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jul 2008 05:03:49 -0400
Content-Disposition: inline
In-Reply-To: <7v8wvizc16.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90914>

On Thu, Jul 31, 2008 at 01:35:33AM -0700, Junio C Hamano wrote:

> > @@ -1002,7 +1002,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
> >  	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk"))
> >  	{
> >  		unkv[(*unkc)++] = arg;
> > -		return 0;
> > +		return 1;
> >  	}
> >  
> >  	if (!prefixcmp(arg, "--max-count=")) {
> >
> > That is, handle_revision_opt says "yes we parsed this, and it should be
> > gone" even though it still gets stuck in the "unknown" section to be
> > parsed by setup_revisions later.
> 
> Hmm, wouldn't that suggest it needs to return 1 when an option candidate
> given to diff_opt_parse() turns out not to be a diff option and stuffed
> back to unkv[] at the end of this function?

Not necessarily. The logic there goes:

  1. it's not a revision option, so pass to diff
  2. it's not a diff opt, so it is unknown; we parsed no options
  3. the caller sees we failed to parse, so it barfs

but the logic here is:

  1. it _is_ a revision option. Our handling of it is just a little odd,
     in that we need to parse it later, when we are in setup_revisions.
     So put it aside for now as a "revision" that just happens to look
     like an option.
  2. caller sees we parsed, and doesn't complain
  3. caller later passes the "revision" to setup_revisions, which knows
     what to do

Now my patch doesn't just operate on "--all", but rather several other
options including --no-walk. And maybe that is not right, and --all
should be handled separately (though I think --remotes would follow the
same logic). I'm not really sure why --no-walk is separated like that.

-Peff
