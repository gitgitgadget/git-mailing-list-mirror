Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078962209B
	for <git@vger.kernel.org>; Wed, 15 May 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791616; cv=none; b=T+VJka96EmL4swbwDcmTbE7w5VJa9m4S0yY1cs0nz+d9l18R5uxYcGuMB5ZtVz3lL6oeDN8dlZNJFG031sI5w0ukUb6BoCoymACcyiXsAw9+2laqDqScU6Sgfa75Su9+crkOJ4J+DysVcdsPfcGLMv3N1GmFYSqCUodMfoFEOuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791616; c=relaxed/simple;
	bh=bQStoj/tDDSxCYpDUW9OKovNOvnQRxcaKntEnQP27aY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mtAvKgNwC0VWodw+QKDIfXfPOi2laShppLS43OYQZnZcdxDZeGHgi4vBoKWnPoNwKMDFDfdmkR2iJZAsuUPA+af6sztqI8kgOZJMI3PPQ7jjxA0E42EBeQ1mWskJ5bEzazVlJWjmvk0EIb5j9Bhf8bsB1KyncSF0k8tDGXUgA+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kawzECdc; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kawzECdc"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id F11A41E60E;
	Wed, 15 May 2024 12:46:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bQStoj/tDDSxCYpDUW9OKovNOvnQRxcaKntEnQ
	P27aY=; b=kawzECdc68D7bTrfIVw6E4wGm0W/cnRL8EwBF1PyfU//+9oLVBQPWF
	vbaEjK/OlgS1eUZ5ghN13YJCZB/xL0ttTATv7rqyo/P9UUFv4cLYUEIbH7uAZva5
	jOU8XMppguCavLPBx977IrpGmTFaq7H3RSVKBm7htuxR7SqwkIJA4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E9E4B1E60D;
	Wed, 15 May 2024 12:46:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7416E1E60A;
	Wed, 15 May 2024 12:46:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/3] pack-objects: use the missing action API
In-Reply-To: <20240515132543.851987-3-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 15 May 2024 15:25:42 +0200")
References: <20221012135114.294680-1-christian.couder@gmail.com>
	<20240515132543.851987-1-christian.couder@gmail.com>
	<20240515132543.851987-3-christian.couder@gmail.com>
Date: Wed, 15 May 2024 09:46:42 -0700
Message-ID: <xmqqo797xbt9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B672E5D6-12DA-11EF-8C41-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index baf0090fc8..55d08c686d 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -39,6 +39,7 @@
>  #include "promisor-remote.h"
>  #include "pack-mtimes.h"
>  #include "parse-options.h"
> +#include "missing.h"
>  
>  /*
>   * Objects we are going to pack are collected in the `to_pack` structure.
> @@ -250,11 +251,6 @@ static unsigned long window_memory_limit = 0;
>  
>  static struct string_list uri_protocols = STRING_LIST_INIT_NODUP;
>  
> -enum missing_action {
> -	MA_ERROR = 0,      /* fail if any missing objects are encountered */
> -	MA_ALLOW_ANY,      /* silently allow ALL missing objects */
> -	MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
> -};

Interesting.  This used to be private to this file, shared the same
name and most of the values with the one used in rev-list, but not
identical (i.e. the new "missing" API knows about MA_PRINT but this
side has been unaware of that value).

> @@ -3826,33 +3822,39 @@ static void show_object__ma_allow_promisor(struct object *obj, const char *name,
>  	show_object(obj, name, data);
>  }
>  
> +static show_object_fn show_object_fn_from_action(enum missing_action action)
> +{
> +	switch (action) {
> +	case MA_ERROR:
> +		return show_object;
> +	case MA_ALLOW_ANY:
> +		return show_object__ma_allow_any;
> +	case MA_ALLOW_PROMISOR:
> +		return show_object__ma_allow_promisor;
> +	default:
> +		BUG("invalid missing action %d", action);

As this is BUG() to catch programming error, ("%d" % action) is OK;
if this were end-user facint, we would also want to pass the "arg"
string the caller had only for error reporting.

>  static int option_parse_missing_action(const struct option *opt UNUSED,
>  				       const char *arg, int unset)
>  {
> +	int res;
> +
>  	assert(arg);
>  	assert(!unset);
>  
> +	res = parse_missing_action_value(arg);
> +	if (res < 0 || (res != MA_ERROR &&
> +			res != MA_ALLOW_ANY &&
> +			res != MA_ALLOW_PROMISOR))
> +		die(_("invalid value for '%s': '%s'"), "--missing", arg);

What is our expectation for how <missing.h> API would evolve over
time?  I think it is a given that it will always be a superset of
the need of rev-list and the need of pack-objects, but if we were
to add a new value of MA_FOO, do we expect that all of the new ones
are not handled by pack-objects,  Some but not all?  Or none of the
new ones are handled by pack-objects?

Regardless of the answer to that question, I think a simple helper
is warranted here, which will also help the [3/3] which adds exactly
the same code to upload-pack.c:upload_pack_config(), so that the
callers can do

	res = parse_missing_action_value_for_packing(arg);
	if (res < 0)
        	die(_("invalid value for '%s': '%s'"), "--missing", arg);

something like

	int parse_missing_action_value_for_packing(const char *arg)
	{
		int res = parse_missing_action_value(arg);

                if (res < 0)
                	return res;

		switch (res) {
		case MA_ERROR:
		case MA_ALLOW_ANY:
		case MA_ALLOW_PROMISOR:
			return res;
		default:
                	return -2 - res;
		}
	}

here, and also in the other place [3/3] adds.  This thin wrapper
returns:

	0 <= res : MA_FOO values that are OK for packing
	-1 = res : parse_missing_action_value() failed
	-1 > res : (2 - res) is the MA_FOO which is unsuitable for packing

to allow the caller to recover which value the user gave us that is
unsuitable for packing, if it wanted to.

> +	if (res != MA_ERROR)
>  		fetch_if_missing = 0;
> +	arg_missing_action = res;
> +	fn_show_object = show_object_fn_from_action(arg_missing_action);
>
> -	die(_("invalid value for '%s': '%s'"), "--missing", arg);
>  	return 0;
>  }

Hmph, wouldn't a small array of show_object_fn suffice, making the
whole thing more like:

	static show_object_fn const fn[] = {
		[MA_ERROR] = show_object,
		[MA_ALLOW_ANY] = show_object__ma_allow_any,
		[MA_ALLOW_PROMISOR] = show_object__ma_allow_promisor,
	};

	res = parse_missing_action_value_for_packing(arg);
	if (res < 0 || ARRAY_SIZE[fn] <= res)
        	die(_("invalid value for '%s': '%s'"), "--missing", arg);
	fn_show_object = fn[res];
	return 0;

without the need for show_object_fn_from_action() helper function?

Other than that, the intention of the code is very clear.

Will queue.  Thanks.
