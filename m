From: Jeff King <peff@peff.net>
Subject: Re: Bug report : bad filter-branch (OSX only)
Date: Wed, 29 Apr 2015 12:43:15 -0400
Message-ID: <20150429164315.GA26682@peff.net>
References: <CAM=W1NkZr6o-DCxXskeWC8xjRMiT2P9qXeeUe91qLBqOxzqNtg@mail.gmail.com>
 <20150428055506.GJ24580@peff.net>
 <CAM=W1NnR2-T7vpMSM-3-VypnR-T235tMudyjJowtj5utNmoKNQ@mail.gmail.com>
 <20150429043947.GA10702@peff.net>
 <20150429045600.GA10781@peff.net>
 <xmqqy4lbtrvj.fsf@gitster.dls.corp.google.com>
 <20150429154857.GA13518@peff.net>
 <xmqqioce6gon.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Olivier ROLAND <cyrus-dev@edla.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 18:43:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnV51-0003GY-F4
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 18:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966345AbbD2QnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 12:43:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:51678 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965622AbbD2QnS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 12:43:18 -0400
Received: (qmail 8769 invoked by uid 102); 29 Apr 2015 16:43:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 11:43:17 -0500
Received: (qmail 27757 invoked by uid 107); 29 Apr 2015 16:43:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 12:43:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2015 12:43:15 -0400
Content-Disposition: inline
In-Reply-To: <xmqqioce6gon.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267983>

On Wed, Apr 29, 2015 at 09:30:00AM -0700, Junio C Hamano wrote:

> >> (
> >> 	while read x && test -n "$x"
> >>         do
> >>         	:;
> >> 	done
> >> 	cat
> >> ) <../commit | eval "$filter_msg"
> >> 
> >> would not spin too much in shell loop, perhaps?
> >
> > Yeah, that is not too bad. Probably we want "read -r", just in case of
> > weirdness in the header lines (and that's in POSIX, and we use it
> > in other scripts, so it should be portable enough). And we can save a
> > subshell if we don't mind the potential variable-name conflict.
> 
> As all we care about is "have we hit an empty line", I do not think "-r"
> really matters, but it would not hurt.

I think something like:

  author ...
  committer ...
  encoding foo\

  this is the real commit message

would behave incorrectly without "-r". I would be shocked if that ever
happens in real life, but I think it doesn't hurt to be careful.

> As to s/()/{}/, please tell me what I am doing wrong.  I am getting
> the same process IDs from all of the $$s and the only difference
> seems to be variable clobbering.

$$ is always the pid of the main shell process, even in a subshell. If
your shell is bash, it provides $BASHPID which can tell the difference
(if you put $BASHPID in your test script, it does show that we fork for
the subshell).

On Linux, you can also test with "strace -fce clone". Interestingly,
dash produces one fewer fork than bash on your test script, but I didn't
track down the exact difference. But I can imagine a shell that is smart
enough to realize a fork is not required in this instance.

-Peff
