Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C506D34F25C
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143236; cv=none; b=YsW2iFPWXlwESRhzSJ+db/HhK1RpSHictONc3VVGdm8rWZnZ5rvtRoRmqBL4CvY5p92w0xqmi9vt1M+eMhNCLSCKz7jjZQkX819CJ4f0c2luIh/aw0dqEjDGm20VgMbn8LDrZAl0QmsjoH/b854X6FW9Blvspo51JKBkdShFzgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143236; c=relaxed/simple;
	bh=oVqm19bT+1HdIMlnc7upkjX9CzJe7pBpi/3rmEXUJlI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=u1FfMJn/UsbUI5gIDkkY19HDUrf0XMV0UUN7ltM9p+/gwTOhoY75qEZcQxY7pmt8QM42UHlUWwR5Ckx6raPa2jkBzSpC4Peg2OfAy9dm0eeOlHIBTa3lOUQWaxLauXJn8GXbdNCpERGLHiOGYFjJimnmAqPH9qKfGXFOl7OFDxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 59MER6iQ270987
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 14:27:07 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>
Cc: "'D. Ben Knoble'" <ben.knoble@gmail.com>, <git@vger.kernel.org>
References: <012601dc42ce$a1adcb50$e50961f0$@nexbridge.com> <CALnO6CD8JU2qMCnC=qQmNOV6Wy1ZnveT3tRxUz1E0LVMj5oU9w@mail.gmail.com> <013201dc42d5$07a71550$16f53ff0$@nexbridge.com> <20251022092708.GE853931@coredump.intra.peff.net>
In-Reply-To: <20251022092708.GE853931@coredump.intra.peff.net>
Subject: RE: [BUG] Strange git notes completion behaviour
Date: Wed, 22 Oct 2025 10:27:01 -0400
Organization: Nexbridge Inc.
Message-ID: <018701dc435f$f1dc1a00$d5944e00$@nexbridge.com>
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
Thread-Index: AQHjmO9AERlM/1ZhxKXB7Q1XH17MtgEgLITOApwjn/kCVAmtv7SPB1gg
X-Antivirus: Norton (VPS 251022-2, 10/22/2025), Outbound message
X-Antivirus-Status: Clean

On October 22, 2025 5:27 AM, Jeff King wrote:
>On Tue, Oct 21, 2025 at 05:52:38PM -0400, rsbecker@nexbridge.com wrote:
>
>> It is the exit code. When in gdb, the return from notes is -12 as
>> above. By the time It gets back to bash, the lower bytes are dropped
>> so I end up with a 0xFF, which bash thinks is a 0, so the exit code =
is
>> hidden from view. I tried the !!fn construct in a standard alone test =
program with
>no wisdom gained.
>
>I don't think the "!!fn()" line ever returns here. In the show() =
function of
>builtin/notes.c (which is what "fn" is pointing to for "git notes =
show"), we end up
>calling execv_git_cmd() to run "git show". So you are really seeing the =
exit code of
>something like:
>
>  git show $(git notes list HEAD)
>
>That in turn is propagating the return from show_blob_object(). Which =
I'd think
>would return "0" here, since it actually showed the blob, though it =
does look like it
>could return -1 in a few cases.
>
>Another possible point of confusion: that git-show invocation will run =
a pager. It's
>been a long time since I've looked at that code, but IIRC we try to =
preserve the exit
>code of the actual Git command (rather than the pager). But you might =
try:
>
>  git --no-pager notes show HEAD
>
>to see if that behaves differently. I couldn't reproduce the issue at =
all on my end.

I tried running with --no-pager. No difference. Interesting:

git show $(git notes list HEAD)

works correctly with no error report (from inside gdb), while the run of

git --no-pager notes show HEAD

still reports:
Run till exit from #0  main (argc=3D5, argv=3D0x811d000)
    at =
/home/jenkinsbuild/.jenkins/workspace/Git_Pipeline/common-main.c:8
Process (0,896) exited with code 037777777764.

Is there a path where just an implied return is used? I have seen the =
optimizer
return whatever is in an x86 register - rsx and rsi are both 12 at =
git.c:982
- on occasion.



