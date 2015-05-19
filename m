From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] sha1_file: pass empty buffer to index empty file
Date: Tue, 19 May 2015 02:37:16 -0400
Message-ID: <20150519063716.GA22771@peff.net>
References: <xmqqa8x4fjf5.fsf@gitster.dls.corp.google.com>
 <1431806796-28902-1-git-send-email-gjthill@gmail.com>
 <xmqqegmfds1n.fsf@gitster.dls.corp.google.com>
 <xmqqvbfrc952.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jim Hill <gjthill@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 19 08:37:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yub9d-0001UL-A6
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 08:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561AbbESGhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 02:37:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:60607 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754555AbbESGhT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 02:37:19 -0400
Received: (qmail 17279 invoked by uid 102); 19 May 2015 06:37:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 01:37:19 -0500
Received: (qmail 10280 invoked by uid 107); 19 May 2015 06:37:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 02:37:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 May 2015 02:37:16 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbfrc952.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269342>

On Sun, May 17, 2015 at 12:10:49PM -0700, Junio C Hamano wrote:

> I spoke too fast X-<.  "while sh t0021-*.sh; do :; done" dies after
> a few iterations and with this squashed in it doesn't.
> 
>  t/t0021-conversion.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index 42e6423..b778faf 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -218,7 +218,7 @@ test_expect_success "filter: clean empty file" '
>  '
>  
>  test_expect_success "filter: smudge empty file" '
> -	git config filter.empty-in-repo.clean true &&
> +	git config filter.empty-in-repo.clean "cat >/dev/null" &&

Hmm, I thought we turned off SIGPIPE when writing to filters these days.
Looks like we still complain if we get EPIPE, though. I feel like it
should be the filter's business whether it wants to consume all of the
input or not[1], and we should only be checking its exit status.

-Peff

[1] As a practical example, consider a file format that has a lot of
    cruft at the end. The clean filter would want to read only to the
    start of the cruft, and then stop for reasons of efficiency.
