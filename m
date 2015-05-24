From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] stat_validity: handle non-regular files
Date: Sun, 24 May 2015 04:29:35 -0400
Message-ID: <20150524082935.GB8718@peff.net>
References: <20150522235116.GA4300@peff.net>
 <20150522235143.GA4818@peff.net>
 <55605DB6.6040909@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: steve.norman@thomsonreuters.com, pclouds@gmail.com,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun May 24 10:29:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwRI0-0004gj-VB
	for gcvg-git-2@plane.gmane.org; Sun, 24 May 2015 10:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbbEXI3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2015 04:29:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:35334 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751249AbbEXI3i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2015 04:29:38 -0400
Received: (qmail 14605 invoked by uid 102); 24 May 2015 08:29:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 May 2015 03:29:38 -0500
Received: (qmail 31541 invoked by uid 107); 24 May 2015 08:29:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 May 2015 04:29:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 May 2015 04:29:35 -0400
Content-Disposition: inline
In-Reply-To: <55605DB6.6040909@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269826>

On Sat, May 23, 2015 at 01:00:06PM +0200, Michael Haggerty wrote:

> I don't have any insight about whether mtimes are reliable change
> indicators for directories.
> 
> But if you make this change, you are changing the contract of the
> stat_validity functions:
> 
> * Have you verified that no callers rely on the old stat_validity's
> check that the file is a regular file?

I think they are OK if a directory appears (they notice the error in
reading and call stat_validity_clear to throw away the result). But it
would be a problem, I suppose, if you put a FIFO or something into
$GIT_DIR/packed-refs. OTOH, that would suffer from the stat data
changing constantly, so we would fall back to safe behavior.

I don't know how careful we want to be. I guess the conservative choice
would be to barf if it's not a file or directory, both of which can be
handled pretty sanely.

> * The docstrings in cache.h need to be updated.

Thanks, will fix if I re-roll (I'm still not convinced this is a robust
thing to be doing overall).

> >  struct stat_validity {
> > -	struct stat_data *sd;
> > +	struct stat_data sd;
> > +	unsigned mode;
> >  };
> 
> Could the mode be stored directly in stat_data?

I'd rather not. stat_data is shared with the cache_entry code, which
holds the mode separately. I'd like to avoid impacting the index code at
all.

> By comparing modes, you are not only comparing file type (S_ISREG vs
> S_ISDIR etc.) but also all of the file permissions. That seems OK with
> me but you might want to document that fact. Plus, I don't know whether
> POSIX allows additional, implementation-defined information to be stored
> in st_mode. If so, you would be comparing that, too.

Yeah, I considered that. My feeling is that testing _more_ information
is probably OK. Even if there is extra data there, it presumably doesn't
change from call to call of stat() unless the directory changes. And if
we are wrong, we fail safely (e.g., if the permissions change we don't
technically need to re-read the pack directory, but it is OK to do so).

-Peff
