From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Try harder to find a remote when on a detached HEAD or
 non-tracking branch.
Date: Tue, 19 Jun 2012 16:12:59 -0400
Message-ID: <20120619201259.GB14692@sigill.intra.peff.net>
References: <1340038866-24552-1-git-send-email-marcnarc@xiplink.com>
 <7vaa004j9f.fsf@alter.siamese.dyndns.org>
 <4FDFA030.7080408@xiplink.com>
 <7vmx402rru.fsf@alter.siamese.dyndns.org>
 <4FE08797.50509@xiplink.com>
 <7vipen191a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 22:13:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh4nV-00053O-Ph
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 22:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892Ab2FSUND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 16:13:03 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:32974
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753762Ab2FSUNC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 16:13:02 -0400
Received: (qmail 12928 invoked by uid 107); 19 Jun 2012 20:13:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Jun 2012 16:13:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2012 16:12:59 -0400
Content-Disposition: inline
In-Reply-To: <7vipen191a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200238>

On Tue, Jun 19, 2012 at 10:55:13AM -0700, Junio C Hamano wrote:

> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
> > On 12-06-18 06:12 PM, Junio C Hamano wrote:
> > ...
> >> That reliance of "origin" is what made me think that "not guessing
> >> and blindly assuming" a wrong thing to do.
> >
> > I think git can do better than erroring out, though.
> >
> >> It is OK that your build usesdetached HEAD, but if that is the case
> >> shoudln't it be the one deciding which specific remote it wants to
> >> take the updated sources from, and telling Git to do so?
> >
> > Sure, but I feel it did that already when it cloned.  It seems reasonable for
> > the submodules to default to using the remote specified when the super-repo
> > was cloned.
> 
> I do not have a strong opinion either way, other than that I would
> prefer predictable behaviour over "works most of the time provided
> if the user does X, otherwise does this random thing".  And coming
> from that standpoint, erroring out when there needs a guess involved
> is certainly more predictable---it is a cop-out option for me in
> areas of the system I do not have strong preferences.

One thing that makes me nervous about this patch is that it is not just a
change to git-submodule, but rather to git-parse-remote.  So it could
affect other parts of the system, too, where a guess might not be as
desirable.

The number of affected code paths is fortunately quite small, since this
is updating the shell library, and most of the remote-handling code is
written in C these days. But it raises a few questions:

  1. git-pull can call into get_default_remote via get_remote_merge_branch.
     Is it impacted by this change?

  2. We install git-parse-remote as part of the plumbing API. Do we know
     of any other 3rd-party scripts that use this interface and might be
     affected?

  3. The C code sets up remote.c:default_remote_name, which defaults to
     "origin". Should this be consistent with what git-parse-remote
     does?

Should this be a submodule-only thing?

-Peff
