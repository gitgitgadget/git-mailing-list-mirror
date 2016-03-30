From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] imap-send.c, cram: allocate enough memory for null
 terminated string
Date: Tue, 29 Mar 2016 21:07:57 -0400
Message-ID: <20160330010756.GA2237@sigill.intra.peff.net>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
 <1459298333-21899-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 03:08:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4cA-0005hu-Aq
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 03:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbcC3BIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 21:08:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:40460 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752674AbcC3BIA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 21:08:00 -0400
Received: (qmail 22629 invoked by uid 102); 30 Mar 2016 01:07:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 21:07:59 -0400
Received: (qmail 30131 invoked by uid 107); 30 Mar 2016 01:07:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 21:07:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2016 21:07:57 -0400
Content-Disposition: inline
In-Reply-To: <1459298333-21899-3-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290245>

On Tue, Mar 29, 2016 at 05:38:49PM -0700, Stefan Beller wrote:

> `strlen` returns the length of a string without the terminating null byte.
> To make sure enough memory is allocated we need to pass `strlen(..) + 1`
> to the allocation function.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  imap-send.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/imap-send.c b/imap-send.c
> index 2c52027..f7e9909 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -872,7 +872,7 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
>  	 * enough upper bound for challenge (decoded result).
>  	 */
>  	encoded_len = strlen(challenge_64);
> -	challenge = xmalloc(encoded_len);
> +	challenge = xmalloc(encoded_len + 1);
>  	decoded_len = EVP_DecodeBlock((unsigned char *)challenge,
>  				      (unsigned char *)challenge_64, encoded_len);
>  	if (decoded_len < 0)

Others pointed out that patches 1 and 2 here probably don't need the
extra byte. But as a side note, for any cases that do, please use
xmallocz() instead of manually adding 1 to the length. Even if you don't
need the final byte to be NUL, it checks for integer overflow.

-Peff
