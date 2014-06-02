From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Improve function dir.c:trim_trailing_spaces()
Date: Mon, 2 Jun 2014 02:47:06 -0400
Message-ID: <20140602064706.GB27254@sigill.intra.peff.net>
References: <1401549691-20788-1-git-send-email-pasha.bolokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 08:47:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrM1Z-0005MX-Rb
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 08:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbaFBGrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 02:47:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:35728 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752383AbaFBGrI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 02:47:08 -0400
Received: (qmail 32144 invoked by uid 102); 2 Jun 2014 06:47:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Jun 2014 01:47:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jun 2014 02:47:06 -0400
Content-Disposition: inline
In-Reply-To: <1401549691-20788-1-git-send-email-pasha.bolokhov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250555>

On Sat, May 31, 2014 at 08:21:31AM -0700, Pasha Bolokhov wrote:

> +	char *p, *last_space = NULL;
> +
> +	for (p = buf; *p; p++)
> +		if (*p == ' ') {
> +			if (!last_space)
> +				last_space = p;
> +		} else {
> +			if (*p == '\\')
> +				p++;
> +			last_space = NULL;
> +		}

Your backslash-escape works here by incrementing "p" an extra time. So
we move past the backslash to the next character (which is escaped), and
then the for-loop increments it again to the character beyond that,
which is the next one worth considering.

What happens if we are parsing a string with an unmatched backslash at
the end of the string, like:

  foo\

We consider the end-of-string NUL to be escaped, skip it, and then keep
reading whatever random bytes are in memory after the string.

The original version did not have a problem with this because it used
a length, which meant that  "i < len" caught this case.

I think you either need to insert an extra check for "!p[1]" when moving
past the escaped character, or move back to a length-based check.

-Peff
