From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] handle http urls with query string ("?foo") correctly
Date: Thu, 5 Jun 2008 08:15:01 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806050758210.21190@racer>
References: <200806050128.33467.bombe@pterodactylus.net> <alpine.DEB.1.00.0806050103520.21190@racer> <200806050848.43462.bombe@pterodactylus.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1049400261-1212650103=:21190"
Cc: git@vger.kernel.org
To: =?ISO-8859-7?Q?David_=A1Bombe=A2_Roden?= <bombe@pterodactylus.net>
X-From: git-owner@vger.kernel.org Thu Jun 05 09:17:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K49io-0000FP-7b
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 09:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbYFEHQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 03:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbYFEHQZ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 03:16:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:45504 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752127AbYFEHQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 03:16:25 -0400
Received: (qmail invoked by alias); 05 Jun 2008 07:16:22 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp048) with SMTP; 05 Jun 2008 09:16:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18WOGMF3VUW/JdqsptPiofe3aOD2zw2jaCfF33bpH
	8G5Pz9m9ODQnlq
X-X-Sender: gene099@racer
In-Reply-To: <200806050848.43462.bombe@pterodactylus.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83870>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1049400261-1212650103=:21190
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 5 Jun 2008, David ¡Bombe¢ Roden wrote:

> 
> ---
> handle http urls with query string ("?foo") correctly
> git breaks when a repository is cloned from an http url that contains a
> query string. This patch fixes this behaviour be inserting the name of
> the requested object (like "/info/refs") before the query string.

Usually, this comes before the "---", and your comments/answers after it.  
And the first line would be the subject:

-- snip --
Handle http urls with query string ("?foo") correctly

Git breaks when a repository is cloned from an http url that contains a
query string. This patch fixes this behaviour be inserting the name of
the requested object (like "/info/refs") before the query string.
-- snap --

And of course, you usually sign off your patches.

> diff --git a/http-walker.c b/http-walker.c
> index 99f397e..b14497a 100644
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
> @@ -109,6 +108,7 @@ static void start_object_request(struct walker *walker,
>  	struct curl_slist *range_header = NULL;
>  	struct active_request_slot *slot;
>  	struct walker_data *data = walker->data;
> +	struct strbuf suffix_buffer = STRBUF_INIT;
>  
>  	snprintf(prevfile, sizeof(prevfile), "%s.prev", obj_req->filename);
>  	unlink(prevfile);
> @@ -146,16 +146,10 @@ static void start_object_request(struct walker *walker,
>  
>  	SHA1_Init(&obj_req->c);
>  
> -	url = xmalloc(strlen(obj_req->repo->base) + 51);
> +	strbuf_addstr(&suffix_buffer, "/objects/");
> +	strbuf_addf(&suffix_buffer, "%c%c/%s", hex[0], hex[1], hex + 2);

How about

	strbuf_addf(&suffix_buffer, "/objects/%c%c/%s",
		hex[0], hex[1], hex + 2);

?

> +	url = transform_url(obj_req->repo->base, strbuf_detach(&suffix_buffer, NULL));

And this line wrapped, like so?

	url = transform_url(obj_req->repo->base,
		strbuf_detach(&suffix_buffer, NULL));

Oh, but maybe it makes more sense to let transform_url() work on the 
strbuf itself?

> @@ -608,8 +603,7 @@ static void fetch_alternates(struct walker *walker, const char *base)
>  	if (walker->get_verbosely)
>  		fprintf(stderr, "Getting alternates list for %s\n", base);
>  
> -	url = xmalloc(strlen(base) + 31);
> -	sprintf(url, "%s/objects/info/http-alternates", base);
> +	url = transform_url(base, "/objects/info/http-alternates");
>  
>  	/* Use a callback to process the result, since another request
>  	   may fail and need to have alternates loaded before continuing */
> @@ -655,8 +649,7 @@ static int fetch_indices(struct walker *walker, struct alt_base *repo)
>  	if (walker->get_verbosely)
>  		fprintf(stderr, "Getting pack list for %s\n", repo->base);
>  
> -	url = xmalloc(strlen(repo->base) + 21);
> -	sprintf(url, "%s/objects/info/packs", repo->base);
> +	url = transform_url(repo->base, "/objects/info/packs");
>  
>  	slot = get_active_slot();
>  	slot->results = &results;

Of course, these two would have to initialise their strbuf, then.

> diff --git a/http.c b/http.c
> index 2a21ccb..a60f9ea 100644
> --- a/http.c
> +++ b/http.c
> @@ -590,15 +590,17 @@ static char *quote_ref_url(const char *base, const char *ref)
>  	qref = xmalloc(len);
>  	memcpy(qref, base, baselen);
>  	dp = qref + baselen;
> -	*(dp++) = '/';
> -	for (cp = ref; (ch = *cp) != 0; cp++) {
> -		if (needs_quote(ch)) {
> -			*dp++ = '%';
> -			*dp++ = hex((ch >> 4) & 0xF);
> -			*dp++ = hex(ch & 0xF);
> +	if (*ref) {
> +		*(dp++) = '/';
> +		for (cp = ref; (ch = *cp) != 0; cp++) {
> +			if (needs_quote(ch)) {
> +				*dp++ = '%';
> +				*dp++ = hex((ch >> 4) & 0xF);
> +				*dp++ = hex(ch & 0xF);
> +			}
> +			else
> +				*dp++ = ch;
>  		}
> -		else
> -			*dp++ = ch;
>  	}
>  	*dp = 0;
>  

Is this correct?  Either it should work the old way, or you will run into 
problems when ref is not empty...

> @@ -611,9 +613,12 @@ int http_fetch_ref(const char *base, struct ref *ref)
>  	struct strbuf buffer = STRBUF_INIT;
>  	struct active_request_slot *slot;
>  	struct slot_results results;
> +	struct strbuf suffix_buffer = STRBUF_INIT;
>  	int ret;
>  
> -	url = quote_ref_url(base, ref->name);
> +	strbuf_addf(&suffix_buffer, "/%s", ref->name);
> +	url = transform_url(base, strbuf_detach(&suffix_buffer, NULL));
> +	url = quote_ref_url(url, "");

... and indeed, it seems that by now, you would not want to add the ref in 
quote_ref_url() anymore... which you do not, since you pass "" as ref 
(and this is the only caller of quote_ref_url).

> @@ -643,3 +648,22 @@ int http_fetch_ref(const char *base, struct ref *ref)
>  	free(url);
>  	return ret;
>  }
> +
> +char *transform_url(const char *url, const char *suffix)
> +{
> +	struct strbuf new_url = STRBUF_INIT;
> +	char *question_mark;
> +	ptrdiff_t offset;
> +
> +	if ((question_mark = strchr(url, '?'))) {

Junio usually prefers assignments outside of the if() statement.

> +		offset = (ptrdiff_t) question_mark - (ptrdiff_t) url;
> +		strbuf_add(&new_url, url, offset);
> +		strbuf_addstr(&new_url, suffix);
> +		strbuf_addstr(&new_url, url + offset);
> +	} else {
> +		strbuf_addstr(&new_url, url);
> +		strbuf_addstr(&new_url, suffix);
> +	}
> +	return strbuf_detach(&new_url, NULL);
> +}
> +

There is an extra empty line at the end.

But another thing is more pressing: obviously, there were reasons to quote 
the ref names with this funny URL encoding (%45%75%6E%6E%79), and you 
effectively undid that change.

> diff --git a/transport.c b/transport.c
> index 3ff8519..b1966d8 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1,3 +1,4 @@
> +#include <stddef.h>

Why?

Ciao,
Dscho

--8323329-1049400261-1212650103=:21190--
