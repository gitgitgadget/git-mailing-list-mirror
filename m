Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7133130E3A
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.68.5.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980466; cv=none; b=bjtPA+4vItYyqn/jwJor74ESXBIx2An6kgPOWC+PjK3aVB0hYHdy4bfIfNngVnybe+g5yjoFhQHIyupbb0Vng0A/E3vZWn06kSAKtgLABMoCvCodcA49p1py57R/oAr5WPMC52O9gHSVdUKxtzhJ8+NuhA7OpoJUevdP7DC/+rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980466; c=relaxed/simple;
	bh=gCIvTA7ig6c3DMdJycI0cWdo8oj29/w3Rx+MXnEeEFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwgUKiyTzuUWBDjgtJZxoRBvX31JfU2SSj31CwU5DNQijbbNK+s04v/EMu/94kXQdMtY0FoCj5mKNM8Bxlh8qe6v+1FhWO/VBeecjW31/Fte2JQ9GnSLvhyt9iwJKyiEnlFDS1I678oYeddgD9e8gTUx+LITAYeX0wFPRr/RsFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com; spf=fail smtp.mailfrom=jeffhostetler.com; arc=none smtp.client-ip=209.68.5.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jeffhostetler.com
Received: from siwi.pair.com (localhost [127.0.0.1])
	by siwi.pair.com (Postfix) with ESMTP id CEBBFCA1276;
	Mon, 26 Feb 2024 15:47:42 -0500 (EST)
Received: from [IPV6:2600:1700:840:e768:b846:2f3e:cac1:b0eb] (unknown [IPv6:2600:1700:840:e768:b846:2f3e:cac1:b0eb])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 8A45CCC83BB;
	Mon, 26 Feb 2024 15:47:42 -0500 (EST)
Message-ID: <aaf53a10-2965-0284-120d-c59685c5090c@jeffhostetler.com>
Date: Mon, 26 Feb 2024 15:47:41 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 14/16] fsmonitor: support case-insensitive events
Content-Language: en-US
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
 Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Jeff Hostetler <jeffhostetler@github.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
 <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
 <288f3f4e54e98a68d72e97125b1520605c138c3c.1708658300.git.gitgitgadget@gmail.com>
 <20240225131023.GC1952@tb-raspi4>
From: Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <20240225131023.GC1952@tb-raspi4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199



On 2/25/24 8:10 AM, Torsten Bögershausen wrote:
>> +	if (!memcmp(name, canonical_path.buf, canonical_path.len)) {
>> +		strbuf_release(&canonical_path);
>> +		/*
>> +		 * NEEDSWORK: Our caller already tried an exact match
>> +		 * and failed to find one.  They called us to do an
>> +		 * ICASE match, so we should never get an exact match,
>> +		 * so we could promote this to a BUG() here if we
>> +		 * wanted to.  It doesn't hurt anything to just return
>> +		 * 0 and go on becaus we should never get here.  Or we
>> +		 * could just get rid of the memcmp() and this "if"
>> +		 * clause completely.
>> +		 */
>> +		return 0; /* should not happen */
> 
> In very very theory, there may be a race-condition,
> when a directory is renamed very fast, more than once.
> I don't think, that the "it did not match exactly, but
> now it matches" is a problem.
> Question: Does it make sense to just remove this ?
> And, may be, find out that the "corrected spelling (tm)"
> of "DIR1" is not "dir1", neither "Dir1", but, exactly, "DIR1" ?
> Would that be a problem ?
> 

I just meant that the dir-name-hash that we computed when
we loaded the index found an exact-case match here that
wasn't found when called index_name_pos() and the negative
"pos" didn't point to this exact-case prefix.  This should
not happen.

Yeah I didn't think it should be a fatal condition, but
since it shouldn't happen, we can make it a BUG() and see.

Jeff
