Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799DE36C
	for <git@vger.kernel.org>; Sun, 22 Sep 2024 06:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726987032; cv=none; b=t0/HNsyf9xlXG0SeDqv7RpZ+MlJretMAKi5zIw/4OjvCOWcGgUBIkZ6oI/iVfxUl7Dyek3MV8wSmDF60eNJPkuBPWywSFcPTISwv/U6/zKno4/kJRUPD4oki2lYScseFju/GX7WIGHkz6G0kdzgRVVC6cL4jN80OZTlj2VWfaXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726987032; c=relaxed/simple;
	bh=R3dsZykQ5MAwcLtpfb6ych4S/UTWbzlW5mjnW9m2M84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CLNT8JQyfiOMJm00pGKu9gmCPKHgKkMUnxRFlxDnjgQNzDi7jW9067KyY7F2t4WMtjBNDf4LjolcprsLhd9ZxoxCuFMDbVsaSzOvk6UEW2readrhQU+pT7M6m98SI4MbU/cs6mVcMCkT3ZClrDeaNr3pZUJVlIwUfptsYw+2wHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=R9i+UC+x; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R9i+UC+x"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 212F636A94;
	Sun, 22 Sep 2024 02:37:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=R3dsZykQ5MAwcLtpfb6ych4S/UTWbzlW5mjnW9
	m2M84=; b=R9i+UC+xSrfQaWPo8vTslrEDWDR8T8AaGJwIZYORyVlW8P2Ge22mdD
	50ckfSi5tKyRr5/ocvAeoYSeEG/GmaDLf4p9ipYtfS2wM/NXIieo2LqWUbA2HBtu
	N6uEc7PSZ1FJPZRgeaphPana/xqbaQ8Emwh91rnpBmBPryKxRS0Ew=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1389536A93;
	Sun, 22 Sep 2024 02:37:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E10D36A92;
	Sun, 22 Sep 2024 02:37:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org,  Han Young <hanyang.tony@bytedance.com>,
  jonathantanmy@google.com,  sokcevic@google.com
Subject: Re: [PATCH 1/2] packfile: split promisor objects oidset into two
In-Reply-To: <20240919234741.1317946-2-calvinwan@google.com> (Calvin Wan's
	message of "Thu, 19 Sep 2024 23:47:40 +0000")
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
	<20240919234741.1317946-2-calvinwan@google.com>
Date: Sat, 21 Sep 2024 23:37:06 -0700
Message-ID: <xmqqzfo08a99.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 171B1FE2-78AD-11EF-8152-9B0F950A682E-77302942!pb-smtp2.pobox.com

Calvin Wan <calvinwan@google.com> writes:

> From: Han Young <hanyang.tony@bytedance.com>
>
> split promisor objects oidset into two, one is objects in promisor packfile,
> and other set is objects referenced in promisor packfile. This enable us to
> check if an object is in promisor packfile.

OK, so the idea is that we can discard the objects that are _in_ a
promisor packfile and assume that we can fetch them back?

Objects that are referenced by objects in the promisor packfile may
or may not be in the same packfile, and we obviously cannot expect
that we can refetch those that are not in the promisor packfile from
the promisor.  So what is the other list for?

What I am wondering is what good the existing helper function
is_promisor_object() is for.  It will say "yes" for objects that we
may have obtained from the promisor remote (hence we can lazily
fetch them again even if we lost them) and in promisor packs, but it
may also say "yes" for any object that an object that is in a
promisor pack (e.g., a tree object that represents a subdirectory
that was not modified by a commit in a promisor pack, a parent
commit of a commit in a promisor pack, etc.).  In other words, are
the callers getting any useful answer to their question to the
helper function, or are they all buggy for not asking "is this
object in a promisor pack" and allowing the helper to say "yes" for
objects that are merely referenced by an object in promisor packs?

Thanks.


> -int is_promisor_object(const struct object_id *oid)
> +int is_in_promisor_pack(const struct object_id *oid, int referenced)
>  {
> -	static struct oidset promisor_objects;
> +	static struct promisor_objects promisor_objects;
>  	static int promisor_objects_prepared;
>  
>  	if (!promisor_objects_prepared) {
> @@ -2303,5 +2308,6 @@ int is_promisor_object(const struct object_id *oid)
>  		}
>  		promisor_objects_prepared = 1;
>  	}
> -	return oidset_contains(&promisor_objects, oid);
> +	return oidset_contains(&promisor_objects.promisor_pack_objects, oid) ||
> +		(referenced && oidset_contains(&promisor_objects.promisor_pack_referenced_objects, oid));
>  }
> diff --git a/packfile.h b/packfile.h
> index 0f78658229..13a349e223 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -195,11 +195,16 @@ int has_object_kept_pack(const struct object_id *oid, unsigned flags);
>  
>  int has_pack_index(const unsigned char *sha1);
>  
> +int is_in_promisor_pack(const struct object_id *oid, int referenced);
> +
>  /*
>   * Return 1 if an object in a promisor packfile is or refers to the given
>   * object, 0 otherwise.
>   */
> -int is_promisor_object(const struct object_id *oid);
> +static inline int is_promisor_object(const struct object_id *oid)
> +{
> +	return is_in_promisor_pack(oid, 1);
> +}
>  
>  /*
>   * Expose a function for fuzz testing.
