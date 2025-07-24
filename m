Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0272D4B5B
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361784; cv=none; b=mLQsIYrb8QyE47ufv317Gb2nOuUe/r3xo97h6ndPqx8/6Fk0VJ54gvgAOWiQC1mKa40dKJbLvTMy/+ddzvoqpEgdjtxRgYHKYphZldZe5pPXqHXehL8VhKPPYureVS8YOwAIwcp1lVQyni9jlJb8qEiWSZEBqacSQjNGuzNpArQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361784; c=relaxed/simple;
	bh=DGqc4HwF3sYVC9YPZJkqIW+Rv9980fbVYafgUGI314k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kk4grDAas6TLhJBbDIT9/I3dGmyAvJg8M+KajZ0LUmfkYfYtqDM56IY/GquBv8iVdDWff/Z0CGxK6d8HThZ4BkhJgj5XF1WtSn7RyJuMXf9OOvD6JFaMrmG6RWkkiWcGA6/Mq6mOxDPM8uftcaF8MAQoIMfgb584bMpaECq+qgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=LOTjSqbI; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="LOTjSqbI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1753361779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yzZyc/r7CubsFS6u0xqmakg7FBzQ7jrDiEHuW1LY5ak=;
	b=LOTjSqbI16SlimqIYt1I7mUbS+CNW8sqDVDhmyVujzM+qrdjRLubVv8HWadcYqAuNoa71Z
	MkkCA2Uhu+wgykInZzJNOgfyrAB2Wr6zYevzKFyDCyRuxrcR1MumfGPPwOXUsM+fzgNlnl
	In0MqCqCq/0dooHanbuYM7oWR6SFQRs=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 6/8] refs: fix identity for migrated reflogs
In-Reply-To: <20250722-pks-reflog-append-v1-6-183e5949de16@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
 <20250722-pks-reflog-append-v1-6-183e5949de16@pks.im>
Date: Thu, 24 Jul 2025 14:56:11 +0200
Message-ID: <87ldodkas4.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> When migrating reflog entries between different storage formats we must
> reconstruct the identity of reflog entries. This is done by passing the
> committer passed to the `migrate_one_reflog_entry()` callback function
> to `fmt_ident()`.
>
> This results in an invalid identity though: `fmt_ident()` expects the
> caller to provide both name and mail of the author, but we pass the full
> identity as mail. This leads to an identity like:
>
>     pks <Patrick Steinhardt ps@pks.im>
>
> Fix the bug by splitting the identity line first. This allows us to
> extract both the name and mail so that we can pass them to `fmt_ident()`
> separately.
>
> This commit does not yet add any tests as there is another bug in the
> reflog migration that will be fixed in a subsequent commit. Once that
> bug is fixed we'll make the reflog verification in t1450 stricter, and
> that will catch both this bug here and the other bug.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 188989e4113..64544300dc3 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2945,7 +2945,7 @@ struct migration_data {
>  	struct ref_store *old_refs;
>  	struct ref_transaction *transaction;
>  	struct strbuf *errbuf;
> -	struct strbuf sb;
> +	struct strbuf sb, name, mail;
>  };
>  
>  static int migrate_one_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
> @@ -2984,7 +2984,7 @@ struct reflog_migration_data {
>  	struct ref_store *old_refs;
>  	struct ref_transaction *transaction;
>  	struct strbuf *errbuf;
> -	struct strbuf *sb;
> +	struct strbuf *sb, *name, *mail;
>  };
>  
>  static int migrate_one_reflog_entry(struct object_id *old_oid,
> @@ -2994,13 +2994,22 @@ static int migrate_one_reflog_entry(struct object_id *old_oid,
>  				    const char *msg, void *cb_data)
>  {
>  	struct reflog_migration_data *data = cb_data;
> +	struct ident_split ident;
>  	const char *date;
>  	int ret;
>  
> +	if (split_ident_line(&ident, committer, strlen(committer)) < 0)
> +		return -1;
> +
> +	strbuf_reset(data->name);
> +	strbuf_add(data->name, ident.name_begin, ident.name_end - ident.name_begin);
> +	strbuf_reset(data->mail);
> +	strbuf_add(data->mail, ident.mail_begin, ident.mail_end - ident.mail_begin);
> +
>  	date = show_date(timestamp, tz, DATE_MODE(NORMAL));
>  	strbuf_reset(data->sb);
>  	/* committer contains name and email */

This comment doesn't make sense here no more. Better leave it out.

> -	strbuf_addstr(data->sb, fmt_ident("", committer, WANT_BLANK_IDENT, date, 0));
> +	strbuf_addstr(data->sb, fmt_ident(data->name->buf, data->mail->buf, WANT_BLANK_IDENT, date, 0));

I was checking whether we could use IDENT_NO_NAME instead of parsing the
ident. But fmt_ident() calls strbuf_addstr_without_crud() which strips
out the angle brackets from the email address, which builds an invalid
identity like: "C O Mitter committer@example.com 1112911993 -0700"

We could opt to add a flag IDENT_LEAVE_CRUD which calls strbuf_addstr()
instead, but I'm not sure we want to go there.

-- 
Cheers,
Toon
