From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] remote rm: delete remote configuration as the last
Date: Fri, 23 May 2014 11:55:53 -0700
Message-ID: <xmqqa9a8jpdy.fsf@gitster.dls.corp.google.com>
References: <537B2FA4.7020001@opera.com> <537F2252.3010101@opera.com>
	<537F22DB.7070102@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jens =?utf-8?Q?Lindstr=C3=B6m?= <jl@opera.com>
X-From: git-owner@vger.kernel.org Fri May 23 20:56:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnudQ-00041D-B4
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 20:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbaEWS4A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 May 2014 14:56:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61993 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042AbaEWSz7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 May 2014 14:55:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AA1BA18D49;
	Fri, 23 May 2014 14:55:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=U953/1XXICfl
	VQfQAWc18g6KkeM=; b=lVKRvDx6aImQXeglEz7IG7eLnFc3VANsfaFFk4YKCC5L
	FQNl3I40jBSObIGzeBVUE7ebTgqVpIJbuoBTe/gR3iw1o/PyNUMAa00oDV4IAbqg
	xeY8vHjkUa+LF2RvpHLFE7oU0VhrYhPfXe7TNQ46mhrOsvCiXHZz4oY643Myw54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=H3zvVW
	oCJ/UeUWR9hvHflHD3ygr2BrZ6g/oWTVewqZ/uP+WajIrLhHPIzoFvfJ5uPHQh17
	fOFI9rGOFYDVLP6gZNB7E9cD8g6EVwpC0agg2MqsyEs9fdZdTbhj7Ugdaw/G7hL/
	egyOQ0DxJqvDe38aLy5YwHFm76wCLwPXJjdfI=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A119818D48;
	Fri, 23 May 2014 14:55:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7437B18D43;
	Fri, 23 May 2014 14:55:55 -0400 (EDT)
In-Reply-To: <537F22DB.7070102@opera.com> ("Jens =?utf-8?Q?Lindstr=C3=B6m?=
 =?utf-8?Q?=22's?= message of "Fri,
	23 May 2014 12:28:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DEB3AB94-E2AB-11E3-A60E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250014>

Jens Lindstr=C3=B6m <jl@opera.com> writes:

> When removing a remote, delete the remote-tracking branches before
> deleting the remote configuration.  This way, if the operation fails =
or
> is aborted while deleting the remote-tracking branches, the command c=
an
> be rerun to complete the operation.
>
> Signed-off-by: Jens Lindstr=C3=B6m <jl@opera.com>

I think this is a good change, regardless of the "calling delete-ref
millions of times, each time rewriting the whole packed-ref file, is
inefficient" issue.

I wonder if the new "if (!result)" block wants to have its own else
clause to let the users know that the definition of the remote was
still left intact under such an unusual condition where ref deletion
somehow fails, but it would be OK as the users have presumably seen
error messages and understand that removal did not happen.

Will queue.  Thanks.

> ---
>  builtin/remote.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index b3ab4cf..84802cd 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -789,10 +789,6 @@ static int rm(int argc, const char **argv)
>  	known_remotes.to_delete =3D remote;
>  	for_each_remote(add_known_remote, &known_remotes);
> =20
> -	strbuf_addf(&buf, "remote.%s", remote->name);
> -	if (git_config_rename_section(buf.buf, NULL) < 1)
> -		return error(_("Could not remove config section '%s'"), buf.buf);
> -
>  	read_branches();
>  	for (i =3D 0; i < branch_list.nr; i++) {
>  		struct string_list_item *item =3D branch_list.items + i;
> @@ -837,6 +833,12 @@ static int rm(int argc, const char **argv)
>  	}
>  	string_list_clear(&skipped, 0);
> =20
> +	if (!result) {
> +		strbuf_addf(&buf, "remote.%s", remote->name);
> +		if (git_config_rename_section(buf.buf, NULL) < 1)
> +			return error(_("Could not remove config section '%s'"), buf.buf);
> +	}
> +
>  	return result;
>  }
