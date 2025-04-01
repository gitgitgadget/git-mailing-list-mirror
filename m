Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0159C1F152B
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743509654; cv=none; b=W8jOepKXdGZlbrpgvbH4zokxuKfC8PFhJr0dhdnuKkUDEjxc6TTpMWAh5+EHjrbiGHpp8ueCD44SCubUrOS8jwu4hnJ6bI/7sIB29GY6WjKEc6VThWg1MphC/pGe6Sio7XGTKyfkxwxbtDlypoLPTWEr6X9u3gMhTv/NqPY3CFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743509654; c=relaxed/simple;
	bh=3gXWIvhUtU4xh0QnSx0Zsa9XCiMDSgZe4f/gauxR0J4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OVZJ9wjtcunVM+rn4Sd1VUz56sF4Q3K+W5ZH3GoZ36UmTRw8qWF99pP+fl1R96udc+lfupp27FxD0387TEozPIKHkp2m8caq9znz18IFzHcRD+bCPM+06pQc2Im1mgEIYSjGIqsZeP7U3FcBX8FsFnVzw6glXh/SDKwPL9T6o8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=JX7dhwli; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="JX7dhwli"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1743509649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hMY15iWEyRlm11g70ERq5MK+P4MiOI9+2nSfNWVeq2w=;
	b=JX7dhwliJqqC8dejXUkKkuEZVLtKhbrW/1Qp7Bvrh2L5C0BX+vf5b3dTgc7+97NaXGcNiX
	jUm8yvRlQ2+U+rWOLrAbKvd9v2KD6PLOTM5I4CkUFdKa1Cv2PQD6XuqTPGB4AsL3AaKYWl
	w2LmOjbItxulQ0jiLgepTHWarmZ68SM=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
 Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/10] builtin/cat-file: deduplicate logic to iterate
 over all objects
In-Reply-To: <20250327-pks-cat-file-object-type-filter-v2-9-4bbc7085d7c5@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
 <20250327-pks-cat-file-object-type-filter-v2-9-4bbc7085d7c5@pks.im>
Date: Tue, 01 Apr 2025 14:13:57 +0200
Message-ID: <87jz84f5a2.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Pull out a common function that allows us to iterate over all objects in
> a repository. Right now the logic is trivial and would only require two
> function calls, making this refactoring a bit pointless. But in the next
> commit we will iterate on this logic to make use of bitmaps, so this is
> about to become a bit more complex.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/cat-file.c | 85 ++++++++++++++++++++++++++++++------------------------
>  1 file changed, 48 insertions(+), 37 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 430320adfe9..6f5dbc821a2 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -622,25 +622,18 @@ static int batch_object_cb(const struct object_id *oid, void *vdata)
>  	return 0;
>  }
>  
> -static int collect_loose_object(const struct object_id *oid,
> -				const char *path UNUSED,
> -				void *data)
> -{
> -	oid_array_append(data, oid);
> -	return 0;
> -}
> -
> -static int collect_packed_object(const struct object_id *oid,
> -				 struct packed_git *pack UNUSED,
> -				 uint32_t pos UNUSED,
> -				 void *data)
> +static int collect_object(const struct object_id *oid,
> +			  struct packed_git *pack UNUSED,
> +			  off_t offset UNUSED,
> +			  void *data)
>  {
>  	oid_array_append(data, oid);
>  	return 0;
>  }
>  
>  static int batch_unordered_object(const struct object_id *oid,
> -				  struct packed_git *pack, off_t offset,
> +				  struct packed_git *pack,
> +				  off_t offset,
>  				  void *vdata)
>  {
>  	struct object_cb_data *data = vdata;
> @@ -654,23 +647,6 @@ static int batch_unordered_object(const struct object_id *oid,
>  	return 0;
>  }
>  
> -static int batch_unordered_loose(const struct object_id *oid,
> -				 const char *path UNUSED,
> -				 void *data)
> -{
> -	return batch_unordered_object(oid, NULL, 0, data);
> -}
> -
> -static int batch_unordered_packed(const struct object_id *oid,
> -				  struct packed_git *pack,
> -				  uint32_t pos,
> -				  void *data)
> -{
> -	return batch_unordered_object(oid, pack,
> -				      nth_packed_object_offset(pack, pos),
> -				      data);
> -}
> -
>  typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,
>  			       struct strbuf *, struct expand_data *);
>  
> @@ -803,6 +779,45 @@ static void batch_objects_command(struct batch_options *opt,
>  
>  #define DEFAULT_FORMAT "%(objectname) %(objecttype) %(objectsize)"
>  
> +typedef int (*for_each_object_fn)(const struct object_id *oid, struct packed_git *pack,
> +				  off_t offset, void *data);
> +
> +struct for_each_object_payload {
> +	for_each_object_fn callback;
> +	void *payload;
> +};
> +
> +static int batch_one_object_loose(const struct object_id *oid,
> +				  const char *path UNUSED,
> +				  void *_payload)
> +{
> +	struct for_each_object_payload *payload = _payload;
> +	return payload->callback(oid, NULL, 0, payload->payload);
> +}
> +
> +static int batch_one_object_packed(const struct object_id *oid,
> +				   struct packed_git *pack,
> +				   uint32_t pos,
> +				   void *_payload)
> +{
> +	struct for_each_object_payload *payload = _payload;
> +	return payload->callback(oid, pack, nth_packed_object_offset(pack, pos),
> +				 payload->payload);
> +}
> +
> +static void batch_each_object(for_each_object_fn callback,
> +			      unsigned flags,
> +			      void *_payload)

Why is this `_payload` typeless? I see it only getting passed in
`struct object_cb_data`, is there a reason to hide this type? With
payload being wrapped in payload I think it's beneficial to keep type
info where possible.

-- 
Toon
