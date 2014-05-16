From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/31] refs.c: add a flag to allow reflog updates to truncate the log
Date: Fri, 16 May 2014 14:20:58 -0700
Message-ID: <xmqqy4y18lol.fsf@gitster.dls.corp.google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
	<1400105610-21194-8-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 16 23:21:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlPYz-00070z-T6
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 23:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964AbaEPVVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 17:21:05 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65260 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753822AbaEPVVD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 17:21:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1455B14A2C;
	Fri, 16 May 2014 17:21:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZM+FABKjg3f7nB2kaWMmYNLbt60=; b=dnw/Z/
	fe0DWhH4YhJbfAKl5N31TGqcMWBrb+3EPUnIsESyBCPQHqwZIzznd5u30kveCreP
	6xDTFPhENlpg+OLekxhxynKQla71mofeinVB2RfHtBN0Arxo/MmtRCufPJkMrLg8
	gOzigZm80N2KM7y+yxHRVIuIjNX6BQvBcSJbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YA1iskj/PKv7n/vR+/5NF/mE63Z7VCEx
	o7rYhjoYT0/4a9js9HPFuqkFTDRBcSLk2eJIVhqc50P2Xchol1y9GDH9csWtzvLJ
	yTT737sz5vCGdwCILNlArJpDRzhOwJpH6o1jhh0ai1cSHgaxBe/kzW7ENYqip5v+
	paFrq105oAo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 06E9614A2B;
	Fri, 16 May 2014 17:21:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B6B0814A23;
	Fri, 16 May 2014 17:20:59 -0400 (EDT)
In-Reply-To: <1400105610-21194-8-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Wed, 14 May 2014 15:13:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F9F5F1C6-DD3F-11E3-895A-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249418>

Ronnie Sahlberg <sahlberg@google.com> writes:

> Add a flag that allows us to truncate the reflog before we write the update.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---

Until we read the callers it is hard to see how such a feature is
useful, though.

(style) The two multi-line comments are formatted differently.

>  refs.c | 12 ++++++++++--
>  refs.h |  4 +++-
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index d8a1568..a8b583a 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3608,7 +3608,11 @@ int transaction_commit(struct ref_transaction *transaction,
>  		}
>  	}
>  
> -	/* Update all reflog files */
> +	/* Update all reflog files
> +	   We have already done all ref updates and deletes.
> +	   There is not much we can do here if there are any reflog
> +	   update errors, other than complain.
> +	*/
>  	for (i = 0; i < n; i++) {
>  		struct ref_update *update = updates[i];
>  
> @@ -3616,7 +3620,11 @@ int transaction_commit(struct ref_transaction *transaction,
>  			continue;
>  		if (update->reflog_fd == -1)
>  			continue;
> -
> +		if (update->flags & REFLOG_TRUNCATE)
> +			if (lseek(update->reflog_fd, 0, SEEK_SET) < 0 ||
> +			    ftruncate(update->reflog_fd, 0)) {
> +				error("Could not truncate reflog");
> +			}

The {} looks somewhat curious here.  If you seeked to the beginning,
and failed to truncate, do you still want to go on without "return"
in front of the error()?  Would that overwrite existing entries?

>  		if (log_ref_write_fd(update->reflog_fd, update->old_sha1,
>  				     update->new_sha1,
>  				     update->committer, update->msg)) {
> diff --git a/refs.h b/refs.h
> index 2e22a26..b1b97e7 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -269,8 +269,10 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
>  			    const unsigned char *old_sha1,
>  			    int flags, int have_old, const char *msg);
>  
> +#define REFLOG_TRUNCATE 0x01
>  /*
> - * Append a reflog entry for refname.
> + * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
> + * this update will first truncate the reflog before writing the entry.
>   */
>  int transaction_update_reflog(struct ref_transaction *transaction,
>  			      const char *refname,
