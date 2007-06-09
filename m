From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/21] Refactoring to make verify_tag() and parse_tag_buffer()
 more similar
Date: Sat, 9 Jun 2007 03:54:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706090339280.4059@racer.site>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net> <200706090210.36270.johan@herland.net>
 <200706090213.40785.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 04:57:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwr8m-0007FP-VM
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 04:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968709AbXFIC5X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 22:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968704AbXFIC5X
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 22:57:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:59035 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S968507AbXFIC5W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 22:57:22 -0400
Received: (qmail invoked by alias); 09 Jun 2007 02:57:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 09 Jun 2007 04:57:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Gfy1JLzbGm8SFTS0V4f1SgqOowDAt/qNHDK8ggL
	goyUr1RY8vjxqI
X-X-Sender: gene099@racer.site
In-Reply-To: <200706090213.40785.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49553>

Hi,

On Sat, 9 Jun 2007, Johan Herland wrote:

> diff --git a/mktag.c b/mktag.c
> index b82e377..0bc20c8 100644
> --- a/mktag.c
> +++ b/mktag.c
> @@ -32,52 +32,48 @@ static int verify_object(unsigned char *sha1, const char *expected_type)
>  	return ret;
>  }
>  
> +static int verify_tag(char *data, unsigned long size)
> +{
>  #ifdef NO_C99_FORMAT
>  #define PD_FMT "%d"
>  #else
>  #define PD_FMT "%td"
>  #endif
>  
> -static int verify_tag(char *buffer, unsigned long size)

Why this rename from buffer to data?

> -{
> -	int typelen;
> -	char type[20];
>  	unsigned char sha1[20];
> -	const char *object, *type_line, *tag_line, *tagger_line;
> +	char type[20];
> +	const char *type_line, *tag_line, *tagger_line;
> +	unsigned long type_len;

Why this change of order?

>  	if (size < 64)
>  		return error("wanna fool me ? you obviously got the size wrong !");
>  
> -	buffer[size] = 0;

Are you sure that your buffer is always NUL terminated?

> -	type_line = object + 48;
> +	type_line = data + 48;

Quite a lot of changes seem to do this object->data. The patch would have 
been much more compact if you just had renamed buffer to object instead of 
data.

> -	typelen = tag_line - type_line - strlen("type \n");
> -	if (typelen >= sizeof(type))
> -		return error("char" PD_FMT ": type too long", type_line+5 - buffer);
> -
> -	memcpy(type, type_line+5, typelen);
> -	type[typelen] = 0;
> +	type_len = tag_line - type_line - strlen("type \n");
> +	if (type_len >= sizeof(type))
> +		return error("char" PD_FMT ": type too long", type_line + 5 - data);
> +	memcpy(type, type_line + 5, type_len);
> +	type[type_len] = '\0';

This renaming variables has nothing to do with refactoring. In fact, I 
have a hard time to find code changes (which your subject suggests, as you 
want to make two functions more similar).

>  	/* TODO: check for committer info + blank line? */
>  	/* Also, the minimum length is probably + "tagger .", or 63+8=71 */
>  
>  	/* The actual stuff afterwards we don't care about.. */
>  	return 0;
> -}
>  
>  #undef PD_FMT
> +}

Any particular reason for this?

> @@ -124,6 +120,7 @@ int main(int argc, char **argv)
>  		free(buffer);
>  		die("could not read from stdin");
>  	}
> +	buffer[size] = 0;

Ah, so you terminate the buffer here. From the patch, it is relatively 
hard to see if this line is always hit _before_ the function is called 
that evidently relies on NUL termination. By moving it here, I think it is 
much more likely to overlook the fact that the function, which made sure 
that its assumption was met, needs this line. Whereas if you left it where 
it was, the assumption would always be met.

> -        if (item->object.parsed)
> -                return 0;
> -        item->object.parsed = 1;
> +	if (item->object.parsed)
> +		return 0;
> +	item->object.parsed = 1;

Again, this has nothing to do with refactoring.

> @@ -57,39 +57,38 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
>  	if (memcmp(data, "object ", 7))
>  		return error("char%d: does not start with \"object \"", 0);
>  
> -	if (get_sha1_hex((char *) data + 7, sha1))
> +	if (get_sha1_hex(data + 7, sha1))

Is this really necessary? Even if (which I doubt), it has nothing to do 
with refactoring.

If you _want_ to _explicitely_ do arithmetic on a char* instead of void*, 
why not DRT and change the function signature?

> -	sig_line++;
> +	tagger_line++;

I am really reluctant with renamings like these. IMHO they don't buy you 
much, except for possible confusion. It is evident that sig means the 
signer (and it is obvious in the case of an unsigned tag, who is meant, 
too).

> +int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
> +{
> +	return parse_tag_buffer_internal(item, (const char *) data, size);
> +}

This cast (and indeed, this function, if you ask me) is unnecessary.

I reviewed only this patch out of your long series, mostly because I found 
the subject line interesting. But IMHO the patch does not what the subject 
line suggests.

Unfortunately, it's unlikely that I will have time until Monday night to 
continue with this patch series.

Ciao,
Dscho
