From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/10] check_repository_format_gently: stop using
 git_config_early
Date: Thu, 3 Mar 2016 13:27:58 -0500
Message-ID: <20160303182758.GB24171@sigill.intra.peff.net>
References: <20160301143546.GA30806@sigill.intra.peff.net>
 <20160301144039.GD12887@sigill.intra.peff.net>
 <CACsJy8Cvap9sJ39LnOCp5hMdYgoNR_HD18br+wWTWAZrCBaXaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 19:28:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abXyq-00005H-Gr
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 19:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757035AbcCCS2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 13:28:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:54306 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755214AbcCCS2B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 13:28:01 -0500
Received: (qmail 8646 invoked by uid 102); 3 Mar 2016 18:28:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Mar 2016 13:28:00 -0500
Received: (qmail 8368 invoked by uid 107); 3 Mar 2016 18:28:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Mar 2016 13:28:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Mar 2016 13:27:58 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8Cvap9sJ39LnOCp5hMdYgoNR_HD18br+wWTWAZrCBaXaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288201>

On Thu, Mar 03, 2016 at 08:08:40PM +0700, Duy Nguyen wrote:

> On Tue, Mar 1, 2016 at 9:40 PM, Jeff King <peff@peff.net> wrote:
> > There's a chicken-and-egg problem with using the regular
> > git_config during the repository setup process. We get
> > around it here by using a special interface that lets us
> > specify the per-repo config, and avoid calling
> > git_pathdup().
> >
> > But this interface doesn't actually make sense. It will look
> > in the system and per-user config, too; we definitely would
> > not want to accept a core.repositoryformatversion from
> > there.
> >
> > The git_config_from_file interface is a better match, as it
> > lets us look at a single file.
> 
> Let's see. We look at core.worktree, core.bare,
> core.repositoryformatversion, and extensions.* in this code. The first
> three should definitely per-repo (and should be mentioned in the
> commit as well). But what about the last one? Any possible use case
> that wants to enable, say extensions.preciousobjects, for all repos?
> Yes we would need to switch core.repo..version to 1 to take effect,
> but that does not actually eliminate this case.. just thinking out
> loud...

I thought about that; a more likely use is to set extensions.refStorage
once it exists, to use your preferred backend everywhere. But it _has_
to match what's in the repository's on-disk format. Setting it in your
~/.gitconfig is going to break all of your existing repositories using
another backend.

So the right thing is to have init.refStorage or something, and have
init/clone default to that when creating the repo, and set up the
correct extensions.refStorage config _and_ set up the on-disk ref
storage to match.

-Peff
