From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] add -A: only show pathless 'add -A' warning when
 changes exist outside cwd
Date: Wed, 20 Mar 2013 08:30:45 -0700
Message-ID: <7v1ubagkbe.fsf@alter.siamese.dyndns.org>
References: <1362786889-28688-1-git-send-email-gitster@pobox.com>
 <20130319224400.GA19014@google.com> <20130319225134.GF19014@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 16:31:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIKyz-00071K-Og
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 16:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413Ab3CTPau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 11:30:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45173 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755465Ab3CTPat (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 11:30:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A1FD92FD;
	Wed, 20 Mar 2013 11:30:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JMTRNLFHMvjKp44plWJtso0d/00=; b=d1te9u
	zZEEZMrr3bUTeZtUW65KYCdc6E9oKWIn++jewGIDVvFI0TXAOBGjXuIh/TSKB9Wb
	UDXaL7QKy7XgUscRdPg9tgImQWNEEY1VQVG5JG1jjfUajLNlc5zedLZHdVKpkKIo
	sRZApgpQnqCUN8CHfE94b0H7AJ33YV3ymlqRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=invNXNpVGxXluz405fljyjQOkT10IqVz
	BTNAPvutcj/0KMicfBG65SDmrwtQwxoiiZNCERB5v+9m0KNvzhsRCBgR1XVQEjZ/
	8lVurK/BJ+tPKa6DJhdtTABbJio8bkLEkQjuzqknrQBlJfaIT0QhtVlKGskbCtEa
	0R4pxXolsxY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CE3C92FC;
	Wed, 20 Mar 2013 11:30:49 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3988692F4; Wed, 20 Mar 2013
 11:30:48 -0400 (EDT)
In-Reply-To: <20130319225134.GF19014@google.com> (Jonathan Nieder's message
 of "Tue, 19 Mar 2013 15:51:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 23DB8434-9173-11E2-AB1B-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218614>

Jonathan Nieder <jrnieder@gmail.com> writes:

> In the spirit of the recent similar change for 'git add -u', avoid
> pestering users that restrict their attention to a subdirectory and
> will not be affected by the coming change in the behavior of pathless
> 'git add -A'.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> As before.

Have you considered implementing this by adding a separate check
immediately after fill_directory() to inspect the paths in dir with
the same strncmp_icase() against the prefix, without touching
prune_directory() at all?  I suspect that would be much cleaner and
easier to change in the version boundary.

Same comment about measuring the size of the working tree and the
area the user is working on applies to this.  After Git 2.0, we
would still want to advise users who say "git add -A" without
pathspecs to see if the user would have been better off with an
explicit ".", so unless advice.addUAuseexplicitdot is set to false,
we would still want to inspect the result from fill_directory (and
in that case we won't be calling into prune_directory).

>  builtin/add.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 4d8d441..2493493 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -170,7 +170,9 @@ int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
>  	return !!data.add_errors;
>  }
>  
> -static char *prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
> +#define WARN_IMPLICIT_DOT (1u << 0)
> +static char *prune_directory(struct dir_struct *dir, const char **pathspec,
> +			     int prefix, unsigned flag)
>  {
>  	char *seen;
>  	int i, specs;
> @@ -187,6 +189,16 @@ static char *prune_directory(struct dir_struct *dir, const char **pathspec, int
>  		if (match_pathspec(pathspec, entry->name, entry->len,
>  				   prefix, seen))
>  			*dst++ = entry;
> +		else if (flag & WARN_IMPLICIT_DOT)
> +			/*
> +			 * "git add -A" was run from a subdirectory with a
> +			 * new file outside that directory.
> +			 *
> +			 * "git add -A" will behave like "git add -A :/"
> +			 * instead of "git add -A ." in the future.
> +			 * Warn about the coming behavior change.
> +			 */
> +			warn_pathless_add();
>  	}
>  	dir->nr = dst - dir->entries;
>  	add_pathspec_matches_against_index(pathspec, seen, specs);
> @@ -433,8 +445,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  	}
>  	if (option_with_implicit_dot && !argc) {
>  		static const char *here[2] = { ".", NULL };
> -		if (prefix && addremove)
> -			warn_pathless_add();
>  		argc = 1;
>  		argv = here;
>  		implicit_dot = 1;
> @@ -475,9 +485,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  		}
>  
>  		/* This picks up the paths that are not tracked */
> -		baselen = fill_directory(&dir, pathspec);
> +		baselen = fill_directory(&dir, implicit_dot ? NULL : pathspec);
>  		if (pathspec)
> -			seen = prune_directory(&dir, pathspec, baselen);
> +			seen = prune_directory(&dir, pathspec, baselen,
> +					implicit_dot ? WARN_IMPLICIT_DOT : 0);
>  	}
>  
>  	if (refresh_only) {
