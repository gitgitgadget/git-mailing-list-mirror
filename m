From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] remote: repack packed-refs once when deleting multiple refs
Date: Fri, 23 May 2014 12:11:57 -0700
Message-ID: <xmqq61kwjon6.fsf@gitster.dls.corp.google.com>
References: <537B2FA4.7020001@opera.com> <537F2252.3010101@opera.com>
	<537F2319.7040105@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jens =?utf-8?Q?Lindstr=C3=B6m?= <jl@opera.com>
X-From: git-owner@vger.kernel.org Fri May 23 21:12:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnut0-0007H3-Sk
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 21:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbaEWTMG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 May 2014 15:12:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55709 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbaEWTME convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 May 2014 15:12:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5A61C195AB;
	Fri, 23 May 2014 15:12:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JKocxNzr6voL
	4jkxGcSHkD7Ifbw=; b=P03sPH1/XBtMNVw8g884ON/+wjpb5I+9e+eVA3PykX/U
	NK71v26GaVdB8yDI2h5VmHoEt+0o4gwg7Lt6D+tepQCv7/VlD3+Ognm3bnbXv8JI
	KMt6/My//2AMHVHQRLMYsbWRGWVq+9XavN/z8xyz8i4muOOoJy7RicsvWT46cN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ni8XNw
	vnhMg2wmEewhYHBmm4xsS3YcUAUwb3f5cjRN4YekkIzIVLSBvVh3/ssSQsva4UhN
	qD12gdQ8/dJBJsob4quWs1LXCUdvsOFpXEQBGH8QjrfORpOVj9GphSo3yzUqMrAJ
	qRPjxsNfTn+URrS6ZSHFKXaS6Id+q8vmDTPGo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4F78A195AA;
	Fri, 23 May 2014 15:12:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DFD781959B;
	Fri, 23 May 2014 15:11:58 -0400 (EDT)
In-Reply-To: <537F2319.7040105@opera.com> ("Jens =?utf-8?Q?Lindstr=C3=B6m?=
 =?utf-8?Q?=22's?= message of "Fri,
	23 May 2014 12:29:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1CF577B4-E2AE-11E3-8435-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250015>

Jens Lindstr=C3=B6m <jl@opera.com> writes:

> When 'git remote rm' or 'git remote prune' were used in a repository
> with many refs, and needed to delete many remote-tracking refs, a lot
> of time was spent deleting those refs since for each deleted ref,
> repack_without_refs() was called to rewrite packed-refs without just
> that deleted ref.
>
> To avoid this, call repack_without_refs() first to repack without all
> the refs that will be deleted, before calling delete_ref() to delete
> each one completely.  The call to repack_without_ref() in delete_ref(=
)
> then becomes a no-op, since packed-refs already won't contain any of
> the deleted refs.
>
> Signed-off-by: Jens Lindstr=C3=B6m <jl@opera.com>
> ---
> Note: remove_branches() no longer checks that the remote-tracking
> branches it deletes point at the right object before deleting them
> by passing the expected SHA-1 to delete_ref().  This was a required
> change since all packed refs have been deleted already by the time
> we call delete_ref(), which causes delete_ref() to fail if given an
> expected SHA-1 to check.  'remote prune' already behaved this way.
>
>  builtin/remote.c | 20 ++++++++++++++++++--
>  refs.c           |  2 +-
>  refs.h           |  2 ++
>  3 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 84802cd..d33abe6 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -749,15 +749,23 @@ static int mv(int argc, const char **argv)
> =20
>  static int remove_branches(struct string_list *branches)
>  {
> +	const char **branch_names;
>  	int i, result =3D 0;
> +
> +	branch_names =3D xmalloc(branches->nr * sizeof(*branch_names));
> +	for (i =3D 0; i < branches->nr; i++)
> +		branch_names[i] =3D branches->items[i].string;
> +	result |=3D repack_without_refs(branch_names, branches->nr);
> +	free(branch_names);

Hmph.  I wonder if you can refactor/enhance the interface to the
repack_without_refs() function before this step in the series, so
that the function lets the caller to know if each ref was actually
removed or it was not in packed-refs from the beginning, and also I
wonder if such a refactoring helps.  My gut feeling is that it would
not help that much this particular series, but it would probably be
a good thing to do in the longer run. So probably it is better to do
without such a change as a part of this series.

>  	for (i =3D 0; i < branches->nr; i++) {
>  		struct string_list_item *item =3D branches->items + i;
>  		const char *refname =3D item->string;
> -		unsigned char *sha1 =3D item->util;

Here, you can check if the refname still exists as a ref; if it no
longer exists, it would mean that the only copy of the ref was in
the packed-refs file and you have already deleted it, and you can
refrain from calling delete_ref() altogether, e.g.


	if (!ref_exists(refname))
		continue; /* already removed the sole copy from packed-ref */

and then still retain the safetly against racing somebody else who
created or updated the ref you wanted to remove here by passing the
object name to delete_ref().

> -		if (delete_ref(refname, sha1, 0))
> +		if (delete_ref(refname, NULL, 0))
>  			result |=3D error(_("Could not remove branch %s"), refname);
>  	}
> +
>  	return result;
>  }
