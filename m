From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Fix failure to delete a packed ref through a symref
Date: Sun, 21 Oct 2012 12:09:01 -0700
Message-ID: <7vsj97fxrm.fsf@alter.siamese.dyndns.org>
References: <7vpq4flb1c.fsf@alter.siamese.dyndns.org>
 <1350816032-16312-1-git-send-email-johan@herland.net>
 <1350816032-16312-3-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx, vmiklos@suse.cz
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Oct 21 21:09:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ0tg-0005CV-Mh
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 21:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497Ab2JUTJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 15:09:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38071 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480Ab2JUTJE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 15:09:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC3BC94DF;
	Sun, 21 Oct 2012 15:09:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a3vsxg0kO0sozqcqwGoEaeQZ8u8=; b=OPxeKx
	oLXEbqa9WFgEcAjmPgHGcwhJsDktf3Bw8fdKFbJelvFLywo5omil5WyT5O+ammy+
	3ZfwodkYWf2M0iVvpYASDkTdrjG4Vqry+fW7I+Gm3djZ3TXYxko4OtU39rjII0Us
	SYxT7X1TTVPRHl+Rb75dY6eJkm5s/dCQIMrbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rcfDwSTcwRTSpAtaI9T6kmrlbIGxcV6x
	bAjKl0u22MjOeKWb7rCptNk4haUlQvKp6eQ6RW2kVBx2JApTzcXcwCfySg651FRx
	3AteiY12oFNsg2qyAMt4sr8CARKP268bZu7MNg30SqNmMfA5f03pxBni0D6Yavcs
	5iAhJJWtlCo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D95B694DE;
	Sun, 21 Oct 2012 15:09:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3133494DC; Sun, 21 Oct 2012
 15:09:03 -0400 (EDT)
In-Reply-To: <1350816032-16312-3-git-send-email-johan@herland.net> (Johan
 Herland's message of "Sun, 21 Oct 2012 12:40:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C70B9B6C-1BB2-11E2-B4B5-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208137>

Johan Herland <johan@herland.net> writes:

> When deleting a ref through a symref (e.g. using 'git update-ref -d HEAD'
> to delete refs/heads/master), we would remove the loose ref, but a packed
> version of the same ref would remain, the end result being that instead of
> deleting refs/heads/master we would appear to reset it to its state as of
> the last repack.
>
> This patch fixes the issue, by making sure we pass the correct ref name
> when invoking repack_without_ref() from within delete_ref().
>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---

Thanks.  Will queue.

>  refs.c                | 2 +-
>  t/t1400-update-ref.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 726c53c..6cec1c8 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1779,7 +1779,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
>  	 * packed one.  Also, if it was not loose we need to repack
>  	 * without it.
>  	 */
> -	ret |= repack_without_ref(refname);
> +	ret |= repack_without_ref(lock->ref_name);
>  
>  	unlink_or_warn(git_path("logs/%s", lock->ref_name));
>  	invalidate_ref_cache(NULL);
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index f7ec203..e415ee0 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -85,7 +85,7 @@ test_expect_success \
>  	"move $m (by HEAD)" \
>  	"git update-ref HEAD $B $A &&
>  	 test $B"' = $(cat .git/'"$m"')'
> -test_expect_failure "delete $m (by HEAD) should remove both packed and loose $m" '
> +test_expect_success "delete $m (by HEAD) should remove both packed and loose $m" '
>  	git update-ref -d HEAD $B &&
>  	! grep "$m" .git/packed-refs &&
>  	! test -f .git/$m
