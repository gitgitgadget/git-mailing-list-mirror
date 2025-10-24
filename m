Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318A1328613
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761327200; cv=none; b=ri1nlUD8DtL/OCjO75/VAVBbsqTbjTlurClwGp0W9ZNFcD1LiIJ0w7ZoiVG4NDev3Rt1198K10NKAysMUNTP2X6NyqhsoozUz4/n8nwSDLoTX4SNwW6AxDiyvvldvZtMhaCnLaHWh57ABR3WkIviiNtTtzL2/eb+olumwVZkIso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761327200; c=relaxed/simple;
	bh=TuzCOVyKmW0OC4TGluM4M6Y4CI0Mk+Idmv8VxDuINbo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=OTow43lOgWRKzEp7lQKc0w7fTNaOQHgFDBIdl6sOp8kngy5pXd0xluFQ3MN6WT70cHheCYCmXye3FPa1nggSRzjMbIpJVA209ZtNEJiaALyZ6ps1O8PDIplp9xq61Qjb+C4s3NaSFpvVVq7aT3TAwAqGHHoxlCIb7GtKtdPEuEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 59OHX74k785831
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 17:33:07 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>
Cc: "'D. Ben Knoble'" <ben.knoble@gmail.com>, <git@vger.kernel.org>
References: <012601dc42ce$a1adcb50$e50961f0$@nexbridge.com> <CALnO6CD8JU2qMCnC=qQmNOV6Wy1ZnveT3tRxUz1E0LVMj5oU9w@mail.gmail.com> <013201dc42d5$07a71550$16f53ff0$@nexbridge.com> <20251022092708.GE853931@coredump.intra.peff.net> <018701dc435f$f1dc1a00$d5944e00$@nexbridge.com> <20251023124837.GB1163932@coredump.intra.peff.net>
In-Reply-To: <20251023124837.GB1163932@coredump.intra.peff.net>
Subject: RE: [BUG] Strange git notes completion behaviour
Date: Fri, 24 Oct 2025 13:33:02 -0400
Organization: Nexbridge Inc.
Message-ID: <029a01dc450c$4318dfe0$c94a9fa0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHjmO9AERlM/1ZhxKXB7Q1XH17MtgEgLITOApwjn/kCVAmtvwG1oGkTAur+K2y0bVr7cA==
X-Antivirus: Norton (VPS 251024-10, 10/24/2025), Outbound message
X-Antivirus-Status: Clean

On October 23, 2025 8:49 AM, Jeff King wrote:
>On Wed, Oct 22, 2025 at 10:27:01AM -0400, rsbecker@nexbridge.com wrote:
>
>> I tried running with --no-pager. No difference. Interesting:
>>
>> git show $(git notes list HEAD)
>>
>> works correctly with no error report (from inside gdb), while the run =
of
>>
>> git --no-pager notes show HEAD
>>
>> still reports:
>> Run till exit from #0  main (argc=3D5, argv=3D0x811d000)
>>     at =
/home/jenkinsbuild/.jenkins/workspace/Git_Pipeline/common-main.c:8
>> Process (0,896) exited with code 037777777764.
>>
>> Is there a path where just an implied return is used? I have seen the =
optimizer
>> return whatever is in an x86 register - rsx and rsi are both 12 at =
git.c:982
>> - on occasion.
>
>Not that I know of (and I'd expect the compiler to complain if we ever
>had a code path that didn't return).  It is weird that git-show =
produces
>the right exit code, but our execvp() of it does not. In your place I
>guess I'd try walking through the debugger all the way down to the exec
>system call (and ideally convincing the debugger to keep going in the
>exec'd process image).

What I found is this:

Git drops into sane_execvp and converts the

git notes show HEAD

to

git show 1aa950256829721750e809788e7b858db79a934a.

When execvp is called, it immediately fails with a -12 - not returned,
just terminates. The -12 is an NonStop-specific execvp error indicating
the process failed because the object is invalid (strange and likely
an artifact rather than a real problem).

When I use the arguments as presented to execvp via bash directly, I =
get:

error: no note found for object =
1aa950256829721750e809788e7b858db79a934a.

and gdb correctly reports

Process (0,709) exited with code 01.

There is no commit with that hash. HEAD is actually =
3fc1917e0e69b23265f5c49f90fdb6f4ed98f4a3
so git show is correctly failing. This is Indicating that notes is not =
invoking git
correctly.

