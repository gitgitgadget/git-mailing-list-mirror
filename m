Received: from mail.ekdawn.com (mail.ekdawn.com [159.69.120.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692081EA6F
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.120.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453743; cv=none; b=atA+Ygocw11mF0StnO/YuLG7YE7M/Z7uuwIxH9Yv6MQeUnEP5lyQjcWp0xt4QycOCMd7LNlMn5uwPeCWV3kmxuXB6DJLg5eEbUSM3wHJrgouCCJnNROwGIMZtzN5NW82SiWLPGShjlia/o94v716Dqbtd1powIhWjJ1FcOTDDIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453743; c=relaxed/simple;
	bh=D0RMHkJ2CRVJA9GeWHDtSmmUZnU80Wp0EtLIrqEkDLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QnNQQ1HfmOblLw83aiB02Z+35iutiYhiCmNubazMOgcsyV1AAtjVBhlLHIfZ+UCuQ4A8cD+W8LI2WHNIhsaHHQiJ7tblQfEBER3yTfmTzvgj2f+WZEy57mJukCFFDQHbVzs6E+AlBaze4EZ+F3v/RYrU0C3YhhDthD/wLlW9uaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=pass smtp.mailfrom=mail.ekdawn.com; arc=none smtp.client-ip=159.69.120.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ekdawn.com
Received: from [10.42.0.97] (dynamic-176-003-149-048.176.3.pool.telefonica.de [176.3.149.48])
	by mail.ekdawn.com (Postfix) with ESMTPSA id 5774218069C;
	Mon,  8 Jul 2024 15:48:57 +0000 (UTC)
Message-ID: <47799635-7832-4c89-b4d3-e992d49ad40c@horse64.org>
Date: Mon, 8 Jul 2024 17:48:56 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
To: rsbecker@nexbridge.com, git@vger.kernel.org
References: <20240708143239.vq47dg7mgh33hykf@carbon>
 <2e10070f-2720-4d70-aa15-d4c008cc57bf@horse64.org>
 <001301dad14b$f8f0e460$ead2ad20$@nexbridge.com>
Content-Language: en-US
From: ellie <el@horse64.org>
In-Reply-To: <001301dad14b$f8f0e460$ead2ad20$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/8/24 5:31 PM, rsbecker@nexbridge.com wrote:
> On Monday, July 8, 2024 11:15 AM, ellie wrote:
>> On 7/8/24 4:32 PM, Konstantin Khomoutov wrote:
>>> On Mon, Jul 08, 2024 at 04:28:25AM +0200, ellie wrote:
>>>
>>> [...]
>>>> error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly:
>>>> CANCEL (err 8)
>>> [...]
>>>> It seems extremely unlikely to me to be possibly an ISP issue, for
>>>> which I already listed the reasons. An additional one is HTTPS
>>>> downloads from github outside of git, e.g. from zip archives, for way
>>>> larger files work fine as well.
>>> [...]
>>>
>>> What if you explicitly disable HTTP/2 when cloning?
>>>
>>>     git -c http.version=HTTP/1.1 clone ...
>>>
>>> should probably do this.
>>>
>>
>> Thanks for the idea! I tested it:
>>
>> $  git -c http.version=HTTP/1.1 clone https://github.com/maliit/keyboard
>> maliit-keyboard
>> Cloning into 'maliit-keyboard'...
>> remote: Enumerating objects: 23243, done.
>> remote: Counting objects: 100% (464/464), done.
>> remote: Compressing objects: 100% (207/207), done.
>> error: RPC failed; curl 18 transfer closed with outstanding read data remaining
>> error: 5361 bytes of body are still expected
>> fetch-pack: unexpected disconnect while reading sideband packet
>> fatal: early EOF
>> fatal: fetch-pack: invalid index-pack output
>>
>> Sadly, it seems like the error is only slightly different. It was still worth a try. I
>> contacted GitHub support a while ago but it got stuck. If there were resume
>> available such hiccups wouldn't matter, I hope that explains why I suggested that
>> feature.
> 
> I don't really understand what "it got stuck" means. Is that a colloquialism? What got stuck? That case at GitHub?
> 
> Have you tried git config --global http.postBuffer 524288000
> 
> It might help. The feature being requesting, even if possible, will probably not happen quickly, unless someone has a solid and simple design for this. That is why we are trying to figure out the root cause of your situation, which is not clear to me as to what exactly is failing (possibly a buffer size issue, if this is consistently failing). My experience, as I said before, on these symptoms, is a proxy (even a local one) that is in the way. If you have your linux instance on a VM, the hypervisor may not be configured correctly. Lack of further evidence (all we really have is the curl RPC failure) makes diagnosing this very difficult.
> 

Thanks for your response, I appreciate it. I don't know what the hold up 
is for them, but I'm probably too unimportant, which I understand. I'm 
not an enterprise user, and >99% of others have faster connections than 
me which is perhaps why they dodge this config(?) issue.

And thanks for your suggestion, but sadly it seems to have no effect:

$ git config --global http.postBuffer 524288000
$ git -c http.version=HTTP/1.1 clone https://github.com/maliit/keyboard 
maliit-keyboard
Cloning into 'maliit-keyboard'...
remote: Enumerating objects: 23243, done.
remote: Counting objects: 100% (464/464), done.
remote: Compressing objects: 100% (207/207), done.
error: RPC failed; curl 18 transfer closed with outstanding read data 
remaining
error: 2444 bytes of body are still expected
fetch-pack: unexpected disconnect while reading sideband packet
fatal: early EOF
fatal: fetch-pack: invalid index-pack output

I'm doubtful this is solvable without either some resume or a fix from 
Github's end. But I can use SSH clone so this isn't urgent.

Resume just seemed like an idea that would also help others, and it's 
what makes many other internet services work much better for me.

Regards,

Ellie

