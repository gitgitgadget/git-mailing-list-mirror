From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH v3] fetch: Strip usernames from url's before storing them
Date: Mon, 20 Apr 2009 09:39:40 +0200
Message-ID: <49EC26BC.5070505@op5.se>
References: <7vbpqxvnpl.fsf@gitster.siamese.dyndns.org> <1239956411-11195-1-git-send-email-ae@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 20 09:42:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvo9P-0000OR-1A
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 09:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbZDTHjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 03:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbZDTHjq
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 03:39:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:39360 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbZDTHjp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 03:39:45 -0400
Received: by fg-out-1718.google.com with SMTP id 22so212608fge.17
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 00:39:43 -0700 (PDT)
Received: by 10.86.61.13 with SMTP id j13mr3705405fga.68.1240213182885;
        Mon, 20 Apr 2009 00:39:42 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id e20sm2589471fga.15.2009.04.20.00.39.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 00:39:41 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <1239956411-11195-1-git-send-email-ae@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116940>

We've used this patch in production the past couple of days.
All tests pass and it works just fine. Any issues with it I
should fix, or did it just slip through?

Andreas Ericsson wrote:
> When pulling from a remote, the full URL including username
> is by default added to the commit message. Since it adds
> very little value but could be used by malicious people to
> glean valid usernames (with matching hostnames), we're far
> better off just stripping the username before storing the
> remote URL locally.
> 
> Note that this patch has no lasting visible effect when
> "git pull" does not create a merge commit. It simply
> alters what gets written to .git/FETCH_HEAD, which is used
> by "git merge" to automagically create its messages.
> 
> Signed-off-by: Andreas Ericsson <ae@op5.se>
> ---
> 
> I made some minor modifications to your function, Junio.
> * use xcalloc() instead of malloc() to make sure the string
>   is nul-terminated.
> * take strlen() of anon_part instead of calculating the whole
>   thing once, as we use that measurement twice.
> * moved handling of !scheme_prefix && !is_bare_ssh_url(url)
>   up top, so both conditions can be seen at once on my fairly
>   cramped editor.
> 
>  builtin-fetch.c |    7 +++++--
>  transport.c     |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  transport.h     |    1 +
>  3 files changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin-fetch.c b/builtin-fetch.c
> index 3c998ea..0bb290b 100644
> --- a/builtin-fetch.c
> +++ b/builtin-fetch.c
> @@ -289,7 +289,7 @@ static int update_local_ref(struct ref *ref,
>  	}
>  }
>  
> -static int store_updated_refs(const char *url, const char *remote_name,
> +static int store_updated_refs(const char *raw_url, const char *remote_name,
>  		struct ref *ref_map)
>  {
>  	FILE *fp;
> @@ -298,11 +298,13 @@ static int store_updated_refs(const char *url, const char *remote_name,
>  	char note[1024];
>  	const char *what, *kind;
>  	struct ref *rm;
> -	char *filename = git_path("FETCH_HEAD");
> +	char *url, *filename = git_path("FETCH_HEAD");
>  
>  	fp = fopen(filename, "a");
>  	if (!fp)
>  		return error("cannot open %s: %s\n", filename, strerror(errno));
> +
> +	url = transport_anonymize_url(raw_url);
>  	for (rm = ref_map; rm; rm = rm->next) {
>  		struct ref *ref = NULL;
>  
> @@ -376,6 +378,7 @@ static int store_updated_refs(const char *url, const char *remote_name,
>  				fprintf(stderr, " %s\n", note);
>  		}
>  	}
> +	free(url);
>  	fclose(fp);
>  	if (rc & 2)
>  		error("some local refs could not be updated; try running\n"
> diff --git a/transport.c b/transport.c
> index 3dfb03c..38c12e7 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1083,3 +1083,51 @@ int transport_disconnect(struct transport *transport)
>  	free(transport);
>  	return ret;
>  }
> +
> +/*
> + * Strip username (and password) from an url and return
> + * it in a newly allocated string.
> + */
> +static char *transport_anonymize_url(const char *url)
> +{
> +	char *anon_url, *scheme_prefix, *anon_part;
> +	size_t anon_len, prefix_len = 0;
> +
> +	anon_part = strchr(url, '@');
> +	if (is_local(url) || !anon_part)
> +		goto literal_copy;
> +
> +	anon_len = strlen(++anon_part);
> +	scheme_prefix = strstr(url, "://");
> +	if (!scheme_prefix) {
> +		if (!strchr(anon_part, ':'))
> +			/* cannot be "me@there:/path/name" */
> +			goto literal_copy;
> +	} else {
> +		const char *cp;
> +		/* make sure scheme is reasonable */
> +		for (cp = url; cp < scheme_prefix; cp++) {
> +			switch (*cp) {
> +				/* RFC 1738 2.1 */
> +			case '+': case '.': case '-':
> +				break; /* ok */
> +			default:
> +				if (isalnum(*cp))
> +					break;
> +				/* it isn't */
> +				goto literal_copy;
> +			}
> +		}
> +		/* @ past the first slash does not count */
> +		cp = strchr(scheme_prefix + 3, '/');
> +		if (cp && cp < anon_part)
> +			goto literal_copy;
> +		prefix_len = scheme_prefix - url + 3;
> +	}
> +	anon_url = xcalloc(1, 1 + prefix_len + anon_len);
> +	memcpy(anon_url, url, prefix_len);
> +	memcpy(anon_url + prefix_len, anon_part, anon_len);
> +	return anon_url;
> +	literal_copy:
> +	return xstrdup(url);
> +}
> diff --git a/transport.h b/transport.h
> index b1c2252..27bfc52 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -74,5 +74,6 @@ const struct ref *transport_get_remote_refs(struct transport *transport);
>  int transport_fetch_refs(struct transport *transport, const struct ref *refs);
>  void transport_unlock_pack(struct transport *transport);
>  int transport_disconnect(struct transport *transport);
> +char *transport_anonymize_url(const char *url);
>  
>  #endif


-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
