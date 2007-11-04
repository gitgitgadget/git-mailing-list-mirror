From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/5] pretty describe: add %ds, %dn, %dd placeholders
Date: Sun, 4 Nov 2007 14:11:24 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711041356330.4362@racer.site>
References: <472DB1B0.1050904@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Nov 04 15:12:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IogDR-0004GJ-2v
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 15:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759496AbXKDOMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 09:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755000AbXKDOMY
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 09:12:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:56481 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759355AbXKDOMX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 09:12:23 -0500
Received: (qmail invoked by alias); 04 Nov 2007 14:12:21 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp042) with SMTP; 04 Nov 2007 15:12:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19CpgkUqDNCSjCrfZv6ilGpHveHs8CYo/Y2AAN6hl
	zS07VoRzvIu6G0
X-X-Sender: gene099@racer.site
In-Reply-To: <472DB1B0.1050904@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63407>

Hi,

On Sun, 4 Nov 2007, Ren? Scharfe wrote:

> The new placeholders %ds (description string, git-describe style), %dn 
> (the name part) and %dd (the depth part) are added.
> 
> To avoid imposing the significant cost of running describe_commit() on 
> every format string, even if none of the new placeholders are used, a 
> new function, interp_count(), is introduced.  It is a stripped down 
> version of interpolate(), that simply counts the placeholders in a 
> format string.  If the describe placeholders are not found, setting up 
> the corresponding replacements is skipped.

The way I read this, those are two really quite independent patches 
squashed into one.

> +	unsigned long occurs[ARRAY_SIZE(table)];

You do not ever use the counts.  So, longs are overkill.  Even ints might 
be overkill, but probably the most convenient.  I would have gone with 
chars.  If I knew how to memset() an array of unsigned:1 entries to all 
zero, I would even have gone with that, but the runtime cost of this is 
probably higher than the chars.

But the even more fundamental problem is that you count the needed 
interpolations _every_ single time you output a commit message.

A much better place would be get_commit_format().  Yes that means 
restructuring the code a bit more, but I would say that this definitely 
would help.  My preference would even be introducing a new source file for 
the user format handling (commit-format.[ch]).

> +
> +/*
> + * interp_count - count occurences of placeholders
> + */
> +void interp_count(unsigned long *result, const char *orig,
> +                  const struct interp *interps, int ninterps)
> +{
> +	const char *src = orig;

You do not ever use orig again.  So why not just use that variable instead 
of introducing a new one?

> +	const char *name;
> +	unsigned long namelen;
> +	int i;
> +	char c;
> +
> +	for (i = 0; i < ninterps; i++)
> +		result[i] = 0;

memset()?

> +
> +	while ((c = *src)) {
> +		if (c == '%') {
> +			/* Try to match an interpolation string. */
> +			for (i = 0; i < ninterps; i++) {
> +				name = interps[i].name;
> +				namelen = strlen(name);
> +				if (strncmp(src, name, namelen) == 0)

prefixcmp()?

> +					break;
> +			}
> +
> +			/* Check for valid interpolation. */
> +			if (i < ninterps) {

This is ugly.  You already had a successful if() for that case earlier.

> +				result[i]++;
> +				src += namelen;
> +				continue;
> +			}
> +		}
> +		src++;
> +	}
> +}

I'd rewrite this whole loop as

	while ((c = *(orig++)))
		if (c == '%')
			/* Try to match an interpolation string. */
			for (i = 0; i < ninterps; i++)
				if (prefixcmp(orig, interps[i].name)) {
					result[i] = 1;
					orig += strlen(interps[i].name);
					break;
				}

Ciao,
Dscho

			
