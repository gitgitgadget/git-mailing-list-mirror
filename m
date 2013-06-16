From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-trees: don't shift conflicts left and right
Date: Sat, 15 Jun 2013 17:56:13 -0700
Message-ID: <7va9mqlvpu.fsf@alter.siamese.dyndns.org>
References: <1371339883-22775-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jun 16 02:56:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo1Ga-0007ef-1m
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 02:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818Ab3FPA4R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Jun 2013 20:56:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46565 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754789Ab3FPA4R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Jun 2013 20:56:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2014A28929;
	Sun, 16 Jun 2013 00:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=npZ9rOevqyFV
	VRKnLK1ldlJCooo=; b=ttIUhWYcYC2hft5ox2nUPB+cEMfHToOkgObKwbB1WK0e
	fVb7/g5Sxuvu3kiwTKNTp6Kp2hDkXuAPmvgWTvHglEdS3EEaKyu+8GBBIgg4K50M
	uXZUmp9Da738+u83kexK/GE2UfIV+hOB7xTKwIUKQrN87hkKIfydCmJRPtS1e1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QvFsOv
	4Ljjf9hWwnn1jgXK/k+TGS8h1yjBBTHAPQz9ZA9zDNABMj+TNn5noRF2RRJY3uUc
	w0MTXcFcJcGIJ1m4i4xrZ7YihcQkL9+bKcZ3c8UC2FmelIjYbavLh2X4xS10cVYw
	uol4FK0yshhZgY8uCMYTll0XXctGykLZ4HaZ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16EC528928;
	Sun, 16 Jun 2013 00:56:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 713F328927;
	Sun, 16 Jun 2013 00:56:15 +0000 (UTC)
In-Reply-To: <1371339883-22775-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
	(=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s message of "Sun, 16 Jun 2013 01:44:43
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BF19130-D61F-11E2-AA90-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227978>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> If o->merge is set, the struct traverse_info member conflicts is shif=
ted
> left in unpack_callback, then passed through traverse_trees_recursive
> to unpack_nondirectories, where it is shifted right before use. =20

> @@ -807,13 +802,6 @@ static int unpack_callback(int n, unsigned long =
mask, unsigned long dirmask, str
> =20
>  	/* Now handle any directories.. */
>  	if (dirmask) {
> -		unsigned long conflicts =3D mask & ~dirmask;
> -		if (o->merge) {
> -			conflicts <<=3D 1;
> -			if (src[0])
> -				conflicts |=3D 1;
> -		}
> -
>  		/* special case: "diff-index --cached" looking at a tree */
>  		if (o->diff_index_cached &&
>  		    n =3D=3D 1 && dirmask =3D=3D 1 && S_ISDIR(names->mode)) {
> @@ -832,7 +820,7 @@ static int unpack_callback(int n, unsigned long m=
ask, unsigned long dirmask, str
>  			}
>  		}
> =20
> -		if (traverse_trees_recursive(n, dirmask, conflicts,
> +		if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
>  					     names, info) < 0)
>  			return -1;
>  		return mask;

This loses the bottom bit (i.e. are we merging and do have an index
entry?) passed to traverse_trees_recursive(), but when that bitmask
comes back to our callback, we immediately discard the bottom bit by
shifting before using it in unpack_nondirectories(), so this seems a
valid clean-up.

One thing renaming df_conficts to conflicts really proves is that
this field is not used by the traverse_trees machinery at all.

Before this patch, the bits in conflicts (now df_conflicts) mask had
the semantics that is not consistent with the dirmask/mask the
tree-walk machinery uses to communicate with its callers and
callbacks.  Everything in tree-walk.[ch] is about "walk N trees",
and bit 0 of dirmask and mask always means the first tree, not
"first tree, or in index if the callback is doing a merge", which
is used in the conflicts field before this patch.

I think the true source of the confusion is that the "conflicts"
field does not logically belong there.  It is not needed in the
general "walk N trees" machinery.

The information is only useful for the unpack_trees callback, and
"info->data" is a more appropriate place to hang such a callback
specific data.

Perhaps we should use info->data field to point at

	struct {
        	struct unpack_trees_options *o;
                unsigned long df_conflict;
	};

and get rid of info->conflicts field?
