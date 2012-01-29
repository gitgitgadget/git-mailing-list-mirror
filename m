From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2] grep: Add the option '--exclude'
Date: Sun, 29 Jan 2012 15:02:57 -0800
Message-ID: <7vvcnudsda.fsf@alter.siamese.dyndns.org>
References: <1327876934-61526-1-git-send-email-surfingalbert@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Albert Yale <surfingalbert@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 00:03:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrdm7-0002yS-0U
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 00:03:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922Ab2A2XDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 18:03:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35747 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654Ab2A2XDA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 18:03:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40927750C;
	Sun, 29 Jan 2012 18:02:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sqP1Tn4M/sYcgW9FtDoDKmqQTnA=; b=fJt9Rk
	ED3v8iFcgJuspylCm7GiBIAOW5tTK3MQwhdJKnT6K7hYsg+KBRV5N1YbK+mWTnQN
	E271cAeWnMFI6vCV+8dtFSnV57JYaWf+WDbdCkPl2JQN9TmxFXDqIfZL7eCMhn1w
	ooo7Dk3nGfKrQ0jKY87M9Y15xaTrDUxY1FfPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x2D3i47096myEJAYp61OO51h5+zEjTwx
	K2DZep4OMdvO1fM6fS4r7u47X5tkD6ZfQifzsqCDSU2NO6HLSONAoPmJiJOPWd67
	aAK0mz+xIkaFPQVE1lHXAuXIcr4UL42uuu6xg0hZFl8HYO0aB5NJ5S/Ur44vK+5z
	6AFj2paYaUo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3673E750B;
	Sun, 29 Jan 2012 18:02:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAD8C750A; Sun, 29 Jan 2012
 18:02:58 -0500 (EST)
In-Reply-To: <1327876934-61526-1-git-send-email-surfingalbert@gmail.com>
 (Albert Yale's message of "Sun, 29 Jan 2012 17:42:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6303A008-4ACD-11E1-BEEB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189300>

Albert Yale <surfingalbert@gmail.com> writes:

> Feedback would again be appreciated,

Hmm.

>  	   [-f <file>] [-e] <pattern>
> +	   [-x<pattern>|--exclude<pattern>]

Compare the above two lines and notice some funny in the added one?

> @@ -124,6 +125,12 @@ OPTIONS
>  	Use fixed strings for patterns (don't interpret pattern
>  	as a regex).
>  
> +-x<pattern>::
> +--exclude<pattern>::
> +	In addition to those found in .gitignore (per directory) and
> +	$GIT_DIR/info/exclude, also consider these patterns to be in the
> +	set of the ignore rules in effect.
> +

Likewise.

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 9ce064a..9772fa4 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -530,6 +530,10 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int
>  			continue;
>  		if (!match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, NULL))
>  			continue;
> +		if (pathspec->exclude &&
> +			pathspec->exclude->nr &&
> +			match_pathspec_depth(pathspec->exclude, ce->name, ce_namelen(ce), 0, NULL))
> +			continue;

Why isn't this just

	if (!match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, NULL))

that is, *no change whatsoever* on the existing codepaths that call
match_pathspec_depth()?  Can't the "even if one of the positive pathspec
matched, if one of the excluded one matches, declare that the path does
*not* match" logic live in match_pathspec_depth() itself?

Exactly the same comment applies to all the other additions that calls
match_pathspec_depth() with pathspec->exclude as its first parameter in
this patch.

> @@ -1053,6 +1084,12 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  	pathspec.max_depth = opt.max_depth;
>  	pathspec.recursive = 1;
>  
> +	if( exclude_list.nr ) {
> +		create_pathspec_from_string_list(&pathspec.exclude, &exclude_list);
> +		pathspec.exclude->max_depth = opt.max_depth;
> +		pathspec.exclude->recursive = 1;
> +	}
> +

Style. Notice where SPs should be near parentheses on "if" statement in
our codebase.
