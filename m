Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F326219ED
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q0bN15G9"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37C3E8
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 10:45:21 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E5311C7E5F;
	Tue, 24 Oct 2023 13:45:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VEolbiUx4Op8Me67GvrxofTRGdyD2hAICpe7eh
	NAPTY=; b=q0bN15G9VD6zzPcKfgjSINB5czYzOP8LrDjI2TMnIjj3I7Tijo+Hlc
	HhXtUjAAc4Zxol+kq22zCByEVLv2SjHBVylJlHUly5bbbgkX0wNSZnKLklHs0vyN
	fLq6SWkbnfmFd9Iaen8h6W9HnVjmcdoCr5g/UFpR+AhqYuSB1+SFI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 05F101C7E5E;
	Tue, 24 Oct 2023 13:45:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5F0B41C7E5D;
	Tue, 24 Oct 2023 13:45:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v4 3/3] rev-list: add commit object support in
 `--missing` option
In-Reply-To: <20231024122631.158415-4-karthik.188@gmail.com> (Karthik Nayak's
	message of "Tue, 24 Oct 2023 14:26:31 +0200")
References: <20231019121024.194317-1-karthik.188@gmail.com>
	<20231024122631.158415-1-karthik.188@gmail.com>
	<20231024122631.158415-4-karthik.188@gmail.com>
Date: Tue, 24 Oct 2023 10:45:19 -0700
Message-ID: <xmqqbkcn52z4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 19D3A8C2-7295-11EE-A2CE-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> @@ -1176,7 +1181,11 @@ static int process_parents(struct rev_info *revs,...
>  					break;
>  				continue;
>  			}
> -			return -1;
> +
> +			if (!revs->do_not_die_on_missing_objects)
> +				return -1;
> +			else
> +				oidset_insert(&revs->missing_objects, &p->object.oid);

I would suspect that swapping if/else would make it easier to
follow.  Everybody else in the patch guards the use of the oidset
with "were we told not to die on missing objects?", i.e.,

	if (revs->do_not_die_on_missing_objects)
		oidset_insert(&revs->missing_objects, &p->object.oid);
	else
		return -1; /* corrupt repository */

> @@ -3800,6 +3809,9 @@ int prepare_revision_walk(struct rev_info *revs)
>  				       FOR_EACH_OBJECT_PROMISOR_ONLY);
>  	}
>  
> +	if (revs->do_not_die_on_missing_objects)
> +		oidset_init(&revs->missing_objects, 0);

I read the patch to make sure that .missing_objects oidset is used
only when .do_not_die_on_missing_objects is set and the oidset is
untouched unless it is initialized.  Well done.

I know I floated "perhaps oidset can replace the object bits,
especially because the number of objects that need marking is
expected to be small", but I am curious what the performance
implication of this would be.  Is this something we can create
comparison easily?

I noticed that nobody releases the resource held by this new oidset.
Shouldn't we do so in revision.c:release_revisions()?

Thanks.
