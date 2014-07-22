From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/12] refs.c: fix handling of badly named refs
Date: Tue, 22 Jul 2014 13:41:05 -0700
Message-ID: <xmqqlhrlf7oe.fsf@gitster.dls.corp.google.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
	<1405549392-27306-13-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 22:41:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9gs9-0006yp-Vy
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 22:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756788AbaGVUlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 16:41:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53488 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755563AbaGVUlN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 16:41:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C6A582B52F;
	Tue, 22 Jul 2014 16:41:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wpxHpl0/GZ5cJ+QAmrvj6b66Lpo=; b=hGwdDs
	K8Xx+oOA+TJJwRIWwGknSOYbeT8zFXtQCFv1njRPgwjWBiEiF/PyhfxTRlT6DjwD
	c/bRlwqIcrfVjrsStXbQ0MDoBbJZBKLaVcMiODMG5Ehj2hTryYFxxZ5Y8YVyjMPO
	tJ9yaXZHQ0/zUQ7oJkUmKFEG7AlhDlcBBI/sc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h7HDdesKuur7P6JwxfnaUT2sMu4OewNJ
	JxIEZwyzLu/0hkBcT2afOxZZnOzA2zXofvE769zUsvA7e/TIBNJQQxOB9/jocVd9
	xxUDJhVn2uR8YzozR3KV8nwMOH1kdfFSdKUdNiOx4jwGee6IMjd8bWNd2JX9R5yR
	l1rUdVPklvg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8A7232B52E;
	Tue, 22 Jul 2014 16:41:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 861522B521;
	Tue, 22 Jul 2014 16:41:06 -0400 (EDT)
In-Reply-To: <1405549392-27306-13-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Wed, 16 Jul 2014 15:23:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 812E5B5E-11E0-11E4-A40A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254036>

Ronnie Sahlberg <sahlberg@google.com> writes:

> We currently do not handle badly named refs well :
> $ cp .git/refs/heads/master .git/refs/heads/master.....@\*@\\.
> $ git branch
>    fatal: Reference has invalid format: 'refs/heads/master.....@*@\.'
> $ git branch -D master.....@\*@\\.
>   error: branch 'master.....@*@\.' not found.
>
> But we can not really recover from a badly named ref with less than
> manually deleting the .git/refs/heads/<refname> file.
>
> Change resolve_ref_unsafe to take a flags field instead of a 'reading'
> boolean and update all callers that used a non-zero value for reading
> to pass the flag RESOLVE_REF_READING instead.
> Add another flag RESOLVE_REF_ALLOW_BAD_NAME that will make
> resolve_ref_unsafe skip checking the refname for sanity and use this
> from branch.c so that we will be able to call resolve_ref_unsafe on such
> refs when trying to delete it.

Makes sense.

> Add checks for refname sanity when updating (not deleting) a ref in
> ref_transaction_update and in ref_transaction_create to make the transaction
> fail if an attempt is made to create/update a badly named ref.
> Since all ref changes will later go through the transaction layer this means
> we no longer need to check for and fail for bad refnames in
> lock_ref_sha1_basic.
>
> Change lock_ref_sha1_basic to not fail for bad refnames. Just check the
> refname, and print an error, and remember that the refname is bad so that
> we can skip calling verify_lock().

This is somewhat puzzling, though.

> @@ -2180,6 +2196,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  		else
>  			unable_to_lock_index_die(ref_file, errno);
>  	}
> +	if (bad_refname)
> +		return lock;

Hmph.  If the only offence was that the ref was named badly due to
historically loose code, does the caller not still benefit from the
verify-lock check to make sure that other people did not muck with
the ref while we were planning to update it?

>  	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
>  
>   error_return:
