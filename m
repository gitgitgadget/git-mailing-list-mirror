From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] [submodule] handle multibyte characters in name
Date: Fri, 14 Jun 2013 08:02:04 -0700
Message-ID: <7vppvorb0z.fsf@alter.siamese.dyndns.org>
References: <1371169563-10267-1-git-send-email-iveqy@iveqy.com>
	<1371169563-10267-2-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 17:02:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnVW2-0001EP-51
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 17:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903Ab3FNPCJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 11:02:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45137 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795Ab3FNPCH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jun 2013 11:02:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EDB62521D;
	Fri, 14 Jun 2013 15:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=acCnjSuYxec8
	noLxQRaKrQ/emzg=; b=yLUmyib5s5VkyQ74i328JkTbhjjPx/vz6r3UmWZTnOgP
	FXvMnwyYzB4kWdsahHW8r3xlu1p9GFxRFF8GYc+PLrFWq3JSECyO/iyqMhaFqi+p
	MVAcStZxzkDkwOuqd9STiGeMGbkUnji5jd/kHS9xbaW46SYTlMkBprqYQVKsB2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DL0Snc
	nhxJI3vdUtjm8NZBP9UkKdo6kJVDVTnvSAE1AGxn3w2YyZbG6NC06Tepac0pxPGN
	pS5bTiqLSo64LyxXoAT2pwhIll7A9jUAbAVUDXE7Rmai2RrMKTXq9Akh/7MKYWIK
	6J9MPGuKDi7K3pMRHo8xXdwGebJj0hHKh3tKQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 026FF2521C;
	Fri, 14 Jun 2013 15:02:07 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D2602521A;
	Fri, 14 Jun 2013 15:02:06 +0000 (UTC)
In-Reply-To: <1371169563-10267-2-git-send-email-iveqy@iveqy.com> (Fredrik
	Gustafsson's message of "Fri, 14 Jun 2013 02:26:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6105A4EC-D503-11E2-99D9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227877>

=46redrik Gustafsson <iveqy@iveqy.com> writes:

> Many "git submodule" operations do not work on a submodule at a path =
whose
> name is not in ASCII.

Thanks.  A suggestion to add some more explanation to the log
message follows.

> This is because "git ls-files" is used to find which paths are bound =
to
> submodules to the current working tree, and the output is C-quoted by=
 default
> for non ASCII pathnames.

And pathnames that has a double-quote, a backslash, or a control
character like a newline or a tab in them.

> Tell "git ls-files" to not C-quote its output, which is easier than u=
nwrapping
> C-quote ourselves.

This patch still does not allow pathnames with characters that do
need C-quote, but the code didn't handle them before, so it is not
making things worse.

The correct approach to solve the problem for all pathnames may be
to use "ls-files -z" and tell the Perl script that reads its output
to read NUL separated records by using $/ =3D "\0".

> Solution-suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
> ---
>  git-submodule.sh           |  2 +-
>  t/t7400-submodule-basic.sh | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 79bfaac..bad051e 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -113,7 +113,7 @@ resolve_relative_url ()
>  module_list()
>  {
>  	(
> -		git ls-files --error-unmatch --stage -- "$@" ||
> +		git -c core.quotepath=3Dfalse ls-files --error-unmatch --stage -- =
"$@" ||
>  		echo "unmatched pathspec exists"
>  	) |
>  	perl -e '
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index ff26535..d5743ee 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -868,4 +868,16 @@ test_expect_success 'submodule deinit fails when=
 submodule has a .git directory
>  	test -n "$(git config --get-regexp "submodule\.example\.")"
>  '
> =20
> +test_expect_success 'submodule with strange name works "=C3=A5 =C3=A4=
=C3=B6"' '
> +	mkdir "=C3=A5 =C3=A4=C3=B6" &&
> +	(
> +		cd "=C3=A5 =C3=A4=C3=B6" &&
> +		git init &&
> +		touch sub
> +		git add sub
> +		git commit -m "init sub"
> +	)
> +	git submodule add "/=C3=A5 =C3=A4=C3=B6" &&
> +	test -n "$(git submodule | grep "=C3=A5 =C3=A4=C3=B6")"
> +'
>  test_done
