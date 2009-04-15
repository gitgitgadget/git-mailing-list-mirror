From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] fetch: Strip usernames from url's before storing them
Date: Wed, 15 Apr 2009 14:30:42 +0200
Message-ID: <49E5D372.1090504@drmicha.warpmail.net>
References: <1239797816-24582-1-git-send-email-ae@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Apr 15 14:32:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu4IA-0002bk-0I
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 14:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758859AbZDOMbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 08:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753298AbZDOMbC
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 08:31:02 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35737 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751941AbZDOMbA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Apr 2009 08:31:00 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 6A5AB31DF18;
	Wed, 15 Apr 2009 08:30:59 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 15 Apr 2009 08:30:59 -0400
X-Sasl-enc: CT+9GbLlnoTQIAphQ8TCZ00aKBm2xv5ddWpIqsKP6RuG 1239798659
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C41DB4D3A;
	Wed, 15 Apr 2009 08:30:58 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090414 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <1239797816-24582-1-git-send-email-ae@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116609>

Andreas Ericsson venit, vidit, dixit 15.04.2009 14:16:
> When pulling from a remote, the full URL including username
> is by default added to the commit message. Since it adds
> very little value but could be used by malicious people to
> glean valid usernames (with matching hostnames), we're far
> better off just stripping the username before storing the
> remote URL locally.

Uhm, this is for non-fast-forwards when pull uses "merge" and creates a
merge commit, right?
Fetch does not create commit messages, and pull does not either if it
rebases. So maybe the commit message could make it clearer for lesser
git-educated people such as myself ;)

Michael
> Signed-off-by: Andreas Ericsson <ae@op5.se>
> ---
>  builtin-fetch.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin-fetch.c b/builtin-fetch.c
> index 3c998ea..47fba00 100644
> --- a/builtin-fetch.c
> +++ b/builtin-fetch.c
> @@ -289,7 +289,48 @@ static int update_local_ref(struct ref *ref,
>  	}
>  }
>  
> -static int store_updated_refs(const char *url, const char *remote_name,
> +/*
> + * strip username information from the url
> + * This will allocate a new string, or return its argument
> + * if no stripping is necessary.
> + *
> + * The url's we want to catch are the following:
> + *   ssh://[user@]host.xz[:port]/path/to/repo.git/
> + *   [user@]host.xz:/path/to/repo.git/
> + *   http[s]://[user[:password]@]host.xz/path/to/repo.git
> + *
> + * Although git doesn't currently support giving the password
> + * to http url's on the command-line, it's easier to catch
> + * that case too than it is to cater for it specially.
> + */
> +static char *anonymize_url(const char *url)
> +{
> +	char *anon_url;
> +	const char *at_sign = strchr(url, '@');
> +	size_t prefix_len = 0;
> +
> +	if (!at_sign)
> +		return strdup(url);
> +
> +	if (!prefixcmp(url, "ssh://"))
> +		prefix_len = strlen("ssh://");
> +	else if (!prefixcmp(url, "http://"))
> +		prefix_len = strlen("http://");
> +	else if (!prefixcmp(url, "https://"))
> +		prefix_len = strlen("https://");
> +	else if (!strchr(at_sign + 1, ':'))
> +		return strdup(url);
> +
> +	anon_url = xcalloc(1, 1 + prefix_len +
> +			   ((unsigned long)at_sign - (unsigned long)url));
> +	if (prefix_len)
> +		memcpy(anon_url, url, prefix_len);
> +	memcpy(anon_url + prefix_len, at_sign + 1, strlen(at_sign + 1));
> +
> +	return anon_url;
> +}
> +
> +static int store_updated_refs(const char *raw_url, const char *remote_name,
>  		struct ref *ref_map)
>  {
>  	FILE *fp;
> @@ -298,11 +339,13 @@ static int store_updated_refs(const char *url, const char *remote_name,
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
> +	url = anonymize_url(raw_url);
>  	for (rm = ref_map; rm; rm = rm->next) {
>  		struct ref *ref = NULL;
>  
> @@ -376,6 +419,7 @@ static int store_updated_refs(const char *url, const char *remote_name,
>  				fprintf(stderr, " %s\n", note);
>  		}
>  	}
> +	free(url);
>  	fclose(fp);
>  	if (rc & 2)
>  		error("some local refs could not be updated; try running\n"
