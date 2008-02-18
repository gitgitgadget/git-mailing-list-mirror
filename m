From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add support for host aliases in config files
Date: Sun, 17 Feb 2008 20:52:00 -0800
Message-ID: <7vskzquarz.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802171337000.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 05:53:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQxzu-0003pi-BU
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 05:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756391AbYBREwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 23:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756308AbYBREwX
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 23:52:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54107 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756199AbYBREwW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 23:52:22 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D8F9F6284;
	Sun, 17 Feb 2008 23:52:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 465626283; Sun, 17 Feb 2008 23:52:15 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802171337000.5816@iabervon.org> (Daniel
 Barkalow's message of "Sun, 17 Feb 2008 13:38:51 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74228>

Daniel Barkalow <barkalow@iabervon.org> writes:

> ..., but I'd like to get the 
> code portion out there are reviewed, at least, since I think last time, 
> the patch only got as far as a discussion of how I should explain what it 
> does.

I actually think that is the most important part to get it right
first.  I usually do not have to read the patch text to reject
an ill-conceived idea if the description is unclear and/or
unconvincing.

I think the documentation (I removed from the quote) shows the
feature is unambiguously good.

> diff --git a/remote.c b/remote.c
> index 6b56473..59338a3 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2,6 +2,15 @@
>  #include "remote.h"
>  #include "refs.h"
>  
> +struct host {
> +	const char *name;
> +
> +	const char *base;
> +
> +	const char **alias;
> +	int alias_nr;
> +};

Extra blank lines?

> @@ -11,9 +20,32 @@ static int allocated_branches;
>  static struct branch *current_branch;
>  static const char *default_remote_name;
>  
> +static struct host **hosts;
> +static int allocated_hosts;

The allocation in remote.c file is unusual from the rest of git
that usually follow the technical/api-allocation-growing
convention (the comment unfortunately applies to the code we
already have there).

> +static const char *alias_url(const char *url)
> +{
> +	int i, j;
> +	for (i = 0; i < allocated_hosts; i++) {
> +		if (!hosts[i])
> +			continue;
> +		for (j = 0; j < hosts[i]->alias_nr; j++) {
> +			if (!prefixcmp(url, hosts[i]->alias[j])) {
> +				char *ret = malloc(strlen(hosts[i]->base) -
> +						   strlen(hosts[i]->alias[j]) +
> +						   strlen(url) + 1);
> +				strcpy(ret, hosts[i]->base);
> +				strcat(ret, url + strlen(hosts[i]->alias[j]));
> +				return ret;
> +			}

First match semantics is fine during runtime but at some point
we would want a "config file lint" that points out ambiguous
aliases perhaps?

> +static struct host *make_host(const char *name, int len)
> +{
> ...
> +	if (empty < 0) {
> +		empty = allocated_hosts;
> +		allocated_hosts += allocated_hosts ? allocated_hosts : 1;
> +		hosts = xrealloc(hosts,
> +				 sizeof(*hosts) * allocated_hosts);

This hand-rolled allocation growing is quite different from the
rest of our codebase.

> +static void add_alias(struct host *host, const char *name)
> +{
> +	int nr = host->alias_nr + 1;
> +	host->alias =
> +		xrealloc(host->alias, nr * sizeof(char *));
> +	host->alias[nr-1] = name;
> +	host->alias_nr = nr;
> +}

And this "add one-by-one" allocation, too.

> @@ -154,7 +233,7 @@ static void read_remotes_file(struct remote *remote)
>  
>  		switch (value_list) {
>  		case 0:
> -			add_url(remote, xstrdup(s));
> +			add_url_alias(remote, xstrdup(s));
>  			break;
>  		case 1:
>  			add_push_refspec(remote, xstrdup(s));
> @@ -206,7 +285,7 @@ static void read_branches_file(struct remote *remote)
>  	} else {
>  		branch = "refs/heads/master";
>  	}
> -	add_url(remote, p);
> +	add_url_alias(remote, p);
>  	add_fetch_refspec(remote, branch);
>  	remote->fetch_tags = 1; /* always auto-follow */
>  }

These two are logical and clean updates.

> @@ -236,6 +315,20 @@ static int handle_config(const char *key, const char *value)
>  		}
>  		return 0;
>  	}
> +	if (!prefixcmp(key, "host.")) {
> +		struct host *host;
> +		name = key + 5;
> +		subkey = strrchr(name, '.');
> +		if (!subkey)
> +			return 0;

This "ignore this entry" is good.  We might later want to add
host.<var> that is not about a specific host, and we would want
to be able to read a configuration that is written for such a
future version of git.

> +		host = make_host(name, subkey - name);
> +		if (!value)
> +			return 0;

This is not.

 (1) We should barf saying "host.<this-host>.<var> configuration
     should be a string", for base and rewritebase, instead of
     silently ignoring such a misconfiguration;

 (2) We should _not_ do such barfing for future variables that
     are not base nor rewritebase, so this "return" is at a
     wrong place.

So the code should do this part (perhaps with git_config_string())
first,...

> +		if (!strcmp(subkey, ".base"))
> +			host->base = xstrdup(value);
> +		else if (!strcmp(subkey, ".rewritebase"))
> +			add_alias(host, xstrdup(value));

... and then ignore anything other than host.<this-host>.{base,rewritebase}
that may mean something in future versions of git.
