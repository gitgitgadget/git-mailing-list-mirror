From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5570: forward git-daemon messages in a different way
Date: Fri, 27 Apr 2012 03:55:51 -0400
Message-ID: <20120427075551.GA12092@sigill.intra.peff.net>
References: <1334393070-7123-1-git-send-email-zbyszek@in.waw.pl>
 <20120414121358.GA26372@ecki>
 <20120414122127.GA31220@ecki>
 <4F8C3E0F.2040300@in.waw.pl>
 <20120416174230.GA19226@sigill.intra.peff.net>
 <20120416224424.GA10314@ecki>
 <20120419060326.GA13982@sigill.intra.peff.net>
 <4F8FB779.60004@viscovery.net>
 <20120426130129.GA27785@sigill.intra.peff.net>
 <4F999105.200@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clemens Buchacher <drizzd@aon.at>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Apr 27 09:56:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNg25-0002VE-Cx
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 09:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757513Ab2D0Hzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 03:55:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47755
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756963Ab2D0Hzy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 03:55:54 -0400
Received: (qmail 25714 invoked by uid 107); 27 Apr 2012 07:56:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 Apr 2012 03:56:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Apr 2012 03:55:51 -0400
Content-Disposition: inline
In-Reply-To: <4F999105.200@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196450>

On Thu, Apr 26, 2012 at 08:16:37PM +0200, Johannes Sixt wrote:

> > Thanks for the pointer; I looked in POSIX but couldn't find that
> > passage. It does say "In all cases, explicit redirection of standard
> > input shall override this activity". It looks like dash interprets that
> > as "open /dev/null, then open the redirected stdin". Which leaves a race
> > condition.
> 
> I don't see a race condition.

One of the proposed solutions was:

  {
    read line
    cat <fifo &
  } <fifo

which I think can end up with this race:

  1. shell opens pipe, reads line

  2. shell forks for 'cat' process

  3. parent shell sees that cat is to be backgrounded, so it does not
     wait for cat to finish, ends {} block, and closes pipe

  4. forked shell process re-opens stdin from /dev/null

  5. nobody has the fifo open, so a writer may get SIGPIPE

  6. forked shell process re-opens stdin from the fifo

> The specs are clear: First redirect stdin
> to /dev/null, and if there are other redirections, apply them later.
> But in our code we have only:
> 
> 	cat >&4 &

Yes. But it also fails sometimes with the solution above, in which we
explicitly redirect from the fifo. The issue is not that we redirect
from /dev/null in the long term, but that there is a moment where we
have closed the old stdin and not yet opened the new one.

> I don't think so. How about this?
> 
> diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
> index ef2d01f..7245ab3 100644
> --- a/t/lib-git-daemon.sh
> +++ b/t/lib-git-daemon.sh
> @@ -30,10 +30,10 @@ start_git_daemon() {
>  		"$@" "$GIT_DAEMON_DOCUMENT_ROOT_PATH" \
>  		>&3 2>git_daemon_output &
>  	GIT_DAEMON_PID=$!
> +	exec 7<git_daemon_output &&
>  	{
> -		read line
> +		read line <&7
>  		echo >&4 "$line"
> -		cat >&4 &
>  
>  		# Check expected output
>  		if test x"$(expr "$line" : "\[[0-9]*\] \(.*\)")" != x"Ready to rumble"
> @@ -43,7 +43,9 @@ start_git_daemon() {
>  			trap 'die' EXIT
>  			error "git daemon failed to start"
>  		fi
> -	} <git_daemon_output
> +		cat <&7 >&4 &
> +		exec 7<&-
> +	}
>  }
>  
>  stop_git_daemon() {
> 
> 
> i.e., we open the readable end of the pipe in the shell, and dup
> it from there to 'read' and later to 'cat'. Finally, we can
> close it, because 'cat' has it still open in the background.

Yes, I believe this will work reliably. Though there is one subtle thing
happening.  At first glance, I thought you might have the same race I
mentioned above; there's no guarantee that the shell subprocess has
actually set up its stdin before your "exec 7<&-" runs. But because
the subprocess has inherited descriptor 7, and because it never
explicitly closes descriptor 7 (as it does for descriptor 0 while
setting up the command's redirections), the pipe is always open. As fd 7
before exec'ing cat, and as both 7 and 0 afterwards.

So I think you could even get rid of your "exec" lines entirely, and
just do:

  {
    read line <&7
    cat <&7 &
  } 7<git_daemon_output

That works reliably for me with this test:

  mkfifo fd
  yes >fd &
  pid=$!
  {
    read line
    echo $line
    wc <fd &
  } <fd
  sleep 1
  kill $pid
  wait $pid
  rm -f fd

which fails for me about one-third of the time in the form above, but
works if you replace the middle part with:

  {
    read line <&7
    echo $line
    wc <&7 &
  } 7<fd

(This is the same thing the test script is doing, but it exercises the race
much better because "yes" is constantly writing output).

Thanks for a clever solution. This is much better than doing something
custom in C.

-Peff
