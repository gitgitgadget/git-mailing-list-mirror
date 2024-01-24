Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09017E778
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119403; cv=none; b=apTqQ1aEF46UCdg93RlG/4lPcDQc24CzQk4OtLKctEGnfvW7U/YutFCDt2+4v6NdRddO7tGGDF0WSp+3eKYAD5piMVbxLceyxAveJLm6zb/WWZ5ArNWqc+Qyc13VjI4HzTiCTJwTTJoTMdhWHclusO2QrMFE71Yz1W7B+r7O1Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119403; c=relaxed/simple;
	bh=D5S0hqKTvEVrGlWpPpsoJptV5qyI36AXoX+mj/w0qaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffEyAyquLYouQ6JixcOKr9Q8FnpmDA5kXwTLFRwJGfK48VzrB5CZX+4e8IYwCQuGA/JXd/uyyjAf3LHwc65y0B175dMowpS9qBnjBgfaEM7Djz3xKjDzoTUjwntb8+VwXp1WvZ4hlItLg4CdwI0Nn/ovVKPttzdJEOIePAXYvZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4TKrLF11Y2z5tv0
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 18:19:49 +0100 (CET)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4TKrL34Bjdz5tlC;
	Wed, 24 Jan 2024 18:19:39 +0100 (CET)
Message-ID: <dfb582cf-b1e4-414d-bfe1-0f93d910ec54@kdbg.org>
Date: Wed, 24 Jan 2024 18:19:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] revision: Implement `git log --merge` also for
 rebase/cherry_pick/revert
To: Elijah Newren <newren@gmail.com>
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>, gitster@pobox.com,
 git@vger.kernel.org, phillip.wood123@gmail.com
References: <xmqqzfxa9usx.fsf@gitster.g>
 <20240117081405.14012-1-mi.al.lohmann@gmail.com>
 <20240117081405.14012-2-mi.al.lohmann@gmail.com>
 <CABPp-BE4zqRX=wd5EBj96hzCS8V73QpdN-2pCpv7qMdkpkX93w@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CABPp-BE4zqRX=wd5EBj96hzCS8V73QpdN-2pCpv7qMdkpkX93w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 24.01.24 um 08:06 schrieb Elijah Newren:
> On Wed, Jan 17, 2024 at 12:14 AM Michael Lohmann
>> +static const char *lookup_other_head(struct object_id *oid)
>> +{
>> +       int i;
>> +       static const char *const other_head[] = {
>> +               "MERGE_HEAD", "REBASE_HEAD", "CHERRY_PICK_HEAD", "REVERT_HEAD"
>> +       };
>> +
>> +       for (i = 0; i < ARRAY_SIZE(other_head); i++)
>> +               if (!read_ref_full(other_head[i],
>> +                               RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>> +                               oid, NULL)) {
>> +                       if (is_null_oid(oid))
>> +                               die("%s is a symbolic ref???", other_head[i]);
>> +                       return other_head[i];
>> +               }
>> +
>> +       die("--merge without MERGE_HEAD, REBASE_HEAD, CHERRY_PICK_HEAD or REVERT_HEAD?");
>> +}
...
> Also, what about cases where users do a cherry-pick in the middle of a
> rebase, so that both REBASE_HEAD and CHERRY_PICK_HEAD exist?  What
> then?

Good point! IMO, REBASE_HEAD should have lower precedence than all the
other *_HEADs. It would mean to reorder the entries:

	static const char *const other_head[] = {
		"MERGE_HEAD", "CHERRY_PICK_HEAD", "REVERT_HEAD", "REBASE_HEAD"
	};

(and perhaps adjust the error message, too).

-- Hannes

