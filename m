From: Jeff King <peff@peff.net>
Subject: Re: propagating repo corruption across clone
Date: Wed, 27 Mar 2013 16:04:06 -0400
Message-ID: <20130327200406.GA5124@sigill.intra.peff.net>
References: <CACsJy8A0eOWEJ2aqPSLof_CodJM6BadFxQHy5Vb0kAwwTSTS3w@mail.gmail.com>
 <20130325155600.GA18216@sigill.intra.peff.net>
 <CAOx6V3a6vGJvJ4HEmAXdTRKKCzRJS23OYd_em1b3aQLzPNEtQA@mail.gmail.com>
 <20130325200752.GB3902@sigill.intra.peff.net>
 <CAOx6V3ZWB1ZpmXcaBeSaPOvHqmAMF3U1rTXuwinFGmEZQwFGYQ@mail.gmail.com>
 <20130326165553.GA7282@sigill.intra.peff.net>
 <1364340037755-7580771.post@n2.nabble.com>
 <20130327012515.GC28148@google.com>
 <1364408595621-7580839.post@n2.nabble.com>
 <20130327194938.GB26380@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Rich Fromm <richard_fromm@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 21:04:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKwaS-0005kq-2K
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 21:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754418Ab3C0UEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 16:04:13 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41867 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754405Ab3C0UEM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 16:04:12 -0400
Received: (qmail 17878 invoked by uid 107); 27 Mar 2013 20:05:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Mar 2013 16:05:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Mar 2013 16:04:06 -0400
Content-Disposition: inline
In-Reply-To: <20130327194938.GB26380@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219321>

On Wed, Mar 27, 2013 at 03:49:38PM -0400, Jeff King wrote:

> On Wed, Mar 27, 2013 at 11:23:15AM -0700, Rich Fromm wrote:
> 
> > But I'm still somewhat confused about what is and is not checked under what
> > conditions.  Consider the three statements:
> > 
> > # 1
> > git clone --mirror myuser@myhost:my_repo
> > 
> > # 2
> > git clone --mirror --config transfer.fsckObjects=true myuser@myhost:my_repo
> > 
> > # 3
> > git clone --mirror myuser@myhost:my_repo && cd my_repo.git && git-fsck
> > 
> > Are 2 and 3 equivalent?  Or is there an increasing level of checking that
> > occurs from 1 to 2, and from 2 to 3?  My guess is the latter, but perhaps
> > this could be clearer in the man pages.
> 
> 2 and 3 are not exactly equivalent, in that they are implemented
> slightly differently, but I do not know offhand of any case that would
> pass 2 but not 3. We do check reachability with transfer.fsckObjects.

Oh, and in the case of #1, I think we would already find corruption, in
that index-pack will expand and check the sha1 of each object we
receive. The transfer.fsckObjects check adds some semantic checks as
well (e.g., making sure author identities are well-formed).

Clone will not currently detect missing objects and reachability
without transfer.fsckObjects set, but that is IMHO a bug; fetch will
notice it, and clone should behave the same way.

-Peff
