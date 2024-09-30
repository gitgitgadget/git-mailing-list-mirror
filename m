Received: from mail.ekdawn.com (mail.ekdawn.com [159.69.120.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DE31A2547
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.120.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727730501; cv=none; b=WuZC3fvsi1qQUbCvgUOWWszOIx+BEZtzUecA+l3keAm46oNdLTWnEfhYUAkzJHLwC/t+WHcRRPdyGPGVSGC+gO+8ZrJeeBWAwlaVKpvhuvbCLP7uw/7XVS2moayp+xIUtvdUPiRZWcYLwhS26BiYBx1uQebc/LgGb8DEA6i1nkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727730501; c=relaxed/simple;
	bh=2oYSDpXrLiWmWUXhYD5s6siJWm52JaP4pYk6TgZVn/U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=mLL1wMtsHQyz5eZFxACw8lQTDWSEh1PLQHG6BaBD0xPnF0JKJNpTKHMV7eFAgEfC4MC9Oy4UFWMPg6jtoUbHjggjnRMHeeKwbGul5m5mEAiFQcoBrE2FmKZ8XMosOdZ2cLUqyUTAQIfT1ubt2d1avXlAGO8YRiFjt72VTSUnHNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=pass smtp.mailfrom=mail.ekdawn.com; arc=none smtp.client-ip=159.69.120.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ekdawn.com
Received: from [10.42.0.106] (dynamic-176-003-143-253.176.3.pool.telefonica.de [176.3.143.253])
	by mail.ekdawn.com (Postfix) with ESMTPSA id 6B5B0188C6D
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 21:01:53 +0000 (UTC)
Message-ID: <55e7ddb5-327a-49f2-9f7c-e285ead69fb2@horse64.org>
Date: Mon, 30 Sep 2024 23:01:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
From: Ellie <el@horse64.org>
To: git@vger.kernel.org
References: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org>
Content-Language: en-US
In-Reply-To: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

My apologies for bringing this up again, but for what it's worth, this 
git repository I can't even clone at depth 1:

$ git clone --depth 1 https://github.com/alf632/terrain3dglitch
Cloning into 'terrain3dglitch'...
remote: Enumerating objects: 697, done.
remote: Counting objects: 100% (697/697), done.
remote: Compressing objects: 100% (439/439), done.
error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly: 
CANCEL (err 8)
error: 1754 bytes of body are still expected
fetch-pack: unexpected disconnect while reading sideband packet
fatal: early EOF
fatal: fetch-pack: invalid index-pack output

The problem seems to be possibly amplified by a timeout config issue 
from github's side, but also made worse by depth 1 already being 100MB+. 
Downloading that amount without resume isn't feasible for everyone. I'm 
assuming if I need all files and sub dirs, there's no workaround here?

I don't want to waste anybody's time, I'm just hoping to provide some 
further data points that in some edge cases, this can be impactful.

(And sorry if I did something silly while cloning and didn't realize.)

Regards,

Ellie

On 6/8/24 1:28 AM, ellie wrote:
> Dear git team,
> 
> I'm terribly sorry if this is the wrong place, but I'd like to suggest a 
> potential issue with "git clone".
> 
> The problem is that any sort of interruption or connection issue, no 
> matter how brief, causes the clone to stop and leave nothing behind:
> 
> $ git clone https://github.com/Nheko-Reborn/nheko
> Cloning into 'nheko'...
> remote: Enumerating objects: 43991, done.
> remote: Counting objects: 100% (6535/6535), done.
> remote: Compressing objects: 100% (1449/1449), done.
> error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly: 
> CANCEL (err 8)
> error: 2771 bytes of body are still expected
> fetch-pack: unexpected disconnect while reading sideband packet
> fatal: early EOF
> fatal: fetch-pack: invalid index-pack output
> $ cd nheko
> bash: cd: nheko: No such file or director
> 
> In my experience, this can be really impactful with 1. big repositories 
> and 2. unreliable internet - which I would argue isn't unheard of! E.g. 
> a developer may work via mobile connection on a business trip. The 
> result can even be that a repository is uncloneable for some users!
> 
> This has left me in the absurd situation where I was able to download a 
> tarball via HTTPS from the git hoster just fine, even way larger binary 
> release items, thanks to the browser's HTTPS resume. And yet a simple 
> git clone of the same project failed repeatedly.
> 
> My deepest apologies if I missed an option to fix or address this. But 
> summed up, please consider making git clone recover from hiccups.
> 
> Regards,
> 
> Ellie
> 
> PS: I've seen git hosters have apparent proxy bugs, like timing out 
> slower git clone connections from the server side even if the transfer 
> is ongoing. A git auto-resume would reduce the impact of that, too.
> 
> 
> 

