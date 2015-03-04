From: Jeff King <peff@peff.net>
Subject: Re: git describe --contains doesn't work properly for a commit
Date: Wed, 4 Mar 2015 13:05:29 -0500
Message-ID: <20150304180529.GA28074@peff.net>
References: <20150226133534.GB14878@dhcp22.suse.cz>
 <20150226142314.GC14878@dhcp22.suse.cz>
 <20150304105408.GA19693@peff.net>
 <54F71F69.3080500@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michal Hocko <mhocko@suse.cz>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 04 19:05:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTDfu-0006w2-TU
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 19:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756984AbbCDSFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 13:05:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:56415 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754279AbbCDSFd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 13:05:33 -0500
Received: (qmail 25562 invoked by uid 102); 4 Mar 2015 18:05:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 12:05:32 -0600
Received: (qmail 815 invoked by uid 107); 4 Mar 2015 18:05:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 13:05:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Mar 2015 13:05:29 -0500
Content-Disposition: inline
In-Reply-To: <54F71F69.3080500@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264766>

On Wed, Mar 04, 2015 at 04:06:17PM +0100, Michael J Gruber wrote:

> >   3. Introduce a more trust-worthy mechanism for ordering commits. The
> >      timestamp here is really just a proxy for the oft-discussed
> >      "generation number" of the commit within the graph. We've avoided
> >      adding generation numbers because of the storage/complexity issues.
> 
> Hmmh.
> 
> Storage: one int (or maybe less) per commit doesn't sound too bad. We
> can probably do without on bare repos by default.
> 
> Complexity: Was that due to replace refs? Other than that, it seemed to
> be simple: max(parent generation numbers)+1.

Calculating them is simple. Caching and storage is the bigger question.
When we do we generate them? Where do we store them? What do we do with
replace-refs and grafts?

I think the answers are "at repack time", "in an auxiliary file alongside
the pack idx", and "we turn it off completely when these features are in
use".

See:

  http://thread.gmane.org/gmane.comp.version-control.git/214916

for a sample implementation.

> ... or can reachability bitmaps help???

Sometimes. If you are asking about --contains traversals, then bitmaps
can let you stop the traversal early. We have some patches that do this
that are running in production at GitHub, but they are kind of gnarly.
One of my goals is to clean them up and get them upstream.

It's also part of why I didn't pursue the series above further. Making
"--contains" faster is one goal, but making "rev-list --objects --all"
faster was more important (since we do it for every fetch). And making
commits faster is only half the equation there.

-Peff
