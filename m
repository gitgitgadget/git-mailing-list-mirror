From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Thu, 18 Apr 2013 14:00:18 -0400
Message-ID: <20130418180017.GA5714@sigill.intra.peff.net>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
 <87txn5xzdn.fsf@linux-k42r.v.cablecom.net>
 <7vd2ttgoyr.fsf@alter.siamese.dyndns.org>
 <87wqs1xi9h.fsf@hexa.v.cablecom.net>
 <7vk3o1f5kb.fsf@alter.siamese.dyndns.org>
 <7vwqs1dnxp.fsf@alter.siamese.dyndns.org>
 <20130417201056.GA2914@sigill.intra.peff.net>
 <7va9owd3d1.fsf@alter.siamese.dyndns.org>
 <20130418172714.GA24690@sigill.intra.peff.net>
 <7vd2tr6833.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 20:00:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USt8E-0001us-Kf
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 20:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab3DRSAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 14:00:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:43426 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428Ab3DRSAV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 14:00:21 -0400
Received: (qmail 8091 invoked by uid 102); 18 Apr 2013 18:00:25 -0000
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (75.15.5.89)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Apr 2013 13:00:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Apr 2013 14:00:18 -0400
Content-Disposition: inline
In-Reply-To: <7vd2tr6833.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221679>

On Thu, Apr 18, 2013 at 10:51:12AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +static const char *add_would_remove_warning = N_(
> > +/* indent for "warning: " */
> > +         "In Git 2.0, 'git add <pathspec>...' will also update the\n"
> > +"index for paths removed from the working tree that match the given\n"
> > +"pathspec. If you want to 'add' only changed or newly created paths,\n"
> > +"say 'git add --no-all <pathspec>...' instead.\n");
> > +
> >  static void warn_add_would_remove(const char *path)
> >  {
> > -	warning(_("In Git 2.0, 'git add <pathspec>...' will also update the\n"
> > -		  "index for paths removed from the working tree that match\n"
> > -		  "the given pathspec. If you want to 'add' only changed\n"
> > -		  "or newly created paths, say 'git add --no-all <pathspec>...'"
> > -		  " instead.\n\n"
> > -		  "'%s' would be removed from the index without --no-all."),
> > -		path);
> > +	static int warned_once;
> > +	if (!warned_once++)
> > +		warning(_(add_would_remove_warning));
> > +	warning("did not stage removal of '%s'", path);
> >  }
> 
> Would "add --dry-run" say this, too?

It probably makes sense to continue to have the warning in the dry-run
case, but it may make sense to tweak it grammatically when we are in
dry-run mode. Saying "would stage removal" is technically correct, but I
think it is somewhat ambiguous: would git do it if we were not in a
--dry-run, or would git do it if it were Git 2.0?

Doing it as:

  warning: not staging removal of '%s'

could work for both cases. Something like "not considering" (or another
synonym for "considering") might be even more accurate. It is not just
that we did not stage it; it is what we did not even consider it an item
for staging under the current rules.

Note that the "not staging" warnings may potentially be interspersed
with the normal dry-run output. I think that's OK. But another
alternative would be to collect the paths and then print:

  warning: In Git 2.0, ...

  The following deleted paths were not considered under the current
  rule. Use "git add -A" to stage their removal now.

    foo
    bar

-Peff
