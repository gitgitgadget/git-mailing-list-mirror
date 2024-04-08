Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7FB5FB8F
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574452; cv=none; b=oEVijop4LZ3KBVr4BmM+IuHoCKjOvYFgvLPOU/e43SibeIjNHSxjBWUMgqI7a75CtrUdCCzGSSBjP1/+nZT1CikuKajCEANYH7zXhou1RkTYvWa2S9PjIuTIuyiVJVYEqE5BMYzjS0u0yoCuUQsRjsZjJwcMgh/MzSbrY4gX4PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574452; c=relaxed/simple;
	bh=fuLzkAnDhd+CFhnAOCG6ACeZMJhMV94tXWkOD7zDQ5Q=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=i+ueaBlp5pzMwGmXovbMz1ZrwTSWHx/wiedqAwUXzD2sJj0RnBtr/yoDzfp+ejLs+3lAD7hWBOpf8DXcJ/Yz03q0PMooKnvIFAEBLwDVJuYjB9TvIMHzr0BGaFu8ZA5Rx3z7sr7L0Y68fwDXTvxeX4F5H2Zzh+GjmGUwYwbEhJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 438B7HZw3639899
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 11:07:18 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc: "'Calvin Wan'" <calvinwan@google.com>,
        "'Git Mailing List'" <git@vger.kernel.org>
References: <CAFySSZAB09QB7U6UxntK2jRJF0df5R7YGnnLSsYc9MYhHsBhWA@mail.gmail.com> <ZhMRNxgwRJ25P4Ud@tapette.crustytoothpaste.net> <037001da8935$4a6e3720$df4aa560$@nexbridge.com> <ZhND3hZXlzDxff5e@tapette.crustytoothpaste.net>
In-Reply-To: <ZhND3hZXlzDxff5e@tapette.crustytoothpaste.net>
Subject: RE: [RFD] Libification proposal: separate internal and external interfaces
Date: Mon, 8 Apr 2024 07:07:13 -0400
Organization: Nexbridge Inc.
Message-ID: <043c01da89a4$ec6efef0$c54cfcd0$@nexbridge.com>
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
Thread-Index: AQLZD9zpP+uuLDZ/yLqfzLjinyux7QI7euh6AXbK4VsCNwZyZK8x1TRA
Content-Language: en-ca

On Sunday, April 7, 2024 9:10 PM, brian m. carlson wrote:
>On 2024-04-07 at 21:48:07, rsbecker@nexbridge.com wrote:
>> On Sunday, April 7, 2024 5:34 PM, brian m. carlson wrote:
>> >We'll also need to consider that libgit2 is currently using `git_`
>> >and thus we'll either need to use something different or avoid =
conflicts.
>> >Perhaps `gitlib_` might be useful.
>>
>> Or `GITL_`
>
>It's more common to use lowercase, so I think we should do that.
>
>> >I should point out that _FILE_OFFSET_BITS=3D64 is effectively =
standard these days.
>> >Nobody wants their files limited to 2 GiB.
>>
>> This is not the default on some platforms. It is still required but =
can be put into a
>knob.
>
>True, but everyone compiles with it.  If you're a software vendor and =
your build only
>supports 2 GiB files, everyone's going to be mad.  We should be able to =
assume that
>vendors are prudent and reasonable people who will compile their =
binaries
>accordingly and not have to return an error if a requested file size is =
larger than 32
>bits.

I am not disagreeing that it "should be" standard. But it is not a =
compiler default, so still needs to be supplied when git is built. =
Removing the define will drop the limit to 2Gb on some platforms. I'm =
not sure where this is going.

>> >Sure.  If we need a file size type, it should be something like
>> >`int64_t` or `uint64_t` and not `off_t`. Not all platforms have =
explicit 64-bit APIs
>compiles. NonStop and S/390 do require explicit controls to make this =
work.
>>
>> This will result in compile warnings with some platforms with APIs
>> that do use off_t for arguments and results.

Where _FILE_OFFSET_BITS=3D64, off_t should be 64 bits. If we are saying =
that git is going to force 64-bit types for offsets, then the types =
should be explicitly different, like git_off_t rather than hard-binding =
them to int64_t. That would allow git_compat_util.h or others to force =
the type broadly instead of making assumptions about the size.
>
>There will need to be a cast.  Our APIs should use a standard 64-bit =
type and not
>expose the platform `off_t`.
>
>> >
>> >> - Limited Platform Compatibility. The external interfaces are able =
to
>> >>   assume that <stdint.h> and other C99 (or maybe even C11+)
>> >>   functionality exists and use it immediately, without weather =
balloons
>> >>   or #ifdefs. If some platform requires special handling, that =
platform
>> >>   isn't supported, at least initially.
>> >
>> >I think this is fine.  It's 2024.  We should assume that C11 (a
>> >13-year-old spec) is available and so is POSIX 1003.1-2008 (except
>> >for Windows).  We may want to have a nice `#ifdef __STDC__ < =
200112L`
>> >(and a similar check for POSIX) to just produce an `#error` if the =
system is too old.
>>
>> I wish this were the case. I have 2 years before C11 is guaranteed to
>> be available on platforms that I maintain. Can we wait until mid-late
>> 2025 before doing this? I do not want to lose access to git.
>
>As mentioned in the original proposal, we don't have to support all =
platforms in the
>libified code.  The main Git binaries will continue to function and be =
supported, but
>the new libified code will rely on newer features.  You will still be =
able to have all the
>Git binaries and functionality, but if you want the new shared library =
to compile
>against, you'll have to furnish a newer compiler.

I am not sure this original assumption still holds, if git is now going =
to depend on the libified code, which seems to be the direction after =
recent discussion.

>As a side note, I don't think requiring porters to support a =
13-year-old spec is
>unreasonable for new, independent parts of the codebase.  As a side =
note, if your
>platform supported GCC or LLVM, then this would be an easy goal to =
achieve.  I
>know it doesn't right now, but it might be an incentive to get it =
there.
>
>> This is not a particularly good assumption. Some architectures do not
>> support kernel-level threading. PUT threading is possible on some
>> platforms but attempts to port git to PUT require that all
>> dependencies also support PUT, which is not a good assumption. Most =
of
>> the dependencies that I have to work with actually do not support PUT
>> or any other form of threading.
>
>I don't believe this is true.  Every architecture which supports Linux =
or any other
>modern Unix has threading support.  You're compiling on
>ia64 and x86, which definitely do support threading and have had it on =
Linux and
>NetBSD for years (before they removed ia64 support).

Just be cause the chipset supports threading, which it does, does not =
mean that every platform has kernel-level threading available to =
applications. For SMP, sure, you can make that assumption, but for MPP =
architectures (few as they are), PUT has been the standard - it is =
available on NonStop and works correctly, but porting git to PUT on =
NonStop has been tried at least twice since I have been involved, with =
bad results each time - the failures may have been in the test suite, =
but if one does not have a test suite that supports what is being =
tested, one should not release it. Where I have an issue with requiring =
PUT as a minimum, is that dependencies for git, and the list is not =
small, do not generally support PUT, even if git does; rather make a =
similar assumption that hardware threading is sufficient - It is not and =
there is ample evidence of that. Cooperative threading (PUT) is much =
more complex to code than a kernel thread implementation, and our =
attempts at porting git to PUT on NonStop failed because of problems in =
dependencies and the git test suites. This is a much longer discussion, =
but I do not have confidence that everything git requires is properly =
reentrant and can handle PUT. They all "should", but that does not =
appear to be the case.

With that said, I can try spinning up an effort again to try the PUT =
build and dive deeper into this, but I do not relish having to debug =
someone else's thread code, at least not without some explicit =
explanation or help of the thread design. My $team will avoid trying to =
debug threaded code that does not work in favour of a rewrite, unless =
the problems are glaringly obvious. My $DAYJOB is already unhappy with =
the time I have spent debugging other project's thread problems - ones =
that would impact git PUT builds.

I am not saying it is impossible to do, but it is a very big ask, to =
justify not only git but all git dependencies to implement PUT threading =
correctly. If kernel threads are ever externalized on NonStop, the topic =
becomes much easier to handle. Again, ia64 goes to the curl because PUT =
is all we will ever get on ia64. Whenever this requirement is put in =
place, it locks git on NonStop to that version. The upshot is that I do =
not think libification has taken into account threading issues, so this =
may be moot.

>Threading is a reasonable thing to have on a modern operating system, =
and if we're
>adding new, independent functionality, that should be able to safely =
work with
>threading.  You can continue to use the binaries without threading, =
just not the new
>shared libraries.
>
>I'll add on that I'm not opposed to continuing to support NonStop in =
principle, but I
>_am_ opposed to having to continue to support really ancient versions =
of common
>standards[0].  POSIX 1003.1-2008 is about 16 years old; it could drive =
a car in much
>of North America.  I think it's the responsibility of porters to =
provide this
>functionality, and in general most open source OSes do this with little =
or no paid
>staff, so it should be reasonable to expect corporate-backed operating =
systems to
>do so.

I agree with that, but I have very little influence on what the NonStop =
team does internally. I am not on team.

>I would strongly recommend that NonStop start supporting modern =
compiler and
>POSIX standards, as well at least one of GCC or LLVM, and that you push =
very hard
>to make that happen.  It's not just Git that's pushing forward here; =
there's a lot of
>open source software that simply will not compile with the =
functionality you
>support, including the increasing amount of software written in Go or =
Rust, and it's
>unreasonable to expect people not to want to use standard functionality =
that's over
>a decade old.  If NonStop doesn't move in that direction, I anticipate =
we will
>eventually drop support for it sooner or later.

This is a great recommendation that will not happen any time soon. It is =
something the community has requested repeatedly but there are inside =
reasons for not doing this. My team spent years trying to port GCC =
without success (I cannot go into why, but it is non-trivial and will =
not happen). At least on the more modern NonStop x86, we do have C11, =
just not on ia64. With the latter going off support relatively soon, we =
could move to C11 safely in about 2 years. With that notice, it would =
give us time to adapt, but would absolutely kick git to the curb on =
ia64.

This does bring up the question of how much notice is needed (or at =
worst considered "considerate") to allow platforms to cope with =
fundamental architectural dependency changes in git.

>[0] This is not just NonStop; Microsoft's long-time refusal to =
implement
>C99 or a newer version of C really ground my gears and I basically gave =
up on
>supporting it for all personal projects as a result.  Fortunately, =
they've now come up
>to a modern standard.
>--
>brian m. carlson (they/them or he/him)
>Toronto, Ontario, CA

I have to say that I this thread is making me very nervous about the =
future of a supportable git on anything but Linux.

