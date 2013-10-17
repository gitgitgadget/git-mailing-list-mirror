From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] checkout: allow dwim for branch creation for "git checkout $branch --"
Date: Thu, 17 Oct 2013 11:09:37 -0700
Message-ID: <xmqqr4bj22hq.fsf@gitster.dls.corp.google.com>
References: <1380186486-8220-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, jc@sahnwaldt.de,
	jrnieder@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Oct 17 20:09:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWs13-0004HA-Dr
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 20:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758223Ab3JQSJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 14:09:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46637 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758160Ab3JQSJl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 14:09:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 545284B7BF;
	Thu, 17 Oct 2013 18:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7lddhV31JPHZT9ODgv68Zmz0KZs=; b=CRAE9r
	U5aD7orc50zt0NEATzNOHdM32Q4ahYcpTqqJQWypK9J1vHZyNSGjl437iuqfRxzk
	PAHQEXOdxTMDMIyLDQVbzal9V2bCvMNFXK9r+N1Z2e4i8gF5iq01h0QdfuWxGyhR
	fmGjsOMfovBPJ0vpzfPHw3ZYrSbdHjWfxZYEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l/cUBtL/Pruakhnq84FEdkL7tbYsWh6f
	cezIHubG5+n4IPl90UGcqaqyWTZfUSZZq26YVLs8lTJ+lzR4bQ7iLSrbg+Cv4W3e
	Z6fY3++n/po8uLE/k0J96WBbAxLaRzj7HVUIJ2hiEuupo9C6AdIE1ApArEfPsq98
	Wrk5k61SNMU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47AAD4B7BD;
	Thu, 17 Oct 2013 18:09:40 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94AEF4B7B8;
	Thu, 17 Oct 2013 18:09:39 +0000 (UTC)
In-Reply-To: <1380186486-8220-1-git-send-email-Matthieu.Moy@imag.fr> (Matthieu
	Moy's message of "Thu, 26 Sep 2013 11:08:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4A1A9880-3757-11E3-861D-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236304>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 0f57397..9edd9c3 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -863,6 +863,13 @@ static const char *unique_tracking_name(const char *name, unsigned char *sha1)
>  	return NULL;
>  }
>  
> +static int error_invalid_ref(const char *arg, int has_dash_dash, int argcount)
> +{
> +	if (has_dash_dash)
> +		die(_("invalid reference: %s"), arg);
> +	return argcount;
> +}

This is somewhat unfortunate; it pretends to be a reusable helper by
being a separate function, but it is not very reusable (see below).

> @@ -917,19 +934,32 @@ static int parse_branchname_arg(int argc, const char **argv,
>  		arg = "@{-1}";
>  
>  	if (get_sha1_mb(arg, rev)) {
> +		/*
> +		 * Either case (3) or (4), with <something> not being
> +		 * a commit, or an attempt to use case (1) with an
> +		 * invalid ref.
> +		 */
> +		int try_dwim = dwim_new_local_branch_ok;
> +
> +		if (check_filename(NULL, arg) && !has_dash_dash)
> +			try_dwim = 0;
> +		/*
> +		 * Accept "git checkout foo" and "git checkout foo --"
> +		 * as candidates for dwim.
> +		 */
> +		if (!(argc == 1 && !has_dash_dash) &&
> +		    !(argc == 2 && has_dash_dash))
> +			try_dwim = 0;
> +
> +		if (try_dwim) {
>  			const char *remote = unique_tracking_name(arg, rev);

Up to this point, the updated code makes very good sense.

>  			if (!remote)
> -				return argcount;
> +				return error_invalid_ref(arg, has_dash_dash, argcount);

The original that returned "argcount" from here were unnecessarily
misleading in the first place. It saw "git checkout foo" where "foo"
does not refer to an object nor a filesystem entity and there was no
unique "refs/remotes/*/foo"; it wanted to return 0 to tell the
caller that it consumed zero arguments as branch names.

And the updated code is even more obscure.  This calling site makes
it look as if it is an error to have no unique "refs/remotes/*/foo"
at this point of the code by naming the helper function "error_*()",
but it is an error in some case and not in others.

                if (!remote) {
                        if (has_dash_dash)
                                die(_("..."));
                        return 0;
                }

would be a lot more understandable.
		
The only reason you have conditional die() here (and on the "else"
side of this "if" statement) is because you delayed the die that was
at a much earlier point in the original.  And the only reason you
created the unfortunate helper function is because you need to deal
with that delayed decision to die now in two places.

So it may be even cleaner to read if you did it this way:

	if (get_sha1_mb(...)) {
		/*
		 * The first token is not a valid rev; we should
		 * ordinarily error out if "git checkout foo --"
		 * if foo is not a valid rev, but first see if
		 * we can auto-create foo to continue...
		 */
		int recover_with_dwim = dwim_new_local_branch_ok;

		... decide if we want to recover_with_dwim ...

		if (recover_with_dwim) {
			const char *remote = unique_tracking_name(arg, rev);
			if (remote) {
				*new_branch = arg;
				arg = remote;
			} else {
				/* no; arg cannot be salvaged */
				recover_with_dwim = 0;
			}
		}

		if (!recover_with_dwim) {
			if (has_dash_dash)
				die(_("invalid ref %s", arg);
			return 0; /* we saw no branch/commit */
		}
		/* otherwise we made a successful recovery */
	}
