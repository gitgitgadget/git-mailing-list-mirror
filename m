From: Jeff King <peff@peff.net>
Subject: Re: ls-files --exclude broken?
Date: Wed, 15 Sep 2010 20:50:24 -0400
Message-ID: <20100916005024.GA3428@sigill.intra.peff.net>
References: <AANLkTimuTHvA+qjqpmz=VkCpTTiRA7imb5+ZyTVmPwYy@mail.gmail.com>
 <7v62y661pl.fsf@alter.siamese.dyndns.org>
 <AANLkTimYNtU7sHn4_Vx50evTWDpMK_=XgshU3ZzT+eVw@mail.gmail.com>
 <AANLkTik7ORPUsABJv-bFraFNt2TvP0Xx=-013P2=A6Nr@mail.gmail.com>
 <AANLkTi=L0PA-p5HkWnurfurfyYAQhCBt+Q7SzzCczFLH@mail.gmail.com>
 <20100916001636.GA2371@sigill.intra.peff.net>
 <AANLkTikd5uZFk8-d7wmB8ZEqOy5=RWsDNnrsHqAQZhkz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 02:50:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow2fn-0002Yk-Sn
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 02:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456Ab0IPAtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 20:49:50 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52058 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752214Ab0IPAtu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 20:49:50 -0400
Received: (qmail 25786 invoked by uid 111); 16 Sep 2010 00:49:49 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 16 Sep 2010 00:49:49 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Sep 2010 20:50:24 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikd5uZFk8-d7wmB8ZEqOy5=RWsDNnrsHqAQZhkz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156286>

On Wed, Sep 15, 2010 at 08:33:29PM -0400, Jay Soffian wrote:

> On Wed, Sep 15, 2010 at 8:16 PM, Jeff King <peff@peff.net> wrote:
> > It's not just the command line. It's also what's in .gitignore files. If
> > you disable just half of that, then you get the awful behavior that some
> > excludes apply to index files, and some don't.
> 
> Files matched by the standard excludes are not likely to be in the
> index in the first place. So in that sense, arguably -x is special.
> 
> But nonetheless, I agree with you, and since the user must
> specifically ask ls-files for the various exclusions, I think it makes
> sense to apply those even to cached files.

But then if somebody asks for both indexed and untracked files together,
the behavior is quite confusing. There is no way to say
"--exclude-standard just for the untracked files", and having exclusions
impact cached files is unlike any other part of git. So the behavior of
something like "git ls-files -s -o --exclude-standard" would be broken.

I have no idea if people are actually doing that.

So I think the best fix would be to leave the default behavior as-is,
and add the --exclude-cached-files-too-pretty-please you mentioned.

> I'm building a project file for my editor and I want to exclude
> certain files that make no sense for it to care about even though they
> are part of the repo. So I tried:
> 
> $ git ls-files -x png -x jpg ...
> 
> and was confused by that not working. I've worked around this by just
> filtering the ls-files output through grep, but, ick.

I certainly have sympathy for you being confused by the behavior of
ls-files. It undoubtedly is a mess.

But as for having to use grep, I would feel worse for you if you were
actually trying to exclude patterns from your .gitignore and you needed
to _convert_ them into a grep pattern. But it doesn't seem like:

  git ls-files | grep -v '\.png$'

is really much more work, and it's way more flexible.

At one point I proposed a "git check-ignore" similar to "git
check-attr", but I never got around to coding it. If you really liked
the gitignore-style patterns for some reason, it would be a nice
flexible way of doing what you want.

-Peff
