From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6] log: pass rev_info to git_log_config()
Date: Fri, 5 Oct 2012 11:33:41 -0400
Message-ID: <20121005153341.GA24957@sigill.intra.peff.net>
References: <7v626r48cv.fsf@alter.siamese.dyndns.org>
 <1349314419-8397-1-git-send-email-gitster@pobox.com>
 <1349314419-8397-6-git-send-email-gitster@pobox.com>
 <7v1uhe3efa.fsf@alter.siamese.dyndns.org>
 <7vk3v5v9ip.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 17:34:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK9uX-0007d6-Sv
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 17:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756528Ab2JEPdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 11:33:46 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42016 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756154Ab2JEPdo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 11:33:44 -0400
Received: (qmail 32047 invoked by uid 107); 5 Oct 2012 15:34:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Oct 2012 11:34:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Oct 2012 11:33:41 -0400
Content-Disposition: inline
In-Reply-To: <7vk3v5v9ip.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207110>

On Thu, Oct 04, 2012 at 09:16:14PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > So we would need to do something like:
> >
> >     - call git_log_config() first to let diff_context_default
> >       updated from the configuration as before.  find the values of
> >       grep.* defaults at the same time, but stash it away in a
> >       separate "struct grep_opt" (yuck);
> >
> >     - call init_revisions() and let it initialize revs->grep_filter
> >       and revs->diffopt as before;
> >
> >     - copy the grep.* defaults we learned during git_log_config() to
> >       revs->grep_filter.
> >
> > which is a bit yucky, but survivable.
> 
> After thinking about it a bit more, I came to a conclusion that the
> configuration handling lifted from builtin/grep.c needs a much
> larger overhaul.
> [...]
> The right way to arrange your configuration callback is probably to
> model it after how diff configuration variables are handled.  You
> call git_config() once, and remember the values you read in set of
> static variables. Later, whenever you need to instantiate a grep_opt,
> you initialize it from these static variables.

Agreed. Maybe the simplest thing would be to have grep_config fill in a
"static struct grep_opt grep_defaults", and then memcpy that into place
during init_revisions?

-Peff
