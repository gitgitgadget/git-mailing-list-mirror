From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Only print an error for the last connect() failure
Date: Thu, 9 Jun 2011 12:33:41 -0400
Message-ID: <20110609163340.GD25885@sigill.intra.peff.net>
References: <13539E82-3E8D-4210-9A3A-DD83F0CA6F85@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dave Zarzycki <zarzycki@apple.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 18:34:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUiB7-0000iW-F1
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 18:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248Ab1FIQdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 12:33:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33511
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984Ab1FIQdp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 12:33:45 -0400
Received: (qmail 15366 invoked by uid 107); 9 Jun 2011 16:33:52 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 12:33:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 12:33:41 -0400
Content-Disposition: inline
In-Reply-To: <13539E82-3E8D-4210-9A3A-DD83F0CA6F85@apple.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175549>

On Thu, Jun 09, 2011 at 09:18:10AM -0700, Dave Zarzycki wrote:

> IPv6 hosts are often unreachable on the primarily IPv4 Internet and
> therefore we shouldn't print an error if there are still other hosts we
> can try to connect() to. This helps "git fetch --quiet" stay quiet.
> ---
>  connect.c |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/connect.c b/connect.c
> index 2119c3f..7f70ce7 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -225,11 +225,13 @@ static int git_tcp_connect_sock(char *host, int flags)
>  		}
>  		if (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
>  			saved_errno = errno;
> -			fprintf(stderr, "%s[%d: %s]: errno=%s\n",
> -				host,
> -				cnt,
> -				ai_name(ai),
> -				strerror(saved_errno));
> +			if (ai->ai_next == NULL) {
> +				fprintf(stderr, "%s[%d: %s]: errno=%s\n",
> +					host,
> +					cnt,
> +					ai_name(ai),
> +					strerror(saved_errno));
> +			}

I agree being noisy about early failures when we succeed later is a bad
thing. But when we fail completely, doesn't your code now mask early
failures and print only the final one? The early failures might be the
important ones for the user.

So perhaps we should do something instead like:

  struct strbuf error_message = STRBUF_INIT;
  ...
  if (connect(...) < 0) {
          strbuf_addf(&error_message, "%s[%d: %s]: errno=%s\n",
                      host, cnt, ai_name(ai), strerror(errno));
          ...
  }

  if (sockfd < 0)
          die("unable to connect to %s:\n%s", host, error_message.buf);
  strbuf_release(&error_message);

-Peff
