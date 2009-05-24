From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5500-fetch-pack: ignore output from git init
Date: Sun, 24 May 2009 12:43:30 -0400
Message-ID: <20090524164329.GC22792@coredump.intra.peff.net>
References: <1243107282-9259-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 18:43:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8GnT-0007oB-0S
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 18:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476AbZEXQnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 12:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753176AbZEXQna
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 12:43:30 -0400
Received: from peff.net ([208.65.91.99]:53086 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753456AbZEXQn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 12:43:29 -0400
Received: (qmail 29216 invoked by uid 107); 24 May 2009 16:43:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 24 May 2009 12:43:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 24 May 2009 12:43:30 -0400
Content-Disposition: inline
In-Reply-To: <1243107282-9259-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119841>

On Sat, May 23, 2009 at 12:34:42PM -0700, Stephen Boyd wrote:

> Signed-off-by: Stephen Boyd <bebarino@gmail.com>

There is no rationale given in the commit message, but I assume it is
"this spews useless crap to the terminal that interferes with the usual
test output".

However, this seems like the wrong direction. We already have a nice
test infrastructure that redirects test output away from the user and
respects "--verbose" to turn it back on. t5500 does quite a bit of work
outside the test harness, and it makes more sense to me to move it
inside. That would take care of your useless spew, _and_ it would help
detect failures in a more robust way.

In other words:

> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index c450f33..ce74508 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -97,7 +97,7 @@ pull_to_client () {
>  (
>  	mkdir client &&
>  	cd client &&
> -	git init 2>> log2.txt &&
> +	git init 2>> log2.txt > /dev/null &&
>  	git config transfer.unpacklimit 0
>  )

Why not:

  test_expect_success 'setup client repo' '
    mkdir client &&
    (cd client &&
     git init 2>>log2.txt &&
     git config transfer.unpacklimit 0
    )
  '

?

-Peff
