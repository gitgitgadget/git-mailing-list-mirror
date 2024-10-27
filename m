Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D6C13B
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730046670; cv=none; b=hvgn6lx7CC5bW43eprwOK00VXQv4jl0se1EYKQddp3DL/PBd6SGkE9OgqvUAnVeeQW4CHfHUjAU6PR8slmaBrnB9mr1fGxrYcMgqqLIQ6EkS4Mx9v9rEOpGm4FvByY4fgmETgzXAXknlO1cw6ONw7VMxrkQeoloters6PbXfdQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730046670; c=relaxed/simple;
	bh=RDMGdVoqzZjhN/5KnlCf7oPsXd3cee7LtXWsnYgI+IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P73ajjpiEwoXidI6xXN/+g4jyEfSJu8xN6TfX7NH3uqYGttDyTnI2rdi0FY+kFzpp9hy8Ywfeglt7/Jaa9HfRF+cFfKpUljVk0mI2RhAKWsAfNSVU70WonEtzozNvj67E8GI8UZO+JN289CuK4juFhMFJIZjGBdCl89s7VuanOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Xc2856sc7zRpKr;
	Sun, 27 Oct 2024 17:31:00 +0100 (CET)
Message-ID: <49619b52-0fea-4179-a829-7ec4a6945055@kdbg.org>
Date: Sun, 27 Oct 2024 17:31:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] compat/mingw: support POSIX semantics for atomic
 renames
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>,
 Taylor Blau <me@ttaylorr.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <cover.1729695349.git.ps@pks.im> <cover.1729770140.git.ps@pks.im>
 <ee1e92e593e35f3888e3e47b6f603c04a1652ec6.1729770140.git.ps@pks.im>
 <542b306a-523d-424b-bc9f-c63bb7040beb@kdbg.org> <Zx5eg2SkHMmNhQRh@pks.im>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <Zx5eg2SkHMmNhQRh@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 27.10.24 um 16:38 schrieb Patrick Steinhardt:
> On Sun, Oct 27, 2024 at 02:23:28PM +0100, Johannes Sixt wrote:
>> Am 24.10.24 um 13:46 schrieb Patrick Steinhardt:
>>> Windows 10 has introduced the `FILE_RENAME_FLAG_POSIX_SEMANTICS` flag
>>> that allows us to fix this usecase [1]. When set, it is possible to
>>> rename a file over a preexisting file even when the target file still
>>> has handles open. Those handles must have been opened with the
>>> `FILE_SHARE_DELETE` flag, which we have ensured in the preceding
>>> commits.
>>>> Careful readers might have noticed that [1] does not mention the above
>>> flag, but instead mentions `FILE_RENAME_POSIX_SEMANTICS`. This flag is
>>> not for use with `SetFileInformationByHandle()` though, which is what we
>>> use. And while the `FILE_RENAME_FLAG_POSIX_SEMANTICS` flag exists, it is
>>> not documented on [2] or anywhere else as far as I can tell.
>>
>> The Windows 10 SDK defines FILE_RENAME_FLAG_REPLACE_IF_EXISTS and
>> FILE_RENAME_FLAG_POSIX_SEMANTICS for SetFileInformationByHandle(). That
>> the documentation lacks "_FLAG_" in the names must be an error in the
>> documentation.
>>
>> I found the mention of FILE_RENAME_POSIX_SEMANTICS quite distracting,
>> because it is a flag to be used with CreateFileW() and basically only
>> has to do with case-sensitivity, but nothing with POSIX semantics of
>> renaming.
> 
> I'd still prefer to mention this, because otherwise an astute reader
> might notice that I'm using a different flag name than what is
> documented in the docs and figure out that I defined the wrong flag
> name.

Ah, I was confused twice here. First, the documentation that you cite[*]
mentions FILE_RENAME_POSIX_SEMANTICS, but the name does not exist at
all. There does exist FILE_RENAME_FLAG_POSIX_SEMANTICS. The
documentation is just wrong. And in my earlier comment I copied the
inexistent flag name.

But I meant to cite this flag: FILE_FLAG_POSIX_SEMANTICS (no "RENAME").
It exists and is for CreateFileW().

Perhaps you also meant cite the latter one as the flag that "is not for
use with `SetFileInformationByHandle()`"?

At any rate, the paragraph as written isn't correct.

[1]:
https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/ntifs/ns-ntifs-_file_rename_information

-- Hannes

