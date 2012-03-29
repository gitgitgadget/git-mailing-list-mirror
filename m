From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Make http-backend REMOTE_USER configurable
Date: Thu, 29 Mar 2012 18:22:30 -0400
Message-ID: <20120329222230.GB1413@sigill.intra.peff.net>
References: <1333051139-14262-1-git-send-email-willsk@bnl.gov>
 <7vzkazoyk3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: William Strecker-Kellogg <willsk@bnl.gov>,
	Git List <git@vger.kernel.org>, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 00:22:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDNjs-0007vD-2b
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 00:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760106Ab2C2WWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 18:22:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39757
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759407Ab2C2WWf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 18:22:35 -0400
Received: (qmail 7292 invoked by uid 107); 29 Mar 2012 22:22:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Mar 2012 18:22:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2012 18:22:30 -0400
Content-Disposition: inline
In-Reply-To: <7vzkazoyk3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194300>

On Thu, Mar 29, 2012 at 03:02:52PM -0700, Junio C Hamano wrote:

> William Strecker-Kellogg <willsk@bnl.gov> writes:
> 
> > The http-backend looks at $REMOTE_USER and sets $GIT_COMMITTER_NAME to
> > that for use in the hooks. At our site we have a third party
> > authentication module for our proxy (Shibboleth) which sets an alternative
> > environment variable that our backend sees instead of REMOTE USER.
> >
> > This patch adds the config option http.remoteuser which changes what
> > environment variable is inspected by the http-backend code (it defaults
> > to REMOTE_USER).
> 
> What is the chain of systems that pass the authenticated ident down to
> this CGI program?  Can another part of that chain stuff the value of
> SHIBBOLETH_USER (or whatever) to REMOTE_USER before running it?
> 
> As a design, I am not convinced this is a good change.
> 
> What if the next person wants to interoperate with an authentication
> system that passes the same information via a mechanism different from
> environment variables?  This change does not help him at all, as it is
> still married to "the information has to come from an environment
> variable" limitation.
> 
> What if an authentication system can supply more appropriate committer
> ident information other than just the uesrname part?

I agree. It seems like one could just wrap http-backend in a script like
this:

  #!/bin/sh
  REMOTE_USER=$SHIBBOLETH_USER
  exec git http-backend "$@"

and that leaves way more flexibility. I think an even better thing would
be for http-backend to leave GIT_COMMITTER_* alone if it exists; that is
the usual well-known interface for setting such things. And then you
could specify a detailed committer name and email if you want, or leave
them blank to pull from $REMOTE_USER as we do now. As it is now, even if
you specify GIT_COMMITTER_EMAIL, it gets overwritten with
"$REMOTE_USER@http.$REMOTE_ADDR".

Just today, we were looking at a similar patch for GitHub (we keep
reflogs on all pushes, and we want to put useful information about the
pusher into the reflog). William's patch would not be flexible enough
for what we want to do, but setting GIT_COMMITTER_* would be easy (we
are also stuffing more information into the reflog message, but that is
a separate issue).

-Peff
