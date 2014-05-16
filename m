From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/31] refs.c: only write reflog update if msg is non-NULL
Date: Fri, 16 May 2014 14:24:17 -0700
Message-ID: <xmqqtx8p8lj2.fsf@gitster.dls.corp.google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
	<1400105610-21194-9-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 16 23:24:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlPcA-0006yU-L1
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 23:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876AbaEPVYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 17:24:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64460 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754774AbaEPVYV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 17:24:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 65E8114B4B;
	Fri, 16 May 2014 17:24:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l6YF/DCPRl+9zcwibse3cBzpL2g=; b=mYGqjm
	b4JrSi1hayCM2fV5NjNhdvplolqO8CkPbjRwNA6uio4wHmEG3s2cav0lLdrUQPzx
	dx7Kng54/SCAKQM1/gk4yAbH9XqJIJyPxtBVaCVo0KoD0Zp47j61uqa1Un0Y+QB1
	gae4iYouk22+Nw8StQp8wzXIKfx7V6XhRurSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=viQbfV7qvsVxwiIFe5kKV2fl9zK8Xc/h
	hnS6lQBM4ZD8GM8oU8hdHtlQ/rxHlchV90OHAuoNMQF4HA6Sfk7f7fVIKaOKGclc
	ri9quFHB9UA8iIXUiOuQCx6i9EKUtHSAr11M6FYfF0gUSj+3lLJiA327+EayU+cM
	bLJjtrdknAs=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5DA7814B4A;
	Fri, 16 May 2014 17:24:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9ACCA14B44;
	Fri, 16 May 2014 17:24:18 -0400 (EDT)
In-Reply-To: <1400105610-21194-9-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Wed, 14 May 2014 15:13:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7081885A-DD40-11E3-974D-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249420>

Ronnie Sahlberg <sahlberg@google.com> writes:

> When performing a reflog transaction update, only write to the reflog iff
> msg is non-NULL. This can then be combined with REFLOG_TRUNCATE to perform
> an update that only truncates but does not write.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 8 +++++---
>  refs.h | 1 +
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index a8b583a..a3f60ad 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3625,9 +3625,11 @@ int transaction_commit(struct ref_transaction *transaction,
>  			    ftruncate(update->reflog_fd, 0)) {
>  				error("Could not truncate reflog");
>  			}
> -		if (log_ref_write_fd(update->reflog_fd, update->old_sha1,
> -				     update->new_sha1,
> -				     update->committer, update->msg)) {
> +		if (update->msg && log_ref_write_fd(update->reflog_fd,
> +						    update->old_sha1,
> +						    update->new_sha1,
> +						    update->committer,
> +						    update->msg)) {

Wouldn't it make it easier to read if you chopped immediately after
the &&, i.e. chopping at a gap at a higher-level in the parse tree?

        if (update->msg &&
            log_ref_write_fd(update->reflog_fd,
                             update->old_sha1, update->old_sha1,
                             update->committer, update->msg)) {
