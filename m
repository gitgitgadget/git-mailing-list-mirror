From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] color: allow multiple attributes
Date: Sun, 28 Feb 2010 07:20:19 -0500
Message-ID: <20100228122019.GB24247@coredump.intra.peff.net>
References: <7vfx4mv0h9.fsf@alter.siamese.dyndns.org>
 <1267325798-8280-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Mark Lodato <lodatom@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 13:20:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nli8N-0008Am-R9
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 13:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967707Ab0B1MU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 07:20:26 -0500
Received: from peff.net ([208.65.91.99]:37321 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966312Ab0B1MUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 07:20:25 -0500
Received: (qmail 28129 invoked by uid 107); 28 Feb 2010 12:20:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 28 Feb 2010 07:20:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Feb 2010 07:20:19 -0500
Content-Disposition: inline
In-Reply-To: <1267325798-8280-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141250>

On Sat, Feb 27, 2010 at 06:56:38PM -0800, Junio C Hamano wrote:

>   >>> but wouldn't it be more user friendly for us
>   >>> to support "red blink bold ul italic"?
>   >>
>   >> Yes, I think this should be done whether or not the patch in question
>   >> is accepted.
> 
>   This time with a bit of test updates as well for real inclusion.

Looks OK to me, but...

>   Also I realized that we can stuff them in an unsigned flag word as
>   bitfields ("red bold" and "red bold bold bold" would give the same
>   boldness anyway) to lift the artificial limit of number of attribute
>   words.

I also had this thought, but shouldn't that mean:

> +		int i;
> +		int num_attrs = count_bits(attr);
> +
> +		if (COLOR_MAXLEN <=
> +		    /* Number of bytes to denote colors and attributes */
> +		    num_attrs
> +		    + (fg < 0 ? 0 : (fg < 8) ? 2 : 8) /* "3x" or "38;5;xxx" */
> +		    + (bg < 0 ? 0 : (bg < 8) ? 2 : 8) /* "4x" or "48;5;xxx" */
> +		    /* Number of semicolons between the above elements */
> +		    + (num_attrs + (0 <= fg) + (0 <= bg) - 1)
> +		    /* ESC '[', terminating 'm' and NUL */
> +		    + 4)
> +			goto bad;

We don't need this, because the length of what can be specified is
bounded, and we simply need to set COLOR_MAXLEN high enough to handle
the longest case? Though I suppose it doesn't hurt to be paranoid.

> +test_expect_success 'fg bg attr...' '
> +	color "blue bold dim ul blink reverse" "[1;2;4;5;7;34m"
> +'

Hmm. Just a thought on the bit-setting approach, but does the order of
attributes ever matter? We are going to lose the ordering information
the user specifies, obviously.

-Peff
