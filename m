From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] builtin-remote: add set-head verb
Date: Fri, 13 Feb 2009 02:09:01 -0800
Message-ID: <7vtz6yabsy.fsf@gitster.siamese.dyndns.org>
References: <1234515275-91263-1-git-send-email-jaysoffian@gmail.com>
 <1234515275-91263-2-git-send-email-jaysoffian@gmail.com>
 <1234515275-91263-3-git-send-email-jaysoffian@gmail.com>
 <1234515275-91263-4-git-send-email-jaysoffian@gmail.com>
 <1234515275-91263-5-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, barkalow@iabervon.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 11:10:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXv0K-00023d-Ap
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 11:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbZBMKJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 05:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbZBMKJM
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 05:09:12 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53282 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbZBMKJL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 05:09:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 14B289950E;
	Fri, 13 Feb 2009 05:09:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 402849950B; Fri,
 13 Feb 2009 05:09:02 -0500 (EST)
In-Reply-To: <1234515275-91263-5-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Fri, 13 Feb 2009 03:54:35 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5A9D4A10-F9B6-11DD-BE13-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109736>

Jay Soffian <jaysoffian@gmail.com> writes:

> Provide a porcelain command for setting/deleting
> $GIT_DIR/remotes/<remote>/HEAD.

The entire series looks sane from a very cursory look; especially the
earlier ones are obviously good.

Calling the subcommand a "verb" is somewhat new, though.  Existing
documentation for git commands that take multiple actions seem to call
them subcommands, including "git-remote.txt" itself.

> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> index fad983e..80f2cfe 100644
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
> @@ -76,6 +76,22 @@ the configuration file format.
>  Remove the remote named <name>. All remote tracking branches and
>  configuration settings for the remote are removed.
>  
> +'set-head'::
> +
> +Sets or deletes the default branch (`$GIT_DIR/remotes/<name>/HEAD`) for
> +the named remote. Having a default branch for a remote is not required,
> +but allows the name of the remote to be specified in lieu of a specific
> +branch. For example, if the default branch for `origin` is set to
> +`master`, then `origin` may be specified wherever you would normally
> +specify `origin/master`.
> ++
> +With `-d`, `$GIT_DIR/remotes/<name>/HEAD` is deleted.
> ++
> +With `-a`, the remote is queried to determine its `HEAD`, then
> +`$GIT_DIR/remotes/<name>/HEAD` is set to the same branch.
> ++
> +Use `<branch>` to set `$GIT_DIR/remotes/<name>/HEAD` explicitly.
> +

Hmph, what does "-a" stand for?  I would have expected to see "-u" that
stands for "update" here.

Also it may be better to be more explicit about both the syntax and the
semantics of `<branch>`.  Do you expect "refs/remotes/<name>/master" or
just "master" (I assume the latter)?  Is it an error if the branch does
not exist in the specified hierarchy?  Can you force to set to a branch
that does not exist in your tracking side (yet) but you know exists on the
remote side already?

> diff --git a/builtin-remote.c b/builtin-remote.c
> index 465c87a..677e20e 100644
> --- a/builtin-remote.c
> +++ b/builtin-remote.c
> @@ -658,7 +659,8 @@ static void free_remote_ref_states(struct ref_states *states)
>  	string_list_clear(&states->new, 0);
>  	string_list_clear(&states->stale, 0);
>  	string_list_clear(&states->tracked, 0);
> -	free(states->head_name);
> +	if (states->head_name)
> +		free(states->head_name);
>  }

Regression?

> @@ -777,6 +779,54 @@ static int show(int argc, const char **argv)
>  	return result;
>  }
>  
> +static int sethead(int argc, const char **argv)

set_head()?

> +{
> +	int opt_a = 0, opt_d = 0, result = 0;
> +	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
> +	char *head_name = NULL;
> +
> +	struct option options[] = {
> +		OPT_GROUP("set-head specific options"),
> +		OPT_BOOLEAN('a', 0, &opt_a,
> +		            "set refs/remotes/<name>/HEAD according to remote"),
> +		OPT_BOOLEAN('d', 0, &opt_d, "delete refs/remotes/<name>/HEAD"),
> +		OPT_END()
> +	};
> +	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
> +	if ((argc == 1 && !(opt_a || opt_d)) ||
> +	   ((argc == 2 && (opt_a || opt_d))) || argc < 1 || argc > 2)
> +		usage_with_options(builtin_remote_usage, options);

The code will scale better, especially for a young subcommand that may acquire
new options, if the check is done by each codepath that deals with a
specific option to do this kind of check.  That is, e.g.

	if (opt_delete) {
        	error if the arg is not remote (alone)
                do the "delete" thing
	} else if (opt_update) {
        	error if the arg is not remote (alone)
                do the "update" thing
	} else {
        	error if the args are not (remote, branch)
		do the "set" thing
	}
