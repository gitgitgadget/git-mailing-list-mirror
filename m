Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761B811182
	for <git@vger.kernel.org>; Sat, 25 May 2024 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716678049; cv=none; b=aZKjYr8e7oQ0C+3/5L3qwKFQsHyMdSobwyL0Ftm25o4Wf/rWLPTcodfDwPSql44aKBZX/4feFWvVHy6oluijFo7hTDDIEZlsNPmpYYd7lpN9w3ycUujq14/RBMwDyq+SrrUXZ6f1sn9w7Dn3eMoC1fq5v800f8d2NYlU3LSjX2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716678049; c=relaxed/simple;
	bh=DjxvVq5AUbSrc0eFVITGtu+Xf4vJhqV+8WX3AHND/nw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d6FCZLak8sCWxjRLVJMn2IA///2RyCJpAWfoQdHZfriBOHbN2OKuCQ16Z2QCw/UW+0uHZtz+8AkJ9NkhDpCJ0km6NrbCjIJXk6pVhP5E75ULDBfQsbc4eaX+2DXlf/dNMtqXOYSprKYrjQj/4wgrCB+FQFkqSG7SKVcStGwhC5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Azt/qi0o; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Azt/qi0o"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1ADA734868;
	Sat, 25 May 2024 19:00:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DjxvVq5AUbSrc0eFVITGtu+Xf4vJhqV+8WX3AH
	ND/nw=; b=Azt/qi0oXaTho3iTa/h3oZXThT9GDGyT9weSb89yXBpmFSVFkB+OwO
	nyfNEDLQ+4E3mMnaE/6dG41aLO1Xfwc+a8NXcX/+EF6pQ9LGUBAjpXnjDJ1XtFA4
	12JL8HfFjwWPpAT2m4Ng/4igNDQqR+KPU+XiBOgK99dRLHM3iDc4I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1418834867;
	Sat, 25 May 2024 19:00:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 81AB434866;
	Sat, 25 May 2024 19:00:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 6/6] update-ref: add support for 'symref-update' command
In-Reply-To: <20240522090326.1268326-7-knayak@gitlab.com> (Karthik Nayak's
	message of "Wed, 22 May 2024 11:03:26 +0200")
References: <20240514124411.1037019-1-knayak@gitlab.com>
	<20240522090326.1268326-1-knayak@gitlab.com>
	<20240522090326.1268326-7-knayak@gitlab.com>
Date: Sat, 25 May 2024 16:00:45 -0700
Message-ID: <xmqqplt9h4yq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9F160450-1AEA-11EF-874F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> +static void parse_cmd_symref_update(struct ref_transaction *transaction,
> +				    const char *next, const char *end)
> +{
> +	char *refname, *new_target, *old_arg;
> +	char *old_target = NULL;
> + ...
> +	old_arg = parse_next_arg(&next);

> +	if (old_arg) {
> +		old_target = parse_next_arg(&next);

Now we have an allocated memory we are responsible for freeing in
old_target, obtained from parse_next_arg() ...

> +		if (!old_target)
> +			die("symref-update %s: expected old value", refname);

... and here we know it is not NULL.  We use it to grab the object
name ...

> +		if (!strcmp(old_arg, "oid")) {
> +			if (repo_get_oid(the_repository, old_target, &old_oid))
> +				die("symref-update %s: invalid oid: %s", refname, old_target);
> +
> +			old_target = NULL;

... and then we overwritten the variable, losing the last reference
to the piece of memory without freeing.

Perhaps squashing this in is sufficient to plug this leak, but there
probably are other new leaks around this code.  I ran out of time so
I'll let you take care of the rest ;-)

Thanks.

 builtin/update-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/builtin/update-ref.c w/builtin/update-ref.c
index 76d20ca0f1..7d2a419230 100644
--- c/builtin/update-ref.c
+++ w/builtin/update-ref.c
@@ -297,7 +297,7 @@ static void parse_cmd_symref_update(struct ref_transaction *transaction,
 
 		if (!strcmp(old_arg, "oid") &&
 		    !repo_get_oid(the_repository, old_target, &old_oid)) {
-			old_target = NULL;
+			FREE_AND_NULL(old_target);
 			have_old = 1;
 		} else if (strcmp(old_arg, "ref"))
 			die("symref-update %s: invalid arg '%s' for old value", refname, old_arg);
