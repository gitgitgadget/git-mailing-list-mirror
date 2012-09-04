From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] path.c: Use vsnpath() in the implementation of
 git_path()
Date: Tue, 04 Sep 2012 13:30:06 -0700
Message-ID: <7vsjax8rap.fsf@alter.siamese.dyndns.org>
References: <50463A72.2000209@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 04 22:30:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8zlM-0004h8-5C
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 22:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932741Ab2IDUaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 16:30:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58595 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932679Ab2IDUaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 16:30:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D11295D9;
	Tue,  4 Sep 2012 16:30:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OrNhp7S92PTDlw6IOXvZzJ8NEHY=; b=X/NyO1
	zlIUIXZFz/qt5M9lKiQjYDIOlintb/kJu+DyZ1JjkLT8WOKnzsJXQonPjd1jpWPo
	Ko+dy5n8ff9cOzxHtvYivL3/HdwR9u/C+XHr4wmrzWTRiZwG1qSVKAqM/pNWvUiQ
	KGNjHQya0mLuX+Mikabfyie1h1R+DNuToGXDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=diGnB0hK9PEKErHpCloYV94wMqmXvHIr
	nNHTXYagZAMlt0HVgYPNjllv5yIgLWtKz9v4uMkSfgfGmu5HXjAQix+k0W0qLgXf
	3Qz1C7uAwubafx9kC/it30jNMMDQ6snqKbFY+t27mte/4I5Ik8Cg5qy4HMYimFff
	6iXxVNQPhEU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 399E695D7;
	Tue,  4 Sep 2012 16:30:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9927695D3; Tue,  4 Sep 2012
 16:30:07 -0400 (EDT)
In-Reply-To: <50463A72.2000209@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Tue, 04 Sep 2012 18:29:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 510DF264-F6CF-11E1-9F1D-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204783>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> The current implementation of git_path() is essentially the same as
> that of vsnpath(), with two minor differences. First, git_path()
> currently insists that the git directory path is no longer than
> PATH_MAX-100 characters in length. However, vsnpath() does not
> attempt this arbitrary 100 character reservation for the remaining
> path components. Second, vsnpath() uses the "is_dir_sep()" macro,
> rather than comparing directly to '/', to determine if the git_dir
> path component ends with a path separator.
> In order to benefit from the above improvements,...

In the longer term, I think this goes in the right direction, but
the loss of reservation, especially when we know git_path() is used
by some callers to get the base directory in $GIT_DIR that want to
append stuff after the returned directory path to form the final
pathname, is a bit worrysome.  It may be hiding a bug (lack of
proper limit check) on the callers' side.

> ... along with increased
> compatability with git_snpath() and git_pathdup(), we reimplement the
> git_path() function using vsnpath().
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>  path.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/path.c b/path.c
> index 741ae77..cbbdf7d 100644
> --- a/path.c
> +++ b/path.c
> @@ -119,23 +119,14 @@ char *mkpath(const char *fmt, ...)
>  
>  char *git_path(const char *fmt, ...)
>  {
> -	const char *git_dir = get_git_dir();
>  	char *pathname = get_pathname();
>  	va_list args;
> -	unsigned len;
> +	char *ret;
>  
> -	len = strlen(git_dir);
> -	if (len > PATH_MAX-100)
> -		return bad_path;
> -	memcpy(pathname, git_dir, len);
> -	if (len && git_dir[len-1] != '/')
> -		pathname[len++] = '/';
>  	va_start(args, fmt);
> -	len += vsnprintf(pathname + len, PATH_MAX - len, fmt, args);
> +	ret = vsnpath(pathname, PATH_MAX, fmt, args);
>  	va_end(args);
> -	if (len >= PATH_MAX)
> -		return bad_path;
> -	return cleanup_path(pathname);
> +	return ret;
>  }
>  
>  void home_config_paths(char **global, char **xdg, char *file)
