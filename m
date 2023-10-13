Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C27D1C691
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qcfWPkPT"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA89A9
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 10:07:35 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C9F02C31E;
	Fri, 13 Oct 2023 13:07:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AbaWU8GPGbILd0on/eID54IeVPhILcUdvht8Bm
	7zd6g=; b=qcfWPkPTWODuO3VWBxjbPxYW3x05gebt6YaGKOic0ENa4gnqxCu9gP
	SnIWzIRA7y3RxLxiPMM9oSGUBAVyjjJenGNjjKbT6FwtUAxdeunaOOgj0y0w2ook
	wIGsZsjydLbOb0hf+yijSCkmrh06ldurahvq1Rz17P1QYT5CAHB/8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 64ADF2C31D;
	Fri, 13 Oct 2023 13:07:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 953262C31B;
	Fri, 13 Oct 2023 13:07:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/3] rev-list: add support for commits in `--missing`
In-Reply-To: <ZSkCGS3JPEQ71dOF@tanuki> (Patrick Steinhardt's message of "Fri,
	13 Oct 2023 10:38:49 +0200")
References: <20231009105528.17777-1-karthik.188@gmail.com>
	<ZSTs3BUVtaI9QIoA@tanuki> <xmqqil7etndo.fsf@gitster.g>
	<CAOLa=ZSbd_E+DAkhuGrUpfHkxaje3jrH9-fEDyctAPFExKnj9A@mail.gmail.com>
	<xmqqbkd5nlq0.fsf@gitster.g>
	<CAOLa=ZQxNX4oGtqrgLyKenC_D8M=9q0sFJVmo4fyjSPtgw315Q@mail.gmail.com>
	<ZSfSt4tXx8sE68Bn@tanuki> <xmqqy1g7hl2y.fsf@gitster.g>
	<ZSjbYCXfSUtEIkAt@tanuki> <ZSkCGS3JPEQ71dOF@tanuki>
Date: Fri, 13 Oct 2023 10:07:29 -0700
Message-ID: <xmqqpm1i1mem.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FEFBB5E2-69EA-11EE-A2DB-A19503B9AAD1-77302942!pb-smtp21.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patrick Steinhardt <ps@pks.im> writes:

> actually exists in the object database. It's the only callsite of that
> function outside of "commit-graph.c", as all other external callers
> would call `lookup_commit_in_graph()` which _does_ perform the object
> existence check.
>
> So I think that the proper way to address the regression would be a
> patch similar to the following:
>
> diff --git a/commit.c b/commit.c
> index b3223478bc..109e9217e3 100644
> --- a/commit.c
> +++ b/commit.c
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

It is (overly) conservative, which I generally should find pleasing,
but as I said, for secondary information like commit-graph that is
derived from the primary source only to precompute for optimization,
our general attitude should be to trust it and let the optimization
kick in, unless the operation being performed primarily cares about
the case where the result from using and not using the secondary
source differs.  An obvious example of such an operation is "fsck",
where we do care and want to notice when the underlying object graph
and what commit-graph records contradict with each other.  And my
suggestion to disable commit-graph while running the "rev-list"
command with the "--missing" option is because that usage would fall
into the same category (please correct me if that is not the case) [*].

So for the purpose of "rev-list --missing", the above change does
take us closer to the answer we would get from the primary source,
but isn't it pessimising other users unnecessarily?  Do we have a
rough idea (if we have a benchmark that would be even better) how
much this lack of has_object() check is contributing to the
performance benefit of using commit-graph?  Majority of callers of
this code should not have to pay the additional overhead here, so
unless it is small enough, this would be pessimising the generic
code for everybody to please "rev-list --missing", which is why I am
worried about going in this direction.
