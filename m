Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1B17D3FA
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718145966; cv=none; b=OedK1Sh+pI8m6mKolQSiZ/Xcq9p6FtsXy0GRFhsfi/BxwsVYSSl2ZuHp+k2atPjyJ3ZjIhEt0BjKvVoJGtzVBZOTjLDPkC8dMHl6LsMhFhtTyozkFrglCBtKLi9uA0ii9sU5F3JslkgIn1hWWyaehBbBr8DHG8rWfj5NK7P0Hno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718145966; c=relaxed/simple;
	bh=Wa/ckkMwgxoVXKV2RIIAp+iGtsECXYs+DNDol39aFDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BqlL+X5634vQkRmTkgNzL/t/zpuVC6bCNJ1WHGqukeSWkHvP8sozKf6az/ZuvE4nbsrN+XmMeZ1WlTv7cdqWid1eHBsdHTccymZ6yMQFFaRf/AC+4Nj6eiseL2iKe7M5ClvGIC3RnJ8SudffOc4254npL7cvPh6bVkz3RMjGRuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UXnceGpG; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UXnceGpG"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 304622AF73;
	Tue, 11 Jun 2024 18:46:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Wa/ckkMwgxoVXKV2RIIAp+iGtsECXYs+DNDol3
	9aFDM=; b=UXnceGpGh4M/DPEEkLJHtey/Ksk3U9Eoy/kikqWRRj3iMtgzVM7YOA
	Es2StiS3I53OiAl2PSZl4pwaerMTYy8CU2tBn6gGSghNCsyQQOfMfo9I7hdsJ6HE
	MQxoiAuuHXnzw0kVLdyuKnlRzpLS69s/p3ctVx7eLJ/muiiDbWWHA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 28D442AF72;
	Tue, 11 Jun 2024 18:46:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C66B2AF6F;
	Tue, 11 Jun 2024 18:46:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 04/16] update-index: generalize 'read_index_info'
In-Reply-To: <9d0689e9c285b375b0067760929011038c085d65.1718130288.git.gitgitgadget@gmail.com>
	(Victoria Dye via GitGitGadget's message of "Tue, 11 Jun 2024 18:24:36
	+0000")
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<9d0689e9c285b375b0067760929011038c085d65.1718130288.git.gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 15:45:59 -0700
Message-ID: <xmqqa5jrt7x4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 609742CC-2844-11EF-9628-965B910A682E-77302942!pb-smtp2.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Move 'read_index_info()' into a new header 'index-info.h' and generalize the
> function to call a provided callback for each parsed line. Update
> 'update-index.c' to use this generalized 'read_index_info()', adding the
> callback 'apply_index_info()' to verify the parsed line and update the index
> according to its contents.
>
> The input parsing done by 'read_index_info()' is similar to, but more
> flexible than, the parsing done in 'mktree' by 'mktree_line()' (handling not
> only 'git ls-tree' output but also the outputs of 'git apply --index-info'
> and 'git ls-files --stage' outputs). To make 'mktree' more flexible, a later
> patch will replace mktree's custom parsing with 'read_index_info()'.

"git apply --index-info"?  

That is a blast from the past.  It no longer exists since 7a988699
(apply: get rid of --index-info in favor of --build-fake-ancestor,
2007-09-17).

As to the scriptability, supporting "ls-files -s" and "ls-tree -r"
output as our input do help, but the third one is not natively
emitted and it is very unlikely that there are third-party tools
that give output in that format.  After all these years, I suspect
that it is sufficient to say

    "update-index --index-info" and "mktree" both read information
    necessary to eventually build trees, but having two separate
    parsers is a maintenance burden, so we are massaging the code
    from the former to be reusable.

without mentioning where the old third format comes from.

> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index d343416ae26..77df380cb54 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -11,6 +11,7 @@
>  #include "gettext.h"
>  #include "hash.h"
>  #include "hex.h"
> +#include "index-info.h"
>  #include "lockfile.h"
>  #include "quote.h"
>  #include "cache-tree.h"
> @@ -509,100 +510,29 @@ static void update_one(const char *path)
>  	report("add '%s'", path);
>  }
>  
> +static int apply_index_info(unsigned int mode, struct object_id *oid, int stage,
> +			    const char *path_name, void *cbdata UNUSED)
>  {
> +	if (!verify_path(path_name, mode)) {
> +		fprintf(stderr, "Ignoring path %s\n", path_name);
> +		return 0;
> +	}
>  
> +	if (!mode) {
> +		/* mode == 0 means there is no such path -- remove */
> +		if (remove_file_from_index(the_repository->index, path_name))
> +			die("git update-index: unable to remove %s", path_name);

This changes the error message.  We used to feed "ptr" (no longer
visible to this function, as the caller unquotes before calling us)
that pointed at the original the user gave to the program; now we
report the path_name which is the result of the unquoting.

> +	}
> +	else {
> +		/* mode ' ' sha1 '\t' name
> +		 * ptr[-1] points at tab,
> +		 * ptr[-41] is at the beginning of sha1
>  		 */
> +		if (add_cacheinfo(mode, oid, path_name, stage))
> +			die("git update-index: unable to update %s", path_name);

But this side used to report the path_name as the result of
unquoting in the original.  So the above change would probably be OK
in the name of consistency?

973d6a20 (update-index --index-info: adjust for funny-path quoting.,
2005-10-16) was the origin of the unquoting, and looking at that
commit, I have a feeling that the "ptr" thing above (i.e., the one I
pointed out as changing the behaviour) was simply forgotten (as
opposed to deliberately made to report the original) while updating
the code to deal with quoted original into unquoted paths.

So I think the change is more than OK.  It is a very welcome (belated)
bugfix for 973d6a20 ;-).

>  	}
> +
> +	return 0;
>  }

It looks a bit disappointing that we die in the callback like above,
when the main parser loop that moved to the other file to be more
reusable is now capable of returning to the caller with an error,
but at this step, it is a good place to stop.  A refactor that does
not change the behaviour.

Nicely done.

> diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
> index cc72ead79f3..29696ade0d0 100755
> --- a/t/t2107-update-index-basic.sh
> +++ b/t/t2107-update-index-basic.sh
> @@ -142,4 +142,31 @@ test_expect_success '--index-version' '
>  	test_must_be_empty actual
>  '
>  
> +test_expect_success '--index-info fails on malformed input' '
> +	# empty line
> +	echo "" |
> +	test_must_fail git update-index --index-info 2>err &&
> +	grep "malformed input line" err &&

Using "test_grep" would make it easier to diagnose when test breaks.
A failing "grep" will be silent.  A failing "test_grep" will tell us
"I was told to find THIS, but didn't find any in THAT".

> +	# bad whitespace
> +	printf "100644 $EMPTY_BLOB A" |
> +	test_must_fail git update-index --index-info 2>err &&
> +	grep "malformed input line" err &&
> +
> +	# invalid stage value
> +	printf "100644 $EMPTY_BLOB 5\tA" |
> +	test_must_fail git update-index --index-info 2>err &&
> +	grep "malformed input line" err &&
> +
> +	# invalid OID length
> +	printf "100755 abc123\tA" |
> +	test_must_fail git update-index --index-info 2>err &&
> +	grep "malformed input line" err &&
> +
> +	# bad quoting
> +	printf "100644 $EMPTY_BLOB\t\"A" |
> +	test_must_fail git update-index --index-info 2>err &&
> +	grep "bad quoting of path name" err
> +'
> +
>  test_done
