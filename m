From: Jeff King <peff@peff.net>
Subject: Re: git clone (ssh://) skips detached HEAD
Date: Wed, 1 Jun 2011 18:51:28 -0400
Message-ID: <20110601225128.GB16820@sigill.intra.peff.net>
References: <BANLkTi=xK+hmvGTLnKREScABU=7v_SKqPQ@mail.gmail.com>
 <20110601220518.GA32681@sigill.intra.peff.net>
 <m31uzdxjf9.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 00:51:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRuGG-0003Pj-3Q
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 00:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758523Ab1FAWvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 18:51:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57699
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758085Ab1FAWva (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 18:51:30 -0400
Received: (qmail 18820 invoked by uid 107); 1 Jun 2011 22:51:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Jun 2011 18:51:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2011 18:51:28 -0400
Content-Disposition: inline
In-Reply-To: <m31uzdxjf9.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174915>

On Wed, Jun 01, 2011 at 03:42:58PM -0700, Jakub Narebski wrote:

> > The reason is that the default refspec on clone is:
> > 
> >   $ git config remote.origin.fetch
> >   +refs/heads/*:refs/remotes/origin/*
> > 
> > And HEAD is not under refs/heads/.
> 
> Hmmm... HEAD is a bit of special case, as HEAD should really land in
> refs/remotes/origin/HEAD from what I understand.

No, that is always supposed to be a symbolic ref. Making it a real ref
would be confusing. I don't think fetch should look at HEAD at all; it's
outside its refspec. However, clone does treat HEAD specially, and
should probably convert the remote's detached HEAD into a local detached
HEAD (we already do if it's part of referenced history).

> > > git clone ssh://127.0.0.1/`pwd`/test test2
> > > remote: Counting objects: 3, done.
> > > remote: Total 3 (delta 0), reused 0 (delta 0)
> > > Receiving objects: 100% (3/3), done.
> > > error: Trying to write ref HEAD with nonexistant object
> > > 91dbc2403853783f637744c31036f94a66084286
> > > fatal: Cannot update the ref 'HEAD'.
> > 
> > This is quite bad behavior. In addition to the ugly error messages, it
> > actually aborts the clone. So it is impossible to clone a repo with a
> > detached HEAD that is not otherwise referenced.
> 
> It _might_ be the case that the fact that git protocol doesn't have
> mechanism to transfer information about symref, and ends up guessing
> where HEAD points to, bites use here.

No, we already handle that case. If there is a valid HEAD and no ref
matches, then we assume it's a detached HEAD. Which makes sense, and the
guess is right in this case. The problem is that we didn't fetch the
objects for HEAD.

-Peff
