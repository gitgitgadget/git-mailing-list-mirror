From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 14/21] Add proper parsing of "tagger" line, but only when
 thorough_verify is set
Date: Sun, 10 Jun 2007 09:58:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706100952130.4059@racer.site>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net> <200706090210.36270.johan@herland.net>
 <200706090218.41941.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 11:02:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxJJM-0007XC-D1
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 11:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbXFJJCI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 05:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbXFJJCH
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 05:02:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:60376 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751610AbXFJJCE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 05:02:04 -0400
Received: (qmail invoked by alias); 10 Jun 2007 09:02:03 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp057) with SMTP; 10 Jun 2007 11:02:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18gVJ10ppkg3OVnaiLSY0ewwqTND2BXfEhcUDOL2n
	u7T7QfKDe+iHnD
X-X-Sender: gene099@racer.site
In-Reply-To: <200706090218.41941.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49690>

Hi,

On Sat, 9 Jun 2007, Johan Herland wrote:

> -	const char *type_line, *tag_line, *tagger_line;
> -	unsigned long type_len, tag_len;
> +	const char   *type_line, *tag_line, *tagger_line;
> +	unsigned long type_len,   tag_len,   tagger_len;
> +	const char *header_end;

This is ugly. Really ugly. Besides, it breaks the minimal patch paradigm.

> @@ -81,7 +82,7 @@ int parse_and_verify_tag_buffer(struct tag *item,
>  	if (size < 64)
>  		return error("Tag object failed preliminary size check");
>  
> -	/* Verify object line */
> +	/* Verify mandatory object line */
>  	if (prefixcmp(data, "object "))
>  		return error("Tag object (@ char 0): "
>  			"Does not start with \"object \"");

Hmph. I think everybody reading C code understands that this is mandatory. 
I even think that the comment is useless. It is sort of a 
code-in-human-language duplicated code.

> -	/* Verify the tagger line */
> +	/*
> +	 * Verify mandatory tagger line, but only when we're checking
> +	 * thoroughly, i.e. on inserting a new tag, and on fsck.
> +	 * There are existing tag objects without a tagger line (most
> +	 * notably the "v0.99" tag in the main git repo), and we don't
> +	 * want to fail parsing on these.
> +	 */

I maintain that even with thorough checking, it is _wrong_ to error on a 
missing tagger. Since we have to deal with tagger-less tags _anyway_, and 
since it is not like you could really do something about it (the tag is 
immutable), you should go with a warning.

> -	 * Calculate lengths of header fields.
> +	 * Calculate lengths of header fields (0 for fields that are not given).

Does that really make sense? You effectively treat a missing field as if 
it were empty. IMHO that is wrong. Besides, this

> +	tagger_len     = header_end > tagger_line ?
> +			(header_end - tagger_line) - 1 : 0;

is really ugly, what with in-line spaces, _and_ special casing.

> -		/* Verify the tagger line */
> +		/* Verify tagger line */

Hmpf.

Ciao,
Dscho
