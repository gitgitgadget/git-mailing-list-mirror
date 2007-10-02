From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Tue, 2 Oct 2007 15:11:04 -0400
Message-ID: <20071002191104.GA7901@coredump.intra.peff.net>
References: <20071002155800.GA6828@coredump.intra.peff.net> <200710021916.44388.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 21:11:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icn9J-0001ip-LB
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 21:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569AbXJBTLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 15:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753453AbXJBTLI
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 15:11:08 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3910 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007AbXJBTLH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 15:11:07 -0400
Received: (qmail 5992 invoked by uid 111); 2 Oct 2007 19:11:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 02 Oct 2007 15:11:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2007 15:11:04 -0400
Content-Disposition: inline
In-Reply-To: <200710021916.44388.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59713>

On Tue, Oct 02, 2007 at 07:16:43PM +0100, Andy Parkins wrote:

> Changed repeated use of the same constants for the ref paths to be
> symbolic constants.  I've defined them in refs.h

I've manually inspected the patch. Comments are below.

> -		if (prefixcmp(head, "refs/heads/"))
> -			die("HEAD not found below refs/heads!");
> -		head += 11;
> +		if (prefixcmp(head, PATH_REFS_HEADS))
> +			die("HEAD not found below " PATH_REFS_HEADS "!");
> +		head += STRLEN_PATH_REFS_HEADS;

This slightly changes the message (extra "/"), but I don't think that is
a big deal...

> -	strcpy(path + len, "refs");
> +	strcpy(path + len, PATH_REFS);
>  	safe_create_dir(path, 1);
> -	strcpy(path + len, "refs/heads");
> +	strcpy(path + len, PATH_REFS_HEADS);
>  	safe_create_dir(path, 1);
> -	strcpy(path + len, "refs/tags");
> +	strcpy(path + len, PATH_REFS_TAGS);
>  	safe_create_dir(path, 1);

...but here it's not immediately obvious if the extra trailing "/" is
OK. Looks like the path just gets handed off to system calls trhough
safe_create_dir, and they are happy with the trailing slash. But it is a
behavior change.

> -		strcpy(path + len, "refs");
> +		strcpy(path + len, PATH_REFS);
>  		adjust_shared_perm(path);
> -		strcpy(path + len, "refs/heads");
> +		strcpy(path + len, PATH_REFS_HEADS);
>  		adjust_shared_perm(path);
> -		strcpy(path + len, "refs/tags");
> +		strcpy(path + len, PATH_REFS_TAGS);
>  		adjust_shared_perm(path);

And of course ditto here.

> -		if (snprintf(ref, sizeof(ref), "refs/tags/%s", *p)
> +		if (snprintf(ref, sizeof(ref), PATH_REFS_TAGS"%s", *p)

I find the 'PATH_REFS_TAGS "%s"' (with a space) you used earlier a
little easier to read.

> -	if (len < 5 || memcmp(name, "refs/", 5))
> +	if (len < STRLEN_PATH_REFS || memcmp(name, PATH_REFS, STRLEN_PATH_REFS))

I imagine this was one of the times you mentioned before where prefixcmp
would be more readable. I would agree.

> -	strcpy(posn, "/objects/");
> +	strcpy(posn, "/" PATH_OBJECTS);
>  	posn += 9;

should be posn += 1 + STRLEN_PATH_OBJECTS ?

> -	url = xmalloc(strlen(repo->base) + 64);
> -	sprintf(url, "%s/objects/pack/pack-%s.idx", repo->base, hex);
> +	url = xmalloc(strlen(repo->base) + STRLEN_PATH_OBJECTS + 56);
> +	sprintf(url, "%s/" PATH_OBJECTS "pack/pack-%s.idx", repo->base, hex);

The '56' is still quite hard to verify as correct ("/" + "pack/pack-" +
".idx" + "\0"). But I wonder if trying to fix that will just make it
harder to read (perhaps a comment is in order?).

Or maybe using a strbuf here would be much more obviously correct?

> -	url = xmalloc(strlen(base) + 31);
> -	sprintf(url, "%s/objects/info/http-alternates", base);
> +	url = xmalloc(strlen(base) + STRLEN_PATH_OBJECTS + 23);
> +	sprintf(url, "%s/" PATH_OBJECTS "info/http-alternates", base);

Also a potential strbuf. Ther are more of this same form, but I'm not
going to bother pointing out each one.

> -- 
> 1.5.3.rc5.11.g312e

Man that was tedious. But I think every other change is purely
syntactic, so there shouldn't be any bugs.

-Peff
