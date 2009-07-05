From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCHv2 1/2] git apply: option to ignore whitespace differences
Date: Mon, 06 Jul 2009 00:21:04 +0100
Message-ID: <4A513560.5040001@ramsay1.demon.co.uk>
References: <1246708429-21823-1-git-send-email-giuseppe.bilotta@gmail.com> <1246708429-21823-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 01:43:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNbMu-0007of-5s
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 01:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755943AbZGEXmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2009 19:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755930AbZGEXmt
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 19:42:49 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:49234 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755755AbZGEXms (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jul 2009 19:42:48 -0400
X-Greylist: delayed 1063 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Jul 2009 19:42:48 EDT
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1MNb51-0004Xj-ZI; Sun, 05 Jul 2009 23:25:08 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <1246708429-21823-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122767>

[Sorry for the late reply to this; I've been catching up on
email after several days away - so if this has already been
addressed, just ignore and sorry for the noise!]

Giuseppe Bilotta wrote:
[snip]
> + * Compare s1 to s2 up to length n, ignoring whitespace differences.
> + * It is acceptable if s2 is a substring of s1.
> + */
> +static int memcmp_ignore_whitespace(const char *s1, const char *s2, size_t n)
> +{
> +	const char *stop = s2 + n;
> +	int result;

result is uninitialized here...

> +
> +	if (!n)
> +		return 0;
> +
> +	/* skip leading whitespace */
> +	while (isspace(*s1))
> +		s1++;
> +	while (isspace(*s2))
> +		s2++;
> +	while (!result && s2 < stop) {

... and is still uninitialized the first time it hits
the loop condition...

> +		result = *s1++ - *s2++;

... so this may or may not be set...

> +		/*
> +		 * skip whitespace inside if we have whitespace
> +		 * on both buffers
> +		 */
> +		if (isspace(*s1) && isspace(*s2)) {
> +			while (isspace(*s1))
> +				s1++;
> +			while (isspace(*s2))
> +				s2++;
> +		}
> +	}
> +
> +	return result;

... so this may still be uninitialized.
> +}
> +

I haven't been following this thread; I just noticed this problem
as the patch floated past...

ATB,
Ramsay Jones
