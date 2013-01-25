From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-web--browser: avoid errors in terminal when running
 Firefox on Windows
Date: Fri, 25 Jan 2013 17:06:17 -0500
Message-ID: <20130125220617.GA23626@sigill.intra.peff.net>
References: <20111111202636.GA20515@sigill.intra.peff.net>
 <3eeabf4989f7f1b4593e89e4c6bcfa8710a7b793.1359125053.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 23:06:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyrQ2-0006gu-8p
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 23:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108Ab3AYWGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 17:06:20 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51082 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977Ab3AYWGT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 17:06:19 -0500
Received: (qmail 17016 invoked by uid 107); 25 Jan 2013 22:07:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Jan 2013 17:07:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Jan 2013 17:06:17 -0500
Content-Disposition: inline
In-Reply-To: <3eeabf4989f7f1b4593e89e4c6bcfa8710a7b793.1359125053.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214589>

On Fri, Jan 25, 2013 at 06:44:13PM +0400, Alexey Shumkin wrote:

>  test_web_browse () {
> -	# browser=$1 url=$2
> +	# browser=$1 url=$2 sleep_timeout=$3
> +	sleep_timeout="$3"
>  	git web--browse --browser="$1" "$2" >actual &&
> +	# if $3 is set
> +	# as far as Firefox is run in background (it is run with &)
> +	# we trying to avoid race condition
> +	# by waiting for "$sleep_timeout" seconds of timeout for 'fake_browser_ran' file appearance
> +	(test -z "$sleep_timeout" || (
> +	    for timeout in $(seq 1 $sleep_timeout); do
> +			test -f fake_browser_ran && break
> +			sleep 1
> +		done
> +		test $timeout -ne $sleep_timeout
> +		)
> +	) &&
>  	tr -d '\015' <actual >text &&

Gross, but I don't really see another way to handle the asynchronous
nature of spawning background browsers.

Two things, though:

  1. Should test_web_browse just delete fake_browser_ran for us? Then
     later tests do not have to remember to do so.

  2. Seeing fake_browser_ran appeared, we know that the script has
     started.  But there is still a race condition in which it may not
     have written anything to "actual" yet.

In this implementation:

> +	cat >"fake browser" <<-\EOF &&
> +	#!/bin/sh
> +
> +	: > fake_browser_ran
> +	if test "$1" = "-version"; then
> +		echo Fake Firefox browser version 1.2.3
> +	else
> +		# Firefox (in contrast to w3m) is run in background (with &)
> +		# so redirect output to "actual"
> +		echo fake: "$@" > actual
> +	fi
> +	EOF

There is a period where fake_browser_ran exists, but nothing is in
actual. You can solve it by setting fake_browser_ran at the end rather
than the beginning.

Or you can drop fake_browser_ran entirely, and just atomically move
actual into place, like:

  echo "fake: $*" >actual.tmp
  mv actual.tmp actual

and then test_web_browse can just spin waiting for "actual" to appear.

-Peff
