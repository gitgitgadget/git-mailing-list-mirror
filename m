Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E60F7464
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752607189; cv=none; b=I/k6p+6R1q1XyCR+wdgeij+NFZxTLi9eKWvD1qV4o7HkhMdr/9lluR2/jau9T+Dzjru0kZH9UJEe1wv3WA7hSmggmuDtgh9Ly3pJCtm11ysff/gMQc95LZWs0ikycZeJfoK3ksdIeOQlkuwMzdj7cy83t/D2bu/WeWzsVTJvPRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752607189; c=relaxed/simple;
	bh=+RKQCs3I6JMuaHnNJjNIyXqUAFde6mDnntORP/NC/PM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTF8EnoVr/x7okai7EcNqUDcaco6+46Fy1FPfyDkDy+KQ8Ig7j7sW0sromP9ViOTgOFOf9CbHey27wV7iU0L+9fc5ShbemynuPUa7H4Tncvz61hek/Y1/vcvou26RaCNzckKnmmDqce+BE6RgONIEH+1Q5l0am0oPtqxHd3OjCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (089144220187.atnat0029.highway.webapn.at [89.144.220.187])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4bhTXC011ZzRpKw;
	Tue, 15 Jul 2025 21:19:38 +0200 (CEST)
Message-ID: <c543a644-8e58-4601-8a79-247cd5e124c5@kdbg.org>
Date: Tue, 15 Jul 2025 21:19:38 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] git-gui: Add support of SHA256 repo
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: git@vger.kernel.org
References: <20250703120430.17240-1-tiwai@suse.de>
 <b78bad36-d4ae-4d91-a72a-c3446e10d34b@kdbg.org> <87ecuha66p.wl-tiwai@suse.de>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <87ecuha66p.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 15.07.25 um 16:18 schrieb Takashi Iwai:
> On Mon, 14 Jul 2025 18:28:13 +0200,
>> BTW, there is a case
>>
>>       if {[regexp {^[0-9a-f]{1,39}$} $head]}
>>
>> around line 3217 in git-gui.sh.
> 
> Obviously I didn't look for numbers less than 40 :)
> I'll replace it, too.
> 
> But I don't understand why it matches up to only 39, not 40 in the
> code above.
> It seems trying to get the proper hash id if it's no full length id?
> If so, the check should be rather like
> 	if {![regexp {^[0-9a-f]{40}$} $head]}
> ??  It makes the conversion a bit simpler.

Obviously, the code wants to turn abbreviated hashes to full hashes.
That can be skipped if it is already the full length. I haven't analyzed
why this is needed or desirable.

>>> @@ -879,7 +881,7 @@ method _do_clone_full_end {ok} {
>>>  		if {[file exists [gitdir FETCH_HEAD]]} {
>>>  			set fd [open [gitdir FETCH_HEAD] r]
>>>  			while {[gets $fd line] >= 0} {
>>> -				if {[regexp "^(.{40})\t\t" $line line HEAD]} {
>>> +				if {[regexp [string map "@@ $hashlength" "^(.{@@})\t\t"] $line line HEAD]} {
>>>  					break
>>>  				}
>>>  			}
>>
>> The repository picker dialog runs before $hashlength is set. Therefore,
>> at the time that this function is executed, $hashlength is not available.
>>
>> This procedure can depend on the file format, which is to have \t\t
>> after the hash regardless of its length.
> 
> Oh that's bad.  I'll rewrite without the reference to $hashlength.
> I guess we can simply replace the above with a range check {40,64}.

Yes, let's do that.

I had something like

   set pos [string find \t\t $line]
   if {pos > 0} {
     set HEAD [string range $line 0 $pos]
     break
   }

in mind.

>>> @@ -986,7 +990,7 @@ method _readtree_wait {fd} {
>>>  
>>>  	# -- Run the post-checkout hook.
>>>  	#
>>> -	set fd_ph [githook_read post-checkout [string repeat 0 40] \
>>> +	set fd_ph [githook_read post-checkout [string repeat 0 $hashlength] \
>>
>> Yet another case where $nullid can be used.
> 
> But it's also in repo picker code, so we don't have $nullid yet?
> I'll rewrite somehow without $hashlength reference here, too.
> (e.g. use the length of "git-rev-parse HEAD" output that is called
> below)
> 
>>>  		[git rev-parse HEAD] 1]

Good call, and good idea for a fix!

-- Hannes

