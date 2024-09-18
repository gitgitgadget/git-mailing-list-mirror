Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882FF1487F1
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726677716; cv=none; b=uSQqtnclRgL42kRatxdemINVOP8acUpaLbyTPh/vBeNKv66TqVpnLoHiWN4MUMEoPvP4cjqKQQPk20Yzh/n28xwKOTkDvwRc8FB6weJdI0x++7mwZGwlrjVX4yk5m469JOdM4VlMODO7c4AtJiqSSwSgoH72J72wrszP+p74Sug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726677716; c=relaxed/simple;
	bh=m5k51jYaQMFfo1ZkGgDY0rCybeFN1ewNb1JBXTbVO6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CvqdNw8vnJNUBuuCHI6beU8a1fbqrX3aAcwNlru3Y4F4Yo249BXifi3gKVfkzl2LtdDv8j7rXgLojwbecEJ51NFOvQVXimghDenOrJid9NBjDsFmrpoSJIRe0iHFugc57nJqi1vTpkWWjxOQIYFQs/XZKalUQVzPN3YfZ1mUzvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bMGvryF8; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bMGvryF8"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2508D302B4;
	Wed, 18 Sep 2024 12:41:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=m5k51jYaQMFfo1ZkGgDY0rCybeFN1ewNb1JBXT
	bVO6Y=; b=bMGvryF8Hl1aXhWv/+hjOQzbpA9fNuXNSfEvuuON9ia0DtUEj/LmJD
	V8l/9rwCSEXBeULMPvJx91/0dX39QfM1H2vMypygtzel24aRUzYY01UgzL6JW2II
	4v5BsL7rJExj1UJV/lZSGODbDK2JwmMEvUlXLECkwHQTstfnQcmx8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D02A302B3;
	Wed, 18 Sep 2024 12:41:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 86D32302B2;
	Wed, 18 Sep 2024 12:41:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v4 1/5] ref: initialize "fsck_ref_report" with zero
In-Reply-To: <ZuRztuVQSVY6SiXF@ArchLinux> (shejialuo@gmail.com's message of
	"Sat, 14 Sep 2024 01:17:42 +0800")
References: <ZuRzCyjQFilGhj8j@ArchLinux> <ZuRztuVQSVY6SiXF@ArchLinux>
Date: Wed, 18 Sep 2024 09:41:51 -0700
Message-ID: <xmqqfrpwj4mo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E87F465E-75DC-11EF-BBA0-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> In "fsck.c::fsck_refs_error_function", we need to tell whether "oid" and
> "referent" is NULL. So, we need to always initialize these parameters to
> NULL instead of letting them point to anywhere when creating a new
> "fsck_ref_report" structure.
>
> The original code explicitly initializes the "path" member in the
> "struct fsck_ref_report" to NULL (which implicitly 0-initializes other
> members in the struct). It is more customary to use " {0} " to express

" {0} " -> "{ 0 }" 

> that we are 0-initializing everything. In order to be align with the the

"be align with the the" -> "align with the"

> codebase, initialize "fsck_ref_report" with zero.

Both I'll amend in-place so no need to reroll just for these.

Thanks.

>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  refs/files-backend.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 8d6ec9458d..890d0324e1 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3446,7 +3446,7 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
>  		goto cleanup;
>  
>  	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
> -		struct fsck_ref_report report = { .path = NULL };
> +		struct fsck_ref_report report = { 0 };
>  
>  		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
>  		report.path = sb.buf;
