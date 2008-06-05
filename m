From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] handle http urls with query string ("?foo") correctly
Date: Thu, 5 Jun 2008 01:12:21 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806050103520.21190@racer>
References: <200806050128.33467.bombe@pterodactylus.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1105240428-1212624749=:21190"
Cc: git@vger.kernel.org
To: =?ISO-8859-7?Q?David_=A1Bombe=A2_Roden?= <bombe@pterodactylus.net>
X-From: git-owner@vger.kernel.org Thu Jun 05 02:15:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K438A-0003oQ-0l
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 02:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbYFEANz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 20:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752335AbYFEANz
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 20:13:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:56957 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752216AbYFEANz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 20:13:55 -0400
Received: (qmail invoked by alias); 05 Jun 2008 00:13:49 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp034) with SMTP; 05 Jun 2008 02:13:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+wg50AgLSw18V9T2630+VtKWXH+1ld4qi6cvaCMU
	EPey7R/DMMNEIw
X-X-Sender: gene099@racer
In-Reply-To: <200806050128.33467.bombe@pterodactylus.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83840>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1105240428-1212624749=:21190
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 5 Jun 2008, David ¡Bombe¢ Roden wrote:

> From 1f55b9176248673b78c77ff292fb5c6c988a7f8b Mon Sep 17 00:00:00 2001
> From: =?utf-8?q?David=20=E2=80=98Bombe=E2=80=99=20Roden?= <bombe@pterodactylus.net>
> Date: Thu, 5 Jun 2008 00:53:56 +0200
> Subject: [PATCH] handle http urls with query string ("?foo") correctly

Please follow the hints in Documentation/SubmittingPatches, or just 
imitate others' mails with patches.

> I'm a developer for the Freenet Project[1] and tried to get git running 
> with Freenet's http-gateway. For several reasons I have to use URLs like 
> "http://host:8888/USK@<lots-of-stuff>/project.git/4?type=text/plain". 
> This breaks the way git creates http URLs to retrieve. The following 
> patch remedys this situation by inserting the git-generated part of the 
> URL (like "/info/refs") before the query string.

I think that this paragraph should be rewritten into a less "I did" form, 
and be the commit message.

> diff --git a/http-walker.c b/http-walker.c
> index 99f397e..711e55b 100644
> --- a/http-walker.c
> +++ b/http-walker.c
> @@ -100,7 +100,6 @@ static void start_object_request(struct walker *walker,
>  	char *hex = sha1_to_hex(obj_req->sha1);
>  	char prevfile[PATH_MAX];
>  	char *url;
> -	char *posn;
>  	int prevlocal;
>  	unsigned char prev_buf[PREV_BUF_SIZE];
>  	ssize_t prev_read = 0;
> @@ -146,16 +145,11 @@ static void start_object_request(struct walker *walker,
>  
>  	SHA1_Init(&obj_req->c);
>  
> -	url = xmalloc(strlen(obj_req->repo->base) + 51);
> +	char *suffix = xmalloc(51);

I guess you are a Java programmer?  In C, this would be "char 
suffix[51];".

Also, we like to have C89 compatibility, especially when it is too simple: 
declarations have to come _before_ statements.
 
>  	obj_req->url = xmalloc(strlen(obj_req->repo->base) + 51);
> -	strcpy(url, obj_req->repo->base);
> -	posn = url + strlen(obj_req->repo->base);
> -	strcpy(posn, "/objects/");
> -	posn += 9;
> -	memcpy(posn, hex, 2);
> -	posn += 2;
> -	*(posn++) = '/';
> -	strcpy(posn, hex + 2);
> +	strcpy(suffix, "/objects/");
> +	sprintf(suffix + 9, "%c%c/%s", hex[0], hex[1], hex + 2);
> +	url = transform_url(obj_req->repo->base, suffix);

This part of Git's source code predates the strbuf work, and therefore it 
is understandable that strbufs are not used there.  However, I think that 
your changes just cry for want of strbufs.

Also, the strcpy() could be merged into the sprintf().

> @@ -384,8 +378,9 @@ static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned ch
>  	if (walker->get_verbosely)
>  		fprintf(stderr, "Getting index for pack %s\n", hex);
>  
> -	url = xmalloc(strlen(repo->base) + 64);
> -	sprintf(url, "%s/objects/pack/pack-%s.idx", repo->base, hex);
> +	char *index_url = xmalloc(64);
> +	sprintf(index_url, "/objects/pack/pack-%s.idx", hex);
> +	url = transform_url(repo->base, index_url);

Again, declaration-after-statement, and again an opportunity for an 
strbuf.

Maybe you want to rewrite your patch before I keep on repeating these two 
comments? ;-)

Thanks,
Dscho
--8323329-1105240428-1212624749=:21190--
