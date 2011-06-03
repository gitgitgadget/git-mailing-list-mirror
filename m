From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Added a remote helper to interact with mediawiki,
 pull & clone handled
Date: Thu, 2 Jun 2011 23:43:48 -0400
Message-ID: <20110603034348.GA1371@sigill.intra.peff.net>
References: <1307006911-4326-1-git-send-email-arnaud.lacurie@ensimag.imag.fr>
 <20110602170327.GA2928@sigill.intra.peff.net>
 <vpqy61jami7.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	git@vger.kernel.org,
	=?utf-8?B?SsOpcsOpbWll?= Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Sylvain =?utf-8?Q?Boulm=C3=A9?= <sylvain.boulme@imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 03 05:44:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSLIn-0005tE-9S
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 05:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599Ab1FCDnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 23:43:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43227
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751574Ab1FCDnv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 23:43:51 -0400
Received: (qmail 3590 invoked by uid 107); 3 Jun 2011 03:43:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Jun 2011 23:43:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jun 2011 23:43:48 -0400
Content-Disposition: inline
In-Reply-To: <vpqy61jami7.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174994>

On Fri, Jun 03, 2011 at 12:37:04AM +0200, Matthieu Moy wrote:

> The idea is that we ultimately want to be able to import a subset of a
> large wiki. In Wikipedia, for example, "show me revisions since N" will
> be very large after a few minutes. OTOH, "show me revisions touching the
> few pages I'm following" should be fast. And at least, it's O(imported
> wiki size), not O(complete wiki size)

Yeah, I think what you want to do is dependent on wiki size. For a small
wiki, it doesn't matter; all pages is not much. For a large wiki, you
want a subset of the pages, and you _never_ want to do any operations on
the whole page space. In the middle are medium-sized wikis, where you
would like look at the whole page space, but ideally not in O(number of
pages).

But the point is somewhat moot, because having just read through the
mediawiki API, I've come to the conclusion (which seems familiar
from the last time I looked at this problem) that there is no way to ask
for what I want in a single query. That is, to say "show me all
revisions of all pages matching some subset X, that have been modified
since revision N". Or even "show me all pages matching some subset X
that have been modified since revision N", and then we could at least
cull the pages that haven't been touched.

But AFAICT, none of those is possible. I think we are stuck asking for
each page's information individually (you can even query multiple pages'
revision information simultaneously, but you can get only a single
revision from each in that case. There's not even a way to say "get me
the latest revision number for all of these pages).

One thing we could do to reduce the total run-time is to issue several
queries in parallel so that the query latency isn't so prevalent. I
don't know what a good level of parallelism is for a server like
wikipedia, though. I'm sure they don't appreciate users hammering the
servers too hard. Ideally you want just enough queries outstanding that
the remote server is always working on _one_, and the rest are doing
something else (traveling across the network, local processing and
storage, etc). But I'm not sure of a good way to measure that.

> but let's not be too ambitious for now: it's a student's project,
> completing one week from now, and the goal is to have something clean
> and extensible. Bells and whistles will come later ;-).

Yes. I think all of this is outside the scope of a student project. I
just like to dream. :)

-Peff
