Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9768AAD4C
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 01:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.144.192.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718068200; cv=none; b=cslYh9g/t7Wt3YMxi5OusVAjLRHeS4spaUlt9hqp1w9oqoAurT480Gkoq2KMLk47Rcmgd+XaxtkTMi1DsyMtf+ZBdzV4zaGAahU7FMMyq7zXy9uDoo95iRF/4SOcDXxcTC1i/3Gd66DmuLE0w9mts54w+PZHHUeC2LzCsEE5dT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718068200; c=relaxed/simple;
	bh=rr0bVxHQXbkYwimpFODYL/ARxe0k1YK+B3v/8/Wffu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCwOSc8ODHPDxz0PSODDp6CgnPIHepSOMPTIWvhh0hiBpn7NJj7eWPeJ77cUYDcbgIQbWMM9wxkPpKFIbwL/LhsB5/Bq9q3T98brbVbFmYxCiiiCYIEFLIqGpcXF888pbnbxQ0HFOlb6CT3+0/UKAxvrfr86S340RuC4+LhcsGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com; spf=pass smtp.mailfrom=rawbw.com; arc=none smtp.client-ip=198.144.192.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rawbw.com
Received: from [192.168.5.3] (c-98-42-44-116.hsd1.ca.comcast.net [98.42.44.116])
	(authenticated bits=0)
	by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 45B19rrN038248
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Mon, 10 Jun 2024 18:09:53 -0700 (PDT)
	(envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-98-42-44-116.hsd1.ca.comcast.net [98.42.44.116] claimed to be [192.168.5.3]
Message-ID: <8fdc76e2-3de2-4312-956c-2662336fa54d@rawbw.com>
Date: Mon, 10 Jun 2024 18:09:52 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] "git clean -df ." silently doesn't delete folders with
 stale .nfs* files
To: rsbecker@nexbridge.com, "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Git Mailing List'" <git@vger.kernel.org>
References: <ae862adb-1475-48e9-bd50-0c07dc42a520@rawbw.com>
 <xmqqwmmw1sev.fsf@gitster.g> <4ed426e4-beb6-45ed-b493-1e19c7c0511b@rawbw.com>
 <xmqqikygzdgk.fsf@gitster.g> <e8feffd0-ba6d-4aae-8c80-3d6482896b08@rawbw.com>
 <0ee501dabb91$aa2340a0$fe69c1e0$@nexbridge.com>
Content-Language: en-US
From: "'Yuri'" <yuri@rawbw.com>
In-Reply-To: <0ee501dabb91$aa2340a0$fe69c1e0$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/24 16:55, rsbecker@nexbridge.com wrote:
> I have tried to reproduce your situation using git 2.43.0 without 
> success. $ mkdir test $ cd test $ touch .nfs12309 $ git clean -df . 
> Removing .nfs12309 


"touch .nfs12309" isn't enough.


Here is a reliable way to reproduce the problem:
1. Have a git repository on an NFS disk.
2. mkdir xx
3. touch xx/x
4. tail -f xx/x &
5. rm xx/x
6. git clean -df .




The last operation reproduces the problem. The xx directory and the 
.nfsNNNN file in it stay without warnings.
The .nfsNNNN file is created by the NFS client when the xx/x file is 
removed.


Anybody with an NFS disk should be able to reproduce it.

FYI: Git generally warns about files that it can't remove because of 
permissions and special flags reasons.
But Git doesn't warn users about this situation with an NFS directory 
lock file.


Thanks,
Yuri


