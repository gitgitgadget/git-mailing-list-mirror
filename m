Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF684DF7
	for <git@vger.kernel.org>; Fri, 24 May 2024 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716587208; cv=none; b=me3fRag0AUDQVBRUrRJ0sWIa4NnTK5XFoQG8RwQnUmvXSJeB4qiUNkr7D2rHOendbQFz1AcZxj0GIGA19d38jLBQKEC/kkaex+V5ylF9PEpyIyH4SBtFgWPFJ5w08moVsq3tgQcx0ndk8MMAGDn3l4enXE3bnhxcq9ErbAYJp0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716587208; c=relaxed/simple;
	bh=nUHHQ1AwcrbbYVJi/GlSXW4Ie30PMgXEZUdVpGL7+0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kTwaaclIiPbpa5x2kuahttSDpQ7QC8kawpScMDwBUfdLIepDdhjwevQeWq0MzOe1IYluNfKV8S8HIBHT1ecPDJTRo3mCtaSw4VxcgT77EK0ZINuh0HPWkwlfa85I29LmS+CHS9fcP4NqD5XKRlyeXm4Uqo40wqALm1FDeP0cTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tfnvRLGL; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tfnvRLGL"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BDE82BE43;
	Fri, 24 May 2024 17:46:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nUHHQ1AwcrbbYVJi/GlSXW4Ie30PMgXEZUdVpG
	L7+0o=; b=tfnvRLGLUyCRybDtBYNqIGuyuthPAj/c7mkwaV4tUNSIaM/FZ0Th+A
	ilSuVC4cK8ypt16cTQ6ztOFn0Av1FunsxAcrKghsYEEX3kPfTOQjFH4+Z8tHTI12
	rE4z3if8so6y22SJDni1WpjEAiF6JRZi1Pib86VIn8evSbtK2JPls=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 44F842BE42;
	Fri, 24 May 2024 17:46:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 41F2B2BE41;
	Fri, 24 May 2024 17:46:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] format-patch: move range/inter diff at the end of a
 single patch output
In-Reply-To: <ZlB2g5bTuBFz5m5_@tanuki> (Patrick Steinhardt's message of "Fri,
	24 May 2024 13:14:11 +0200")
References: <20240523225007.2871766-1-gitster@pobox.com>
	<20240523225007.2871766-3-gitster@pobox.com> <ZlB2g5bTuBFz5m5_@tanuki>
Date: Fri, 24 May 2024 14:46:43 -0700
Message-ID: <xmqqo78ukhmk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1CE191F8-1A17-11EF-9DBF-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, May 23, 2024 at 03:50:07PM -0700, Junio C Hamano wrote:
> [snip]
>> @@ -1176,6 +1172,9 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
>>  	opt->loginfo = NULL;
>>  	maybe_flush_or_die(opt->diffopt.file, "stdout");
>>  	opt->diffopt.no_free = no_free;
>> +	if (shown)
>> +		show_diff_of_diff(opt);
>
> Shouldn't we write the range-diff before `maybe_flush_or_die()`?

Hmph, perhaps.  That would catch errors from write done in the
show_diff_of_diff() helper.

>> +
>> +	# remove up to the last "patch" output line,
>> +	# and remove everything below the signature mark.
>> +	sed -e "1,/^+fleep\$/d" -e "/^-- /,\$d" 0001-fleep.patch >actual &&
>> +
>> +	# fabricate Interdiff output.
>> +	git diff boop~2 boop >inter &&
>> +	{
>> +		echo "Interdiff:" &&
>> +		sed -e "s/^/  /" inter
>> +	} >expect &&
>>  	test_cmp expect actual
>>  '
>
> Do we also want to have a test that demonstrates the new behaviour for
> range-diffs?

I dunno.  From the whitebox point of view I know it appears at the
same place, so it does not matter all that much.

> I also think that there's a bug here. The output from the above command
> is:
> ...
>     --- a/blorp
>     +++ b/blorp
>     @@ -1 +1 @@
>     -fnorp
>     +fleep
>     Interdiff against v1:
>       diff --git a/blorp b/blorp
> ...
>
> The diff is before the separator for the signature, and there is no
> clear delimiter between the actual diff and the interdiff.

Earlier Eric expressed concern about writing this out _after_ the
mail signature mark "-- ", so the output deliberately goes before
it.  There is no need for any marker after the last line of the
patch.  "Interdiff against ..." is a clear enough delimiter.

FWIW, the parsing of patches has always paid attention to the
lengths recorded in @@ ... @@ hunk headers, and the parser notices
where the run of ("diff --git a/... b/..." followed by a patch) ends
and stops without problems.  On the other hand, if you remove the
line "+fleep" in the above example and try to feed it to "git
apply", it would correctly notice that it failed to see the expected
one line of postimage and complains (because it sees "Interdiff
against..."  when it expects to see a line that begins with a plus).

So, I do not see any problem with the output from this cocde at all.

Thanks for careful reading.

