Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456AC1E4AF
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718113750; cv=none; b=ljowbjqXwkhStqTpZn3fGNE6QvFGu+Yd04mVo+mmdiBhqXkueiBDfymoG++lgWRz34/smJg45vzMuq5OZ3NkjpLP5lT7rBn0NvJ5BNNUNIz5L0oNGqEItNFGaDLEThyC5jP/WEg6cTM5M08CfeQc2Tlay/XTSYvvFBdeRBUI8o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718113750; c=relaxed/simple;
	bh=OHi7+XBFgBIx7JgJfpDGYblloJjg1UvxfgU1MUkkalA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=oQ2/pjt0Kn7Q6lTpay47nx9KER3weSiXbFFXsacHnhsqXyjuYgqiPOfMN9I+6KXVfIq7wkQ545075Vo5AxUv9ptSWa9cBNhOwNubYe4VxblTH7ER/CFzPwxzNCP6HHDfcfqWtjB6B5nLZ+OV3u87N4ZV9S8QJf4+bUruZm9RMD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 45BDmmFR1933685
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 13:48:49 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>, "'Yuri'" <yuri@rawbw.com>
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Git Mailing List'" <git@vger.kernel.org>
References: <ae862adb-1475-48e9-bd50-0c07dc42a520@rawbw.com> <xmqqwmmw1sev.fsf@gitster.g> <4ed426e4-beb6-45ed-b493-1e19c7c0511b@rawbw.com> <xmqqikygzdgk.fsf@gitster.g> <e8feffd0-ba6d-4aae-8c80-3d6482896b08@rawbw.com> <0ee501dabb91$aa2340a0$fe69c1e0$@nexbridge.com> <8fdc76e2-3de2-4312-956c-2662336fa54d@rawbw.com> <20240611064847.GC3248245@coredump.intra.peff.net>
In-Reply-To: <20240611064847.GC3248245@coredump.intra.peff.net>
Subject: RE: [BUG] "git clean -df ." silently doesn't delete folders with stale .nfs* files
Date: Tue, 11 Jun 2024 09:48:43 -0400
Organization: Nexbridge Inc.
Message-ID: <102101dabc06$16dfead0$449fc070$@nexbridge.com>
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
Thread-Index: AQETpLHCLpFQr2QiGEI4aCI0uZSumAGFDyW3ASm+LNUCETu8/AHXUzFkAMoJcpkCHbeU6QEt3DN5svtaVkA=
Content-Language: en-ca

On Tuesday, June 11, 2024 2:49 AM, Jeff King wrote:
>On Mon, Jun 10, 2024 at 06:09:52PM -0700, 'Yuri' wrote:
>
>> "touch .nfs12309" isn't enough.
>>
>> Here is a reliable way to reproduce the problem:
>> 1. Have a git repository on an NFS disk.
>> 2. mkdir xx
>> 3. touch xx/x
>> 4. tail -f xx/x &
>> 5. rm xx/x
>> 6. git clean -df .
>>
>> The last operation reproduces the problem. The xx directory and the
>> .nfsNNNN file in it stay without warnings.
>> The .nfsNNNN file is created by the NFS client when the xx/x file is
>> removed.
>
>That is not the behavior I get. I see:
>
>  $ git clean -df .
>  warning: failed to remove xx/.nfs0000000002c8197f00000002: Device or
>resource busy
>
>Which makes sense, since the kernel fails our unlink() call. Maybe your =
system
>behaves differently at the syscall level?
>
>This is a pretty standard Debian system with kernel 6.8.12. I set up =
the NFS mount
>with:
>
>   mkdir /mnt/{server,client}
>   exportfs -o rw,sync 127.0.0.1:/mnt/server
>   mount -t nfs 127.0.0.1:/mnt/server /mnt/client
>
>and then made the repository in /mnt/client. "mount" tells me it's =
using nfs4.
>
>Running "git clean" on the server side does remove the files (no =
warning, but the
>directories are actually removed).

It has been a while since I did a self-mount in NFS, but I do not think =
that will reproduce the issue. The mounts have to be on different =
servers from the client to experience this silly rename situation. On =
self-mount, IIRC, the client is aware that it is on its own machine and =
will not try to detect the situation.=20

