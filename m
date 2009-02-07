From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Sat, 7 Feb 2009 02:10:56 -0500
Message-ID: <20090207071056.GB14856@coredump.intra.peff.net>
References: <20090205204436.GA6072@diku.dk> <20090206191511.GD19494@coredump.intra.peff.net> <2c6b72b30902061410l64c98c33g19b97f656d347c83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sat Feb 07 08:17:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVhRU-00017C-IN
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 08:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbZBGHLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 02:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752898AbZBGHLi
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 02:11:38 -0500
Received: from peff.net ([208.65.91.99]:49907 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430AbZBGHLg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 02:11:36 -0500
Received: (qmail 19142 invoked by uid 107); 7 Feb 2009 07:11:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 07 Feb 2009 02:11:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Feb 2009 02:10:56 -0500
Content-Disposition: inline
In-Reply-To: <2c6b72b30902061410l64c98c33g19b97f656d347c83@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108819>

On Fri, Feb 06, 2009 at 11:10:23PM +0100, Jonas Fonseca wrote:

> > It looks like you just keep the view on the same line number when moving
> > to the new blame output. In practice, this has very mixed results. Most
> > of the time it does exactly what I want, but if the file changes
> > significantly, you get dumped at a totally unrelated part of the file.
> > I'm not sure if there is a more clever solution, though.
> 
> Yes, it is a bit easy to get lost. It should be possible to find the
> original line number either by making git-blame also honor
> --show-number for the --incremental output or by using the "porcelain"
> version:
> 
>   git blame --show-number -L <line>,<line> <rev> <file>

I'm not sure that will always work. You know that in some version of the
file, line number X is of interest to you. You want to find the "same"
spot in the parent commit. So you can:

  1. use the line number in the blamed file; this doesn't work because
     the re-blamed file may have much more or less content before X,
     which is going to shift the content of interest.

  2. use the line number that the content was introduced on in the blamed
     commit. This has the same problem as above, but may be more
     accurate because you are only jumping _one_ revision to the parent
     of the blamed commit (instead of from wherever you started
     blaming).

My impression is that tig is currently doing (1).  I think (2) will
suffer from the same problem, but in practice the margin of error will
be much smaller because your are rewinding through fewer changes. So if
that is what you were suggesting, I think it is probably worth trying.

It would require a "reload and jump to this arbitrary line" function,
which I remember being problematic when I did my original patch a long
time ago.  But I haven't looked at the new code to see if it is easier
now (it looks like you have been doing quite a bit of refactoring in
that area lately).

You could also try matching up content, but that is equally error-prone.
You can't find the same line in the parent, for the obvious reason that
you've just blamed it, so by definition it doesn't exist in the parent.
You could try doing a fuzzy match on the surrounding blamed lines, but
there is no guarantee that they exist in the parent commit, either. So I
think the line number guess is probably our best bet.

-Peff
