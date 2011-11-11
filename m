From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-web--browser: avoid errors in terminal when running
 Firefox on Windows
Date: Fri, 11 Nov 2011 13:35:55 -0500
Message-ID: <20111111183555.GC16055@sigill.intra.peff.net>
References: <20111003095731.GB16078@sigill.intra.peff.net>
 <1321028283-17307-1-git-send-email-Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Chris Packham <judge.packham@gmail.com>
To: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 11 19:36:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROvxL-00068C-FT
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 19:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755724Ab1KKSf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 13:35:58 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39680
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537Ab1KKSf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 13:35:57 -0500
Received: (qmail 3856 invoked by uid 107); 11 Nov 2011 18:36:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Nov 2011 13:36:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Nov 2011 13:35:55 -0500
Content-Disposition: inline
In-Reply-To: <1321028283-17307-1-git-send-email-Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185279>

On Fri, Nov 11, 2011 at 08:18:03PM +0400, Alexey Shumkin wrote:

> Firefox on Windows by default is placed in "C:\Program Files\Mozilla Firefox"
> folder, i.e. its path contains spaces. Before running this browser "git-web--browse"
> tests version of Firefox to decide whether to use "-new-tab" option or not.
> 
> Quote browser path to avoid error during this test.

Thanks. I even noticed this bug early on in the previous discussion:

  http://article.gmane.org/gmane.comp.version-control.git/181600

but forgot about it by the time the final patch rolled around. Your fix
looks correct, but:

>  test_expect_success \
> +	'Firefox below v2.0 paths are properly quoted' '
> +	echo fake: http://example.com/foo >expect &&
> +	cat >"fake browser" <<-\EOF &&
> +	#!/bin/sh
> +
> +	if [ "$1" == "-version" ]; then

Using "==" is a bashism. Just use "=".

Also, a style nit, but we usually spell this "test" and not "[". I admit
I don't care much, though.

> +		# Firefox (in contrast to w3m) is run in background (with &)
> +		# so redirect output to "actual"
> +		echo fake: "$@" > actual
> +	fi
> +	EOF
> +	chmod +x "fake browser" &&
> +	git config browser.firefox.path "`pwd`/fake browser" &&
> +	git web--browse --browser=firefox \
> +		http://example.com/foo &&
> +	test_cmp expect actual

Hmm. So we are running the fake browser in the background, but then
check that it has written something as soon as web--browse exits. Isn't
that a race condition? I.e., we could run "test_cmp" before the browser
has actually written anything?

I'm not sure there's a good way to do it.  You would need either to wait
some pre-determined "it could not possibly take it longer than N seconds
to run" sleep, or we need some kind of synchronization point. We can't
wait call "wait" on the child PID (if we even have it, because it's not
our child).

-Peff
