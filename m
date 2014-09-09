From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 06/32] lockfile: unlock file if lockfile permissions cannot be adjusted
Date: Tue, 09 Sep 2014 15:39:18 -0700
Message-ID: <xmqqr3zkifl5.fsf@gitster.dls.corp.google.com>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
	<1409989846-22401-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 10 00:39:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRU4Q-0007x3-UT
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 00:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbaIIWjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 18:39:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63560 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980AbaIIWjV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 18:39:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9BE61396DB;
	Tue,  9 Sep 2014 18:39:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KT5Wo51Dvzl1k2EwZAMr3i28w2w=; b=gqbA6j
	vyD90BKrTjXPgBKck3Yp43vWwwssH0TzcK2oJRWohA1k+989BNvNIhIGbTjg47q4
	+5PTOw5cTkwP3W8PRQPldABvlkrQ9zryaoiG/G1qsVBvuC5OLCl+/muXxgDnmhHZ
	6KbaL73rpjsfNLS/GHEDwYuc5dO1safH1cHSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=od52K2Z3VC7Tral8W+L4R/NO3/zPH+pp
	mkgdYnqGWBnDxvDpityh1kTzSY8Eb/6rDKeVkPGcoV+hcfWOBS8C5hjUcQeeT5hI
	3yOxenpKBEOLite3cPxJNQFXrvFbkM8DgEm4vvEJfM8NyRqqSSYn1PgPSCisaJEt
	gyu3hiS6zHE=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 915C9396D9;
	Tue,  9 Sep 2014 18:39:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 112E7396D5;
	Tue,  9 Sep 2014 18:39:19 -0400 (EDT)
In-Reply-To: <1409989846-22401-7-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Sat, 6 Sep 2014 09:50:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 237D53B2-3872-11E4-8C7A-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256720>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> If the call to adjust_shared_perm() fails, lock_file returns -1, which
> to the caller looks like any other failure to lock the file.  So in
> this case, roll back the lockfile before returning so that the lock
> file is deleted immediately and the lockfile object is left in a
> predictable state (namely, unlocked).  Previously, the lockfile was
> retained until process cleanup in this situation.

... which would mean that other processes can grab a lock on the
same file a bit earlier. Is there any negative implication caused by
that difference?  I do not think of any but I could be missing
something.

>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  lockfile.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lockfile.c b/lockfile.c
> index b1c4ba0..d4f165d 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -153,6 +153,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
>  			int save_errno = errno;
>  			error("cannot fix permission bits on %s",
>  			      lk->filename);
> +			rollback_lock_file(lk);
>  			errno = save_errno;
>  			return -1;
>  		}
