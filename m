From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Increase some limits in git-mailinfo
Date: Mon, 26 Feb 2007 20:34:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702262020590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0702261036550.12485@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702261107060.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 26 20:34:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLlcC-0003Fv-39
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 20:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030486AbXBZTeZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 14:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030487AbXBZTeZ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 14:34:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:33117 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030486AbXBZTeY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 14:34:24 -0500
Received: (qmail invoked by alias); 26 Feb 2007 19:34:22 -0000
X-Provags-ID: V01U2FsdGVkX1/FqJ9jtQnFaL+l9rTTHWVZl6s4QUu9+je4y1T3dZ
	N3sQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702261107060.12485@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40647>

Hi,

On Mon, 26 Feb 2007, Linus Torvalds wrote:

> +
> +	/* Count mbox From headers as headers */
> +	if (!memcmp(line, "From ", 5) || !memcmp(line, ">From ", 6))

I know that you copied that, but why not use the new prefixcmp() function?

>  static int read_one_header_line(char *line, int sz, FILE *in)
>  {
> -	int ofs = 0;
> -	while (ofs < sz) {
> -		int peek, len;
> -		if (fgets(line + ofs, sz - ofs, in) == NULL)
> -			break;
> -		len = eatspace(line + ofs);
> -		if ((len == 0) || !is_rfc2822_header(line)) {
> -			/* Re-add the newline */
> -			line[ofs + len] = '\n';
> -			line[ofs + len + 1] = '\0';
> -			break;
> -		}
> -		ofs += len;
> -		/* Yuck, 2822 header "folding" */
> +	int len;
> +
> +	/* Get the first part of the line.. */
> +	if (!fgets(line, sz, in))
> +		return 0;
> +
> +	/*
> +	 * Is it an empty line or not a valid rfc2822 header?
> +	 * If so, stop here, and return false ("not a header")
> +	 */
> +	len = eatspace(line);
> +	if (!len || !is_rfc2822_header(line)) {
> +		/* Re-add the newline */
> +		line[len] = '\n';
> +		line[len + 1] = '\0';

Just a micro-issue: if the input ends in the middle of a header line, 
_and_ this line is of exactly the right size (sz), then len + 1 is not 
necessarily smaller than sz, right?

It's not like this can be used for a DOS or stuff, but I try to get more 
aware of off-by-one bugs, which I introduced all too often...

> +		addlen = eatspace(continuation);
> +		if (len < sz) {

Shouldn't this be "sz - 1"? We are setting "line[len] = 0;" later... While 
at it, we can always check for "addlen > 0", just in case?

But then, should it not be rather "sz - 2", because we want to _add_ 
something to the line?

> +			if (addlen >= sz - len)
> +				addlen = sz - len - 1;
> +			memcpy(line + len, continuation, addlen);
> +			len += addlen;
> +		}
>  	}
> -	/* Count mbox From headers as headers */
> -	if (!ofs && (!memcmp(line, "From ", 5) || !memcmp(line, ">From ", 6)))
> -		ofs = 1;
> -	return ofs;
> +	line[len] = 0;
> +
> +	return 1;

Ciao,
Dscho
