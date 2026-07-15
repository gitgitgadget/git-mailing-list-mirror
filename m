Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2662839CCFC
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 05:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784094106; cv=none; b=Hv8/Bwr5foKNaE/Fv66R8fh9yo1dc/9edV74pX51zoYhEn2VH0aGcXxbfP20V7lr5yoalYlF5G5V0IqGhyEvi8goJt5IP3nEtzordEu53oewe1m27sAgozDDefMVQe9zFIlMMOhKn7C7p0bKr2na/2iHsSCkvXsRbqhjM9fxD4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784094106; c=relaxed/simple;
	bh=9tDyStpZXcZn4ZYG4Lxlx0DjSx4bq4EndDA6rxnnxDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UuzYGJHG46rsgnQH+H7p49XFDxgoWDv35xtSD+864txNWRzfTcdS+XA1pltP87Okb7QUXqfHB7SATRIn5wStLaRW9Uu8SvQlU+G/NEAE+nrjIqFd20Nh1ydWlot9W/p7reEq3xtEul6OIwbXIb2IcPP4d1Mhf6/W8qWYW2xqGF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=EXZn0de9; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="EXZn0de9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784094101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YADij6EhA3oRDbRL3IAaBqn2faJAu4bs76sCIFCeb4c=;
	b=EXZn0de9usmYTErzf6tdOLOJlohTKMb7jYW202He5FJdwS2sGrDRxgCUw+oiGcezwkyHId
	2mKsOmnZQ2mABQSuQuyh0FlWHuPx2S5hxNa7pyjidq+Vb1mPcPEIN3QYIdsvicAkGcO8aB
	23iZ3IkoLebjSQQy9MWs1kSgm+DPVBs=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>
Subject: Re: [PATCH v3 9/9] builtin/cat-file: filter objects via object
 database
In-Reply-To: <20260713-pks-odb-for-each-object-filter-v3-9-b3c65c641073@pks.im>
References: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
 <20260713-pks-odb-for-each-object-filter-v3-9-b3c65c641073@pks.im>
Date: Wed, 15 Jul 2026 07:41:33 +0200
Message-ID: <871pd4n71u.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> When batching all objects, git-cat-file(1) reaches into the internals of
> the object database and manually manages bitmaps to apply object
> filters. This creates coupling between the command and the internals of
> the respective backend.
>
> Refactor git-cat-file(1) to use the new object filter option when
> batching all objects. This significantly simplifies the logic and
> ensures that we don't have to reach into internals of the "files" source
> anymore.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/cat-file.c | 76 +++++-------------------------------------------------
>  1 file changed, 7 insertions(+), 69 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index b4b99a73da..1458dd76d6 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -20,7 +20,6 @@
>  #include "userdiff.h"
>  #include "oid-array.h"
>  #include "packfile.h"
> -#include "pack-bitmap.h"
>  #include "object-file.h"
>  #include "object-name.h"
>  #include "odb.h"
> @@ -844,28 +843,6 @@ static int batch_one_object_oi(const struct object_id *oid,
>  	return payload->callback(oid, NULL, 0, payload->payload);
>  }
>  
> -static int batch_one_object_packed(const struct object_id *oid,
> -				   struct packed_git *pack,
> -				   uint32_t pos,
> -				   void *_payload)
> -{
> -	struct for_each_object_payload *payload = _payload;
> -	return payload->callback(oid, pack, nth_packed_object_offset(pack, pos),
> -				 payload->payload);
> -}
> -
> -static int batch_one_object_bitmapped(const struct object_id *oid,
> -				      enum object_type type UNUSED,
> -				      int flags UNUSED,
> -				      uint32_t hash UNUSED,
> -				      struct packed_git *pack,
> -				      off_t offset,
> -				      void *_payload)
> -{
> -	struct for_each_object_payload *payload = _payload;
> -	return payload->callback(oid, pack, offset, payload->payload);
> -}
> -
>  static void batch_each_object(struct batch_options *opt,
>  			      for_each_object_fn callback,
>  			      unsigned flags,
> @@ -875,56 +852,17 @@ static void batch_each_object(struct batch_options *opt,
>  		.callback = callback,
>  		.payload = _payload,
>  	};
> +	struct odb_source_info source_info;
> +	struct object_info oi = {
> +		.source_infop = &source_info,
> +	};
>  	struct odb_for_each_object_options opts = {
>  		.flags = flags,
> +		.filter = &opt->objects_filter,

Ahha, so here we pass the filter down.

>  	};
> -	struct bitmap_index *bitmap = NULL;
> -	struct odb_source *source;
> -
> -	/*
> -	 * TODO: we still need to tap into implementation details of the object
> -	 * database sources. Ideally, we should extend `odb_for_each_object()`
> -	 * to handle object filters itself so that we can move the filtering
> -	 * logic into the individual sources.
> -	 */
> -	odb_prepare_alternates(the_repository->objects);
> -	for (source = the_repository->objects->sources; source; source = source->next) {
> -		struct odb_source_files *files = odb_source_files_downcast(source);
> -		int ret = odb_source_for_each_object(&files->loose->base, NULL, batch_one_object_oi,
> -						     &payload, &opts);
> -		if (ret)
> -			break;
> -	}
> -
> -	if (opt->objects_filter.choice != LOFC_DISABLED &&
> -	    (bitmap = prepare_bitmap_git(the_repository)) &&
> -	    !for_each_bitmapped_object(bitmap, &opt->objects_filter,
> -				       batch_one_object_bitmapped, &payload)) {

Similar to the new code, the filter is used if possible. It is
batch_object_write() which ensures the filter is applied. That didn't
change. 

> -		struct packed_git *pack;
> -
> -		repo_for_each_pack(the_repository, pack) {
> -			if (bitmap_index_contains_pack(bitmap, pack) ||
> -			    open_pack_index(pack))
> -				continue;
> -			for_each_object_in_pack(pack, batch_one_object_packed,
> -						&payload, flags);
> -		}
> -	} else {
> -		struct odb_source_info source_info;
> -		struct object_info oi = {
> -			.source_infop = &source_info,
> -		};
> -
> -		for (source = the_repository->objects->sources; source; source = source->next) {
> -			struct odb_source_files *files = odb_source_files_downcast(source);
> -			int ret = odb_source_for_each_object(&files->packed->base, &oi,
> -							     batch_one_object_oi, &payload, &opts);
> -			if (ret)
> -				break;
> -		}
> -	}
>  
> -	free_bitmap_index(bitmap);
> +	odb_for_each_object_ext(the_repository->objects, &oi,
> +				batch_one_object_oi, &payload, &opts);

Nice to see it abstracted out like this!

>  }
>  
>  static int batch_objects(struct batch_options *opt)
>
> -- 
> 2.55.0.313.g8d093f411d.dirty
>
>

-- 
Cheers,
Toon
