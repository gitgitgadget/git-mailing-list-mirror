From: Jeff King <peff@peff.net>
Subject: Re: diff: --quiet does not imply --exit-code if --diff-filter is
 present
Date: Tue, 31 May 2011 12:25:46 -0400
Message-ID: <20110531162546.GA11321@sigill.intra.peff.net>
References: <87wrh7jgzk.wl@dns1.atmark-techno.com>
 <20110531153356.GB2594@sigill.intra.peff.net>
 <7vvcwqkh4a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yasushi SHOJI <yashi@atmark-techno.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 31 18:25:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRRlS-0005fL-Av
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 18:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757455Ab1EaQZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 12:25:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37096
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757396Ab1EaQZs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 12:25:48 -0400
Received: (qmail 26250 invoked by uid 107); 31 May 2011 16:25:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 31 May 2011 12:25:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 May 2011 12:25:46 -0400
Content-Disposition: inline
In-Reply-To: <7vvcwqkh4a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174811>

On Tue, May 31, 2011 at 08:46:29AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Commit 2cfe8a6 (diff --quiet: disable optimization when
> > --diff-filter=X is used, 2011-03-16) fixes this in some
> > cases by disabling the optimization when a filter is
> > present. However, it only tweaked run_diff_files, missing
> > the similar case in diff_tree. Thus the fix worked only for
> > diffing the working tree and index, but not between trees.
> 
> Thanks; a natural question is if we need the same for diff-index, then.

No, it calls straight into unpack_trees. So I think the question is
"should unpack_trees respect the QUICK optimization". I suspect it
didn't happen simply because unpack_trees is so complex, and there are
probably corner cases with merging.

> We probably want to have a helper in diff.c that does
> 
> 	int diff_can_quit_early(struct diff_options *opt)
>         {
>         	return (DIFF_OPT_TST(opt, QUICK) &&
>                 	!opt->filter &&
>                         DIFF_OPT_TST(opt, HAS_CHANGES));
> 	}
> 
> It is possible for us to later add new diffcore transformations that need
> a similar "do not stop feeding early, as results may be filtered".

Yeah, that is a good refactoring. It's more readable, and it would have
prevented this bug. :)

-Peff
