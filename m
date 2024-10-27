Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1961E535
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 21:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730065025; cv=none; b=lD2ez2N6s3/ZDqC+N6PRlpohMLGuC9RV1+03wXr2Zgq9tgBZSma0Abdw07/nFBbj8/xE+y/FioEEta9MrWs3F9LEQ60utTC26cc+dPZeNmd1jbIb7M6xx3anEa5xu4dHjj/Fed7hAwYql1QbFJnxbBO+J3Pvq33rhcgC75G/Ec0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730065025; c=relaxed/simple;
	bh=Gjs2YDGszPus6ZP9evZ/FIiacV3lto49ZKU7GCnRweo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDcVoTkjKR4K/c7rmuADgMXzAlxjF4roeN7KVzpdrAzwUJqB9YTJKzbwd8ZA9icOzKhG9P9XhwtOBFyuvdx5bT71GQBfTGsbPL8LyRvdD3Zrfxrl38aZEvNqruCHWyI1JC1vtl5C9BKC0T4RxZo8XXLO1WP+VEN4POgbDJjQJd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4Xc8x42Sp2zRpKk;
	Sun, 27 Oct 2024 22:36:55 +0100 (CET)
Message-ID: <c044ea3c-2f8c-45c1-99cf-17d9dad5b55f@kdbg.org>
Date: Sun, 27 Oct 2024 22:36:55 +0100
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
 <49619b52-0fea-4179-a829-7ec4a6945055@kdbg.org> <Zx54B6FdGprtH0HV@pks.im>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <Zx54B6FdGprtH0HV@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 27.10.24 um 18:27 schrieb Patrick Steinhardt:
> On Sun, Oct 27, 2024 at 05:31:00PM +0100, Johannes Sixt wrote:
>> Am 27.10.24 um 16:38 schrieb Patrick Steinhardt:
>>> On Sun, Oct 27, 2024 at 02:23:28PM +0100, Johannes Sixt wrote:
>>>> Am 24.10.24 um 13:46 schrieb Patrick Steinhardt:
>>>>> Windows 10 has introduced the `FILE_RENAME_FLAG_POSIX_SEMANTICS` flag
>>>>> that allows us to fix this usecase [1]. When set, it is possible to
>>>>> rename a file over a preexisting file even when the target file still
>>>>> has handles open. Those handles must have been opened with the
>>>>> `FILE_SHARE_DELETE` flag, which we have ensured in the preceding
>>>>> commits.
>>>>>> Careful readers might have noticed that [1] does not mention the above
>>>>> flag, but instead mentions `FILE_RENAME_POSIX_SEMANTICS`. This flag is
>>>>> not for use with `SetFileInformationByHandle()` though, which is what we
>>>>> use. And while the `FILE_RENAME_FLAG_POSIX_SEMANTICS` flag exists, it is
>>>>> not documented on [2] or anywhere else as far as I can tell.
>>>>
>>>> The Windows 10 SDK defines FILE_RENAME_FLAG_REPLACE_IF_EXISTS and
>>>> FILE_RENAME_FLAG_POSIX_SEMANTICS for SetFileInformationByHandle(). That
>>>> the documentation lacks "_FLAG_" in the names must be an error in the
>>>> documentation.
>>>>
>>>> I found the mention of FILE_RENAME_POSIX_SEMANTICS quite distracting,
>>>> because it is a flag to be used with CreateFileW() and basically only
>>>> has to do with case-sensitivity, but nothing with POSIX semantics of
>>>> renaming.
>>>
>>> I'd still prefer to mention this, because otherwise an astute reader
>>> might notice that I'm using a different flag name than what is
>>> documented in the docs and figure out that I defined the wrong flag
>>> name.
>>
>> Ah, I was confused twice here. First, the documentation that you cite[*]
>> mentions FILE_RENAME_POSIX_SEMANTICS, but the name does not exist at
>> all. There does exist FILE_RENAME_FLAG_POSIX_SEMANTICS. The
>> documentation is just wrong. And in my earlier comment I copied the
>> inexistent flag name.
>>
>> But I meant to cite this flag: FILE_FLAG_POSIX_SEMANTICS (no "RENAME").
>> It exists and is for CreateFileW().
>>
>> Perhaps you also meant cite the latter one as the flag that "is not for
>> use with `SetFileInformationByHandle()`"?
>>
>> At any rate, the paragraph as written isn't correct.
> 
> I think I'm missing something. That's what the paragraph says:
> 
>     Careful readers might have noticed that [1] does not mention the above
>     flag, but instead mentions `FILE_RENAME_POSIX_SEMANTICS`. This flag is
>     not for use with `SetFileInformationByHandle()` though, which is what we
>     use. And while the `FILE_RENAME_FLAG_POSIX_SEMANTICS` flag exists, it is
>     not documented on [2] or anywhere else as far as I can tell.
> 
> And I'd claim it is correct.
> 
> `FILE_RENAME_POSIX_SEMANTICS` exists, this it is not a documentation
> error. It is at a lower level than `FILE_RENAME_FLAG_POSIX_SEMANTICS`,
> the documentation at [1] refers to "ntifs.h", which is part of the
> Windows Driver Kit interfaces. So it is not supposed to be used with
> `SetFileInformationByHandle()`, but with `FtlSetInformationFile()` [2],
> which _also_ has a separate `FILE_RENAME_INFO` structure that looks the
> same as `FILE_RENAME_INFO` defined for `SetFileInformationByHandle()`.
> The only difference as far as I can tell is that the flags used for
> these structures have slightly different names.
> 
> Now I totally get your confusion -- I have been extremely confused by
> all of this, as well. It certainly is a documentation error that the
> respective `FILE_RENAME_FLAG_POSIX_SEMANTICS` is undocumented, but
> having proper docs for this is rather important such that the reader
> knows what its behaviour is. So I have no other choice than to link to
> the ntifs interfaces, as it documents the actual behaviour, even though
> it lives in a different part of the Windows APIs.
> > Patrick
> 
> [1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/ntifs/ns-ntifs-_file_rename_information
> [2]: https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/fltkernel/nf-fltkernel-fltsetinformationfile

OK, then let's leave the text as it is.

Thanks,
-- Hannes

