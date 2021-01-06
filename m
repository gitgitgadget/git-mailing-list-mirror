Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD8EC433E6
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 05:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A12822CA2
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 05:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbhAFF4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 00:56:20 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55592 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbhAFF4U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 00:56:20 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F1DAE10C9D6;
        Wed,  6 Jan 2021 00:55:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=o1JyC8kZGPFbc8+qGfKkIItb6pE=; b=NtBaQMfpj7qb6lbuFbLw
        MdcCPSa7qny2/ffNTIKHVmPvkMpS7+I3Bd9Q891JDWYTdgi3a0rQNcCdrc646GUw
        dj+giWbkTdojY+xLaYHwelV6tiTP4tG1FBGG6y+lV3ZM1Ti+sN5QSo+WKdtuqvoX
        ejs8U/tWegRXD4pH1qaXy3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=M8UlWZmKdgyU264Dod9HsA6WrL3MS85cSgy80aUFARiflY
        F7p0CEpF9c/K4G/pCtaNSF838ZI/osQUwZmFfXXDgD1yHs30Cjf/h6KenLSqA5Wj
        cYGdlV1xnINLpMbuVrH8Np26HFVox8kFUBmi6V4PO5ygVAQMzR0ZqvuAPpa7k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EB01510C9D4;
        Wed,  6 Jan 2021 00:55:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3C94110C9D3;
        Wed,  6 Jan 2021 00:55:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] refs: allow @{n} to work with n-sized reflog
References: <0c6885f15f5ce0be28142d9c69724362e72481a9.1609551262.git.liu.denton@gmail.com>
Date:   Tue, 05 Jan 2021 21:55:29 -0800
Message-ID: <xmqqk0sqvcby.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8F513E0-4FE3-11EB-84FC-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> This sequence works
>
> 	$ git checkout -b newbranch
> 	$ git commit --allow-empty -m one
> 	$ git show -s newbranch@{1}
>
> and shows the state that was immediately after the newbranch was
> created.
>
> But then if you do
>
> 	$ git reflog expire --expire=now refs/heads/newbranch
> 	$ git commit --allow=empty -m two
> 	$ git show -s newbranch@{1}
>
> you'd be scolded with
>
> 	fatal: log for 'newbranch' only has 1 entries
>
> While it is true that it has only 1 entry, we have enough
> information in that single entry that records the transition between
> the state in which the tip of the branch was pointing at commit
> 'one' to the new commit 'two' built on it, so we should be able to
> answer "what object newbranch was pointing at?". But we refuse to
> do so.

Yeah, I am often hit and irritated by this behaviour.

> Make @{0} the special case where we use the new side to look up that
> entry. Otherwise, look up @{n} using the old side of the (n-1)th entry
> of the reflog.

OK.

> diff --git a/refs.c b/refs.c
> index 13dc2c3291..c35c61a009 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -887,12 +887,16 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
>  		const char *message, void *cb_data)
>  {
>  	struct read_ref_at_cb *cb = cb_data;
> +	int at_indexed_ent;
>  
>  	cb->reccnt++;
>  	cb->tz = tz;
>  	cb->date = timestamp;
>  
> -	if (timestamp <= cb->at_time || cb->cnt == 0) {
> +	if (cb->cnt > 0)
> +		cb->cnt--;
> +	at_indexed_ent = cb->cnt == 0 && !is_null_oid(ooid);

The code treats two cases identically (i.e. the case where cb->cnt
was originally zero, and one).  Is that intended?

I thought the code was to special case only <ref>@{0}, but with this
conditional decrement, cb->cnt==0 would not be usable by the rest
of the code as the "we must read the new side instead" signal. Is
that why null-ness of ooid is also tested here?  It is hard to tell
the intention because "at_indexed_ent" does not quite tell me what
the code wants to use the variable for.

> +	if (timestamp <= cb->at_time || at_indexed_ent) {
>  		if (cb->msg)
>  			*cb->msg = xstrdup(message);
>  		if (cb->cutoff_time)
> @@ -905,28 +909,41 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
>  		 * we have not yet updated cb->[n|o]oid so they still
>  		 * hold the values for the previous record.
>  		 */
> -		if (!is_null_oid(&cb->ooid)) {
> -			oidcpy(cb->oid, noid);
> -			if (!oideq(&cb->ooid, noid))
> -				warning(_("log for ref %s has gap after %s"),
> +		if (!is_null_oid(&cb->ooid) && !oideq(&cb->ooid, noid))
> +			warning(_("log for ref %s has gap after %s"),
>  					cb->refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
> -		}
> -		else if (cb->date == cb->at_time)
> +		if (at_indexed_ent)
> +			oidcpy(cb->oid, ooid);
> +		else if (!is_null_oid(&cb->ooid) || cb->date == cb->at_time)
>  			oidcpy(cb->oid, noid);
>  		else if (!oideq(noid, cb->oid))
>  			warning(_("log for ref %s unexpectedly ended on %s"),
>  				cb->refname, show_date(cb->date, cb->tz,
>  						       DATE_MODE(RFC2822)));
> -		oidcpy(&cb->ooid, ooid);
> -		oidcpy(&cb->noid, noid);
>  		cb->found_it = 1;
> -		return 1;
>  	}
>  	oidcpy(&cb->ooid, ooid);
>  	oidcpy(&cb->noid, noid);
> -	if (cb->cnt > 0)
> -		cb->cnt--;
> -	return 0;
> +	return cb->found_it;
> +}
> +
> +static int read_ref_at_ent_newest(struct object_id *ooid, struct object_id *noid,
> +				  const char *email, timestamp_t timestamp,
> +				  int tz, const char *message, void *cb_data)
> +{
> +	struct read_ref_at_cb *cb = cb_data;
> +
> +	if (cb->msg)
> +		*cb->msg = xstrdup(message);
> +	if (cb->cutoff_time)
> +		*cb->cutoff_time = timestamp;
> +	if (cb->cutoff_tz)
> +		*cb->cutoff_tz = tz;
> +	if (cb->cutoff_cnt)
> +		*cb->cutoff_cnt = cb->reccnt;
> +	oidcpy(cb->oid, noid);
> +	/* We just want the first entry */
> +	return 1;
>  }

The similarity of this to read_ref_at_ent_oldest is somehow
striking.  Do we really need to invent a new callback?

>  static int read_ref_at_ent_oldest(struct object_id *ooid, struct object_id *noid,
> @@ -967,6 +984,11 @@ int read_ref_at(struct ref_store *refs, const char *refname,
>  	cb.cutoff_cnt = cutoff_cnt;
>  	cb.oid = oid;
>  
> +	if (cb.cnt == 0) {
> +		refs_for_each_reflog_ent_reverse(refs, refname, read_ref_at_ent_newest, &cb);
> +		return 0;
> +	}
> +
>  	refs_for_each_reflog_ent_reverse(refs, refname, read_ref_at_ent, &cb);
>  
>  	if (!cb.reccnt) {
> diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
> index dc9fe3cbf1..ed4a366e85 100755
> --- a/t/t1503-rev-parse-verify.sh
> +++ b/t/t1503-rev-parse-verify.sh
> @@ -86,8 +86,8 @@ test_expect_success 'fails silently when using -q' '
>  test_expect_success 'fails silently when using -q with deleted reflogs' '
>  	ref=$(git rev-parse HEAD) &&
>  	git update-ref --create-reflog -m "message for refs/test" refs/test "$ref" &&
> -	git reflog delete --updateref --rewrite refs/test@{0} &&
> -	test_must_fail git rev-parse -q --verify refs/test@{0} >error 2>&1 &&
> +	git reflog delete --updateref --rewrite refs/test@{1} &&
> +	test_must_fail git rev-parse -q --verify refs/test@{1} >error 2>&1 &&
>  	test_must_be_empty error
>  '
>  
> @@ -139,6 +139,19 @@ test_expect_success 'master@{n} for various n' '
>  	test_must_fail git rev-parse --verify master@{$Np1}
>  '
>  
> +test_expect_success '@{1} works with only one reflog entry' '
> +	git checkout -B newbranch &&
> +	git reflog expire --expire=now refs/heads/newbranch &&
> +	git commit --allow-empty -mexpired &&
> +	git rev-parse --verify newbranch@{1}
> +'
> +
> +test_expect_success '@{0} works with empty reflog' '
> +	git checkout -B newbranch &&
> +	git reflog expire --expire=now refs/heads/newbranch &&
> +	git rev-parse --verify newbranch@{0}
> +'
> +
>  test_expect_success SYMLINKS 'ref resolution not confused by broken symlinks' '
>  	ln -s does-not-exist .git/refs/heads/broken &&
>  	test_must_fail git rev-parse --verify broken
