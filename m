From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] write_ref_sha1(): Move write elision test to callers
Date: Thu, 12 Feb 2015 11:58:40 -0800
Message-ID: <xmqq386asxzj.fsf@gitster.dls.corp.google.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 12 20:58:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLzuR-0001qB-LX
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 20:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbbBLT6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 14:58:43 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60291 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750871AbbBLT6m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 14:58:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D98263798C;
	Thu, 12 Feb 2015 14:58:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2dtMBaljluqndFRbSN/cLT1Y7co=; b=Mm4041
	iRUo/OFSIhnHdc0xbPpZ+2spUIkKxCU/UQUYtDNt9lqsviYamlT/JgQisKXjzkeH
	BhWAFt2GaeTMb7sGgmf9gPOxzA9UIhcGx876bgyou2dDB53bmZXGKxzF8PQ9lfju
	EsbcS/4fgZQ8c9RqrCmV+fehlh7Wrd19yWcC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VUMyl5a31ceGiiqUym48FHlZwbqkOOJW
	0bc3RdWEOv8I8u86CuruQH4Nwj9UoA7L+hP/FrJlcVt0DWIc1zfTXlU7jsiOYJZq
	QPQoog/qFzf1LkALKrfvproad7OhFwb2YrsEZB9lTFAv44cS8J5o1wDTh0scwBom
	CEYYc4WkGek=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CFDD83798B;
	Thu, 12 Feb 2015 14:58:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 583C53798A;
	Thu, 12 Feb 2015 14:58:41 -0500 (EST)
In-Reply-To: <1423473164-6011-3-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Mon, 9 Feb 2015 10:12:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8ADAC5F4-B2F1-11E4-81C2-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263758>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> write_ref_sha1() previously skipped the write if the reference already
> had the desired value, unless lock->force_write was set. Instead,
> perform that test at the callers.
>
> Two of the callers (in rename_ref()) unconditionally set force_write
> just before calling write_ref_sha1(), so they don't need the extra
> check at all. Nor do they need to set force_write anymore.

Good.  I recall that this convoluted "the callee checks if the
values are the same so we need to tell it not to do that" logic
looked very disturbing.



> The last caller, in ref_transaction_commit(), still needs the test.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index d1130e2..651e37e 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2878,7 +2878,6 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>  		error("unable to lock %s for update", newrefname);
>  		goto rollback;
>  	}
> -	lock->force_write = 1;
>  	hashcpy(lock->old_sha1, orig_sha1);
>  	if (write_ref_sha1(lock, orig_sha1, logmsg)) {
>  		error("unable to write current sha1 into %s", newrefname);
> @@ -2894,7 +2893,6 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>  		goto rollbacklog;
>  	}
>  
> -	lock->force_write = 1;
>  	flag = log_all_ref_updates;
>  	log_all_ref_updates = 0;
>  	if (write_ref_sha1(lock, orig_sha1, NULL))
> @@ -3080,10 +3078,6 @@ static int write_ref_sha1(struct ref_lock *lock,
>  	static char term = '\n';
>  	struct object *o;
>  
> -	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
> -		unlock_ref(lock);
> -		return 0;
> -	}
>  	o = parse_object(sha1);
>  	if (!o) {
>  		error("Trying to write ref %s with nonexistent object %s",
> @@ -3797,15 +3791,21 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  		struct ref_update *update = updates[i];
>  
>  		if (!is_null_sha1(update->new_sha1)) {
> -			if (write_ref_sha1(update->lock, update->new_sha1,
> -					   update->msg)) {
> +			if (!update->lock->force_write &&
> +			    !hashcmp(update->lock->old_sha1, update->new_sha1)) {
> +				unlock_ref(update->lock);
> +				update->lock = NULL;
> +			} else if (write_ref_sha1(update->lock, update->new_sha1,
> +						  update->msg)) {
>  				update->lock = NULL; /* freed by write_ref_sha1 */
>  				strbuf_addf(err, "Cannot update the ref '%s'.",
>  					    update->refname);
>  				ret = TRANSACTION_GENERIC_ERROR;
>  				goto cleanup;
> +			} else {
> +				/* freed by write_ref_sha1(): */
> +				update->lock = NULL;
>  			}
> -			update->lock = NULL; /* freed by write_ref_sha1 */
>  		}
>  	}
