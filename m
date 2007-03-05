From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] git-branch: add --track and --no-track options
Date: Mon, 5 Mar 2007 15:50:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703051520340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <esgm1m$33f$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 15:50:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOEW7-0003ft-JJ
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 15:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933493AbXCEOuU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 09:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933496AbXCEOuU
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 09:50:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:52487 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933493AbXCEOuT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 09:50:19 -0500
Received: (qmail invoked by alias); 05 Mar 2007 14:50:17 -0000
X-Provags-ID: V01U2FsdGVkX1/rxmUF3ObrkuRA1AEL25nMfw6sXk7M5jnzXWbuTV
	sNFAJl4nvnmPbc
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <esgm1m$33f$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41445>

Hi,

it is a very good idea to read the information which remote tracks which 
branch from the config, i.e. if you branch "refs/remotes/hallo", to look 
if there is any remote information for that local ref.

On Mon, 5 Mar 2007, Paolo Bonzini wrote:

> diff --git a/builtin-branch.c b/builtin-branch.c
> index d371849..f39759b 100644
> --- a/builtin-branch.c
> +++ b/builtin-branch.c
> @@ -12,7 +12,7 @@
>  #include "builtin.h"
>  
>  static const char builtin_branch_usage[] =
> -  "git-branch [-r] (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [--color | --no-color] [-r | -a] [-v [--abbrev=<length> | --no-abbrev]]";
> +  "git-branch [-r] (-d | -D) <branchname> | [--track | --no-track] [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [--color | --no-color] [-r | -a] [-v [--abbrev=<length> | --no-abbrev]]";
>  
>  #define REF_UNKNOWN_TYPE    0x00
>  #define REF_LOCAL_BRANCH    0x01
> @@ -308,14 +308,105 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev)
>  	free_ref_list(&ref_list);
>  }
>  
> +

extra empty line.

> +static void get_remote_branch_name(const char* value)
> +{
> +	int len_first = -1, len_second = -1;
> +	if (*value == '+')
> +		value++;
> +

> +	/* Try an exact match first.  */
> +	sscanf(value, "refs/%*[^:]:%n", &len_first);

This is the first time I saw that sscanf format type. How portable is it?

> +	if (len_first != -1
> +	    && !strcmp(value + len_first, start_ref)) {

I really would rather do

	const char *p;
	if (!prefixcmp(value, "refs/") && (p = strchr(value, ':')) &&
			!strcmp(p + 1, start_ref)) {

> +		/* Truncate the value before the colon.  */
> +		asprintf(&config_repo, "%.*s", len_first - 1, value);

asprintf() is a GNU extension. I guess it is better to just

	config_repo = xstrdup(value);
	config_repo[p - value] = '\0';


> +		return;
> +	}
> +
> +	/* Try with a wildcard match now.  */
> +	sscanf(value, "refs/%*[^/]/*:%nrefs/remotes/%*[^/]/*%n",
> +	       &len_first, &len_second);
> +	if (len_first != -1 && len_second != -1
> +	    && (len_second - 2) - len_first == remote_len + 13
> +	    && !strncmp(value + len_first, start_ref, remote_len + 13)) {
> +		/* Replace the star with the remote branch name.  */
> +		asprintf(&config_repo, "%.*s%s",
> +			 len_first - 3, value,
> +			 start_ref + remote_len + 13);

Same here:

	else if (!prefixcmp(value, "refs/") && (p = strchr(value, ':')) &&
			!memcmp(p + 1, start_ref, remote_len) &&
			!strcmp(p + 1 + remote_len, "/*")) {
		config_repo = xstrdup(value);
		config_repo[p - value] = '\0';
	}

BTW I prefer to skip the curly brackets when there is only one statement 
in the block.

Just to be on the safe side, you might want to check here if there are 
more than one remotes "tracking" into start_ref. However, it might not be 
relevant in practice.

> +	}
> +}
> +
> +static int get_remote_config(const char* key, const char* value)
> +{
> +        if (!prefixcmp(key, "remote.") &&
> +            !strncmp(key + 7, start_ref + 13, remote_len)) {
> +		if (config_track == -1
> +		    && !strcmp(key + 7 + remote_len, ".trackintolocalbranches"))

FWIW I don't think .trackIntoLocalBranches" is needed. Opinions?

> +static void register_pull(const char *name, const char *real_ref, int track)

Maybe call it "set_branch_defaults()"?

> +			die("what a long branch name you have!");
> +			goto out;

die() does not return, so no need to "goto out;"... But then, it might be 
nicer to return -1, i.e.

			ret = error("what a long branch name you have!");

and saying
		if (!ret) {
			git_config_set(key, value);
			...
			printf("Branch %s setup...
		}
	}
	if (repo_config)
		free(repo_config);
	return ret;

But I see you made it return "void", so you can skip the "return ret;".

> @@ -333,7 +424,9 @@ static void create_branch(const char *name, const char *start_name,
>  	if (start_sha1)
>  		/* detached HEAD */
>  		hashcpy(sha1, start_sha1);
> -	else if (get_sha1(start_name, sha1))
> +	else if (dwim_ref(start_name, strlen(start_name), sha1, &real_ref) > 1)
> +		die("Ambiguous object name: '%s'.", start_name);

I know, I should have said that earlier, but I just found out myself: We 
have a config variable core.warnambiguousrefs, and maybe we should _not_ 
complain and set the defaults when the global variable warn_ambiguous_refs 
is 0.

Ciao,
Dscho
