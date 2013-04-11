From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/5] check-ignore: allow incremental streaming of
 queries via --stdin
Date: Thu, 11 Apr 2013 15:11:32 -0400
Message-ID: <20130411191132.GC3177@sigill.intra.peff.net>
References: <20130411110511.GB24296@pacific.linksys.moosehall>
 <1365681913-7059-1-git-send-email-git@adamspiers.org>
 <1365681913-7059-4-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 21:11:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQMuO-0004K6-BK
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 21:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633Ab3DKTLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 15:11:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40837 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206Ab3DKTLj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 15:11:39 -0400
Received: (qmail 18348 invoked by uid 107); 11 Apr 2013 19:13:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Apr 2013 15:13:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2013 15:11:32 -0400
Content-Disposition: inline
In-Reply-To: <1365681913-7059-4-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220916>

On Thu, Apr 11, 2013 at 01:05:12PM +0100, Adam Spiers wrote:

> +test_expect_success 'setup: have stdbuf?' '
> +	if which stdbuf >/dev/null 2>&1
> +	then
> +		test_set_prereq STDBUF
> +	fi
> +'
> +
> +test_expect_success STDBUF 'streaming support for --stdin' '
> +	(
> +		echo one
> +		sleep 2
> +		echo two
> +	) | stdbuf -oL git check-ignore -v -n --stdin >out &
> +	pid=$! &&
> +	sleep 1 &&
> +	grep "^\.gitignore:1:one	one" out &&
> +	test $( wc -l <out ) = 1 &&
> +	sleep 2 &&
> +	grep "^::	two" out &&
> +	test $( wc -l <out ) = 2 &&
> +	( wait $pid || kill $pid || : ) 2>/dev/null
> +'

I always get a little nervous with sleeps in the test suite, as they are
indicative that we are trying to avoid some race condition, which means
that the test can fail when the system is under load, or when a tool
like valgrind is used which drastically alters the timing (e.g., if
check-ignore takes longer than 1 second to produce its answer, we may
fail here).

Is there a simpler way to test this?

Like:

  # Set up a long-running "check-ignore" connected by pipes.
  mkfifo in out &&
  (git check-ignore ... <in >out &) &&

  # We cannot just "echo >in" because check-ignore
  # would get EOF after echo exited; instead we open
  # the descriptor in our shell, and then echo to the
  # fd. We make sure to close it at the end, so that
  # the subprocess does get EOF and dies properly.
  exec 9>in &&
  test_when_finished "exec 9>&-" &&

  # Now we can do interactive tests
  echo >&9 one &&
  read response <out &&
  test "$response" = ... &&
  echo >&9 two &&
  read response <out &&
  test "$response" = ...

Hmm. Maybe simpler wasn't the right word. :) But it avoids any sleeps or
race conditions.

-Peff
