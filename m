From: Jeff King <peff@peff.net>
Subject: Re: [RFC] How to pass Git config command line instructions to
 Submodule commands?
Date: Thu, 28 Apr 2016 08:17:53 -0400
Message-ID: <20160428121753.GA5023@sigill.intra.peff.net>
References: <60724588-B06E-47E8-9302-8709C4601826@gmail.com>
 <CAGZ79kYmAr-O6_Jw2KO9eZEfZQ+_WBiERF=nhOYLJCZpUjSSyA@mail.gmail.com>
 <CA+P7+xoaqNF+uBHVnD2QR7j-=0Hyvd-scTc_vOdV+etC0VS9jA@mail.gmail.com>
 <20160425212449.GA7636@sigill.intra.peff.net>
 <017AA7DB-5224-49C3-A4A6-6C93005BF006@gmail.com>
 <20160428112511.GA11522@sigill.intra.peff.net>
 <20160428120504.GA22399@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Users <git@vger.kernel.org>, Jens.Lehmann@web.de
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 14:18:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avktP-0000QJ-6w
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 14:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbcD1MR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 08:17:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:58233 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753500AbcD1MR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 08:17:56 -0400
Received: (qmail 21363 invoked by uid 102); 28 Apr 2016 12:17:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 08:17:55 -0400
Received: (qmail 8930 invoked by uid 107); 28 Apr 2016 12:17:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 08:17:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 08:17:53 -0400
Content-Disposition: inline
In-Reply-To: <20160428120504.GA22399@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292871>

On Thu, Apr 28, 2016 at 08:05:04AM -0400, Jeff King wrote:

> So AFAICT 14111fc49 is totally broken. It doesn't actually work for
> git-submodule (because of the missing export), nor for git-fetch
> (because that skips the shell script), and the one case we are testing
> already worked without it (but probably _should_ be sanitizing the
> config, so is buggy, too).

This last bit is not quite accurate. The test in t5550 doesn't pass
without 14111fc49. But it _does_ pass if we make
sanitize_submodule_env() in the shell script a noop. That's because it
is going through clone_submodule() in the C code, which uses the C-only
prepare_submodule_repo_env().

So that case _is_ correct right now. It's just that t5550 isn't testing
the shell script part, which is broken. Probably running "git submodule
update" in the resulting clone would cover that.

And for the fetch case, we probably just need to be calling
prepare_submodule_repo_env() there, too.

-Peff
