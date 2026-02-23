Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E01734D90E
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845859; cv=none; b=qJOd18Qsg5vWAXyvsDTDd4QqjKMcSUHfzQiRujHWHbcTJr5vQ/AIM2clDDastjXWRO40xSmSAPW6sRJZ2Ikm5eDXhAHE4TmE43m5ISkbxsvhZDSgFTIBm6ezOrfHSM8dacdaDj6AM+Gh8DE/TOEAKkya1U78HQxGjDAzq1EqFpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845859; c=relaxed/simple;
	bh=EF+/ce/UHxNd6iFY2iNm9XwZQl8l3boAhlOzpgDfQyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eCNdniIGyeQymGxZQL5oCzyuhdPv3yeL/HVAxfieeqHt7jB6haWy69CdziYGTOiXDDpv0t9cPP7GkKPZhboqtqa9YNe97OGFkxJoDC05AZ1ga6AE+F1w1oiX9zQDRvMeykJsqO8+KMH+HKxSN38oqI2yY/31sIMJNHR1Tg9rVO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=c3Ois3QM; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="c3Ois3QM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1771845854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xRpNqNpmOgu+92MjcDJ/1F0k45V3MEmf8FfvYbtN6Ug=;
	b=c3Ois3QMkHgiw55SpZhB+tbaKD5BRxwz7+9hcJ1Sa96MxvRPirV+wgi9M+Jez8mp0TquD6
	V1vZSUkspTqk85NTQ436N+K8Xa0SHXGRrokypkEjFt5IREhgyefwlpvWKBEQSynohBOSBc
	gzut3ffqmZfYkVXqGKdJat7m31qOuyw=
From: Toon Claes <toon@iotcl.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org,
 ps@pks.im, gitster@pobox.com, phillip.wood123@gmail.com,
 phillip.wood@dunelm.org.uk, karthik.188@gmail.com,
 johannes.schindelin@gmx.de, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 2/2] replay: add --revert mode to reverse commit changes
In-Reply-To: <CAP8UFD1CAYZwK4x4-AZWjx3cubzu5WcndR8WJzhcegET+i22nA@mail.gmail.com>
References: <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-3-siddharthasthana31@gmail.com>
 <87tsvbe2sm.fsf@iotcl.com>
 <CAP8UFD1CAYZwK4x4-AZWjx3cubzu5WcndR8WJzhcegET+i22nA@mail.gmail.com>
Date: Mon, 23 Feb 2026 12:23:55 +0100
Message-ID: <87pl5vem9g.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Feb 20, 2026 at 6:35=E2=80=AFPM Toon Claes <toon@iotcl.com> wrote:
>>
>> The modes `--onto`, `--advance` and `--revert` seem to be extremely
>> different from each other. So I'm starting to wonder whether it won't
>> make more sense to instead create subcommands instead of options for
>> these. Maybe something like:
>>
>>     git replay revert --base=3D<branch> <revision-range>
>>     git replay pick --base=3D<branch> <revision-range>
>>     git replay replay --base=3D<branch> <revision-range>
>
> (I think you mean `git replay rebase` in the above line, no?)

I'm fine either way, but I agree saying "replay" twice looks weird.

> I agree that we should consider this. But I think we should do it
> separately in another series, after this one about --revert is merged.
> We might even consider waiting until we have more experience using
> `git replay --revert` to make a more informed decision. We shouldn't
> wait for too long either though...

I can agree with that.

> Also if we nearly always need a base, then why not:
>
>   git replay rebase <base> <revision-range>
>   git replay pick <base> <revision-range>
>   git replay revert <base> <revision-range>
>
> ?
>
> Or what was the reason for introducing --base=3D<branch>?

Well, the modes 'revert' and 'pick' work different from 'replay'. The
latter looks in <revision-range> to determine which refs need updating.
This can lead to multiple refs that will be updated (with option
--contained). The first two only operate on one ref and ignore whatever
refs are in <revision-range>. (I think, correct me if I'm wrong)

That's why I suggest to take it one step further:

     git replay revert --ref=3D<branch> <revision-range>
     git replay pick --ref=3D<branch> <revision-range>
     git replay rebase --onto=3D<branch> <revision-range>

That's why the first two use --ref instead of --onto.

As a benefit, this also enables me to address another issue I have:
git-replay(1) cannot be used on bare commit IDs. This issue was also
raised by Yee Cheng Chin[1].

With options `--onto` and `--ref` we can fix this. Because you can use
them together:

    git replay replay --ref=3Dref/heads/branch --onto=3D112233 aabbcc..ddee=
ff
    git replay pick --ref=3Dref/heads/branch --onto=3D112233 aabbcc..ddeeff
    git replay rebase --ref=3Dref/heads/branch --onto=3D112233 aabbcc..ddee=
ff

The value of --onto doesn't need to be a ref, but --ref needs. For the
'rebase' subcommand option --ref is optional, for the other two --onto
is optional. And when one of both is omitted, one defaults to the other.

What do you think?

[1]: https://lore.kernel.org/git/CAHTeOx-SMLh_idKhGczPKzZNOKy04uYXmUhL8Z79y=
RuNpmE4eA@mail.gmail.com/

--=20
Cheers,
Toon
