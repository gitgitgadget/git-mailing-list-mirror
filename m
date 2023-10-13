Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18C6134CD
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KOc/pRo/"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D425F83
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 11:21:50 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A1761A8A5E;
	Fri, 13 Oct 2023 14:21:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oxRBnxR9aBbiJQnvkFxkvYcdlmb8ZN0KkS/c34
	WX5pQ=; b=KOc/pRo/mvGSC3nXbXlMp4kWzLvyDy63XtREJmrFvEqZGsW2tj72C0
	6rJfmRSgv3pi7DCi+laHX1W4lQ7wbDkVxrZmrR+BhE+dA6XljwYJb7XOfSAZ0Uko
	jzSl/5jU6xHunc1UuRHVszOQH37YmZCfvhoZ8Akb2VZqfGyNOhZFU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FF911A8A5D;
	Fri, 13 Oct 2023 14:21:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7F8781A8A5C;
	Fri, 13 Oct 2023 14:21:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Taylor
 Blau <me@ttaylorr.com>
Subject: Re: [PATCH] commit: detect commits that exist in commit-graph but
 not in the ODB
In-Reply-To: <b0bf576c51a706367a758b8e30eca37edb9c2734.1697200576.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 13 Oct 2023 14:37:35 +0200")
References: <ZSkCGS3JPEQ71dOF@tanuki>
	<b0bf576c51a706367a758b8e30eca37edb9c2734.1697200576.git.ps@pks.im>
Date: Fri, 13 Oct 2023 11:21:48 -0700
Message-ID: <xmqq1qdy1iyr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 601B93EC-69F5-11EE-A424-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patrick Steinhardt <ps@pks.im> writes:

> @@ -572,8 +572,13 @@ int repo_parse_commit_internal(struct repository *r,
>  		return -1;
>  	if (item->object.parsed)
>  		return 0;
> -	if (use_commit_graph && parse_commit_in_graph(r, item))
> +	if (use_commit_graph && parse_commit_in_graph(r, item)) {
> +		if (!has_object(r, &item->object.oid, 0))
> +			return quiet_on_missing ? -1 :
> +				error(_("commit %s exists in commit-graph but not in the object database"),
> +				      oid_to_hex(&item->object.oid));
>  		return 0;
> +	}

Ever since this codepath was introduced by 177722b3 (commit:
integrate commit graph with commit parsing, 2018-04-10), we blindly
trusted what commit-graph file says.  This change is a strict
improvement in the correctness department, but there are two things
that are a bit worrying.

One.  The additional check should certainly be cheaper than a full
reading and parsing of an object, either from a loose object file or
from a pack entry.  It may not hurt performance too much, but it
still would give us more confidence if we know by how much we are
pessimising good cases where the commit-graph does match reality.
Our stance on these secondary files that store precomputed values
for optimization purposes is in general to use them blindly unless
in exceptional cases where the operation values the correctness even
when the validity of these secondary files is dubious (e.g., "fsck"),
and doing this extra check regardless of the caller at this low level
of the callchain is a bit worrying.

Another is that by the time parse_commit_in_graph() returns true and
we realize that the answer we got is bogus by asking has_object(),
item->object.parsed has already been toggled on, so the caller now
has a commit object that claimed it was already parsed and does not
match reality.  Hopefully the caller takes an early exit upon seeing
a failure from parse_commit_gently() and the .parsed bit does not
matter, but maybe I am missing a case where it does.  I dunno.

Other than that, sounds very sensible and the code change is clean.

Will queue.  Thanks.

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index ba65f17dd9..25f8e9e2d3 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -821,4 +821,27 @@ test_expect_success 'overflow during generation version upgrade' '
>  	)
>  '
>  
> +test_expect_success 'commit exists in commit-graph but not in object database' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		test_commit A &&
> +		test_commit B &&
> +		test_commit C &&
> +		git commit-graph write --reachable &&
> +
> +		# Corrupt the repository by deleting the intermittent commit
> +		# object. Commands should notice that this object is absent and
> +		# thus that the repository is corrupt even if the commit graph
> +		# exists.
> +		oid=$(git rev-parse B) &&
> +		rm .git/objects/"$(test_oid_to_path "$oid")" &&
> +
> +		test_must_fail git rev-parse HEAD~2 2>error &&
> +		grep "error: commit $oid exists in commit-graph but not in the object database" error
> +	)
> +'
> +
>  test_done
