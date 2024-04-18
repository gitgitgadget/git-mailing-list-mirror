Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30392146596
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713476349; cv=none; b=PUlQAMMOqr29SLPe2ZQMNCo7UlWghKGhhCPOZhMm5yd3ZsnfWfcdFt3gmm2wtORJaFaj47P+uXkFsIxnuN9Z9YYegd4CHrTntOD9+7GtAoBlAmbUzB31bfwrzVgP0IbQLpyREir3zoSwQfpB+GVsxYOMKa54bglsQJuhPckBN2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713476349; c=relaxed/simple;
	bh=PjQfVZDkaV85aSNmIKSCdYNQNklVZr+hmSS3XAYxNMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kPj7iEyOs2mLy09zA4r/6V5YzuNmtBqqwT50qosvlb9/xGDiErgjjyCtwV5Z9IDxD8uVf1WA/p3ntwLLsLiBU4DnRlgXIJjVET3ZATHGhtM+EnW1sEMH3qtb2y+0GvJVzwmQzLnfaD+IsfF1l1hY1jGszJu82NsVgjpmcK5m0Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=W+PtacoN; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W+PtacoN"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 84FC31EC770;
	Thu, 18 Apr 2024 17:39:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PjQfVZDkaV85aSNmIKSCdYNQNklVZr+hmSS3XA
	YxNMg=; b=W+PtacoNIghz3DYeYEmdKpq/7WHElq59B00uO8rz5thDLGtG7pY8EH
	QpQF0QiG2NpBUHXC5XURV64LBUxZsfi/CkkeAtGS3CoKoXAp31g5Mph2X07q4G0n
	e5UV/D1DiAcn8mfb8L3J3x2Hsn3ityWWTcYIjjQIgmL/oY73CBunM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D9C41EC76F;
	Thu, 18 Apr 2024 17:39:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9FC481EC76E;
	Thu, 18 Apr 2024 17:39:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/4] rev-list: refactor --missing=<missing-action>
In-Reply-To: <20240418184043.2900955-2-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 18 Apr 2024 20:40:40 +0200")
References: <20240418184043.2900955-1-christian.couder@gmail.com>
	<20240418184043.2900955-2-christian.couder@gmail.com>
Date: Thu, 18 Apr 2024 14:39:03 -0700
Message-ID: <xmqqplumpczs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 140E9588-FDCC-11EE-A208-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> Both `git rev-list` and `git pack-objects` support a
> `--missing=<missing-action>` feature, but they currently don't share
> any code for that.

So "git pack-objects" will still stay unaware of <missing.h> after
this step, which was a bit unexpected.

> For now, this refactoring is about moving code from
> "builtin/rev-list.c" into new "missing.{c,h}" files. But in a
> following commit, that refactored code will be used in
> `git pack-objects` too.

I think it is easier to grok if you said this in the second
paragraph, before mentioning "another command".  The first paragraph
talks about rev-list and pack-objects logically but not phisically
sharing the feature, so with "For now, this refactoring is about
moving ... into" -> "Refactor the support for --missing in rev-list
into", it is enough to explain how this change is a first step to
make things better, without bringing the third thing into picture.

IOW ...

> In a following commit, we are going to add support for a similar
> 'missing-action' feature to another command. To avoid duplicating
> similar code, let's start refactoring the rev-list code for this
> feature into new "missing.{c,h}" files.

... this paragraph should have much lower weight in explaining this
commit.

> As `enum missing_action` and parse_missing_action_value() are moved to
> "missing.{c,h}", we need to modify the later a bit, so that it stops

"later" -> "latter"?

> updating a global variable, but instead returns either -1 on error or
> the parsed value otherwise.

OK.  As a shared helper function, I agree that assignment to a global
should be outside of its responsibility.  Which means that the caller
is now responsible for making that assignment.

>  static int try_bitmap_count(struct rev_info *revs,
>  			    int filter_provided_objects)
>  {
> @@ -569,10 +536,14 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  	for (i = 1; i < argc; i++) {
>  		const char *arg = argv[i];
>  		if (skip_prefix(arg, "--missing=", &arg)) {
> +			int res;
>  			if (revs.exclude_promisor_objects)
>  				die(_("options '%s' and '%s' cannot be used together"), "--exclude-promisor-objects", "--missing");
> -			if (parse_missing_action_value(arg))
> +			res = parse_missing_action_value(arg);
> +			if (res >= 0) {
> +				arg_missing_action = res;
>  				break;
> +			}

... which seems to be missing from here.

>  		}
>  	}
>  
> diff --git a/missing.c b/missing.c
> new file mode 100644
> index 0000000000..83e0c5e584
> --- /dev/null
> +++ b/missing.c
> @@ -0,0 +1,26 @@
> +#include "git-compat-util.h"
> +#include "missing.h"
> +#include "object-file.h"
> +
> +int parse_missing_action_value(const char *value)
> +{
> +	if (!strcmp(value, "error"))
> +		return MA_ERROR;
> +
> +	if (!strcmp(value, "allow-any")) {
> +		fetch_if_missing = 0;
> +		return MA_ALLOW_ANY;
> +	}
> +
> +	if (!strcmp(value, "print")) {
> +		fetch_if_missing = 0;
> +		return MA_PRINT;
> +	}
> +
> +	if (!strcmp(value, "allow-promisor")) {
> +		fetch_if_missing = 0;
> +		return MA_ALLOW_PROMISOR;
> +	}

... and this one still touches the global.

> +	return -1;
> +}
> diff --git a/missing.h b/missing.h
> new file mode 100644
> index 0000000000..c8261dfe55
> --- /dev/null
> +++ b/missing.h
> @@ -0,0 +1,18 @@
> +#ifndef MISSING_H
> +#define MISSING_H
> +
> +enum missing_action {
> +	MA_ERROR = 0,    /* fail if any missing objects are encountered */
> +	MA_ALLOW_ANY,    /* silently allow ALL missing objects */
> +	MA_PRINT,        /* print ALL missing objects in special section */
> +	MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
> +};
> +
> +/*
> +  Return an `enum missing_action` in case parsing is successful or -1
> +  if parsing failed. Also sets the fetch_if_missing global variable
> +  from "object-file.h".
> + */

... and this also mentions the global.

> +int parse_missing_action_value(const char *value);
> +
> +#endif /* MISSING_H */

