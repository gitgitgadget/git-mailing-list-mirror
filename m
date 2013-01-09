From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/19] reset.c: remove unnecessary variable 'i'
Date: Wed, 09 Jan 2013 11:39:50 -0800
Message-ID: <7vpq1e5ent.fsf@alter.siamese.dyndns.org>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1357719376-16406-7-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 20:40:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt1VW-0003Ny-BZ
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 20:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272Ab3AITjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 14:39:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60219 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932165Ab3AITjx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 14:39:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C94CADC4;
	Wed,  9 Jan 2013 14:39:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rm/QfD0h8LXtrxGeJSAMgn8WBEA=; b=WCe/gU
	flnlwpXUjv21GvDcRpc0ybpyNLR+fQHnHpPMIlwIr+jXiwM3b6Q252rhMJasJcGu
	sU0wASTcSxJDOdGZ8DiwgPMqe+SbevACNn8E9xeZBUIMaSfVI6KhnjcLaaj+o8n4
	2dfnvY+UoJon4pII/jWxkgQ5n5DeP8zQQV7qg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T2FkTR8jcY3Sl5wmBNxEX8OPcVpOmKgq
	1Yc604IRRsaVUNxGhaSZoCAK6BoJESRN4UVXDimWadWSFQ2RJK0Pa0joQDYJWngu
	GBfyF9A7sLEra0/AL5rD3qn3TYAzxR5t6QGeB/NESKuGWysQ4mNOeVWg4iM2SPR6
	t3GQckvSwsk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F14DADC3;
	Wed,  9 Jan 2013 14:39:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D05FAADBB; Wed,  9 Jan 2013
 14:39:51 -0500 (EST)
In-Reply-To: <1357719376-16406-7-git-send-email-martinvonz@gmail.com> (Martin
 von Zweigbergk's message of "Wed, 9 Jan 2013 00:16:03 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 562D8D94-5A94-11E2-9F2B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213086>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> Throughout most of parse_args(), the variable 'i' remains at 0. In the
> remaining few cases, we can do pointer arithmentic on argv itself
> instead.
> ---
> This is clearly mostly a matter of taste. The remainder of the series
> does not depend on it in any way.

I agree that it indeed is a matter of taste between

 (1) look at av[i], check with (i < ac) for the end, and increment i to
     iterate over the arguments; and

 (2) look at av[0], check with (0 < ac) for the end, and increment
     av and decrement ac at the same time to iterate over the
     arguments.

When (ac, av) appear as a pair, however, adjusting only av without
adjusting ac is asking for future trouble.  It violates a common
expectation that av[ac] points at the NULL at the end of the list.

If a code chooses to use !av[0] as the terminating condition and
never looks at ac, then incrementing only av is fine, but in such a
case, the function probably should lose ac altogether.

>  builtin/reset.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 9473725..68be05c 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -199,7 +199,6 @@ static void die_if_unmerged_cache(int reset_type)
>  }
>  
>  const char **parse_args(int argc, const char **argv, const char *prefix, const char **rev_ret) {
> -	int i = 0;
>  	const char *rev = "HEAD";
>  	unsigned char unused[20];
>  	/*
> @@ -210,34 +209,34 @@ const char **parse_args(int argc, const char **argv, const char *prefix, const c
>  	 * git reset [-opts] -- <paths>...
>  	 * git reset [-opts] <paths>...
>  	 *
> -	 * At this point, argv[i] points immediately after [-opts].
> +	 * At this point, argv points immediately after [-opts].
>  	 */
>  
> -	if (i < argc) {
> -		if (!strcmp(argv[i], "--")) {
> -			i++; /* reset to HEAD, possibly with paths */
> -		} else if (i + 1 < argc && !strcmp(argv[i+1], "--")) {
> -			rev = argv[i];
> -			i += 2;
> +	if (argc) {
> +		if (!strcmp(argv[0], "--")) {
> +			argv++; /* reset to HEAD, possibly with paths */
> +		} else if (argc > 1 && !strcmp(argv[1], "--")) {
> +			rev = argv[0];
> +			argv += 2;
>  		}
>  		/*
> -		 * Otherwise, argv[i] could be either <rev> or <paths> and
> +		 * Otherwise, argv[0] could be either <rev> or <paths> and
>  		 * has to be unambiguous.
>  		 */
> -		else if (!get_sha1_committish(argv[i], unused)) {
> +		else if (!get_sha1_committish(argv[0], unused)) {
>  			/*
> -			 * Ok, argv[i] looks like a rev; it should not
> +			 * Ok, argv[0] looks like a rev; it should not
>  			 * be a filename.
>  			 */
> -			verify_non_filename(prefix, argv[i]);
> -			rev = argv[i++];
> +			verify_non_filename(prefix, argv[0]);
> +			rev = *argv++;
>  		} else {
>  			/* Otherwise we treat this as a filename */
> -			verify_filename(prefix, argv[i], 1);
> +			verify_filename(prefix, argv[0], 1);
>  		}
>  	}
>  	*rev_ret = rev;
> -	return i < argc ? get_pathspec(prefix, argv + i) : NULL;
> +	return *argv ? get_pathspec(prefix, argv) : NULL;
>  }
>  
>  int cmd_reset(int argc, const char **argv, const char *prefix)
