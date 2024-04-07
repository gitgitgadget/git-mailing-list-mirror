Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B52582
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712526507; cv=none; b=NnWko1dQY23YV24aLIfeTwGnvTUN5CJ2knPXg4UrFPohVCwTnrf+wPy1XHJPDCtFuBbYqzAEe7QDq8DwHf2pHwCANnxAtd28Gaq6U7jZGu3Lg0NB6XgvLTQZxv9LQ5csucPYQXzMy+lXD5LNreF7r0B/nxV7E43zs/SPsSmAQQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712526507; c=relaxed/simple;
	bh=DedAmw2pk0vsAObwPzITuMLkKA9TYwzh5oAMlIxaIYE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=pa7t6ucR6fDy9MGA3oLCmBJtiiLxiHCh5QhY98lEazFYFZCyV6ujxD+hluEDcAAda6NM7B1BxiibzlGxglKzqUDOkKtIWS15CTgEcSZTXpIj8od+jHLTEF303QUl+DK8aZu76gZgFPEPw1zoU0uPcnap+MadMR5MMAcvoDjC/9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 437LmBlr3494204
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 7 Apr 2024 21:48:12 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Calvin Wan'" <calvinwan@google.com>
Cc: "'Git Mailing List'" <git@vger.kernel.org>
References: <CAFySSZAB09QB7U6UxntK2jRJF0df5R7YGnnLSsYc9MYhHsBhWA@mail.gmail.com> <ZhMRNxgwRJ25P4Ud@tapette.crustytoothpaste.net>
In-Reply-To: <ZhMRNxgwRJ25P4Ud@tapette.crustytoothpaste.net>
Subject: RE: [RFD] Libification proposal: separate internal and external interfaces
Date: Sun, 7 Apr 2024 17:48:07 -0400
Organization: Nexbridge Inc.
Message-ID: <037001da8935$4a6e3720$df4aa560$@nexbridge.com>
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
Thread-Index: AQLZD9zpP+uuLDZ/yLqfzLjinyux7QI7euh6r05s6cA=
Content-Language: en-ca

On Sunday, April 7, 2024 5:34 PM, brian m. carlson wrote:
>On 2024-04-02 at 14:18:51, Calvin Wan wrote:
>> Issues
>> ------
>> - Symbol name collisions: Since C doesn't have namespacing or other
>>   official name mangling mechanisms, all of the symbols inside of the
>>   library that aren't static are going to be at risk of colliding =
with
>>   symbols in the external project. This is especially a problem for
>>   common symbols like "error()".
>
>Yes, I think this is important.  We'll want to avoid the mistake that =
OpenSSL and Perl
>made by just exporting random symbols or using more than one namespace.
>
>We'll also need to consider that libgit2 is currently using `git_` and =
thus we'll either
>need to use something different or avoid conflicts.
>Perhaps `gitlib_` might be useful.

Or `GITL_`

>
>I might also suggest that we enable symbol versioning on platforms that =
support it,
>which is a nice way to avoid conflicts.
>
>> - Header files: This is actually several related problems:
>>   - Git codebase's header files assume that anything that's brought =
in
>>     via <git-compat-util.h> is available; this includes system header
>>     files, but also macro definitions, including ones that change how
>>     various headers behave. Example: _GNU_SOURCE and
>>     _FILE_OFFSET_BITS=3D64 cause headers like <unistd.h> to change
>>     behavior; _GNU_SOURCE makes it provide different/additional
>>     functionality, and _FILE_OFFSET_BITS=3D64 makes types like =
`off_t` be
>>     64-bit (on some platforms it might be 32-bit without this =
define).
>
>I should point out that _FILE_OFFSET_BITS=3D64 is effectively standard =
these days.
>Nobody wants their files limited to 2 GiB.

This is not the default on some platforms. It is still required but can =
be put into a knob.

>> - Tolerant. The header files probably won't be the first/only =
#include
>>   in the external project's translation unit, and they should still
>>   work. This means not using types like `off_t` or `struct stat` in =
the
>>   interfaces provided, since their sizes are dependent on the =
execution
>>   environment (what's been included, #defines, CFLAGS, etc.)
>
>Sure.  If we need a file size type, it should be something like =
`int64_t` or `uint64_t`
>and not `off_t`. Not all platforms have explicit 64-bit APIs compiles. =
NonStop and S/390 do require explicit controls to make this work.

This will result in compile warnings with some platforms with APIs that =
do use off_t for arguments and results.

>
>> - Limited Platform Compatibility. The external interfaces are able to
>>   assume that <stdint.h> and other C99 (or maybe even C11+)
>>   functionality exists and use it immediately, without weather =
balloons
>>   or #ifdefs. If some platform requires special handling, that =
platform
>>   isn't supported, at least initially.
>
>I think this is fine.  It's 2024.  We should assume that C11 (a =
13-year-old spec) is
>available and so is POSIX 1003.1-2008 (except for Windows).  We may =
want to
>have a nice `#ifdef __STDC__ < 200112L` (and a similar check for POSIX) =
to just
>produce an `#error` if the system is too old.

I wish this were the case. I have 2 years before C11 is guaranteed to be =
available on platforms that I maintain. Can we wait until mid-late 2025 =
before doing this? I do not want to lose access to git.

>We should therefore also assume that threading is available because =
POSIX 1003.1-
>2008 requires it as part of the base specification (and Windows =
obviously also
>supports it).  Because this is a library, we'll want to avoid =
interfaces that are clearly
>not thread safe and document the requirements for thread safety (either =
that the
>object must be externally synchronized or that it is internally =
synchronized).

This is not a particularly good assumption. Some architectures do not =
support kernel-level threading. PUT threading is possible on some =
platforms but attempts to port git to PUT require that all dependencies =
also support PUT, which is not a good assumption. Most of the =
dependencies that I have to work with actually do not support PUT or any =
other form of threading.

>> - Non-colliding. Symbol names in these external interface headers =
should
>>   have a standard, obvious prefix as a manual namespacing solution.
>>   Something like `gitlib_`. (Prior art: cURL uses a `curl_` prefix =
for
>>   externally-visible symbols, libgit2 uses `git_<module_name>_foo`
>>   names; for internal symbols, they use `Curl_` and =
`git_<module>__foo`
>>   (with a double underscore), respectively)
>
>Yeah, I think we came up with the same idea.  I do like the =
`gitlib_module_foo`
>approach.
>
>Overall, I read through this and I didn't see anything I obviously =
disagreed with.
>Everything seemed to be either reasonable or something I didn't have a =
strong
>opinion on.

Significantly changing git dependencies and requirement are not intended =
to be part of the libification project. There are version serious =
consequences to doing that. Losing access to git is definitely not =
desirable from my point of view.

--Randall

