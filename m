Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A8571FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 21:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbcFUVhN (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 17:37:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58794 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751536AbcFUVhM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 17:37:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BAC2625A25;
	Tue, 21 Jun 2016 17:36:38 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XeCbbu7NJ33EXbaxxWE3nae7w6E=; b=SrWfyB
	igA+UO3cVuZL7LlH/4FM0QYrVhRw7zOeIQ7lhax22U8pOqVTH9//F3bac3gib6sc
	DtDLM/stbz0lR0UTohcUu4DL7RsoUuqPDVEYiW/HVB4sqpKX3JFqIoBu7/aP50rl
	LfiR5fmgFKu1ja/ZLrH8yrCV8kgq9ScfVEMVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bgFcyUhYZRVUB9rQReCd1+v9N6XbcjZ1
	0e68PG+WOU3MTvJXw+q1q0lRxtNzq9ybkI348nNu9fkX9NvjNWbnPt+x/vGYVXuB
	jb8qvVh8uAxOcvGIBWDO561yuj1T1V+Ily4JRkWCy0mzVoW+n5U4DgO03I1X67p+
	y7AyCKHmiZE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B322325A24;
	Tue, 21 Jun 2016 17:36:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3CA7525A1E;
	Tue, 21 Jun 2016 17:36:38 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	"brian m. carlson" <sandals@crustytoothpaste.net>
Cc:	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/8] Apply object_id Coccinelle transformations.
References: <20160618221407.1046188-1-sandals@crustytoothpaste.net>
	<20160618221407.1046188-3-sandals@crustytoothpaste.net>
Date:	Tue, 21 Jun 2016 14:36:36 -0700
In-Reply-To: <20160618221407.1046188-3-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Sat, 18 Jun 2016 22:14:01 +0000")
Message-ID: <xmqqtwgmns0r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C307286-37F8-11E6-A18D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Apply the set of semantic patches from contrib/examples/coccinelle to
> convert some leftover places using struct object_id's hash member to
> instead use the wrapper functions that take struct object_id natively.

It is somewhat curious how these 'some leftover places' are chosen.

Especially, this hunk was interesting.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 1f380764..dac3a222 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1725,14 +1725,14 @@ static int verify_lock(struct ref_lock *lock,
>  			errno = save_errno;
>  			return -1;
>  		} else {
> -			hashclr(lock->old_oid.hash);
> +			oidclr(&lock->old_oid);
>  			return 0;
>  		}
>  	}
>  	if (old_sha1 && hashcmp(lock->old_oid.hash, old_sha1)) {
>  		strbuf_addf(err, "ref %s is at %s but expected %s",
>  			    lock->ref_name,
> -			    sha1_to_hex(lock->old_oid.hash),
> +			    oid_to_hex(&lock->old_oid),
>  			    sha1_to_hex(old_sha1));
>  		errno = EBUSY;
>  		return -1;

The function gets old_sha1 which is the old-world "const unsigned
char *" that is passed via lock_ref_sha1_basic() from public entry
points like rename_ref() and ref_transaction_commit().  As this
codepath and the functions involved have not be converted to oid,
we end up seeing oid_to_hex() next to sha1_to_hex() ;-)

Not a complaint; this is how we make progress incrementally.

It was just I noticed this function is left in a somewhat funny
intermediate state after this step.

Thanks.
