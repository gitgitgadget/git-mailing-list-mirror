Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531E31A682A
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782807526; cv=none; b=LADrlU+Mz0GsjQ5Qlc7ZNFIIF9yg63axQoHv9oU33hiQtMvUDWCh09iZmQbpd4PUT3dhAUSGp8QiSm4S/JAzlG3JYkYEZIZ/oux0RGh09YeQAxf7JSFQsz9XZTY//emViSuT0wp+R3yhLfh66h0bWVgpgRyPL1SGDCv4vgx+LIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782807526; c=relaxed/simple;
	bh=RNVVvPYZlQo6pmh+UmgIyXIkV5zS83EOIoZCBAYP1FI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RLGydKg37JiJWCSNcB5wule0oIF5ZZPXEpKOc6SCj+ixjxdcp6S7TI+Lp9Fa63j44nRgzfXMnYgXd4dPeEl+0wQl6EeXnalWNhgR4GA5ISAcSfeoeyum52m2jvGw0Po6vpfyRHekKlpNcUdX47yimkUnd+HZewAeAoWTcUBQMew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=WUHl8lO0; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="WUHl8lO0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1782807520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/5xvih0f0/37a0Dnc7J3+k8swNF5iloZEuc/kU8q4yQ=;
	b=WUHl8lO04/tiLopkGu1GjAAe120S4BwSjGSdK5Iz7/qIVk57i8a9AjgyHL+PcaZj6rrCBo
	epD3VSr1Ew8axNmhP48ba45uQn5nYIEukN1a0QSLgqspKAApNT7+P//vPw1fnN/iHIPHyz
	cKOsURKfmffpmF0yg270iB4bQRsWGW8=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] odb/source: generalize `reprepare()` callback
In-Reply-To: <akINy-hP5EPD4Y4e@pks.im>
References: <20260622-b4-pks-odb-generalize-prepare-v1-0-d2a5c5d13144@pks.im>
 <20260622-b4-pks-odb-generalize-prepare-v1-1-d2a5c5d13144@pks.im>
 <87ldc14i4n.fsf@emacs.iotcl.com> <akINy-hP5EPD4Y4e@pks.im>
Date: Tue, 30 Jun 2026 10:18:32 +0200
Message-ID: <87ik704f1j.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Jun 26, 2026 at 02:10:32PM +0200, Toon Claes wrote:
>> > diff --git a/builtin/grep.c b/builtin/grep.c
>> > index 8080d1bf5e..7361bf071e 100644
>> > --- a/builtin/grep.c
>> > +++ b/builtin/grep.c
>> > @@ -1361,10 +1360,8 @@ int cmd_grep(int argc,
>> >  			struct odb_source *source;
>> >  
>> >  			odb_prepare_alternates(the_repository->objects);
>> > -			for (source = the_repository->objects->sources; source; source = source->next) {
>> > -				struct odb_source_files *files = odb_source_files_downcast(source);
>> > -				odb_source_packed_prepare(files->packed);
>> > +			for (source = the_repository->objects->sources; source; source = source->next)
>> > +				odb_source_prepare(source, 0);
>> 
>> So you're downcasting inside the implementation by the backends itself.
>> That makes sense, but would it be worth to say something about that in
>> the commit message?
>
> Hm. Would that provide much value? I'm probably quite a bit biased here,
> but I think that it's implicit that the backends have to eventually cast
> the generic structure to their own backend.
>
> So I wouldn't really know how to clarify this. Did you have anything
> specific in mind?

Ah, I'm sorry, I misread that. I thought you changed the vtable function
to do the downcasting, but you're simply changing from calling a 
`*_packed_*()` to the generic variant that goes through the vtable.

Anyhow, not worth mentioning in the commit message.

>> > diff --git a/odb/source-packed.c b/odb/source-packed.c
>> > index 42c28fba0e..fa5a072488 100644
>> > --- a/odb/source-packed.c
>> > +++ b/odb/source-packed.c
>> > @@ -15,7 +15,7 @@ static int find_pack_entry(struct odb_source_packed *store,
>> >  {
>> >  	struct packfile_list_entry *l;
>> >  
>> > -	odb_source_packed_prepare(store);
>> > +	odb_source_prepare(&store->base, 0);
>> 
>> Why are you not using ODB_PREPARE_FLUSH_CACHES here? It used to do
>> before?
>
> Because this was calling `odb_source_packed_prepare()` before, not
> `odb_source_reprepare()`. So this was calling the non-flushing
> variant.

Again, confusion on my end.

>> >  	if (store->midx && fill_midx_entry(store->midx, oid, e))
>> >  		return 1;
>> >  
>> > @@ -47,7 +47,7 @@ static int odb_source_packed_read_object_info(struct odb_source *source,
>> >  	 * been added since the last time we have prepared the packfile store.
>> >  	 */
>> >  	if (flags & OBJECT_INFO_SECOND_READ)
>> > -		odb_source_reprepare(source);
>> > +		odb_source_prepare(source, ODB_PREPARE_FLUSH_CACHES);
>> 
>> I think the new code is correct, but why wasn't `packed` used here in
>> the past? The old odb_source_reprepare() expected a downcasted, didn't
>> it?
>
> No, `odb_source_reprepare()` is the generic variant. The naming schema
> is typically:
>
>   - `odb_source_frobnicate()` for the generic variants, which receive a
>     `struct odb_source` as input.
>
>   - `odb_source_<type>_frobnitcate()` for their backend-specific
>     implementations, which cast down the generic `struct odb_source` to
>     their backend-specific struct.

Yeah, I understand things better now. Thanks for clarifying.

-- 
Cheers,
Toon
