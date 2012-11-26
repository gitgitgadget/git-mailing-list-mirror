From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] push: clarify rejection of update to non-commit-ish
Date: Mon, 26 Nov 2012 10:53:18 -0800
Message-ID: <7vk3t8ryap.fsf@alter.siamese.dyndns.org>
References: <1353644515-17349-1-git-send-email-chris@rorvick.com>
 <1353644515-17349-8-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 19:53:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td3oI-000271-Cg
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 19:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533Ab2KZSxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 13:53:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33085 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753655Ab2KZSxV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 13:53:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 980EAA4BB;
	Mon, 26 Nov 2012 13:53:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0gI0GajZWi271mSbGZUoKbJKZs8=; b=VasW0Q
	VKLcvXP+/kHW3gUFwvHJosmZ0n04Kl5s/6wcbWNdJ+fGGApb+G90zAF0aWdOrTcG
	UY9HYaDKWiq6YTjQ7G16pZ82pGjSZbSh/b95TjnFqWoA0phTSAqLV/eCP/S7UwSU
	mlr+W7GymmmeePK3fzr2L0dyERdH0AVKpIIFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eeE6vkstzHZjYuRW+5xMpFt8LOIuA+ZT
	QeQbnJgz+Cf5VY9UsCcRWrCKuwGqRsXqtNTqRhrF1ibMsHNddeQxjwiDzxsZIatR
	zNZt8+1uGpRRg2PR5LcdvjrezCGo1EHBKo598YEkrQVpNbma1oyTKDDKDGz1+TTM
	xXXdA36wt9I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84C3FA4BA;
	Mon, 26 Nov 2012 13:53:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E38FAA4B8; Mon, 26 Nov 2012
 13:53:19 -0500 (EST)
In-Reply-To: <1353644515-17349-8-git-send-email-chris@rorvick.com> (Chris
 Rorvick's message of "Thu, 22 Nov 2012 22:21:55 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BB57376-37FA-11E2-A585-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210468>

Chris Rorvick <chris@rorvick.com> writes:

> Pushes must already (by default) update to a commit-ish due the fast-
> forward check in set_ref_status_for_push().  But rejecting for not being
> a fast-forward suggests the situation can be resolved with a merge.
> Flag these updates (i.e., to a blob or a tree) as not forwardable so the
> user is presented with more appropriate advice.
>
> Signed-off-by: Chris Rorvick <chris@rorvick.com>
> ---
>  remote.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/remote.c b/remote.c
> index f5bc4e7..ee0c1e5 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1291,6 +1291,11 @@ static inline int is_forwardable(struct ref* ref)
>  	if (!o || o->type != OBJ_COMMIT)
>  		return 0;
>  
> +	/* new object must be commit-ish */
> +	o = deref_tag(parse_object(ref->new_sha1), NULL, 0);
> +	if (!o || o->type != OBJ_COMMIT)
> +		return 0;
> +

I think the original code used ref_newer() which took commit-ish on
both sides.

With this code, the old must be a commit but new can be a tag that
points at a commit?  Why?
