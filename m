From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] git-completion.bash: add support for path completion
Date: Fri, 11 Jan 2013 14:02:53 -0800
Message-ID: <7v8v7zbcoi.fsf@alter.siamese.dyndns.org>
References: <1357930123-26310-1-git-send-email-manlio.perillo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, szeder@ira.uka.de, felipe.contreras@gmail.com,
	peff@peff.net
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 23:03:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttmh3-0006J7-E6
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 23:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979Ab3AKWC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 17:02:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35029 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754804Ab3AKWC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 17:02:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0759AA930;
	Fri, 11 Jan 2013 17:02:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kgoP29ilC46cpFVxX86cS6Vp5KM=; b=gC5hfx
	jfa1mIEMIdh/9RXlUR2HBWPR4ssOPfL0E2xC5zK2FCdU5QfNm/uOxvfrGZLGh4/u
	fPt/EZhCbAkoqvb1rOagTb61KzmovAnVZS9RjbO0I1q6VkPj3ktj8cBkhsHR7QSt
	zloKbboFgIxoEYi9RYm2qFiuY9yGEBOZK5PDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YesviXw0tAEwx0yt+gnBtmve0gw08uhS
	K8axZJjpB+7tnb2VIdxt/3PQu2TRzYB0wEn88V4BZuSvb09mWU+j7kaqtJd3d58k
	4eJEA+VC512wdNzI/+64T/9SvdBvOyUBlU+e2UPcvuk9NzlFB/uqzdkLuj7pRVW+
	+sQU8km2fUg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E720FA92F;
	Fri, 11 Jan 2013 17:02:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1ABF5A92C; Fri, 11 Jan 2013
 17:02:55 -0500 (EST)
In-Reply-To: <1357930123-26310-1-git-send-email-manlio.perillo@gmail.com>
 (Manlio Perillo's message of "Fri, 11 Jan 2013 19:48:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6D20B60-5C3A-11E2-A7B8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213247>

Manlio Perillo <manlio.perillo@gmail.com> writes:

> +# Process path list returned by "ls-files" and "diff-index --name-only"
> +# commands, in order to list only file names relative to a specified
> +# directory, and append a slash to directory names.
> +__git_index_file_list_filter ()
> +{
> +	# Default to Bash >= 4.x
> +	__git_index_file_list_filter_bash
> +}
> +
> +# Execute git ls-files, returning paths relative to the directory
> +# specified in the first argument, and using the options specified in
> +# the second argument.
> +__git_ls_files_helper ()
> +{
> +	# NOTE: $2 is not quoted in order to support multiple options
> +	cd "$1" && git ls-files --exclude-standard $2
> +} 2>/dev/null

I think this redirection is correct but a bit tricky; it is in
effect during the execution of the { block } (in other words, it is
not about squelching errors during the function definition).

-- >8 --
#!/bin/sh
cat >t.sh <<\EOF &&
echo I am "$1"
t () { echo "Goes to stdout"; echo >&2 "Goes to stderr"; } 2>/dev/null
t
for sh in bash dash ksh zsh
do
	$sh t.sh $sh
done
-- 8< --

Bash does (so do dash and real AT&T ksh) grok this correctly, but
zsh does not seem to (I tried zsh 4.3.10 and 4.3.17; also zsh
pretending to be ksh gets this wrong as well).  Not that what ksh
does matters, as it won't be dot-sourcing bash completion script.

It however may affect zsh, which does seem to dot-source this file.
Perhaps zsh completion may have to be rewritten in a similar way as
tcsh completion is done (i.e. does not dot-source this file but ask
bash to do the heavy-lifting).

This function seems to be always called in an subshell (e.g. as an
upstream of a pipeline), so the "cd" may be harmless, but don't you
need to disable CDPATH while doing this?

> +# Execute git diff-index, returning paths relative to the directory
> +# specified in the first argument, and using the tree object id
> +# specified in the second argument.
> +__git_diff_index_helper ()
> +{
> +	cd "$1" && git diff-index --name-only --relative "$2"
> +} 2>/dev/null

Ditto.

> @@ -722,6 +875,43 @@ __git_has_doubledash ()
>  	return 1
>  }
>  
> +# Try to count non option arguments passed on the command line for the
> +# specified git command.
> +# When options are used, it is necessary to use the special -- option to
> +# tell the implementation were non option arguments begin.
> +# XXX this can not be improved, since options can appear everywhere, as
> +# an example:
> +#	git mv x -n y

If that is the case, it is a bug in the command line parser, I
think.  We should reject it, and the command line completer
certainly should not encourage it.
