From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug report about symlinks
Date: Sun, 03 Aug 2014 10:19:21 -0700
Message-ID: <xmqqk36ptrs6.fsf@gitster.dls.corp.google.com>
References: <web-416867478@relay1.vsu.ru> <53DABD69.7010004@web.de>
	<xmqqppgkw55g.fsf@gitster.dls.corp.google.com>
	<53DCF14D.8040705@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nikolay Avdeev <avdeev@math.vsu.ru>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 03 19:19:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDzRd-0006LO-6i
	for gcvg-git-2@plane.gmane.org; Sun, 03 Aug 2014 19:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbaHCRTb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Aug 2014 13:19:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50032 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769AbaHCRTa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Aug 2014 13:19:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F30162CB57;
	Sun,  3 Aug 2014 13:19:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=up2q89kLVdcW
	8YFpIqgtUyZcJ1k=; b=LtuQotXRaKU7yOFSGCKk0vFMuxYPbdmg5jaHxUs+vk5y
	FpqhBL0nCaDA3N1aW6Ygw80dfE98E4mCs0NkONQm9jLjnHcHrznvR3ZZOHIA8oHI
	fnCmlDAMifanhKwws/4lCXlwbTcGC2dk2sWYlFsp/QzLo4LLsNLgZZjG06QbxhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WSt5Di
	giiBjJAqWlhyy5szkKlirg1jdMJKhJvybC+HADjx+Ux4vhHrDj9np3/Pafs3GJ3k
	7sN6B6fQFdCXiS4JdQSIYmIBe9TxO23rwECRp24JqNI2BZcCTnyZmRfFCNviVIO/
	73lDKjpDk+oXuJrDEWrX7YJC8Zrr5ivqs5TUY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D2D962CB56;
	Sun,  3 Aug 2014 13:19:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 489322CB4E;
	Sun,  3 Aug 2014 13:19:23 -0400 (EDT)
In-Reply-To: <53DCF14D.8040705@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Sat, 02
	Aug 2014 16:10:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5009D4D0-1B32-11E4-86C7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254728>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> How about the patch below?  Before it checks if an index entry exists
> in the work tree, it checks if its path includes a symlink.

Honestly, I didn't expect the fix to be in the refresh-index code
path, but doing this there sort of makes sense.

I think you, who dug to find out where to add the check, already
know this, and I am writing this mainly for myself and for the list
archive, but when the knee-jerk "has-syjmlink-leading-path missing?"
reaction came to me, two obvious optimizations also came to my mind:

 - When checking a cache entry "a/b/c/d/e" and we find out "a/b/c"
   is a symbolic link, we mark it as ~CE_VALID, but at the same
   time, we learn "a/b/c/any/thing" are also ~CE_VALID with that
   check, so we _could_, after the has_symlink_leading_path once
   returns true, so there may be an opportunity to fast-forward the
   scan, marking all paths under "a/b/c" as ~CE_VALID.

 - After finding out "a/b/c" is a symbolic link to cause anything
   underneath marked as ~CE_VALID, we also know "a/" and "a/b/"
   exists as real directories, so a later check for "a/b/some/thing"
   can start checking at "a/b/some/" without checking "a/" and "a/b/".

The latter is more important as it is a much more common case that
the shape of the working tree not to change.

But I think the implementation of has_symlink_leading_path() already
has these optimizations built inside around the (unfortunately named)
"struct cache_def", so it probably would not give us much boost to
implement such a fast-forwarding of the scan.

> And do we need to use the threaded_ variant of the function here?

Hmmm, this is a tangent, but you comment made me wonder if we also
need to adjust preload_thread() in preload-index.c somehow, but we
do not touch CE_UPTODATE there, so it probably is not necessary.

The caller of refresh_cache_ent() is walking an array of sorted
pathnames aka istate->cache[] in a single-threaded fashion, possibly
with a pathspec to limit the scan.  Do you mean that we may want to
make istate->cache[] scanned by multiple threads?  I am not sure.

> diff --git a/read-cache.c b/read-cache.c
> index 5d3c8bd..6f0057f 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1064,6 +1064,14 @@ static struct cache_entry *refresh_cache_ent(s=
truct index_state *istate,
>  		return ce;
>  	}
> =20
> +	if (has_symlink_leading_path(ce->name, ce_namelen(ce))) {
> +		if (ignore_missing)
> +			return ce;
> +		if (err)
> +			*err =3D ENOENT;
> +		return NULL;
> +	}
> +
>  	if (lstat(ce->name, &st) < 0) {
>  		if (ignore_missing && errno =3D=3D ENOENT)
>  			return ce;
