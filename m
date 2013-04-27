From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/9] completion: refactor diff_index wrappers
Date: Sat, 27 Apr 2013 14:29:22 -0700
Message-ID: <7v7gjnu0gd.fsf@alter.siamese.dyndns.org>
References: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
	<1367093407-8898-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 23:29:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWCgU-0007qm-8T
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 23:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787Ab3D0V3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 17:29:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62574 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753898Ab3D0V3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 17:29:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3B501A7CC;
	Sat, 27 Apr 2013 21:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D1tAmtLA1pkOvaE5ORAhNWZ9l+o=; b=U4zYVl
	VIuXIP9fVLyv6rZ8ABISEJZ9cJ4Se0PDPPm0RmNVq+SZYCAHP4MRU1HKwjZBXgdo
	RlVgh4H2xkUPM4Mu5A04It9FWLvPxv40QeOH+weh4EU/WTz6QK+ZT9qclSHQNHJk
	DeMgIugDvxwXVchoLaZOTzICkd/XB6q54+9yY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cyim7AlJxAvYIxBQZvUgSG0lTXAixL/x
	y8GWNNtUbNUQ0rvwPQHo+AKiMQZtKTfG0e4Jplb9acVu7RON+z4fjz63fgDXqHzQ
	TLOmWB/t30ZNXVsyvDKyvWiLyTv1Pr8QK6bHLmNKzgsLUvbGcGI3wF2EYYCrqYIz
	OlREYJUckTA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B78131A7CB;
	Sat, 27 Apr 2013 21:29:24 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF0041A7C8;
	Sat, 27 Apr 2013 21:29:23 +0000 (UTC)
In-Reply-To: <1367093407-8898-6-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sat, 27 Apr 2013 15:10:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 87E1545A-AF81-11E2-8145-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222701>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> At the end of the day what we really need is to find out the files that
> have been staged, or modified, because those files are the ones that
> make sense to pass as arguments to 'git commit'.
>
> We need diff-index to find those out, since 'git ls-files' doesn't do
> that.
>
> But we don't need wrappers and wrappers basically identical to the ones
> used for 'git ls-files', when we can pretend it receives a --committable
> option that would return what we need.
>
> That way, we can remove a bunch of code without any functional changes.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 71 ++++++++--------------------------
>  1 file changed, 16 insertions(+), 55 deletions(-)

Nice line reduction.


>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 7f1ebe4..2561265 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -297,30 +297,25 @@ __git_index_file_list_filter ()
>  	__git_index_file_list_filter_bash
>  }
>  
> -# Execute git ls-files, returning paths relative to the directory
> -# specified in the first argument, and using the options specified in
> -# the second argument.
> +# Execute 'git ls-files', unless the --committable option is specified, in
> +# which case it runs 'git diff-index' to find out the files that can be
> +# committed.  It return paths relative to the directory specified in the first
> +# argument, and using the options specified in the second argument.
>  __git_ls_files_helper ()
>  {
>  	(
>  		test -n "${CDPATH+set}" && unset CDPATH
> -		# NOTE: $2 is not quoted in order to support multiple options
> -		cd "$1" && git ls-files --exclude-standard $2
> +		cd "$1"
> +		if [ "$2" == "--committable" ]; then
> +			git diff-index --name-only --relative HEAD
> +		else
> +			# NOTE: $2 is not quoted in order to support multiple options
> +			git ls-files --exclude-standard $2
> +		fi
>  	) 2>/dev/null
>  }
>  
>  
> -# Execute git diff-index, returning paths relative to the directory
> -# specified in the first argument, and using the tree object id
> -# specified in the second argument.
> -__git_diff_index_helper ()
> -{
> -	(
> -		test -n "${CDPATH+set}" && unset CDPATH
> -		cd "$1" && git diff-index --name-only --relative "$2"
> -	) 2>/dev/null
> -}
> -
>  # __git_index_files accepts 1 or 2 arguments:
>  # 1: Options to pass to ls-files (required).
>  # 2: A directory path (optional).
> @@ -337,22 +332,6 @@ __git_index_files ()
>  	fi
>  }
>  
> -# __git_diff_index_files accepts 1 or 2 arguments:
> -# 1) The id of a tree object.
> -# 2) A directory path (optional).
> -#    If provided, only files within the specified directory are listed.
> -#    Sub directories are never recursed.  Path must have a trailing
> -#    slash.
> -__git_diff_index_files ()
> -{
> -	local dir="$(__gitdir)" root="${2-.}"
> -
> -	if [ -d "$dir" ]; then
> -		__git_diff_index_helper "$root" "$1" | __git_index_file_list_filter |
> -			sort | uniq
> -	fi
> -}
> -
>  __git_heads ()
>  {
>  	local dir="$(__gitdir)"
> @@ -550,8 +529,10 @@ __git_complete_revlist_file ()
>  }
>  
>  
> -# __git_complete_index_file requires 1 argument: the options to pass to
> -# ls-file
> +# __git_complete_index_file requires 1 argument:
> +# 1: the options to pass to ls-file
> +#
> +# The exception is --committable, which finds the files appropriate commit.
>  __git_complete_index_file ()
>  {
>  	local pfx cur_="$cur"
> @@ -570,26 +551,6 @@ __git_complete_index_file ()
>  	esac
>  }
>  
> -# __git_complete_diff_index_file requires 1 argument: the id of a tree
> -# object
> -__git_complete_diff_index_file ()
> -{
> -	local pfx cur_="$cur"
> -
> -	case "$cur_" in
> -	?*/*)
> -		pfx="${cur_%/*}"
> -		cur_="${cur_##*/}"
> -		pfx="${pfx}/"
> -
> -		__gitcomp_file "$(__git_diff_index_files "$1" "$pfx")" "$pfx" "$cur_"
> -		;;
> -	*)
> -		__gitcomp_file "$(__git_diff_index_files "$1")" "" "$cur_"
> -		;;
> -	esac
> -}
> -
>  __git_complete_file ()
>  {
>  	__git_complete_revlist_file
> @@ -1211,7 +1172,7 @@ _git_commit ()
>  	esac
>  
>  	if git rev-parse --verify --quiet HEAD >/dev/null; then
> -		__git_complete_diff_index_file "HEAD"
> +		__git_complete_index_file "--committable"
>  	else
>  		# This is the first commit
>  		__git_complete_index_file "--cached"
