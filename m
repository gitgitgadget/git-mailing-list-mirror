From: Jeff King <peff@peff.net>
Subject: Re: Supporting "-v" option for git-log
Date: Wed, 25 May 2011 09:29:44 -0400
Message-ID: <20110525132816.GA6709@sigill.intra.peff.net>
References: <BANLkTik70gu0NUzUEnGNWHQr8CfbdPVe5g@mail.gmail.com>
 <SNT124-W39164C74A457129811245DC4740@phx.gbl>
 <BANLkTi=v8j=VdBNgThRTFXk+YbPFOFvzwQ@mail.gmail.com>
 <SNT124-W5207D5461CD80509763B79C4740@phx.gbl>
 <BANLkTikT4s+Twfip2g7Zo-XcML1Wbd3qBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tim Mazid <timmazid@hotmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Elazar Leibovich <elazarl@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 15:29:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPE9u-0006pB-8J
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 15:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513Ab1EYN3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 09:29:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42140
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757856Ab1EYN3s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 09:29:48 -0400
Received: (qmail 32037 invoked by uid 107); 25 May 2011 13:29:46 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 May 2011 09:29:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2011 09:29:44 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikT4s+Twfip2g7Zo-XcML1Wbd3qBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174390>

On Wed, May 25, 2011 at 02:28:12PM +0300, Elazar Leibovich wrote:

> On Wed, May 25, 2011 at 2:21 PM, Tim Mazid <timmazid@hotmail.com> wrote:
> >
> > Well, personally, I've never used the --grep option. I pipe it through
> > grep, where I can supply options such as -v.
> 
> But then you must use single-line commits output. Which is
> inconvenient if you want to read all the commit message.

You can use perl to consider records larger than a single line, like:

  git log -z | perl -ln0e 'print unless /your pattern/'

But of course that is somewhat inconvenient to type, and is somewhat
slower than the internal grep.

> Now that I think of it, we already have the '--not' option for
> revision specifiers. Why won't we use it for grep patterns? That way
> -v will not be overloaded (it usually means verbose). For example
> 
>     git log --all --not --grep A --grep B

The problem is that "--not" already has a meaning, and the scope of that
meaning is different than what you propose. That is, in this command:

  git log a --not b c

The "--not" applies to both "b" and "c". So you are changing the meaning
of the existing:

  git log a --not --grep b c

(which now means "grep for b, but do not include commits in c"). And
even if we wanted to do that, there is a parsing ambiguity. Does the
"--not" apply _just_ to the grep, or does it also include "not c"?

Which is a shame, because we already have all of the code for "--and",
"--or", and "--not" in git-grep. It is just a syntactic conflict. I
think you could get away with "--grep-and", "--grep-or", and
"--grep-not". They are obviously less nice to type, but there would be
not conflict.

-Peff
