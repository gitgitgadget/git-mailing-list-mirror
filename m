Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C585420441
	for <e@80x24.org>; Sun,  1 Jan 2017 02:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932082AbdAACJg (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 21:09:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52721 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932071AbdAACJg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 21:09:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C9F435C0CA;
        Sat, 31 Dec 2016 21:09:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UkBjyoUSd9oZbMvEQlCkXpVYHHI=; b=Kisb7n
        HL3TO3DADwwhT6vgUjrvZAD2Mi4bL6AIRB0+PDMeniT5aMj3Q5wT6yQn19fio8KG
        z+B89l7OcvWFwQD7UN2eKd57vgg3Mu4RGZ9Fp0/MTieG3XJi6zVar6pXOoA0Dw11
        1Zd20GuAf6FY5EqtMQKuyjGy0Z93fNZQiaGcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fVDPC6tbcroMdq6sm/bLeLCm0OrggRoG
        YfoUvoXordJXoCeLw7Bwz306xnHGOkr7A1aXwa5vcU6wE01eSlg+TIXPlYxseg4w
        m4bYacS+LCqfK4nx5FcHWrMX8Y/IR0cXXsx98uE4HSsoRT6k3Gjqej3Xba7v5ITL
        Mazp3iHKUo4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C29815C0C6;
        Sat, 31 Dec 2016 21:09:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3EEED5C0C4;
        Sat, 31 Dec 2016 21:09:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH v3 10/23] log_ref_write(): inline function
References: <cover.1483153436.git.mhagger@alum.mit.edu>
        <dba3d081c32854593d8113f9cd604a9891748bcd.1483153436.git.mhagger@alum.mit.edu>
Date:   Sat, 31 Dec 2016 18:09:33 -0800
In-Reply-To: <dba3d081c32854593d8113f9cd604a9891748bcd.1483153436.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Sat, 31 Dec 2016 04:12:50 +0100")
Message-ID: <xmqqzijb4jky.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 56C740FE-CFC7-11E6-BAA6-06F112518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This function doesn't do anything beyond call files_log_ref_write(), so

s/call/&ing/; I think.

> replace it with the latter at its call sites.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs/files-backend.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 49a119c..fd8a751 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2832,14 +2832,6 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
>  	return 0;
>  }
>  
> -static int log_ref_write(const char *refname, const unsigned char *old_sha1,
> -			 const unsigned char *new_sha1, const char *msg,
> -			 int flags, struct strbuf *err)
> -{
> -	return files_log_ref_write(refname, old_sha1, new_sha1, msg, flags,
> -				   err);
> -}
> -
>  int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
>  			const unsigned char *new_sha1, const char *msg,
>  			int flags, struct strbuf *err)
> @@ -2903,7 +2895,8 @@ static int commit_ref_update(struct files_ref_store *refs,
>  	assert_main_repository(&refs->base, "commit_ref_update");
>  
>  	clear_loose_ref_cache(refs);
> -	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, 0, err)) {
> +	if (files_log_ref_write(lock->ref_name, lock->old_oid.hash, sha1,
> +				logmsg, 0, err)) {
>  		char *old_msg = strbuf_detach(err, NULL);
>  		strbuf_addf(err, "cannot update the ref '%s': %s",
>  			    lock->ref_name, old_msg);
> @@ -2934,7 +2927,7 @@ static int commit_ref_update(struct files_ref_store *refs,
>  		if (head_ref && (head_flag & REF_ISSYMREF) &&
>  		    !strcmp(head_ref, lock->ref_name)) {
>  			struct strbuf log_err = STRBUF_INIT;
> -			if (log_ref_write("HEAD", lock->old_oid.hash, sha1,
> +			if (files_log_ref_write("HEAD", lock->old_oid.hash, sha1,
>  					  logmsg, 0, &log_err)) {
>  				error("%s", log_err.buf);
>  				strbuf_release(&log_err);
> @@ -2973,7 +2966,8 @@ static void update_symref_reflog(struct ref_lock *lock, const char *refname,
>  	struct strbuf err = STRBUF_INIT;
>  	unsigned char new_sha1[20];
>  	if (logmsg && !read_ref(target, new_sha1) &&
> -	    log_ref_write(refname, lock->old_oid.hash, new_sha1, logmsg, 0, &err)) {
> +	    files_log_ref_write(refname, lock->old_oid.hash, new_sha1,
> +				logmsg, 0, &err)) {
>  		error("%s", err.buf);
>  		strbuf_release(&err);
>  	}
> @@ -3748,9 +3742,11 @@ static int files_transaction_commit(struct ref_store *ref_store,
>  
>  		if (update->flags & REF_NEEDS_COMMIT ||
>  		    update->flags & REF_LOG_ONLY) {
> -			if (log_ref_write(lock->ref_name, lock->old_oid.hash,
> -					  update->new_sha1,
> -					  update->msg, update->flags, err)) {
> +			if (files_log_ref_write(lock->ref_name,
> +						lock->old_oid.hash,
> +						update->new_sha1,
> +						update->msg, update->flags,
> +						err)) {
>  				char *old_msg = strbuf_detach(err, NULL);
>  
>  				strbuf_addf(err, "cannot update the ref '%s': %s",
