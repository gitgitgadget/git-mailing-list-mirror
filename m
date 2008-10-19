From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Sun, 19 Oct 2008 14:26:03 -0700
Message-ID: <7vy70k5las.fsf@gitster.siamese.dyndns.org>
References: <1224445691-1366-1-git-send-email-tuncer.ayaz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 11:27:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Krfo8-0002nv-0b
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 23:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbYJSV0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 17:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbYJSV0M
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 17:26:12 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57842 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbYJSV0L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 17:26:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B1F768D607;
	Sun, 19 Oct 2008 17:26:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0A1E48D606; Sun, 19 Oct 2008 17:26:05 -0400 (EDT)
In-Reply-To: <1224445691-1366-1-git-send-email-tuncer.ayaz@gmail.com> (Tuncer
 Ayaz's message of "Sun, 19 Oct 2008 21:48:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8C13D0A2-9E24-11DD-BD3F-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98634>

Tuncer Ayaz <tuncer.ayaz@gmail.com> writes:

> 2) my adaption of the following two lines from
> builtin-fetch.c to the new verbosity option:
>     if (verbosity == VERBOSE)
>         transport->verbose = 1;
>     if (verbosity == QUIET)
>         transport->verbose = -1;

Hmm, what's wrong with it?  Looks Ok to me...

>  static struct option builtin_fetch_options[] = {
> -	OPT__QUIET(&quiet),
> -	OPT__VERBOSE(&verbose),
> +	{ OPTION_CALLBACK, 'q', "quiet", NULL, NULL,
> +		"operate quietly",
> +		PARSE_OPT_NOARG, option_parse_quiet },
> +	{ OPTION_CALLBACK, 'v', "verbose", NULL, NULL,
> +		"be verbose",
> +		PARSE_OPT_NOARG, option_parse_verbose },

Isn't there a OPTION_FOO that assigns a constant to the given variable?

> @@ -192,7 +211,6 @@ static int s_update_ref(const char *action,
>  
>  static int update_local_ref(struct ref *ref,
>  			    const char *remote,
> -			    int verbose,
>  			    char *display)
>  {
>  	struct commit *current = NULL, *updated;
> ...
> @@ -366,18 +384,19 @@ static int store_updated_refs(const char *url, const char *remote_name,
>  			note);
>  
>  		if (ref)
> -			rc |= update_local_ref(ref, what, verbose, note);
> +			rc |= update_local_ref(ref, what, note);

Hmph, in the existing code, do_fetch()->fetch_refs()->store_updated_refs()
callchain relies on the "verbose" to be global anyway, so losing the
ability to call update_local_ref() with verbosity as parameter is not a
huge deal.

I however think it would be more beneficial in the longer term to keep
"verbosity" as parameter so the caller can tweak what the callee does, and
making large part of what cmd_fetch() does callable from outside.  That
would involve making the builtin_fetch_options[] on-stack, and passing
verbosity (and possibly other variables currently used as file-scope
global) as parameters, which is outside of the scope of your patch, but it
is something to keep in mind.

> diff --git a/git-pull.sh b/git-pull.sh
> index 75c3610..dc613db 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -16,6 +16,7 @@ cd_to_toplevel
>  test -z "$(git ls-files -u)" ||
>  	die "You are in the middle of a conflicted merge."
>  
> +verbosity=
>  strategy_args= no_stat= no_commit= squash= no_ff= log_arg=
>  curr_branch=$(git symbolic-ref -q HEAD)
>  curr_branch_short=$(echo "$curr_branch" | sed "s|refs/heads/||")

It would fit at the end of the next line just fine, wouldn't it?

> @@ -23,6 +24,10 @@ rebase=$(git config --bool branch.$curr_branch_short.rebase)
>  while :
>  do
>  	case "$1" in
> +	-q|--quiet)
> +		verbosity="$verbosity -q" ;;
> +	-v|--verbose)
> +		verbosity="$verbosity -v" ;;

You know verbosity flags (-q and -v) are "the last one wins", so I do not
see much point in this concatenation.
