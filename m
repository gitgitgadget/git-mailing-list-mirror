From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 14/15] ident: trim whitespace from default name/email
Date: Tue, 22 May 2012 13:12:04 -0400
Message-ID: <20120522171204.GB11600@sigill.intra.peff.net>
References: <20120521230917.GA474@sigill.intra.peff.net>
 <20120521231029.GN10981@sigill.intra.peff.net>
 <7vipfo5f60.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 22 19:12:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWsd3-0004kr-Qn
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 19:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557Ab2EVRMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 13:12:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51814
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481Ab2EVRMI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 13:12:08 -0400
Received: (qmail 19926 invoked by uid 107); 22 May 2012 17:12:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 May 2012 13:12:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 May 2012 13:12:04 -0400
Content-Disposition: inline
In-Reply-To: <7vipfo5f60.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198207>

On Tue, May 22, 2012 at 09:55:19AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... Any other value
> > comes from a config file, where we will have cleaned up
> > accidental whitespace already.
> 
> Are you referring to the behaviour of the config parser that removes
> leading and trailing whitespaces when reading an unquoted string value?

Yes, exactly.

> If the user really wanted to have trailing whitespaces by quoting, we
> would let it pass, in other words; it probably is a reasonable behaviour.

Right, that's why I said "accidental" above; you can still do it, but I
think you'd have to be really trying. But I really wonder if we should
be blocking that, too. fmt_ident will drop it anyway, so this is really
only for code paths that want to use the email directly.

> The same can be said about the environment variable GIT_COMMITTER_NAME and
> friends, but "accidental whitespaces are cleaned up already" does not
> apply to them.

Yes, but those variables don't hit this code path at all. They go
straight to fmt_ident, which does the cleanup.  If you have code like
this:

  email = getenv("GIT_COMMITTER_EMAIL");
  if (!email)
          email = ident_default_email();

you might have trim-able spaces in the getenv result, and nobody is
handling that (fmt_ident does, but accessing it directly does not).
We could go a step further and replace ident_default_email with a
git_committer_email() which does the above, plus any whitespace
trimming.

> So, isn't the real rationale behind this choice to allow users who give
> leading or trailing whitespaces in the configuration and environment
> variables on purpose use whatever value they specified?

To be honest, the real rationale was laziness and a desire to keep the
interfaces simple. The risky code path (in my opinion) for getting extra
whitespace is pulling data from gecos, or from a file like
/etc/mailname. IOW, my intent was to block common accidents, but not
worry about somebody intentionally trying to push whitespace through.

> I agree with the placement of trimming in this patch, but I do not quite
> get (I do not mean "I do not agree with") what the quoted sentence wanted
> to say.
> 
> Other than that single small "hrm...", the entire series was a pleasant
> read.  Thanks.

Thanks. I'm happy to update this patch if we want it to be more
paranoid, or I can update the commit message if it just needs explained
better.

-Peff
