From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] mktag.c: improve verification of tagger field and
 tests
Date: Mon, 31 Mar 2008 01:40:22 -0700
Message-ID: <7vr6drl215.fsf@gitster.siamese.dyndns.org>
References: <47EABA21.90708@nrlssc.navy.mil>
 <47EBC844.3020602@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos Rica <jasampler@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Mar 31 10:41:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgFaA-0002ze-5D
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 10:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbYCaIkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 04:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753945AbYCaIkk
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 04:40:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52962 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbYCaIkj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 04:40:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0B07224DC;
	Mon, 31 Mar 2008 04:40:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7651A24DB; Mon, 31 Mar 2008 04:40:29 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78569>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> @@ -97,11 +98,53 @@ static int verify_tag(char *buffer, unsigned long size)
>  	/* Verify the tagger line */
>  	tagger_line = tag_line;
>  
> -	if (memcmp(tagger_line, "tagger", 6) || (tagger_line[6] == '\n'))
> -		return error("char" PD_FMT ": could not find \"tagger\"", tagger_line - buffer);
> +	if (memcmp(tagger_line, "tagger ", 7) || (tagger_line[7] == '\n'))
> +		return error("char" PD_FMT ": could not find \"tagger \"",
> +			tagger_line - buffer);

You increment tagger_line by 7 after this step, so it might be a good idea
to make sure [7] != '\0', but does it make sense to compare it with '\n'
here?  I can see the original compared [6] with '\n', but I do not think
it makes sense to inherit it when you are "improving" the validation.

> +	/*
> +	 * Check for correct form for name and email
> +	 * i.e. " <" followed by "> " on _this_ line
> +	 */
> +	tagger_line += 7;
> +	if (!(lb = strstr(tagger_line, " <")) || !(rb = strstr(lb+2, "> ")) ||
> +		strchr(tagger_line, '\n') < rb)
> +		return error("char" PD_FMT ": malformed tagger",
> +			tagger_line - buffer);

The intention is 'on the line there must be " <" followed by something
followed by "> " before the end of line.'.  That's fine, but can the last
strchr() ever return NULL?

> +	if (lb == tagger_line)
> +		return error("char" PD_FMT ": missing tagger name",
> +			tagger_line - buffer);
> +
> +	/* timestamp */
> +	tagger_line = rb + 2;
> +	if (*tagger_line == ' ')
> +		return error("char" PD_FMT ": malformed tag timestamp",
> +			tagger_line - buffer);

'After "> ", there has to be the timestamp'.

> +	for (;;) {
> +		unsigned char c = *tagger_line++;
> +		if (c == ' ')
> +			break;
> +		if (isdigit(c))
> +			continue;
> +		return error("char" PD_FMT ": malformed tag timestamp",
> +			tagger_line - buffer);
> +	}

If the char immediately after "> " is ' ', it definitely is bogus, and you
want to make sure one or more digits, so the validation is correct but
feels a bit roundabout.

> +	/* timezone, 5 digits [+-]hhmm, max. 1400 */
> +	if (!((tagger_line[0] == '+' || tagger_line[0] == '-') &&
> +	      isdigit(tagger_line[1]) && isdigit(tagger_line[2]) &&
> +	      isdigit(tagger_line[3]) && isdigit(tagger_line[4]) &&
> +	      tagger_line[5] == '\n' && atoi(tagger_line+1) <= 1400))
> +		return error("char" PD_FMT ": malformed tag timezone",
> +			tagger_line - buffer);
> +	tagger_line += 6;

The open-coded strtoul() bothers me a bit, but it is not much longer nor
less readable than:

        (*tagger_line == '+' || *tagger_line == '-')
        && strtoul(tagger_line + 1, &ep, 10) <= 1400
        && ep - (tagger_line + 1) == 4
        && *ep == '\n'

so it probably is fine.

> +	/* Verify the blank line separating the header from the body */
> +	if (*tagger_line != '\n')
> +		return error("char" PD_FMT ": trailing garbage in tag header",
> +			tagger_line - buffer);

Having said all that, I'll queue this in 'next'; perhaps we can fix it up
real quick and merge it in 1.5.5.
