From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] submodule summary: Don't barf when invoked in an empty
 repo
Date: Wed, 17 Feb 2010 01:10:05 -0500
Message-ID: <20100217061005.GA520@coredump.intra.peff.net>
References: <20100216041945.GB10296@vfb-9.home>
 <20100216062422.GC10296@vfb-9.home>
 <20100216072154.GF2169@coredump.intra.peff.net>
 <201002161121.14613.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jacob Helwig <jacob.helwig@gmail.com>,
	Ping Yin <pkufranky@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Feb 17 07:10:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhd74-0002ft-0t
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 07:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014Ab0BQGKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 01:10:10 -0500
Received: from peff.net ([208.65.91.99]:49814 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680Ab0BQGKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 01:10:09 -0500
Received: (qmail 11452 invoked by uid 107); 17 Feb 2010 06:10:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 17 Feb 2010 01:10:18 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Feb 2010 01:10:05 -0500
Content-Disposition: inline
In-Reply-To: <201002161121.14613.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140206>

On Tue, Feb 16, 2010 at 11:21:14AM +0100, Johan Herland wrote:

> I'm working from the simple test case in the below patch, I get the
> following output with your proposed fix:
> 
>   [...]
>   trace: built-in: git 'rev-parse' '-q' '--verify' '^0'
>   [...]
>   trace: built-in: git 'diff-index' '--raw' 'HEAD' '--'
>   fatal: bad revision 'HEAD'
>   [...]
> 
> I.e. your fix doesn't work because $1 is empty (not "HEAD") at this point.

Ah, right. I was testing "git status" which calls "git submodule summary
HEAD", but your test uses the assumed HEAD. And both need fixing.

> My alternative patch (below) does pass my test case (and all the other
> tests as well)
> 
> I'd still like an ACK from the original author (Ping Yin) as well, as I'm
> not sure if I overlooked something by removing the "$1^0".

Your patch looks correct to me. I don't really see how dropping the "^0"
will have any effect. rev-parse --verify already prefers revisions to
files, and diff-index should peel if needed.

Which, btw, seems like a mini-bug here. The point of this code is to say
"if we have an argument, is it a revision? If so, shift it off.
Otherwise, put it (and any other arguments) after the -- as a file
limiter".

Usually if I have a branch "master" and a file "master", git will
complain about the ambiguity unless I use an explicit "--" separator.
But here it always takes it as a revision, no questions asked. Or if I
am in "--files" mode, that argument is simply removed and ignored (see
just below where we unset $head).

Probably it should be re-ordered as

  if test -n "$files"; then
     ...
  else
     if rev=$(git rev-parse -q --verify --default HEAD "$1")
       ...
  fi

It just doesn't come up much because usually having branch names and
filenames the same is sufficiently annoying that nobody does it.

-Peff
