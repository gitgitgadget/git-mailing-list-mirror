Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DCC16C6B9
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 21:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713476837; cv=none; b=ad1svo0wYPDu48MOnajv3N0ZMt7qhckOjWvG7yWWnu4uOxD/6sOlNSPlilK2+hkCkz5mXjKAOdSGc9KN5SxxZ3XZOAm1kkldFG9chg8ksIhXlreha4uqcdQFfbGCq5k1spWPD4AF9WMEOdedc/0n9j5i5Os+cVa0/HbJoBhN/yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713476837; c=relaxed/simple;
	bh=GC2oVqzardmNsqwwRneUUTwUnsDDbEJ8ipDwCIMOU7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BDziHHxX+JaA/LfmebdHmBQu2vSGizer8/2kHSuk5+qrICiaZnUd45xvwsz5ZVRQkT5sldRMe9dgN0NKe65JpUjGH3A/eX8TEV++RAXZhXwshsDW8fejErtI/wX9rBRXdyB18INzv4w4k6sNX4P2kN55+6lTSah+AghW2mRO+aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vDZY22Et; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vDZY22Et"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BD84A2BF21;
	Thu, 18 Apr 2024 17:47:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GC2oVqzardmNsqwwRneUUTwUnsDDbEJ8ipDwCI
	MOU7U=; b=vDZY22EtuZjvlxSgaEC61CGF7Ce4bd0MSKxmcnDL2ww5Dduo+6r+nG
	XeafKKZ6WpTuHKmi6kJqXdO1+fJpU64NgDbqkzd4oCgD5QwTSxIb7KcWA8m7gJKh
	RrFEsDXL4PC+esft7k8QfAvSz4LDeUYAOK25tc8MHMvO2hvMlch8I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B5F1B2BF20;
	Thu, 18 Apr 2024 17:47:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AE9AE2BF1D;
	Thu, 18 Apr 2024 17:47:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/4] missing: support rejecting --missing=print
In-Reply-To: <20240418184043.2900955-3-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 18 Apr 2024 20:40:41 +0200")
References: <20240418184043.2900955-1-christian.couder@gmail.com>
	<20240418184043.2900955-3-christian.couder@gmail.com>
Date: Thu, 18 Apr 2024 14:47:10 -0700
Message-ID: <xmqqfrvipcm9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 365DB7BC-FDCD-11EE-90FB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> `git pack-objects` supports the `--missing=<missing-action>` option in
> the same way as `git rev-list` except when '<missing-action>' is
> "print", which `git pack-objects` doesn't support.
>
> As we want to refactor `git pack-objects` to use the same code from
> "missing.{c,h}" as `git rev-list` for the `--missing=...` feature, let's
> make it possible for that code to reject `--missing=print`.
>
> `git pack-objects` will then use that code in a following commit.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/rev-list.c | 2 +-
>  missing.c          | 4 ++--
>  missing.h          | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index f71cc5ebe1..a712a6fd62 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -539,7 +539,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  			int res;
>  			if (revs.exclude_promisor_objects)
>  				die(_("options '%s' and '%s' cannot be used together"), "--exclude-promisor-objects", "--missing");
> -			res = parse_missing_action_value(arg);
> +			res = parse_missing_action_value(arg, 1);

Hmph, this smells like a horribly unscalable design, as we make the
vocabulary of missing-action richer, you'd end up piling on "this
choice is allowed in this call" parameters, wouldn't you?  The first
person who adds such an ad-hoc parameter would say "hey, what's just
one extra parameter print_ok between friends", but the next person
would say the same thing for their new choice and adds frotz_ok, and
we'd be in chaos.

Rather, shouldn't the _caller_ decide if the parsed value is
something it does not like and barf?

Alternatively, add a _single_ "reject" bitset and do something like

	int parse_missing_action_value(const char *value, unsigned reject)
	{
		...
		if (!(reject & (1<<MA_ERROR) && !strcmp(value, "error")))
			return MA_ERROR;
		if (!(reject & (1<<MA_PRINT) && !strcmp(value, "print")))
			return MA_PRINT;
		...

which would scale better (but still my preference is to have the
caller deal with only the values it recognises---do not make the
caller say "if (res >= 0 && res != MA_PRINT)" as that will not scale
when new choices that are accepted elsewhere are added.
