Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE12130AD5
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108180; cv=none; b=La1hivJFOUgRlss615xa6AAjCv3o0LYOmvxlQg2+Dpn0gzvOTnv0FDdvOMX5jsqOAN1dJnpCVCczhA+/YjjDXjzRjwTCD9ENxVkDjk4eqvYEBeRMD6TwOS4AUwm7/pTgEoIMZEM9cxYGTy0mc8TNbiom50tlMNAl7Btk/ic1L8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108180; c=relaxed/simple;
	bh=Rb7DLN1wagtnWotDCXRZ3UsjAeeHAiH7PkmkGp4FCmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTnb18j0LkUXgLDp+YN72HvIkwJXCh9H73e8Q3BvCKegNqU/ScfPyx8kZnEyuzFfGLB2R9Ok0yQpeR2ljHqFLpATGUY83KZif1wgem+XQrO+F8uyIfJLmzkuGHNHJeMr84KUvfusW/iH4KID0J2Saiz77phLTeMENP20Xtw6g5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <dev+git@drbeat.li>)
	id 1rb2xq-000000008ES-0Bbn
	for git@vger.kernel.org;
	Fri, 16 Feb 2024 19:29:34 +0100
Received: from [10.20.10.233] (port=40784 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <dev+git@drbeat.li>)
	id 1rb2xo-00AxPb-2i;
	Fri, 16 Feb 2024 19:29:32 +0100
Message-ID: <4a1d3618-cebe-4c20-89ce-c5dab51af21a@drbeat.li>
Date: Fri, 16 Feb 2024 19:29:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] completion: use awk for filtering the config entries
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20240216171046.927552-1-dev+git@drbeat.li>
 <xmqqr0hcjorg.fsf@gitster.g>
Content-Language: de-CH
From: Beat Bolli <dev+git@drbeat.li>
In-Reply-To: <xmqqr0hcjorg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

On 16.02.24 18:35, Junio C Hamano wrote:
> Beat Bolli <dev+git@drbeat.li> writes:
> 
>> Commits 1e0ee4087e (completion: add and use
>> __git_compute_first_level_config_vars_for_section, 2024-02-10) and
>> 6e32f718ff (completion: add and use
>> __git_compute_second_level_config_vars_for_section, 2024-02-10)
>> introduced new helpers for config completion.
>>
>> Both helpers use a pipeline of grep and awk to filter the list of config
>> entries. awk is perfectly capable of filtering, so let's eliminate the
>> grep process and move the filtering into the awk script.
> 
> Makes sense.  I wonder if we can have some simple script sanity
> checker that catches things like this, e.g., catting a single file
> into pipe, grep appearing upstream of awk or sed, etc.

Yes, there are quite a few cases of these in t/. I'm not sure if it's 
worth the churn, though. At least it would make the tests faster on 
Windows...

>> The "-E" grep option (extended syntax) was not necessary, as $section is
>> a single word.
>>
>> While at it, wrap the over-long lines to make them more readable.
>>
>> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
>> ---
>>
>> Junio, this goes on top of 'pb/complete-config' which is on next
>> currently.
> 
> Alternatively we could redo the topic, squashing this fix in, after
> the release when we rewind 'next'.

As you like. This commit would have to be split to apply to the two 
original commits.

>>   contrib/completion/git-completion.bash | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index 444b3efa63..fcf1afd75d 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2673,7 +2673,8 @@ __git_compute_first_level_config_vars_for_section ()
>>   	__git_compute_config_vars
>>   	local this_section="__git_first_level_config_vars_for_section_${section}"
>>   	test -n "${!this_section}" ||
>> -	printf -v "__git_first_level_config_vars_for_section_${section}" %s "$(echo "$__git_config_vars" | grep -E "^${section}\.[a-z]" | awk -F. '{print $2}')"
>> +	printf -v "__git_first_level_config_vars_for_section_${section}" %s \
>> +		"$(echo "$__git_config_vars" | awk -F. "/^${section}\.[a-z]/ { print \$2 }")"
>>   }
>>   
>>   __git_compute_second_level_config_vars_for_section ()
>> @@ -2682,7 +2683,8 @@ __git_compute_second_level_config_vars_for_section ()
>>   	__git_compute_config_vars_all
>>   	local this_section="__git_second_level_config_vars_for_section_${section}"
>>   	test -n "${!this_section}" ||
>> -	printf -v "__git_second_level_config_vars_for_section_${section}" %s "$(echo "$__git_config_vars_all" | grep -E "^${section}\.<" | awk -F. '{print $3}')"
>> +	printf -v "__git_second_level_config_vars_for_section_${section}" %s \
>> +		"$(echo "$__git_config_vars_all" | awk -F. "/^${section}\.</ { print \$3 }")"
>>   }
>>   
>>   __git_config_sections=

