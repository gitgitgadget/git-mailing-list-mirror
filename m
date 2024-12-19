Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32871A42C4
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734636719; cv=none; b=MsztDCPsk0S+ifeEneXxrgxj5Ig+CbanVhLnDQH3jzyNnaOd9zpKF4S/wZxXkSiZW8heVstcYqRcFLFxeHGCQ9wTETroqiNp5tLqmgZpNNIizOtlS7EPfJUt+TuIl4Ad+I02hFEC5Hexe9xUNF/QVFNztwTVLPifDoyL0AdyVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734636719; c=relaxed/simple;
	bh=/cDYul9s6XPEJvPSZcvhc0DBhpoBFEBCobK92m3Awhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nqOJC2SVuO0PFA3LNZFokL+LXP8oV66MHBbGZXqQQqzVEI2f+qX/vCzen6OucZktFnla7sQPQUUphEeME9QFcu3oPZDpN/R0ruvqwDMU0bfdgdgYPOd/TbdkoPBIHZlk8yb78dH2HD3wgYaLZldA0/MFAT0SkIbIxgFbv7npHZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=AaoYfkF7; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="AaoYfkF7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1734636713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/cDYul9s6XPEJvPSZcvhc0DBhpoBFEBCobK92m3Awhw=;
	b=AaoYfkF75CiX6WBnJ7iu8PE8vpFX5EVF2cew8Y8WpGzeskHFROuoKTNKiVhEJ2wPmK16mL
	MMwVHL6UxZWIAyBAgdIia0uxfI72WSBNq5y2pHNLrWzjaXHU9KgCQ3Z5df6KW7ICoqeIv8
	pfF82qgIAtufUZYpK8+ieuMMjNyL/sg=
From: Toon Claes <toon@iotcl.com>
To: karthik nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 5/8] refs: add `committer_info` to
 `ref_transaction_add_update()`
In-Reply-To: <CAOLa=ZT9KDNaz84DLoRBzY_yaZ3kZ2FUWADohZhM4EcrJgmS+A@mail.gmail.com>
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
 <20241213-320-git-refs-migrate-reflogs-v2-5-f28312cdb6c0@gmail.com>
 <Z1wnbCoidG-lC7ui@pks.im>
 <CAOLa=ZT9KDNaz84DLoRBzY_yaZ3kZ2FUWADohZhM4EcrJgmS+A@mail.gmail.com>
Date: Thu, 19 Dec 2024 20:31:42 +0100
Message-ID: <875xnfh3kx.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

karthik nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> On Fri, Dec 13, 2024 at 11:36:50AM +0100, Karthik Nayak wrote:
>>> The `ref_transaction_add_update()` creates the `ref_update` struct. To
>>> facilitate addition of reflogs in the next commit, the function needs to
>>> accommodate setting the `committer_info` field in the struct. So modify
>>> the function to also take `committer_info` as an argument and set it
>>> accordingly.
>>
>> I was wondering a bit whether we could instead pull out a
>> `add_update_internal()` function so that we don't need to modify all
>> callers of `ref_transaction_add_update()`. Because ultimately, we don't
>> use the field anywhere except from `ref_transaction_add_reflog_update()`
>> as far as I can see.
>>
>> This is more of a thought than a strong opinion, so feel free to ignore.
>>
>
> Yes, that is a possible change, but the number of code changes are
> relatively low and I didn't think it made so much difference. Also
> because we'd now have one more function. But I don't mind doing it
> either, if anyone feels strongly about it, I'll happily make that
> change.

Yes, I agree the number of callsites isn't that large, but on the other
hand, I see various calls to this function having four `NULL`s in a row
as arguments. Personally, I think that starts to smell a bit.

Now, before you change anything. I'm not sure what Patrick was
suggesting? Would it mean we basically rename
`ref_transaction_add_update()` to `add_update_internal()` and create a
new wrapper function `ref_transaction_add_update()` that simply calls
`add_update_internal(<ARGS>..., NULL, msg)`? I don't think that's a
great solution either.

Alternively, because ref_transaction_add_update() returns the `struct
ref_update`, why not add a function `ref_update_set_committer` and call
that where we need to set the committer? I see this also will help in a
future commit where you call ref_transaction_add_update() differently
depending on reflog updates.

--
Toon
