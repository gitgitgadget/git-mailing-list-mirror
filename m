From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] grep: prepare for new header field filter
Date: Sat, 29 Sep 2012 01:22:02 -0400
Message-ID: <20120929052202.GA3330@sigill.intra.peff.net>
References: <7vr4pmm3qz.fsf@alter.siamese.dyndns.org>
 <1348893689-20240-1-git-send-email-pclouds@gmail.com>
 <1348893689-20240-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 07:22:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THpVx-0005Ik-Hu
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 07:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878Ab2I2FWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 01:22:06 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34262 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420Ab2I2FWF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 01:22:05 -0400
Received: (qmail 25675 invoked by uid 107); 29 Sep 2012 05:22:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 29 Sep 2012 01:22:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Sep 2012 01:22:02 -0400
Content-Disposition: inline
In-Reply-To: <1348893689-20240-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206624>

On Sat, Sep 29, 2012 at 11:41:27AM +0700, Nguyen Thai Ngoc Duy wrote:

> diff --git a/grep.c b/grep.c
> index 898be6e..8d73995 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -720,7 +720,14 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
>  		if (strncmp(bol, field, len))
>  			return 0;
>  		bol += len;
> -		saved_ch = strip_timestamp(bol, &eol);
> +		switch (p->field) {
> +		case GREP_HEADER_AUTHOR:
> +		case GREP_HEADER_COMMITTER:
> +			saved_ch = strip_timestamp(bol, &eol);
> +			break;
> +		default:
> +			break;
> +		}

Reading this hunk, I wondered what happens to saved_ch if we do not set
it here. Fortunately it is initialized to 0, as we already have to
handle the non-header case. Then later we do this, which does introduce
a new condition (saved_ch was not set, but we trigger the first half of
the conditional):

      if (p->token == GREP_PATTERN_HEAD && saved_ch)
                *eol = saved_ch;

However, the second half of that conditional (which previously was only
triggered when we tried to split the timestamp, but there was a bogus
line with no ">" on it) prevents us from overwriting *eol.

So I think it is good, but it was non-obvious enough that I wanted to
save other reviewers from investigating it.  The rest of the patch looks
good to me, as well.

-Peff
