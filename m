From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Add support for merging from upstream by default.
Date: Tue, 8 Feb 2011 16:33:59 -0600
Message-ID: <20110208223359.GB17981@elie>
References: <1297198129-3403-1-git-send-email-jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Bert Wesarg <bert.wesarg@gmail.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 23:34:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmw8V-0007yR-6O
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 23:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755897Ab1BHWeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 17:34:07 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61593 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755873Ab1BHWeF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 17:34:05 -0500
Received: by gyb11 with SMTP id 11so2503638gyb.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 14:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=9D7q9fNjAfxA3WBOJ4aFgbhdjK5KLJCDEA820uBVYPA=;
        b=N9nJk9AR3BlHC4OCPkQomVM2aGCky9425fOfpUtFERJLPaH0IZT1kThK3Np9EAKKQY
         k69vYxjZGcJe2yVSWgP7A0rDANyrl1l4KkkEVJUskENFlPaDWIjW2eQvFOhBUJ0mQeqK
         niJ58rvmgdlWQikF1R3mEkQ9KSDpIK0gxVoBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jgd4yoMb2vhWI11AJ+Hxymb1malXPh/345M6RNK4IZw3X4F1GzwRstRqOwBmFlQUpR
         a8bKJTJrJGnq8NVXIwDA36vhXDb+HDFe1SaPDYijp5g/7k7DopUUV3+jlSpW/6dn5Uhl
         xrtA+ADXgUU87UswLql/oJgGtOzy/zWR/hsTs=
Received: by 10.236.105.199 with SMTP id k47mr2037523yhg.90.1297204444512;
        Tue, 08 Feb 2011 14:34:04 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id n63sm4069867yha.20.2011.02.08.14.34.01
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 08 Feb 2011 14:34:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297198129-3403-1-git-send-email-jaredhance@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166371>

Jared Hance wrote:

> Adds the option merge.defaultupstream to add support for merging from the
> upstream branch by default.

Could you give an example of breakage this configurability is designed
to prevent?

Not that it is a bad idea to be careful anyway, mind you --- just
looking for a clear answer for when people ask "and why would I ever
want to set merge.defaultToUpstream to false?"

> reduce reduncancy and impove clarity.

redundancy, improve :)

> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1389,6 +1389,11 @@ man.<tool>.path::
>  
>  include::merge-config.txt[]
>  
> +merge.defaultUpstream::
> +	If merge is called without any ref arguments, merge from the branch
> +	specified in branch.<current branch>.merge, which is considered to be
> +	the upstream branch for the current branch.

I'd prefer to say "merge from the branch configured with --track or
--set-upstream" (but that's just me).

> +++ b/builtin/merge.c
> @@ -37,7 +37,7 @@ struct strategy {
>  };
>  
>  static const char * const builtin_merge_usage[] = {
> -	"git merge [options] <remote>...",
> +	"git merge [options] [<remote>...]",
>  	"git merge [options] <msg> HEAD <remote>",
>  	NULL

Side note: these should probably say "<commit>" or "<branch>" rather
than "<remote>".  I'm guessing the usage string comes from the days
before the separate-remotes ref layout...

> @@ -58,6 +58,8 @@ static int option_renormalize;
[...]
> -static int git_merge_config(const char *k, const char *v, void *cb)
> +static int per_branch_config(const char *k, const char *v, void *cb)
>  {
> -	if (branch && !prefixcmp(k, "branch.") &&
> -		!prefixcmp(k + 7, branch) &&
> -		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
> +	const char *variable;
> +	if(!branch || prefixcmp(k, "branch.")
> +	   || prefixcmp(k + 7, branch))
> +		return 1; /* ignore me */

Style: missing space after "if" keyword.

Clarity: we are not supposed to _ignore_ the non-branch.*
configuration, just leave it for other functions to handle, no?
Maybe the comment should say "let others handle it" or something?

> +
> +	variable = k + 7 + strlen(branch);

'7' can be written in a more self-explanatory way as 'strlen("branch.")'
and the optimizer will take care of translating it to 7.  Don't worry
about it if that makes the diff or code harder to read, though; I'm
just mentioning the trick for future reference.

> +	if(!strcmp(variable, ".mergeoptions")) {

Style: missing space after "if" keyword.

> @@ -518,9 +524,26 @@ static int git_merge_config(const char *k, const char *v, void *cb)
>  		parse_options(argc, argv, NULL, builtin_merge_options,
>  			      builtin_merge_usage, 0);
>  		free(buf);
> +
> +		return 0;

I'd group the cleanup with the return.

	parse_options(...);

	free(buf);
	return 0;

>  	}
> +	else if(strcmp(variable, ".merge")) {

Style: missing space after "if".  Uncuddled brace.

[...]
> @@ -911,6 +934,24 @@ static int evaluate_result(void)
>  	return cnt;
>  }
>  
> +static void setup_merge_commit(struct strbuf *buf,
> +	struct commit_list ***remotes, const char *s)
> +{
> +	struct object *o;
> +	struct commit *commit;
> +
> +	o = peel_to_type(s, 0, NULL, OBJ_COMMIT);
> +	if (!o)
> +		die("%s - not something we can merge", s);
> +	commit = lookup_commit(o->sha1);
> +	commit->util = (void *)s;
> +	*remotes = &commit_list_insert(commit, *remotes)->next;
> +
> +	strbuf_addf(buf, "GITHEAD_%s", sha1_to_hex(o->sha1));
> +	setenv(buf->buf, s, 1);
> +	strbuf_reset(buf);
> +}

Would be easier to review if this code movement were in a separate
patch (separating cleanup from semantic changes).

> @@ -983,9 +1024,15 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  	if (!allow_fast_forward && fast_forward_only)
>  		die("You cannot combine --no-ff with --ff-only.");
>  
> -	if (!argc)
> -		usage_with_options(builtin_merge_usage,
> -			builtin_merge_options);
> +	if (!argc) {
> +		if(default_upstream && upstream_branch) {

Style: missing space after "if".  Unnecessary braces.  To avoid
keeping the reader in suspense, it's usually best to handle the
(simple) error case first, like so:

		if (!default_upstream || !upstream_branch)
			usage_with_options(...);
		setup_merge_commit(...);

[...]
> @@ -1048,7 +1095,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>  
> -	if (head_invalid || !argc)
> +	if (head_invalid || (!argc && !(default_upstream && upstream_branch)))

Might be clearer to split the line?

	if (head_invalid
	    || (!argc && (!default_upstream || !upstream_branch)))
		usage_with_options(...);
    
Even better would be to use descriptive messages, like so:

 if (head_invalid)
	usage_msg_opt("cannot use old-style invocation from an unborn branch",
		...);
 if (!argc && ...)
	usage_msg_opt("no commit to merge specified", ...);

Thanks for making this happen. :)
Jonathan
