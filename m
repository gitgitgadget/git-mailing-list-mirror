From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push: Learn to set up branch tracking with '--track'
Date: Thu, 29 Jan 2009 17:33:08 -0500
Message-ID: <20090129223308.GB12871@coredump.intra.peff.net>
References: <cover.1233236267u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901291438030.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 29 23:35:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSfT3-0005kK-0k
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 23:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbZA2WdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 17:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753310AbZA2WdL
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 17:33:11 -0500
Received: from peff.net ([208.65.91.99]:50923 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738AbZA2WdK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 17:33:10 -0500
Received: (qmail 19883 invoked by uid 107); 29 Jan 2009 22:33:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 29 Jan 2009 17:33:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2009 17:33:08 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901291438030.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107740>

On Thu, Jan 29, 2009 at 02:38:43PM +0100, Johannes Schindelin wrote:

> When pushing a branch to a remote repository that the remote side did
> not know beforehand, it is often handy to set up the branch tracking
> such that
> 
> 	$ git checkout xyz
> 	$ git push --track origin xyz:abc
> 	$ git pull
> 
> will pull the branch 'abc' from the remote 'origin' into the branch
> 'xyz'.

What if "xyz" is a tag? Right now, the patch generates a bogus config
section. Yes, you can say "don't use --track, then". But I can think two
reasons why that isn't acceptable:

  1. You might be pushing multiple things, one of which is a branch
     and one of which is not.

  2. This is likely to grow a related config variable, similar to
     branch.autosetupmerge.

How about "git push --track origin HEAD"? This also generates bogus
config. How about "git push --track origin refs/heads/*:refs/heads/*"?
Also bogus.

It looks like you catch "git push --track --all". So at least there is
no bogus config generated. But it would be nice to translate this to
"create a tracking branch for everything I pushed".

So I think this patch is going about it the wrong way. Instead of
parsing the refspec, I think you actually want to look at what we _do_
push (or at least try to push -- probably even uptodate refs should also
have tracking established), and use that. Then you will have wildcards
expanded, --all handled, etc. And I suspect all you have to do is
iterate over the result of match_refs (which we call later), which
should be even easier (because you don't have to parse the refspecs
yourself). But I haven't looked carefully.

> +		if (!err && track)
> +			setup_tracking(transport->url);

Wouldn't the remote name (if we have one) be preferable to the URL? As
it is, doing "git push --track origin master" results in

  [branch "master"]
    remote = $YOUR_URL_FOR_ORIGIN
    merge = refs/heads/master

which means that:

  1. If you ever change remote.origin.url, it will not propagate to your
     branch section.

  2. When you fetch, you are fetching into FETCH_HEAD, meaning your
     tracking refs are not updated.

-Peff
