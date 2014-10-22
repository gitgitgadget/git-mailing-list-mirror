From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/15] refs.c: use packed refs when deleting refs during a transaction
Date: Wed, 22 Oct 2014 12:48:43 -0700
Message-ID: <xmqqy4s7homc.fsf@gitster.dls.corp.google.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
	<1413923820-14457-4-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 21:48:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xh1tt-0005A0-OW
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 21:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbaJVTsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2014 15:48:50 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64913 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932071AbaJVTst (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2014 15:48:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9793D1808B;
	Wed, 22 Oct 2014 15:48:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4EUViG+NXY+nQ+0oYofCvWbBpw8=; b=wBaJaZ
	MrUfcMEYweRz2tNpYGkanR3PWTNi8w87UV0P8NRdeQZ8Plh96a1uG9ZT85uJ0RHe
	1mMD4z6YGlycsF/nxBcivliD/4BI7b/zEsQktHceDpw4vRMa/oPlwE6mr+6oJ+ll
	f9K6xOIgTaG6lJBhACtGh3kJRTB06MC2uEkcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ho//tqtjbYgESX/P13XgC08IXnXdLlhz
	x3p0xMT2M+MWAM0iMAxix4+Cx6nn9hypHZLlbCzfrQ7QA24oeVH3qKKulHT+yQ80
	FfE8S9IqbqJ2e/WgeOo/OgL2YD4azF4gMZSzzTnvAvNXDsIp8D2Y/vOsY0aT1vto
	V6zOqw8G9ho=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F29C1808A;
	Wed, 22 Oct 2014 15:48:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 429A318086;
	Wed, 22 Oct 2014 15:48:44 -0400 (EDT)
In-Reply-To: <1413923820-14457-4-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Tue, 21 Oct 2014 13:36:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6E3DC5DE-5A24-11E4-A0A5-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ronnie Sahlberg <sahlberg@google.com> writes:

> commit fb5fa1d338ce113b0fea3bb955b50bbb3e827805 upstream.

Huh?

> Make the deletion of refs during a transaction more atomic.
> Start by first copying all loose refs we will be deleting to the packed
> refs file and then commit the packed refs file. Then re-lock the packed refs
> file to stop anyone else from modifying these refs and keep it locked until
> we are finished.
> Since all refs we are about to delete are now safely held in the packed refs
> file we can proceed to immediately unlink any corresponding loose refs
> and still be fully rollback-able.
>
> The exception is for refs that can not be resolved. Those refs are never
> added to the packed refs and will just be un-rollback-ably deleted during
> commit.
>
> By deleting all the loose refs at the start of the transaction we make make
> it possible to both delete one ref and then re-create a different ref in
> the same transaction even if the two refs would normally conflict.
>
> Example: rename m->m/m
>
> In that example we want to delete the file 'm' so that we make room so
> that we can create a directory with the same name in order to lock and
> write to the ref m/m and its lock-file m/m.lock.
>
> If there is a failure during the commit phase we can rollback without losing
> any refs since we have so far only deleted loose refs that that are
> guaranteed to also have a corresponding entry in the packed refs file.
> Once we have finished all updates for refs and their reflogs we can repack
> the packed refs file and remove the to-be-deleted refs from the packed refs,
> at which point all the deleted refs will disappear in one atomic rename
> operation.
>
> This also means that for an outside observer, deletion of multiple refs
> in a single transaction will look atomic instead of one ref being deleted
> at a time.
>
> In order to do all this we need to change the semantics for the
> repack_without_refs function so that we can lock the packed refs file,
> do other stuff, and later be able to call repack_without_refs with the
> lock already taken.
> This means we need some additional changes in remote.c to reflect the
> changes to the repack_without_refs semantics.
>
> Change-Id: I1e4f58050acaabc6bcfa3409fbc0c2b866bb59aa
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>


> @@ -3821,23 +3824,109 @@ int transaction_commit(struct transaction *transaction,
> ...
> +	if (need_repack) {
> +		packed = get_packed_refs(&ref_cache);;
> +		sort_ref_dir(packed);
> +		if (commit_packed_refs()){

SP between "){".

> +			strbuf_addf(err, "unable to overwrite old ref-pack "
> +				    "file");

This is bending backwards sacrificing readability; 80-col limit is
not that hard a limit.  Split at the comma instead, perhaps?

			strbuf_addf(err,
				    "unable to overwrite old ref-pack file");

> ...
> +		if (!update->lock) {
> +			int df_conflict = (errno == ENOTDIR);
> +
> +			strbuf_addf(err, "Cannot lock the ref '%s'.",
> +				    update->refname);
> +			ret = df_conflict ?
> +			  TRANSACTION_NAME_CONFLICT : 

A trailing SP here...

> @@ -3860,6 +3953,16 @@ int transaction_commit(struct transaction *transaction,
>  			update->reflog_lock = update->orig_update->reflog_lock;
>  			continue;
>  		}
> +		if (log_all_ref_updates && !reflog_exists(update->refname) &&
> +		    create_reflog(update->refname)) {
> +			ret = -1;
> +			if (err)
> +				strbuf_addf(err, "Failed to setup reflog for "
> +					    "%s", update->refname);

Split after comma, perhaps?
