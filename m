From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-completion.bash: add support for path completion
Date: Wed, 19 Dec 2012 11:57:42 -0800
Message-ID: <7vzk1995mx.fsf@alter.siamese.dyndns.org>
References: <1355943496-5533-1-git-send-email-manlio.perillo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 20:58:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlPmH-0000o7-9s
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 20:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489Ab2LST5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 14:57:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39969 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945Ab2LST5q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 14:57:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 080C4A1C8;
	Wed, 19 Dec 2012 14:57:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vHrgwODEFaOLJJ7InvLnwQ6IWkk=; b=ogKGzP
	HZdokETh7lwPKZk0giprlQTz6teoMLeouDh9mrSZ/6zaO+2OaioYB8c7SusXcMo6
	yhBwQF44OMrdjYZbgTVyQkBnMjdZudgdPI7xbCLJCdDAf9qhrZbScwy0HxTTN5wO
	AREBzXyH1Klkc+qrufRm7JEx82jz/c4M4dE3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hnNkyIlL9NaElgqvYlBMWz5/vhRfzhU7
	px+wblGjmIflwoUDupX+OaLsXutCG28GGCSc7ayyk/Oc1sT8viPIndlLTX+/n4VN
	TJobL5La4ORZNLkEWFFQbyYYuc9+T+hjM0s83eBFymYcZPQSUjgbEuTum4UCOyu7
	b4pa6BCCvDg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7C88A1C7;
	Wed, 19 Dec 2012 14:57:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A802A1C4; Wed, 19 Dec 2012
 14:57:43 -0500 (EST)
In-Reply-To: <1355943496-5533-1-git-send-email-manlio.perillo@gmail.com>
 (Manlio Perillo's message of "Wed, 19 Dec 2012 19:58:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A5FF02A-4A16-11E2-BB4B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211843>

[jch: again, adding area experts to Cc]

Manlio Perillo <manlio.perillo@gmail.com> writes:

> Changes from version 2:
>
> 	* Perl is no more used.
> 	* Fixed some coding style issues.
> 	* Refactorized code, to improve future path completion support for
> 	  the "git reset" command.

Thanks.  Will replace what was queued on 'pu'.

> +# Process path list returned by "ls-files" and "diff-index --name-only"
> +# commands, in order to list only file names relative to a specified
> +# directory, and append a slash to directory names.
> +# It accepts 1 optional argument: a directory path.  The path must have
> +# a trailing slash.

The callsites that call this function, and the way the argument is
used, do not make it look like it is an optional argument to me.

After reading later parts of the patch, I think the callers are
wrong (see below) and you did intend to make "$1" optional.

> +__git_index_file_list_filter ()
> +{
> +	local path
> +
> +	while read -r path; do
> +		path=${path#$1}

This will work correctly only if $1 does not have any shell
metacharacter that removes prefix of $path that matches $1 as a
pathname expansion pattern.  As this file is for bash completion,
using string-oriented Bash-isms like ${#1} (to get the length of the
prefix) and ${path:$offset} (to get substring) are perfectly fine
way to correct it.

Also, as $1 is optional, won't this barf if it is run under "set -u"?

> +# __git_index_files accepts 1 or 2 arguments:
> +# 1: A string for file index status mode ("c", "m", "d", "o"), as
> +#    supported by git ls-files command.
> +# 2: A directory path (optional).
> +#    If provided, only files within the specified directory are listed.
> +#    Sub directories are never recursed.  Path must have a trailing
> +#    slash.
> +__git_index_files ()
> +{
> +	local dir="$(__gitdir)"
> +
> +	if [ -d "$dir" ]; then
> +		git --git-dir="$dir" ls-files --exclude-standard "-${1}" "${2}" |
> +			__git_index_file_list_filter ${2} | uniq

Even though everywhere else you seem to quote the variables with dq,
but this ${2} is not written as "${2}", which looks odd.  Deliberate?

If you wanted to call __git_index_file_list_filter without parameter
when the caller did not give you the optional $2, then the above is
not the way to write it.  It would be ${2+"$2"}.  The upstream of
the pipe (ls-files) also is getting an empty string as the pathspec
when $2 is omitted, and the call will break if this is run under
"set -u".

> +# __git_diff_index_files accepts 1 or 2 arguments:
> +# 1) The id of a tree object.
> +# 2) A directory path (optional).
> +#    If provided, only files within the specified directory are listed.
> +#    Sub directories are never recursed.  Path must have a trailing
> +#    slash.
> +__git_diff_index_files ()
> +{
> +	local dir="$(__gitdir)"
> +
> +	if [ -d "$dir" ]; then
> +		git --git-dir="$dir" diff-index --name-only "${1}" |
> +			__git_index_file_list_filter "${2}" | uniq

This one, when the optional $2 is absent, will call __git_index_file_list_filter
with an empty string in its "$1".  Intended, or is it also ${2+"$2"}?

> +# __git_complete_index_file requires 1 argument: the file index
> +# status mode
> +__git_complete_index_file ()
> +{
> +	local pfx cur_="$cur"
> +
> +	case "$cur_" in
> +		?*/*)
> +			pfx="${cur_%/*}"
> +			cur_="${cur_##*/}"
> +			pfx="${pfx}/"
> +
> +			__gitcomp_nl "$(__git_index_files ${1} ${pfx})" "$pfx" "$cur_" ""
> +			;;
> +		*)
> +			__gitcomp_nl "$(__git_index_files ${1})" "" "$cur_" ""
> +			;;
> +	esac

Please dedent the case arms by one level, i.e.

	case $value in
        $pattern1)
        	action1
                ;;
                ...
		;;
	esac

> +# __git_complete_diff_index_file requires 1 argument: the id of a tree
> +# object
> +__git_complete_diff_index_file ()
> +{
> +	local pfx cur_="$cur"
> +
> +	case "$cur_" in
> +		?*/*)
> +			pfx="${cur_%/*}"
> +			cur_="${cur_##*/}"
> +			pfx="${pfx}/"
> +
> +			__gitcomp_nl "$(__git_diff_index_files ${1} ${pfx})" "$pfx" "$cur_" ""
> +			;;
> +		*)
> +			__gitcomp_nl "$(__git_diff_index_files ${1})" "" "$cur_" ""
> +			;;

Unquoted $1 looks fishy, even if the only caller of this function
always gives "HEAD" to it (in which case you can do without making
it a parameter in the first place).

Unquoted ${pfx} given to __git_diff_index_files also looks fishy.
