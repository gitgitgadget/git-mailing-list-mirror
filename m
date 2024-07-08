Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A10EC7
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452731; cv=none; b=qFGJPQVNmWEwIfDtJnvWsfxHlsf/iz0bGc95h9ehHHVKHZ/i1XOVdK/D4Lm3r0v3/pJJNcfgddivLl9YDTPP0d0QTRPAz+NUmwtGVUd7d2EmHHs25O0K9Gwv0bOVORzCvQDBNlVVS+6mRz9WBnojebE79uXe0Vy4NWQ398/aKVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452731; c=relaxed/simple;
	bh=GC9mrlf8HD5QWScFtGi56GTUgqPrYmcZlxWZ8Z3QJrY=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=qez59IOgwMqogM9088oUuAJgeG9RRkOSolh496zj4CCZOlRPjmkEkOfDtiwPRyKLP3hksRX+JsvzBOD9fky07B+vPX4EiKL/1TXl+3/9bepVBz2Jj061JzXPnLY1TTd6/UKM+gKT7k6T7gsZyzNWWhvYxQNcg9/DbQFhfSv2dQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 468FVxvP3217104
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 15:32:00 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'ellie'" <el@horse64.org>, <git@vger.kernel.org>
References: <20240708143239.vq47dg7mgh33hykf@carbon> <2e10070f-2720-4d70-aa15-d4c008cc57bf@horse64.org>
In-Reply-To: <2e10070f-2720-4d70-aa15-d4c008cc57bf@horse64.org>
Subject: RE: With big repos and slower connections, git clone can be hard to work with
Date: Mon, 8 Jul 2024 11:31:53 -0400
Organization: Nexbridge Inc.
Message-ID: <001301dad14b$f8f0e460$ead2ad20$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIOcuJNQOiJMkQZvscuPTyr1NeGYwK0gGVSsXAMllA=
Content-Language: en-ca

On Monday, July 8, 2024 11:15 AM, ellie wrote:
>On 7/8/24 4:32 PM, Konstantin Khomoutov wrote:
>> On Mon, Jul 08, 2024 at 04:28:25AM +0200, ellie wrote:
>>
>> [...]
>>> error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly:
>>> CANCEL (err 8)
>> [...]
>>> It seems extremely unlikely to me to be possibly an ISP issue, for
>>> which I already listed the reasons. An additional one is HTTPS
>>> downloads from github outside of git, e.g. from zip archives, for =
way
>>> larger files work fine as well.
>> [...]
>>
>> What if you explicitly disable HTTP/2 when cloning?
>>
>>    git -c http.version=3DHTTP/1.1 clone ...
>>
>> should probably do this.
>>
>
>Thanks for the idea! I tested it:
>
>$  git -c http.version=3DHTTP/1.1 clone =
https://github.com/maliit/keyboard
>maliit-keyboard
>Cloning into 'maliit-keyboard'...
>remote: Enumerating objects: 23243, done.
>remote: Counting objects: 100% (464/464), done.
>remote: Compressing objects: 100% (207/207), done.
>error: RPC failed; curl 18 transfer closed with outstanding read data =
remaining
>error: 5361 bytes of body are still expected
>fetch-pack: unexpected disconnect while reading sideband packet
>fatal: early EOF
>fatal: fetch-pack: invalid index-pack output
>
>Sadly, it seems like the error is only slightly different. It was still =
worth a try. I
>contacted GitHub support a while ago but it got stuck. If there were =
resume
>available such hiccups wouldn't matter, I hope that explains why I =
suggested that
>feature.

I don't really understand what "it got stuck" means. Is that a =
colloquialism? What got stuck? That case at GitHub?

Have you tried git config --global http.postBuffer 524288000

It might help. The feature being requesting, even if possible, will =
probably not happen quickly, unless someone has a solid and simple =
design for this. That is why we are trying to figure out the root cause =
of your situation, which is not clear to me as to what exactly is =
failing (possibly a buffer size issue, if this is consistently failing). =
My experience, as I said before, on these symptoms, is a proxy (even a =
local one) that is in the way. If you have your linux instance on a VM, =
the hypervisor may not be configured correctly. Lack of further evidence =
(all we really have is the curl RPC failure) makes diagnosing this very =
difficult.

