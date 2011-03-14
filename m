From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] setup_path(): Free temporary buffer
Date: Mon, 14 Mar 2011 13:14:22 -0700
Message-ID: <7v7hc1cvdt.fsf@alter.siamese.dyndns.org>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
 <1300130318-11279-3-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Mar 14 21:14:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzEA1-0001Gs-V5
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 21:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987Ab1CNUOd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2011 16:14:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63821 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320Ab1CNUOc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2011 16:14:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D6F8D4A0A;
	Mon, 14 Mar 2011 16:16:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/+zuaKIc4itr
	ZdLpGjSWph0N6ms=; b=KG3sVZpGKTtv8QO190h9a456AwF/jxlXKm20DX5U2wWu
	WLMX5z718pDG0r2ReJp7Pu/UtgaUUvR42DJnTBmtKpBOFaBIyxREMSnVZjSBv8AZ
	XPqmNK1I6iXwfrNPzjSe7O6WycwL/ONAQEfpMQLAKoq1lxp5uWa389TAPReKWVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nMZ9Dx
	mCwk9Z63lBGsXb4UxmF/uOpvXwKS7A+czp80U+8ZwAG6DCyukpYtN/oOhmgQBsaf
	euRTqwy3BUxHyRrazdJBOyecxmhi6w0JVW2r1TGZhaK8hBZXM2yEzqidhads0Qiy
	QIomYNwm8lRFCWJ2lCsHOqb1tXEtVr/4mEl04=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B24FB4A08;
	Mon, 14 Mar 2011 16:15:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A93D74A07; Mon, 14 Mar 2011
 16:15:54 -0400 (EDT)
In-Reply-To: <1300130318-11279-3-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Mon, 14 Mar 2011 20:18:37
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF5A9EC0-4E77-11E0-A0B3-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169023>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Make sure the pointer git_exec_path() returns is in the heap and free
> it after it's no longer needed.
>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> ---
>  exec_cmd.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)

The proposed log message does not explain half of what this patch does,=
 if
I am reading the patch correctly. Here is what I would consider as a fa=
ir
description:

    Subject: git_exec_path: always return a free-able string

    git_exec_path() returns a string that the callers do not have to fr=
ee
    in most cases, but when it calls into system_path() and ends up goi=
ng
    into runtime-prefix codepath, it allocates an extra string on the
    heap, which ends up leaking because the callers are not allowed to
    free it.

    In order to allow the callers to clean up in all cases, change the =
API
    of git_exec_path() to always return a string on heap.  This require=
s
    all the callers to free it.

    Update only one caller setup_path() to follow the new API, but leav=
e
    other callers to leak even in normal cases.  The caller in git.c ex=
its
    immediately after using it, so we don't care about the leak there
    anyway.  Also help.c has a few calls to it but the number of calls =
to
    the function is small and bounded, so the leak is small and we don'=
t
    care.


And then reviewers can agree or disagree if the small leaks in git.c (j=
ust
one string allocation that immediately is followed by exit after its us=
e)
and help.c (in list_commands() and load_commands_list(), neither of whi=
ch
is called millions of times anyway) are OK to accept.

I tend to think they are Ok, but then I also tend to think one leak of
exec-path return value in setup_path() is perfectly fine for the same
reason, so in that sense I don't see a point in this patch...

> diff --git a/exec_cmd.c b/exec_cmd.c
> index 38545e8..c16c3d4 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -73,11 +73,11 @@ const char *git_exec_path(void)
>  	const char *env;
> =20
>  	if (argv_exec_path)
> -		return argv_exec_path;
> +		return xstrdup(argv_exec_path);
> =20
>  	env =3D getenv(EXEC_PATH_ENVIRONMENT);
>  	if (env && *env) {
> -		return env;
> +		return xstrdup(env);
>  	}
> =20
>  	return system_path(GIT_EXEC_PATH);
> @@ -99,10 +99,13 @@ void setup_path(void)
>  {
>  	const char *old_path =3D getenv("PATH");
>  	struct strbuf new_path =3D STRBUF_INIT;
> +	char *exec_path =3D (char *) git_exec_path();
> =20
> -	add_path(&new_path, git_exec_path());
> +	add_path(&new_path, exec_path);
>  	add_path(&new_path, argv0_path);
> =20
> +	free(exec_path);
> +
>  	if (old_path)
>  		strbuf_addstr(&new_path, old_path);
>  	else
