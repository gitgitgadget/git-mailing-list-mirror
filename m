From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5570: forward git-daemon messages in a different way
Date: Wed, 18 Apr 2012 23:03:26 -0700
Message-ID: <20120419060326.GA13982@sigill.intra.peff.net>
References: <1334393070-7123-1-git-send-email-zbyszek@in.waw.pl>
 <20120414121358.GA26372@ecki>
 <20120414122127.GA31220@ecki>
 <4F8C3E0F.2040300@in.waw.pl>
 <20120416174230.GA19226@sigill.intra.peff.net>
 <20120416224424.GA10314@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, gitster@pobox.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Apr 19 08:03:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKkSw-0006gd-GC
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 08:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512Ab2DSGDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 02:03:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38236
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242Ab2DSGDa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 02:03:30 -0400
Received: (qmail 25232 invoked by uid 107); 19 Apr 2012 06:03:39 -0000
Received: from c-67-169-43-61.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.43.61)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Apr 2012 02:03:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Apr 2012 23:03:26 -0700
Content-Disposition: inline
In-Reply-To: <20120416224424.GA10314@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195924>

On Tue, Apr 17, 2012 at 12:44:25AM +0200, Clemens Buchacher wrote:

> On Mon, Apr 16, 2012 at 01:42:30PM -0400, Jeff King wrote:
> > 
> > Hmm. t5570 seems to pass reliably on dash for me with:
> > 
> > diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
> > index ef2d01f..9f52cb6 100644
> > --- a/t/lib-git-daemon.sh
> > +++ b/t/lib-git-daemon.sh
> > @@ -33,7 +33,7 @@ start_git_daemon() {
> >  	{
> >  		read line
> >  		echo >&4 "$line"
> > -		cat >&4 &
> > +		cat >&4 <git_daemon_output &
> >  
> >  		# Check expected output
> >  		if test x"$(expr "$line" : "\[[0-9]*\] \(.*\)")" != x"Ready to rumble"
> 
> Yes, me too. I can reproduce reliably with dash and the above fixes it
> reliably.
> 
> > But the test above does fail.
> 
> Which one do you mean? The output check works for me.

Sorry, I meant the test you posted with "yes":

mkfifo fd
yes >fd &
pid=$!
{
        read line
        echo $line
        cat <fd &
} <fd
sleep 1
kill $pid
wait $pid
rm -f fd

It sometimes succeeds and sometimes fails for me. So I think we are
perhaps just winning a race every time in the actual git-daemon run
(because it is not writing nearly as quickly as "yes").

> > Is it purely luck of the timing that git-daemon never gets SIGPIPE? I
> > guess the problem is that the {}-section can finish before "cat
> > <git_daemon_output" has actually opened the pipe?
> 
> No clue. But shouldn't the fork return only after the fd's have been
> opened successfully? If I change cat to "(echo di; cat; echo do); sleep
> 1; pgrep yes", then one can see that cat terminates right away, even
> though yes is still running. It's as if cat never gets to read from the
> pipe, but from /dev/null instead. A bug in dash?

Hmm. Yeah, if you strace the cat, it gets an immediate EOF. And even
weirder, I notice this in the strace output:

  clone(...)
  close(0)                                = 0
  open("/dev/null", O_RDONLY)             = 0
  ...
  execve("/bin/cat", ["cat"], [/* 50 vars */]) = 0

What? The shell is literally redirecting the cat process's stdin from
/dev/null. I'm totally confused. If you do "cat <foo", it will still
close stdin momentarily before reopening it (which means that the "yes"
process can get SIGPIPE in that instant).

Looking in the dash source code, this is very deliberate:

  $ sed -n 838,840p jobs.c
   * When job control is turned off, background processes have their standard
   * input redirected to /dev/null (except for the second and later processes
   * in a pipeline).

I can't find anything relevant in POSIX. But I don't really see a way to
work around this. The cat _has_ to be a background job. So I think we
are stuck with a solution like your custom C wrapper.

As an aside, though, does it really make sense for git-daemon to respect
SIGPIPE? Under what circumstance would that actually be useful? So we
should perhaps fix that, too. But even if we do so, it's nice for our
test script to robustly report the actual stderr.

-Peff
