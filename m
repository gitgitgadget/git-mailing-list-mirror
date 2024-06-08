Received: from mail.ekdawn.com (mail.ekdawn.com [159.69.120.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1880725740
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.120.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717839853; cv=none; b=gCNPZsIYvuMLJE0MdARRYeg6g7ypqN3EM8Q24hBxhzD/ByLw0KIk0YJAhOy0HTgDavTj9+2cr1idRzNOxmchTTw/dLSfesHA6RnHlDCNsymUg1B30UQsDW+vuWP+Tjxo5FXuAGQ+wTSFWyoc/Fip9CNrYvjzVaNMoTxZ2kpSxVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717839853; c=relaxed/simple;
	bh=+VCHz7Vo+DjRiFIlBqjgPZezsQ7LBtfZw5VRz2UZXto=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rggBFiZLi/3layAeT0qYWwifY7M5tImUFcmQtnt6a/tKjoEfLjo2Yl41JnIAK9tLmDicZrIEG0C+ftV5DS2NwEq9zWm0yz6UiTQMgMw6UfOu55jeGZ3wrumWxHL7yTr0SF6GgmhqnsXlX/yNXmsdI9pKN8T1LXybGevJSkAsMnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=pass smtp.mailfrom=horse64.org; arc=none smtp.client-ip=159.69.120.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horse64.org
Received: from [10.42.0.97] (dynamic-176-007-192-159.176.7.pool.telefonica.de [176.7.192.159])
	by mail.ekdawn.com (Postfix) with ESMTPSA id AB5A918574E;
	Sat,  8 Jun 2024 09:43:05 +0000 (UTC)
Message-ID: <7de78f3d-f174-4bf6-837f-9c90bf935d21@horse64.org>
Date: Sat, 8 Jun 2024 11:44:09 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
From: ellie <el@horse64.org>
To: Jeff King <peff@peff.net>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org
References: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org>
 <0be201dab933$17c02530$47406f90$@nexbridge.com>
 <fdb869ef-4ce9-4859-9e36-445fd9200776@horse64.org>
 <0beb01dab93b$c01dfa10$4059ee30$@nexbridge.com>
 <200c3bd2-6aa9-4bb2-8eda-881bb62cd064@horse64.org>
 <20240608084323.GB2390433@coredump.intra.peff.net>
 <bc030171-70fa-41cf-945a-2d20bf237372@horse64.org>
Content-Language: en-US
In-Reply-To: <bc030171-70fa-41cf-945a-2d20bf237372@horse64.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Another idea that probably is silly in some way too: couldn't after the 
first error, git automatically start over and do this whole --depth=1 
followed by --deepen... automatically? I feel like anything that 
wouldn't require knowing and manually doing that process would be an 
improvement for people affected often by this.

Regards,

Ellie

On 6/8/24 11:40 AM, ellie wrote:
> Sorry if I'm misunderstanding, and I assume this is a naive suggestion 
> that may not work in some way: but couldn't git somehow retain all the 
> objects it already has fully downloaded cached? And then otherwise start 
> over cleanly (and automatically), but just get the objects it already 
> has from the local cache? In practice, that might already be enough to 
> get through a longer clone despite occasional hiccups.
> 
> Sorry, I'm really not qualified to make good suggestions, it's just that 
> the current situation feels frustrating as an outside user.
> 
> Regards,
> 
> Ellie
> 
> On 6/8/24 10:43 AM, Jeff King wrote:
>> On Sat, Jun 08, 2024 at 02:46:38AM +0200, ellie wrote:
>>
>>> The deepening worked perfectly, thank you so much! I hope a resume will
>>> still be considered however, if even just to help out newcomers.
>>
>> Because the packfile to send the user is created on the fly, making a
>> clone fully resumable is tricky (a second clone may get an equivalent
>> but slightly different pack due to new objects entering the repo, or
>> even raciness between threads).
>>
>> One strategy people have worked on is for servers to point clients at
>> static packfiles (which _do_ remain byte-for-byte identical, and can be
>> resumed) to get some of the objects. But it requires some scheme on the
>> server side to decide when and how to create those packfiles. So while
>> there is support inside Git itself for this idea (both on the server and
>> client side), I don't know of any servers where it is in active use.
>>
>> -Peff
