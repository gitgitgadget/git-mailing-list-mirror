From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/15] refs.c: only write reflog update if msg is non-NULL
Date: Thu, 23 Oct 2014 11:32:45 -0700
Message-ID: <xmqq8uk6skky.fsf@gitster.dls.corp.google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
	<1413919462-3458-10-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 20:32:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhNBt-0002HV-H6
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 20:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343AbaJWSct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 14:32:49 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50564 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754197AbaJWScs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2014 14:32:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E80F717A27;
	Thu, 23 Oct 2014 14:32:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=89IAWa4pQQUxr6M+652PcH+L7qQ=; b=Wrt7hX
	w+t8MijIMS9FJ32W5GHNura/D3vYaioDrjShJWmyRakWMRjkNsCYqBd5gyaR0ku9
	mG3La9edFyrbyG1+1YJ+8mCLx2Byv+vs+H19JxCit617tYSIzLyYhOvCzuhrdKyn
	7S7k0dUKRjVCyHd57XW89bgZCyXhuUO0n/HNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=erWc+jgTiAHIvQFdoOgDH/ZnYwSGHRfS
	IIkH7tqMTYTrBhsAVmhTiL5bRnDZhas6iy2Z/+jTwi8kO0nEByMmY073oxH1P/bc
	8/xKZl8Z3O6WxPCkiCFLgFTGdoji/xxJhfb52FtAXgnDBffnTLJGLf0V1ssTETgc
	UCxOiMObIFk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DEF5417A26;
	Thu, 23 Oct 2014 14:32:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FACA17A23;
	Thu, 23 Oct 2014 14:32:47 -0400 (EDT)
In-Reply-To: <1413919462-3458-10-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Tue, 21 Oct 2014 12:24:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FC76EC86-5AE2-11E4-84F8-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ronnie Sahlberg <sahlberg@google.com> writes:

> commit 020ed65a12838bdead64bc3c5de249d3c8f5cfd8 upstream.
>
> When performing a reflog transaction update, only write to the reflog iff
> msg is non-NULL. This can then be combined with REFLOG_TRUNCATE to perform
> an update that only truncates but does not write.

Does any existing caller call this codepath with update->msg == NULL?

Will "please truncate" stay to be the only plausible special cause
to call into this codepath without having any meaningful message?

I am trying to make sure that this patch is not painting us into a
corner where we will find out another reason for doing something
esoteric in this codepath but need to find a way other than setting
msg to NULL for the caller to trigger that new codepath.  Put it in
another way, please convince me that a new boolean field in update,
e.g. update->truncate_reflog, is way overkill for this.

>
> Change-Id: I44c89caa7e7c4960777b79cfb5d339a5aa3ddf7a
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  refs.c | 5 +++--
>  refs.h | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index d54c3b9..f14b76e 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3895,8 +3895,9 @@ int transaction_commit(struct transaction *transaction,
>  				update->reflog_fd = -1;
>  				continue;
>  			}
> -		if (log_ref_write_fd(update->reflog_fd, update->old_sha1,
> -				     update->new_sha1,
> +		if (update->msg &&
> +		    log_ref_write_fd(update->reflog_fd,
> +				     update->old_sha1, update->new_sha1,
>  				     update->committer, update->msg)) {
>  			error("Could write to reflog: %s. %s",
>  			      update->refname, strerror(errno));
> diff --git a/refs.h b/refs.h
> index 5075073..bf96b36 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -337,6 +337,7 @@ int transaction_delete_ref(struct transaction *transaction,
>  /*
>   * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
>   * this update will first truncate the reflog before writing the entry.
> + * If msg is NULL no update will be written to the log.
>   */
>  int transaction_update_reflog(struct transaction *transaction,
>  			      const char *refname,
