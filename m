Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6692D0614
	for <git@vger.kernel.org>; Sun, 16 Aug 2026 17:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786902712; cv=none; b=HfYwOFJxE9xMTyfAwXgo+ISkaOigVaLTBwNDpMYwn+btEz1yYB2ysZgcJRoW8iY7swnsTe3zpCwerUeD7UusvyYtxoNeZZ89aKXiCW59cAOI8v/vJxuXylBTcuXgqDe36Q1Ftb4qGRjW6S+4SEg0wrrPRqNwSS62vfC10Sw0faI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786902712; c=relaxed/simple;
	bh=v64spem6oGueuYDXS5zadcW2KuQXYSwJuabIi5C6qcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+vdEdmqDFoobUUBkuD8mZM0y+GHUM62/uH9mZAbDn6sOyI4Nngo/TMzRB2NY743jllwD1P1EtWX5mZYncYKlNF7gtB6WvY29OItMhiyeVeKk+WHdeHZZKbEIKryUyLyt3bq0JcWKpw0gKAEwQWYjaadcQioHvpWKUete5k3rC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=UD/vitUO; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="UD/vitUO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1786902693; x=1787507493; i=l.s.r@web.de;
	bh=EdaMd//0w449aQuVFB4PisO8H80Kp0aI4nbi9d6Wlys=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UD/vitUOubLDViHatr1dXNlM9cghd5vM+qZMrvziq+h2pv12MUukroskwxu+MeMw
	 Pn3XkR8dPNuj/Dp+D9s+jUjoUIGzUUEAj8jXiKPK1buAy7q+BhgvNGK/FgkprjVfN
	 o5pcA5Vk6hWiW3/wqsOsBO6i9CYET3iulNsSgKW/XmCoDPUF+kqsfFvKdPhXZu8ql
	 Ij/cV0PBvr+dRIeiVJZgV1krV/3ptB98zqbmlIEynHcR6rYUycLcmd0VE0jR6RUkk
	 mrJaEdf1A+HwY8YMeE87ZRUB/jmfggqCHtk5DPt31uVWWX4AkxfMCIP1fNnQhyg6W
	 mVbUSoSodfoQzZKYQQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Icd-1wjcW20HZP-016XEX; Sun, 16
 Aug 2026 19:51:33 +0200
Message-ID: <17e8c4e6-9eeb-4c71-9297-d8d5771217d8@web.de>
Date: Sun, 16 Aug 2026 19:51:32 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1.5] worktree: Fix out of bounds read that causes data
 loss and reject invalid empty input in worktree add
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Matthias_A=C3=9Fhauer_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Marc Branchaud <marcnarc@xiplink.com>,
 =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= <pclouds@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>, =?UTF-8?Q?Matthias_A=C3=9Fhauer?=
 <mha1993@live.de>
References: <pull.2187.git.1784978348.gitgitgadget@gmail.com>
 <52ee6501-24ac-402b-b650-92a829030380@web.de> <xmqqwltwz36a.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqwltwz36a.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OPw1XCFcA4FEvi9jX2eKNyZPRZLf5gajOzA9/BpE7iHnDwUmrdM
 qAE6Ne9XX3olj+mj36gvUPMZnMFgGJMa4SiirVnIN4OBzf/LPHD8dxRT2znEOnk4U8uLR/U
 yEE5YC7bemxfs/gT9E6gnl33GYlPpd7ohznaGRNPhtX8XIcAwLOduWJpHkoJ/On14QpDC8C
 uRCKHueh9QDCVU102dAHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZoVPw4Auzqk=;2syrATyIYl22qE/MYHg3xF6RpXp
 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
 X54Xd6uQOs=

On 8/12/26 12:46 AM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> From: =3D?UTF-8?q?Matthias=3D20A=3DC3=3D9Fhauer?=3D <mha1993@live.de>
>>
>> `worktree_basename` tries to read from memory before the passed `path`
>> string, if `path` is empty (or only consists of directory separators).
>> That results in unexpected nonsense data being returned to the caller,
>> which can lead to issues, such as `git worktree add ""` recursively
>> deleting the current working directory, including `.git`.
>>
>> Stop reading out of bounds in these cases to avoid that behaviour.
>>
>> This leads to `git worktree add ""` consistently exiting with the
>> message `BUG: How come '' becomes empty after sanitization?`, which is
>> still undesirable, but at least it doesn't result in data loss anymore.
>>
>> This fixes https://github.com/git-for-windows/git/issues/6346
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>> How about this while we're waiting for a reroll?  It implements what th=
e
>> commit message says, nothing more.  Follows the style of the first loop=
.
>=20
> This one I think is obvious and clear.  Why not take the authorship
> too so that we do not have to worry about DCO?

That feels unfair: Matthias did most of the work by identifying the bug
and removing the premature subtraction from the loop doesn't seem very
original to me.  Ultimately my main concern is getting this surprisingly
impactful bug fixed in a reasonable amount of time, though..

Ren=C3=A9

>=20
>>
>>  builtin/worktree.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> index 654d27c3e1..a770dd5ead 100644
>> --- a/builtin/worktree.c
>> +++ b/builtin/worktree.c
>> @@ -303,11 +303,9 @@ static const char *worktree_basename(const char *p=
ath, int *olen)
>>  	while (len && is_dir_sep(path[len - 1]))
>>  		len--;
>> =20
>> -	for (name =3D path + len - 1; name > path; name--)
>> -		if (is_dir_sep(*name)) {
>> -			name++;
>> -			break;
>> -		}
>> +	name =3D path + len;
>> +	while (name > path && !is_dir_sep(name[-1]))
>> +		name--;
>> =20
>>  	*olen =3D len;
>>  	return name;

