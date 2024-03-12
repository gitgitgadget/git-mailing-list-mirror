Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972C716FF59
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268529; cv=none; b=Bv6TxIU0oIXz7sqb+Cn7c35MJW9y0JuaRPUIp3QJ5jeoNZ+RZPMjXyrMZonyXNQlq7Y3Vxi34DmLd1M2GBe4p9b9jJ8oZLSe+QooM4CnySADcqDfttoEM6mTRjx9j0xEYcKKQNbsRuC8ecMKvY5YUTgONKkmeRmJrDZK6S6yjjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268529; c=relaxed/simple;
	bh=8o42131xdDRXZdru5qmlWkR7BXrtzYBpdsAiw1Z2tSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l00ezQUpEB9hNVg0yS84ljVdCzvIhLtaF+o/cZKpss6WvcbyrwnchB2Q0PJOg7I0JR5v0SAZHkOPEuryKE92gYh3ciDXvg5sgi5OCxhVQAezThEZvaWHClPs1yIXfuhmg/mTKEv2MtyiJq/BEBszwYxF6tL6Xcf6ALM68eyi1do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Dt7/V6os; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dt7/V6os"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C047374FE;
	Tue, 12 Mar 2024 14:35:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8o42131xdDRXZdru5qmlWkR7BXrtzYBpdsAiw1
	Z2tSY=; b=Dt7/V6osfDm/X5msdy5nNTkrgmO1p92/nWkVNMlOQ2g9ckX78xZ05x
	OboSnTiBECQaEu+TZHEM3Stloda/bfYzYGkcqq3fI9FRlvhfMDstX468rhNIXX52
	RwhP8QApl/tsyfOzYXg+GfGFBMcjobqnycShD4moBKUxiHPEV0dlc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 43826374FD;
	Tue, 12 Mar 2024 14:35:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E450E374FB;
	Tue, 12 Mar 2024 14:35:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] cat-file: avoid verifying submodules' OIDs
In-Reply-To: <951f73397c15f76da75bbd74a02f36da0116623f.1710183362.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Mon, 11 Mar 2024
	18:56:02 +0000")
References: <pull.1689.git.1710183362.gitgitgadget@gmail.com>
	<951f73397c15f76da75bbd74a02f36da0116623f.1710183362.git.gitgitgadget@gmail.com>
Date: Tue, 12 Mar 2024 11:35:16 -0700
Message-ID: <xmqqh6hbl2mz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4655ADD2-E09F-11EE-B559-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +Submodules are handled specially in `git cat-file`, as the objects
> +corresponding to the recorded OIDs are not expected to be present in the
> +current repository. For that reason, submodules are reported as having
> +type `submodule` and mode 1600000 and all other fields are zeroed out.

While the above may not be technically wrong per-se, I am not sure
if that is the more important part of what we want to tell our
users.  For example, "git ls-tree HEAD -- sha1collisiondetection"
reports "160000 commit ...object.name.... sha1collisiondetection".
Is it correct to say ...

    Submodules are handled specially in `git ls-tree`, as the
    objects corresponding to the recorded OIDs are not expected to
    be present in the current repository.

...?  I do not think so.

For the same reason, as an explanation for the reason why "git
cat-file -t :sha1collisiondetection" just reports "submodule", the
new text does not sit well.

I actually have to wonder if the new behaviour proposed by this
patch is a solution that is in search of a problem, or trying to
solve an unstated problem in a wrong way.

    O=$(git rev-parse --verify :sha1collisiondetection)
    git cat-file -t "$O"
    
should fail because the object whose name is $O is not available.
Why should then this succeed and give a different result?

    git cat-file -t :sha1collisiondetection

The "cat-file" command is about objects.  While object's type may
sometimes be inferrable (by being contained in a tree), if the user
asks us to determine the type of the object, we should actually hit
the object store, whether the commit object in question happens to
be on our history or somebody else's history that our gitlink points
at.

So, I am not yet convinced that I should take this patch.  Previous
two steps looked good, though.

Thanks.

> index 73bd78c0b63..c59ad682d1f 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -128,7 +128,9 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
>  	switch (opt) {
>  	case 't':
>  		oi.type_name = &sb;
> -		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
> +		if (obj_context.mode == S_IFGITLINK)
> +			strbuf_addstr(&sb, "submodule");
> +		else if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
>  			die("git cat-file: could not get object info");
