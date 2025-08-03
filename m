Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E8E205502
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754214879; cv=none; b=dLMWI3WTG4Zq5D9gyj6U3We2SgqTMEjs53lK3Qew3ENZfXv6zdiUPISVviuRIWtvlUc8DIk4aeIsQLRgqXWx1KKARWPyJYqGpEHlikWExOYHfTenvDenqQhYsRYBXGZoeeSEY7BASBMn9egy6TAWkXq+mc9youwGpdCgZjun7rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754214879; c=relaxed/simple;
	bh=SwfJjldP1vdqJ4Egjs7j3x6EAcBvZIK4b75vvsU1CCM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ssCS+ShrAyLYf+aj32koXxyO7bhUU35zWkGN0WtRlNSmeHcJCpcjh3dGTrSV5hPlUqCOlUsQkCdt9v/otMrzej4kTn9VqmLlFwxzzgJvVebmyvUbiMADipQph2n9lql+VUpG2f54NNASP+w6toxU1Ghr9etWvBUWfTsIn/8h1zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=VdTsY9v6; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="VdTsY9v6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754214867; x=1754819667; i=l.s.r@web.de;
	bh=iEdMJWXvKMiR5Mcir+PQnwkqOmdfj4pFCzYlehuu2t8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VdTsY9v65bkqmfR4BBtyfFlrerl6cdHUVnLG7BaGC8EnObKbJCePNIHeSDpxiOgr
	 ulFWq6Ri1CIxHNNo6KVi8yqGwFIfkJnoF2nNHaGbsOtjHVMVOkt7ztFgjOFhpU4Wo
	 HnE9scYLIv37yMoiLEcx6nIPVDJ06otpQfF7FYR+PXOK9WDzxUpMoEfEMuy3sGAX2
	 yXjN1CSSv2nGV+19HqboBiMDfw74bl5maiaB1ppQgbsz4twjhDJb/2thCfvGvW0wW
	 IqBjkYcqq2GU+mUX3N6nzDnbGyA9/bWpyId0w98TOr85/UZLltvwnDUPGp4z5WQJ3
	 suZweZbCzfXFgNERoQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjBVv-1uCSJz3LYT-00noWp; Sun, 03
 Aug 2025 11:54:26 +0200
Message-ID: <c5d91cec-3fec-422e-86d4-78767d95f208@web.de>
Date: Sun, 3 Aug 2025 11:54:26 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v2 1/3] commit: convert pop_most_recent_commit() to
 prio_queue
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <8ff40c56-368a-4347-aeae-2aca2cb6a5b2@web.de>
 <5d7c631a-ae94-4a59-b4ee-8161b5136d86@web.de>
 <148541F5-DC9F-4A3A-B1B1-0FED8AA5A101@gmail.com>
Content-Language: en-US
In-Reply-To: <148541F5-DC9F-4A3A-B1B1-0FED8AA5A101@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dSgv03CMe+RdJrTkevxhIdxZIFFqJDZ8WNOxojM2DZfcZwALJ9p
 xY7E/QQIsPEwKF9L5GfK/rMo+rF8Sy4tjK4SqIjx9MUxuaR68OCfR5kmVPi7mopg0AVgWQF
 7mrvUVfCuJH9i4Klcv1QOBvBaLNRBx+CMdGqqIGn11tva1GXLBH5a2KAlc6MBjVH5U1cI1w
 JyfQh/hIY+QXQMiHqnl1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:69Xd21wOuxM=;hGbWsPzrVmnaA4ijbL8KqoIxBGg
 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
 pdHuaA7c+FpslFvD4/CPuaM=

On 7/21/25 4:02 PM, Lidong Yan wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>> +#
>> +# Creates lots of merges to make history traversal costly.  In
>> +# particular it creates 2^($max_level-1)-1 2-way merges on top of
>> +# 2^($max_level-1) root commits.  E.g., the commit history looks like
>> +# this for a $max_level of 3:
>> +#
>> +#     _1_
>> +#    /   \
>> +#   2     3
>> +#  / \   / \
>> +# 4   5 6   7
>> +#
>> +# The numbers are the fast-import marks, which also are the commit
>> +# messages.  1 is the HEAD commit and a merge, 2 and 3 are also merges=
,
>> +# 4-7 are the root commits.
>> +#
>=20
> I feel that the reason there's no significant performance improvement is=
 probably
> because mostly we are using the priority queue to sort O(siblings) nodes=
.
> For example, in this case, the most time-consuming operation is when the=
 priority
> queue or commit list contains 4 and 5, and we then need to insert 6 and =
7.
>=20
> Assuming the maximum number of siblings is W and the number of nodes is =
N,
> the time complexity with a commit list is O(W=C2=B2 =C3=97 N), while usi=
ng a priority queue
> gives O(W log W =C3=97 N). Perhaps in many projects, W isn't particularl=
y large,
> which results in the performance improvement not being very significant.

Kinda.  While traversing the history we take a commit from to the
commit_list or prio_queue and put back its parents.  For single-parent
commits this sequence keeps the number of stored items the same.  Merges
increase that number.

We add and retrieve each commit in the (relevant part of) history.  That
takes O(N) and O(1) for the sorted list, and O(log N) and O(log N) for
the prio_queue, where N is the length of the list.

So the best-case history is a string of single-parent commits, keeping
only a single item on the list/queue throughout.  That requires no
sorting or heaping, making the additions and retrievals O(1).  The
overall complexity is then O(N) for both variants, N being the number
of commits in the history.

Worst-case history might be a single merge of all commits -- a
centipede or myriapod?  With all commits on the sorted list we get a
complexity of O(N=C2=B2) for the traversal, and O(N log N) with a prio_que=
ue.

Ren=C3=A9

