Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C03930E0C5
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771424482; cv=none; b=hDIGpozABEhl5tA4h3DKs65e0SAHbCjBWVhVYEx3MOPaEJBSwTYgDlw3d0gXdn0XMOab0mJcXz9bwTp3pM2IMXWg60lt3R52MsVv6jixxH5P19z/rOZkeE6NOuua2NqDtaeTOywYQ9N7juxpkJhjMlb6iNv9/4NVGOeakhBpANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771424482; c=relaxed/simple;
	bh=RabvTZzzcSw0RBgpepEmeeheWt0CnCB3mMEBXJGLWoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YyEvYKb5RAeiT81br5UTVc7eY/kpptnEgvQqOebGBfiDYB0adzwIRY3TC+gwKUcmxWM+GzhHv8avXEPR8l7HgL50+NjzQxLWFnGMLk4fcYN2fGpA7u6k6od6kp4OFOxgoA7/X5dR0GW+UfHiej65y/bnMfekTuPqEVU2HRNkcwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=K2ar2M2T; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="K2ar2M2T"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1771424476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d1gzqUcLxJcg6+e5PFRdF/ZoWX2YFRH8jMCSDl+XXoo=;
	b=K2ar2M2TU5BuGITbDCoIUVOPwXsxlb6VLgMhctjEBr/ty0uC9B9GfdJTO7u0JrDeXNSKil
	vq4qm2DJm9aVYudc7kZReO0gcsMLHRlBthEyK3pA1FagzQxYJCknqhAhMK+m568xGi1u4w
	PGZ2zYU3ubrCO6E8VV+9xyJEzgyTWm4=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>, gitster@pobox.com
Subject: Re: [PATCH v6 4/6] refs: move out stub modification to generic layer
In-Reply-To: <CAOLa=ZQwrOGpZfVtfTfPFhnkJ_qnEhv8mxO3Ot7nQXusbkJkYw@mail.gmail.com>
References: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
 <20260214-kn-alternate-ref-dir-v6-4-86a82c77cf59@gmail.com>
 <aZQXpb7RMW83eGxe@pks.im>
 <CAOLa=ZQwrOGpZfVtfTfPFhnkJ_qnEhv8mxO3Ot7nQXusbkJkYw@mail.gmail.com>
Date: Wed, 18 Feb 2026 15:21:02 +0100
Message-ID: <87o6lmceup.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> On Sat, Feb 14, 2026 at 11:34:17PM +0100, Karthik Nayak wrote:
>>> When creating the reftable reference backend on disk, we create stubs to
>>> ensure that the directory can be recognized as a Git repository. This is
>>> done by calling `refs_create_refdir_stubs()`. Move this to the generic
>>> layer as this is needed for all backends excluding from the files
>>> backends. In an upcoming commit, we'll also need to extend this logic to
>>> create stubs when using alternate reference directories.
>>>
>>> Similarly, move the logic for deletion of stubs to the generic layer.
>>> The files backend recursively calls the remove function of the
>>> 'packed-backend', here skip calling the generic function since that
>>> would try to delete stubs.
>>
>> Tiniest nit: it might make sense to reorder patches a bit so that the
>> creation of `refs_create_refdir_stubs()` and this patch here sit next to
>> each other.
>>
>
> I think that would be nice, let me do that.

Thanks, I was thinking the same, but I wasn't going to comment on that.
Happy to see you've agreed on this already.

>> What's missing a bit in the commit message is the motivation. What does
>> this step enable us to do that we couldn't do before?
>>
>
> I did add a line
>
>   In an upcoming commit, we'll also need to extend this logic to create
>   stubs when using alternate reference directories.
>
> I'll expand a little on that.

<3

>>> diff --git a/refs.c b/refs.c
>>> index 11d028232b..a24602c9bf 100644
>>> --- a/refs.c
>>> +++ b/refs.c
>>> @@ -2190,12 +2190,59 @@ void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
>>>  /* backend functions */
>>>  int ref_store_create_on_disk(struct ref_store *refs, int flags, struct strbuf *err)
>>>  {
>>> -	return refs->be->create_on_disk(refs, flags, err);
>>> +	int ret = refs->be->create_on_disk(refs, flags, err);
>>> +
>>> +	if (!ret &&
>>> +	    ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
>>> +		struct strbuf msg = STRBUF_INIT;
>>> +
>>> +		strbuf_addf(&msg, "this repository uses the %s format", refs->be->name);
>>> +		refs_create_refdir_stubs(refs->repo, refs->gitdir, msg.buf);
>>> +		strbuf_release(&msg);
>>> +	}
>>> +
>>> +	return ret;
>>>  }
>>
>> This makes me wonder: if we called `refs_create_refdir_stubs()` before
>> we call `->create_on_disk()`, could we even do it for the "files"
>> backend? Just a thought though.
>>
>
> Well, there is some nuance there
>
> 1. 'refs/heads', 'refs/tags' is not created for linked worktrees.

I'm a little bit confused what you mean here? Would it be a problem if
it *is* created?

> 2. 'HEAD' is only created lazily, not in `create_on_disk()`.

Okay, seems like a valid argument to me. You don't want to have
`refs/HEAD` created with `ref: refs/heads/.invalid`?

> Also the intent is totally different, the stubs are for backward
> compatibility. So I think its better to let that logic stay within the
> files-backend.

That's mainly because you named the function like this, but it doesn't
have to be named like that.

>> For symmetry it would be nice to not have an early return here, but also
>> format the condition for this block in the same way as we have it for
>> `ref_store_create_on_disk()`.
>>
>> Patrick
>
> Yeah sure, we can do that here, in the last commit, we'll have to modify
> that anyway back to something like this. But it definitely would be
> easier to review this commit. Will add.

:+1:

-- 
Cheers,
Toon
