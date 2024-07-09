Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F4B1DA303
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720509375; cv=none; b=s4SjJbUYnwz+/Pfz7eP/yfLjJOO5V2I9z9WZ+0X1Wp2+PIWUGrNLNntWxNwTPzUyQL5LV2LxtgEl2c+wDRDJt7/PYer4nNg1ZJj/6pVDzghP9HaicXxiQGElXGvGh8SOrWsLyiD4m+69pI1x/FF7J7N3NDPePjUw0NdvX9uyguM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720509375; c=relaxed/simple;
	bh=5+zd0SALJicEhdPHpqTmsPekmMBUvt0yTHA1NpWpdx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DX478mCRXGQnR16wUScKZB60Ov6y1KpcQ6S5eCQ9mMzK5bE7UBtPubCXWmPN5pa7lQMYAxiHVQWHa/tKfq6yAn9GbywU+ISnignfMYciaQRDPrOjGdeX6L/s91QL38OrdRaMjZR/oytVdzxpakE4Uz5/L5GhbZb7K0nFYTtHghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ae6yqaTo; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ae6yqaTo"
X-Envelope-To: eric.peijian@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1720509369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HpGT2aq9pFqSOdwDhT+N43qgwoAIZg3k88Qd9iFMjDs=;
	b=ae6yqaToROI5b9d1IYi8A5cRHZJHjiQ1+WqGDGy3T58HqsiYZdS4sOsfah054RkGxAcHlN
	n54qdEY1DpAbLu0AivxsPhNBU9xU2GcscYvJRAlm1vJn0YZnrxVfR0cM82YBrZQzMhHkvO
	rYFgIKsd9gAfCtFvz3hAr7VRgOeu66s=
X-Envelope-To: git@vger.kernel.org
X-Envelope-To: chriscool@tuxfamily.org
X-Envelope-To: calvinwan@google.com
X-Envelope-To: jonathantanmy@google.com
X-Envelope-To: johncai86@gmail.com
X-Envelope-To: eric.peijian@gmail.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Toon claes <toon@iotcl.com>
To: Eric Ju <eric.peijian@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, Calvin Wan
 <calvinwan@google.com>, Jonathan Tan <jonathantanmy@google.com>, John Cai
 <johncai86@gmail.com>, Eric Ju <eric.peijian@gmail.com>
Subject: Re: [PATCH 4/6] transport: add client support for object-info
In-Reply-To: <20240628190503.67389-5-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240628190503.67389-5-eric.peijian@gmail.com>
Date: Tue, 09 Jul 2024 09:15:58 +0200
Message-ID: <87ikxfqbm9.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Eric Ju <eric.peijian@gmail.com> writes:

> diff --git a/transport.c b/transport.c
> index 83ddea8fbc..2847aa3f3c 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -436,11 +504,27 @@ static int fetch_refs_via_pack(struct transport *transport,
>  	args.server_options = transport->server_options;
>  	args.negotiation_tips = data->options.negotiation_tips;
>  	args.reject_shallow_remote = transport->smart_options->reject_shallow;
> -
> -	if (!data->finished_handshake) {
> -		int i;
> +	args.object_info = transport->smart_options->object_info;
> +
> +	if (transport->smart_options && transport->smart_options->object_info) {
> +		struct ref *ref = object_info_refs;
> +
> +		if (!fetch_object_info(transport, data->options.object_info_data))
> +			goto cleanup;
> +		args.object_info_data = data->options.object_info_data;
> +		args.quiet = 1;
> +		args.no_progress = 1;
> +		for (size_t i = 0; i < transport->smart_options->object_info_oids->nr; i++) {
> +			struct ref *temp_ref = xcalloc(1, sizeof (struct ref));
> +			temp_ref->old_oid = *(transport->smart_options->object_info_oids->oid + i);

Any reason why you're not using the subscript operator (square brackets)
like this:

+			temp_ref->old_oid = transport->smart_options->object_info_oids->oid[i];

> +			temp_ref->exact_oid = 1;
> +			ref->next = temp_ref;
> +			ref = ref->next;
> +		}
> +		transport->remote_refs = object_info_refs->next;

I find it a bit weird you're allocating object_info_refs, only to use it
to point to the next. Can I suggest a little refactor:

----8<-----8<----
diff --git a/transport.c b/transport.c
index 662faa004e..56cb3a1693 100644
--- a/transport.c
+++ b/transport.c
@@ -479,7 +479,7 @@ static int fetch_refs_via_pack(struct transport *transport,
        struct ref *refs = NULL;
        struct fetch_pack_args args;
        struct ref *refs_tmp = NULL;
-       struct ref *object_info_refs = xcalloc(1, sizeof (struct ref));
+       struct ref *object_info_refs = NULL;

        memset(&args, 0, sizeof(args));
        args.uploadpack = data->options.uploadpack;
@@ -509,7 +509,7 @@ static int fetch_refs_via_pack(struct transport *transport,
        args.object_info = transport->smart_options->object_info;

        if (transport->smart_options && transport->smart_options->object_info) {
-               struct ref *ref = object_info_refs;
+               struct ref *ref = object_info_refs = xcalloc(1, sizeof (struct ref));

                if (!fetch_object_info(transport, data->options.object_info_data))
                        goto cleanup;
@@ -517,13 +517,12 @@ static int fetch_refs_via_pack(struct transport *transport,
                args.quiet = 1;
                args.no_progress = 1;
                for (size_t i = 0; i < transport->smart_options->object_info_oids->nr; i++) {
-                       struct ref *temp_ref = xcalloc(1, sizeof (struct ref));
-                       temp_ref->old_oid = *(transport->smart_options->object_info_oids->oid + i);
-                       temp_ref->exact_oid = 1;
-                       ref->next = temp_ref;
+                       ref->old_oid = transport->smart_options->object_info_oids->oid[i];
+                       ref->exact_oid = 1;
+                       ref->next = xcalloc(1, sizeof (struct ref));
                        ref = ref->next;
                }
-               transport->remote_refs = object_info_refs->next;
+               transport->remote_refs = object_info_refs;
        } else if (!data->finished_handshake) {
                int must_list_refs = 0;
                for (int i = 0; i < nr_heads; i++) {
@@ -565,7 +564,7 @@ static int fetch_refs_via_pack(struct transport *transport,

        data->finished_handshake = 0;
        if (args.object_info) {
-               struct ref *ref_cpy_reader = object_info_refs->next;
+               struct ref *ref_cpy_reader = object_info_refs;
                for (int i = 0; ref_cpy_reader; i++) {
                        oid_object_info_extended(the_repository, &ref_cpy_reader->old_oid, &(*args.object_info_data)[i], OBJECT_INFO_LOOKUP_REPLACE);
                        ref_cpy_reader = ref_cpy_reader->next;
----8<-----8<----

To be honest, I'm not sure it works, because fetch_object_info() always
seem to return a non-zero value. I'm not sure this is due to missing
code coverage, or a bug. I guess it's worth looking into.

-- 
Toon
