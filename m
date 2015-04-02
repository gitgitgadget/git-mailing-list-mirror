From: Jeff King <peff@peff.net>
Subject: Re: git 2.3.4, ssh: Could not resolve hostname
Date: Thu, 2 Apr 2015 15:14:52 -0400
Message-ID: <20150402191452.GA20420@peff.net>
References: <56B33978-76A0-4EE0-BCC0-EF030FD52E41@rawsound.com>
 <20150402180914.GA19081@peff.net>
 <201C57EF-FC96-4FFB-81D2-90F94428A6CA@rawsound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: "Reid Woodbury Jr." <reidw@rawsound.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 21:15:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdkZw-0006hd-JZ
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 21:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbbDBTO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 15:14:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:41498 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751066AbbDBTOz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 15:14:55 -0400
Received: (qmail 13937 invoked by uid 102); 2 Apr 2015 19:14:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Apr 2015 14:14:55 -0500
Received: (qmail 14570 invoked by uid 107); 2 Apr 2015 19:15:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Apr 2015 15:15:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Apr 2015 15:14:52 -0400
Content-Disposition: inline
In-Reply-To: <201C57EF-FC96-4FFB-81D2-90F94428A6CA@rawsound.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266659>

On Thu, Apr 02, 2015 at 11:58:13AM -0700, Reid Woodbury Jr. wrote:

> The colons were part of the output. The 'xxxx' replaces the domain in
> the response.

OK, if the double colons are correct, then that is almost certainly the
problem:

  $ ssh does-not-exist
  ssh: Could not resolve hostname does-not-exist: No address associated with hostname
  $ ssh does-not-exist:
  ssh: Could not resolve hostname does-not-exist:: No address associated with hostname

> The domain is an internal one that my client would rather keep private.

Can you give us a hint as to the format of your remote URL? This "works":

  $ git push does-not-exist:repo.git
  ssh: Could not resolve hostname does-not-exist: No address associated with hostname

in the sense that it looks up the right hostname (which is of course
nonsense, but note the single colon in the error message). So does:

  $ git push ssh://does-not-exist/repo.git
  ssh: Could not resolve hostname does-not-exist: No address associated with hostname

but this does not:

  $ git push ssh://does-not-exist:/repo.git
  ssh: Could not resolve hostname does-not-exist:: No address associated with hostname

(note the doubled colon). v2.3.3 did strip off that extra colon, but I
am not sure the URL above (i.e., a colon with no hostname) is actually
sane. IOW, it may have happened to work in older versions, but I'm not
sure we would want to promise to keep it working.

Can you show us what your URL looks like, obfuscating the names but
keeping the syntax the same? Also, are you using the "insteadOf" config
syntax at all (which could easily lead to funny splicing, I imagine).

> But this got me to think that this might be an
> important detail: I am using GIT from a remote node on a Cisco
> AnyConnect VPN with DNS served by ActiveDirectory.

If the extra colon is indeed the problem, I don't think the DNS setup is
relevant. The name git is feeding to ssh is bogus.

-Peff
