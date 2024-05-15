Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBC215665B
	for <git@vger.kernel.org>; Wed, 15 May 2024 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789769; cv=none; b=kENsCznBt5j9XmUUG4bN4FJcPTl4oh85qDlZN2mvoMtARPYH8wun6FMPGI3JBleCNJBXCD6YVQFxRCv4kYavQsILwBL/Rlt8onF43d52E6OxV9OE7PTgxPw7lajmKszZB17QAWAfmQIGc0Qbu5Oufj0XMw+g3G8HfZvo99Ob4Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789769; c=relaxed/simple;
	bh=Uezf7KqlYS5S8AT5veqaFQnCNAysJBv93dCo1xSZXuM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IanmMnhucpuzOFxnyyjWLnoveLzb4AConAu+li8ejRKFscb//YEuLa+KL9kKxgVaZcd5WJVtMy/kcU8+zxJ9XKZ9k3dK4DlQMNpEKSo5WM90h5t6fCK6XF6KjkjZLTkj8jJGtCms/CltrG/oDRmobh8jiN+2JRP+tozrqxn5gCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ImreTcQC; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ImreTcQC"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E0E1037CFD;
	Wed, 15 May 2024 12:16:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Uezf7KqlYS5S8AT5veqaFQnCNAysJBv93dCo1x
	SZXuM=; b=ImreTcQCCz7aIUYv2VKmT9OEV4Dnh33RLfgR+FEvsnq9ZEyjoy4KBM
	Pzz4ZX51lRunzFPNqFgN8t14KyMpkH4cW9+5/Xqy/mf8jT/Uw8MwwJE9QD6CBj9N
	uhUJLLIti8vp80wSOSv8rz6fWxNJoh6NukCbzbArhw5hCJronr5yQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D540337CFC;
	Wed, 15 May 2024 12:16:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0CB4337CFB;
	Wed, 15 May 2024 12:16:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 1/3] rev-list: refactor --missing=<missing-action>
In-Reply-To: <20240515132543.851987-2-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 15 May 2024 15:25:41 +0200")
References: <20221012135114.294680-1-christian.couder@gmail.com>
	<20240515132543.851987-1-christian.couder@gmail.com>
	<20240515132543.851987-2-christian.couder@gmail.com>
Date: Wed, 15 May 2024 09:16:04 -0700
Message-ID: <xmqq4jaz1263.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6EAA3816-12D6-11EF-B658-25B3960A682E-77302942!pb-smtp2.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> Both `git rev-list` and `git pack-objects` support a
> `--missing=<missing-action>` feature, but they currently don't share
> any code for that.
>
> Refactor the support for `--missing=<missing-action>` in
> "builtin/rev-list.c" into new "missing.{c,h}" files. In a following
> commit, that refactored code will be used in "builtin/pack-objects.c"
> too.
>
> In yet a following commit, we are going to add support for a similar
> 'missing-action' feature to another command, and we are also going to
> reuse code from the new "missing.{c,h}" files.
>
> As `enum missing_action` and parse_missing_action_value() are moved to
> "missing.{c,h}", we need to modify the latter a bit, so that it stops
> updating any global variable, but instead returns the parsed value or
> -1 on error.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Makefile           |  1 +
>  builtin/rev-list.c | 43 ++++++++-----------------------------------
>  missing.c          | 20 ++++++++++++++++++++
>  missing.h          | 17 +++++++++++++++++
>  4 files changed, 46 insertions(+), 35 deletions(-)
>  create mode 100644 missing.c
>  create mode 100644 missing.h

All makes sense.  Will queue.  Thanks.

> diff --git a/Makefile b/Makefile
> index 0285db5630..e0ddcc2cbd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1062,6 +1062,7 @@ LIB_OBJS += merge-recursive.o
>  LIB_OBJS += merge.o
>  LIB_OBJS += midx.o
>  LIB_OBJS += midx-write.o
> +LIB_OBJS += missing.o
>  LIB_OBJS += name-hash.o
>  LIB_OBJS += negotiator/default.o
>  LIB_OBJS += negotiator/noop.o
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 77803727e0..40aa770c47 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -20,6 +20,7 @@
>  #include "reflog-walk.h"
>  #include "oidset.h"
>  #include "packfile.h"
> +#include "missing.h"
>  
>  static const char rev_list_usage[] =
>  "git rev-list [<options>] <commit>... [--] [<path>...]\n"
> @@ -71,12 +72,6 @@ static struct oidset omitted_objects;
>  static int arg_print_omitted; /* print objects omitted by filter */
>  
>  static struct oidset missing_objects;
> -enum missing_action {
> -	MA_ERROR = 0,    /* fail if any missing objects are encountered */
> -	MA_ALLOW_ANY,    /* silently allow ALL missing objects */
> -	MA_PRINT,        /* print ALL missing objects in special section */
> -	MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
> -};
>  static enum missing_action arg_missing_action;
>  
>  /* display only the oid of each object encountered */
> @@ -392,34 +387,6 @@ static void print_disk_usage(off_t size)
>  	strbuf_release(&sb);
>  }
>  
> -static inline int parse_missing_action_value(const char *value)
> -{
> -	if (!strcmp(value, "error")) {
> -		arg_missing_action = MA_ERROR;
> -		return 1;
> -	}
> -
> -	if (!strcmp(value, "allow-any")) {
> -		arg_missing_action = MA_ALLOW_ANY;
> -		fetch_if_missing = 0;
> -		return 1;
> -	}
> -
> -	if (!strcmp(value, "print")) {
> -		arg_missing_action = MA_PRINT;
> -		fetch_if_missing = 0;
> -		return 1;
> -	}
> -
> -	if (!strcmp(value, "allow-promisor")) {
> -		arg_missing_action = MA_ALLOW_PROMISOR;
> -		fetch_if_missing = 0;
> -		return 1;
> -	}
> -
> -	return 0;
> -}
> -
>  static int try_bitmap_count(struct rev_info *revs,
>  			    int filter_provided_objects)
>  {
> @@ -569,10 +536,16 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  	for (i = 1; i < argc; i++) {
>  		const char *arg = argv[i];
>  		if (skip_prefix(arg, "--missing=", &arg)) {
> +			int res;
>  			if (revs.exclude_promisor_objects)
>  				die(_("options '%s' and '%s' cannot be used together"), "--exclude-promisor-objects", "--missing");
> -			if (parse_missing_action_value(arg))
> +			res = parse_missing_action_value(arg);
> +			if (res >= 0) {
> +				if (res != MA_ERROR)
> +					fetch_if_missing = 0;
> +				arg_missing_action = res;
>  				break;
> +			}
>  		}
>  	}
>  
> diff --git a/missing.c b/missing.c
> new file mode 100644
> index 0000000000..ce3cf734a8
> --- /dev/null
> +++ b/missing.c
> @@ -0,0 +1,20 @@
> +#include "git-compat-util.h"
> +#include "missing.h"
> +#include "object-file.h"
> +
> +int parse_missing_action_value(const char *value)
> +{
> +	if (!strcmp(value, "error"))
> +		return MA_ERROR;
> +
> +	if (!strcmp(value, "allow-any"))
> +		return MA_ALLOW_ANY;
> +
> +	if (!strcmp(value, "print"))
> +		return MA_PRINT;
> +
> +	if (!strcmp(value, "allow-promisor"))
> +		return MA_ALLOW_PROMISOR;
> +
> +	return -1;
> +}
> diff --git a/missing.h b/missing.h
> new file mode 100644
> index 0000000000..1e378d6215
> --- /dev/null
> +++ b/missing.h
> @@ -0,0 +1,17 @@
> +#ifndef MISSING_H
> +#define MISSING_H
> +
> +enum missing_action {
> +	MA_ERROR = 0,      /* fail if any missing objects are encountered */
> +	MA_ALLOW_ANY,      /* silently allow ALL missing objects */
> +	MA_PRINT,          /* print ALL missing objects in special section */
> +	MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
> +};
> +
> +/*
> +  Return an `enum missing_action` in case parsing is successful or -1
> +  if parsing failed.
> +*/
> +int parse_missing_action_value(const char *value);
> +
> +#endif /* MISSING_H */
