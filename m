From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 RFC] verify_filename: ask the caller to chose the
 kind of diagnosis
Date: Sun, 17 Jun 2012 13:22:26 -0700
Message-ID: <7vehpd7kot.fsf@alter.siamese.dyndns.org>
References: <vpq395tvlc0.fsf@bauges.imag.fr>
 <1339958341-22186-1-git-send-email-Matthieu.Moy@imag.fr>
 <1339958341-22186-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Jun 17 22:22:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgLzp-0005Oz-Rz
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jun 2012 22:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398Ab2FQUWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jun 2012 16:22:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54477 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386Ab2FQUWa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2012 16:22:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6525685F0;
	Sun, 17 Jun 2012 16:22:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ApVzJpv7CDTQNCPCKAaq8UPkkSE=; b=vQJgdB
	F5g7HIqFGrnOsxpzPQ1UqbedPtG40F6tj+jO7Dyh4lA2trgOQzZ+BBavW0nl6Zdg
	lxotGix78AlnpxIz4+GgjqAr3sVEMCV5g8/q+P+cKefHIzufZ77D0cUmR8EBV0ox
	w8DLLLl8+UQu0SRM9n56fMIVv/loIEcZwIris=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BDkPmop3Xa3h6TZ4xWtewQAhhW1MKqmU
	lJFWQkUScjjwdymCsClAkWhxbdgoFecHoF8iB8/cez3sNcS36eG2+WPDngg+nZNl
	HIAOjlGsM5tF5onjY0KAGtXhfB933T3hkhb2IcZQq3l9DZr3sRSklhkiM2PXcPMr
	QZ4M2+5VtwY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B6E585ED;
	Sun, 17 Jun 2012 16:22:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAE6685E6; Sun, 17 Jun 2012
 16:22:28 -0400 (EDT)
In-Reply-To: <1339958341-22186-2-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Sun, 17 Jun 2012 20:39:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 28E1374A-B8BA-11E1-AE7A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200128>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> +/*
> + * Verify that "name" is a filename.
> + * The "diagnose_rev" is used to provide a user-friendly diagnosis. If
> + * 0, the diagnosis will try to diagnose "name" as an invalid object
> + * name (e.g. HEAD:foo). If non-zero, the diagnosis will only complain
> + * about an inexisting file.
> + */
> +extern void verify_filename(const char *prefix, const char *name, int diagnose_rev);

The whole point of verify_filename() is to make sure, because the
user did not have disambiguating "--" on the command line, that the
first non-rev argument is a path and also it cannot be interpreted
as a valid rev.  It somehow feels wrong to make it also responsible,
for a possibly misspelled rev.  The caller can mistakenly throw 0 or
1 at random but the _only_ right value for this parameter is to set
it to true only for the first non-rev, no?

Let's look at the patched sites.

> diff --git a/builtin/grep.c b/builtin/grep.c
> index fe1726f..41924dc 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -927,8 +927,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  	/* The rest are paths */
>  	if (!seen_dashdash) {
>  		int j;
> -		for (j = i; j < argc; j++)
> -			verify_filename(prefix, argv[j]);
> +		if (i < argc) {
> +			verify_filename(prefix, argv[i], 1);
> +			for (j = i + 1; j < argc; j++)
> +				verify_filename(prefix, argv[j], 0);
> +		}

This is exactly

	verify_filename(prefix, argv[j], j == first_non_rev)

> diff --git a/builtin/reset.c b/builtin/reset.c
> index 8c2c1d5..4cc34c9 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -285,7 +285,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  			rev = argv[i++];
>  		} else {
>  			/* Otherwise we treat this as a filename */
> -			verify_filename(prefix, argv[i]);
> +			verify_filename(prefix, argv[i], 1);

This is also checking the first non-rev, too.  We just saw
"florbl^{triee}" in "git reset florbl^{triee} hello.c" is not a
valid rev.  If "florbl^{triee}" is indeed a file, we shouldn't
complain and die with "This may be a misspelled rev", but take it as
a path.

> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 733f626..13495b8 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -486,7 +486,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  
>  		if (as_is) {
>  			if (show_file(arg) && as_is < 2)
> -				verify_filename(prefix, arg);
> +				verify_filename(prefix, arg, 0);
>  			continue;
>  		}
>  		if (!strcmp(arg,"-n")) {
> @@ -734,7 +734,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  		as_is = 1;
>  		if (!show_file(arg))
>  			continue;
> -		verify_filename(prefix, arg);
> +		verify_filename(prefix, arg, 1);
>  	}

These are, too.

> diff --git a/revision.c b/revision.c
> index 935e7a7..756196a 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1780,8 +1780,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  			 *     as a valid filename.
>  			 * but the latter we have checked in the main loop.
>  			 */
> -			for (j = i; j < argc; j++)
> -				verify_filename(revs->prefix, argv[j]);
> +			verify_filename(revs->prefix, arg, 1);			
> +			for (j = i + 1; j < argc; j++)
> +				verify_filename(revs->prefix, argv[j], 0);

Likewise.

> @@ -81,13 +83,13 @@ static void NORETURN die_verify_filename(const char *prefix, const char *arg)
>   * it to be preceded by the "--" marker (or we want the user to
>   * use a format like "./-filename")
>   */
> -void verify_filename(const char *prefix, const char *arg)
> +void verify_filename(const char *prefix, const char *arg, int diagnose_rev)
>  {
>  	if (*arg == '-')
>  		die("bad flag '%s' used after filename", arg);
>  	if (check_filename(prefix, arg))
>  		return;
> -	die_verify_filename(prefix, arg);
> +	die_verify_filename(prefix, arg, diagnose_rev);

And this implements the "if it is path, don't complain, but
otherwise diagnose misspelled rev if the caller asked us to".

I think the patch is not wrong per-se, but diagnose_rev is probably
misnamed.  It tells the callee what to do, but gives little hint to
the caller when to set it.  s/diagnose_rev/first_non_rev/ or
something might make it easier to understand for future callers.

Thanks.
