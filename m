Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726622E03ED
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761332550; cv=none; b=lmFLZyxAXha2dQFIEqIO3JPlSiD7OQI7v7ER/TBrnBRDAeRU0WDHhaHi/ElXok7aG+1gZdp1Ok4b45ieCs9+/bhiE+LSiekZIwmYlDX+ugY0gD5zoiastRJTSu9zLMPRN/Jm8P+LuFT5lBFKONUMPAfj7ojgj8T+tMky9ygucqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761332550; c=relaxed/simple;
	bh=iCobprn77GPrXOe51TWReSyiXkoLwkzPcbbuKJvxopY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=KazyyVJLpVI9p6ycoQO4+y0xpq16RNIKcfdbihDTLaxROlrYanAcRnG8UecT7dm/RuCVxC5qFBOR6n2BYW8JFwBkNDNFXwI1XTjLtnuSdeItY+Ovl4or/qDvYP9npS62+4I9NRU9GX3fr57+hjSwP8HbCJE5T0SqDLYwotaKwy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 59OJ2No4802419
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 19:02:24 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>
Cc: "'D. Ben Knoble'" <ben.knoble@gmail.com>, <git@vger.kernel.org>
References: <012601dc42ce$a1adcb50$e50961f0$@nexbridge.com> <CALnO6CD8JU2qMCnC=qQmNOV6Wy1ZnveT3tRxUz1E0LVMj5oU9w@mail.gmail.com> <013201dc42d5$07a71550$16f53ff0$@nexbridge.com> <20251022092708.GE853931@coredump.intra.peff.net> <018701dc435f$f1dc1a00$d5944e00$@nexbridge.com> <20251023124837.GB1163932@coredump.intra.peff.net> <029a01dc450c$4318dfe0$c94a9fa0$@nexbridge.com> <20251024174659.GA3635620@coredump.intra.peff.net> <029f01dc4515$59ae09c0$0d0a1d40$@nexbridge.com> <20251024185209.GA3637589@coredump.intra.peff.net>
In-Reply-To: <20251024185209.GA3637589@coredump.intra.peff.net>
Subject: RE: [BUG] Strange git notes completion behaviour
Date: Fri, 24 Oct 2025 15:02:18 -0400
Organization: Nexbridge Inc.
Message-ID: <02a401dc4518$bbf66110$33e32330$@nexbridge.com>
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
Thread-Index: AQHjmO9AERlM/1ZhxKXB7Q1XH17MtgEgLITOApwjn/kCVAmtvwG1oGkTAur+K2wCggldTgJg/ggBAXlNwCkBpM37ibQtbZmQ
X-Antivirus: Norton (VPS 251024-10, 10/24/2025), Outbound message
X-Antivirus-Status: Clean



>-----Original Message-----
>From: Jeff King <peff@peff.net>
>Sent: October 24, 2025 2:52 PM
>To: rsbecker@nexbridge.com
>Cc: 'D. Ben Knoble' <ben.knoble@gmail.com>; git@vger.kernel.org
>Subject: Re: [BUG] Strange git notes completion behaviour
>
>On Fri, Oct 24, 2025 at 02:38:05PM -0400, rsbecker@nexbridge.com wrote:
>
>> On October 24, 2025 1:47 PM, Jeff King wrote:
>> >On Fri, Oct 24, 2025 at 01:33:02PM -0400, rsbecker@nexbridge.com =
wrote:
>> >
>> >> What I found is this:
>> >>
>> >> Git drops into sane_execvp and converts the
>> >>
>> >> git notes show HEAD
>> >>
>> >> to
>> >>
>> >> git show 1aa950256829721750e809788e7b858db79a934a.
>> >>
>> >> When execvp is called, it immediately fails with a -12 - not
>> >> returned, just terminates. The -12 is an NonStop-specific execvp
>> >> error indicating the process failed because the object is invalid
>> >> (strange and likely an artifact rather than a real problem).
>> >
>> >When you say "object" here, you don't mean a Git object, but rather
>> >that
>> >execvp() could not run the "git" binary for some reason (so the =
"object"
>> >here is the on-disk executable)? Just making sure I understand.
>> >
>> >> When I use the arguments as presented to execvp via bash directly, =
I get:
>> >>
>> >> error: no note found for object
>> >1aa950256829721750e809788e7b858db79a934a.
>> >>
>> >> There is no commit with that hash. HEAD is actually
>> >> 3fc1917e0e69b23265f5c49f90fdb6f4ed98f4a3
>> >> so git show is correctly failing. This is Indicating that notes is
>> >> not invoking git correctly.
>> >
>> >Are you sure you are running "git show" there and not "git notes =
show".
>> >Because 1aa950256 should be the blob that the note for HEAD points
>> >to, and thus does not itself have a note. And "git show" should not
>> >be looking up notes at all (and the "no note found" message is from
>builtin/notes.c).
>>
>> I am 100% sure that git notes show is running git show with the notes =
blob as
>above.
>
>Yes, I am, too. What I was asking is when you tried to replicate that =
using bash
>directly, how did you get a "no note found" message from "git show"? =
I.e., it
>sounds like you ran the wrong command. Or I am misunderstanding what =
you you
>meant by "When I use the arguments as presented to execvp via bash =
directly".

I ran the exact command that git passed to execvp but did so via bash. =
This is what
gdb showed:

Breakpoint 2, sane_execvp (file=3D0x80aa470 "git", argv=3D0x8122700)
    at /home/randall/git/run-command.c:244
*  244          int exec_id =3D trace2_exec(file, (const char **)argv);
(xInspect 0,1011):n
*  247          if (!execvp(file, argv))
(xInspect 0,1011):p file
$1 =3D (const unsigned char *) 0x80aa470 "git"
(xInspect 0,1011):p argv[0]
$2 =3D 0x81224a0 "git"
(xInspect 0,1011):p argv[1]
$3 =3D 0x8122770 "show"
(xInspect 0,1011):p argv[2]
$4 =3D 0x8122780 "1aa950256829721750e809788e7b858db79a934a"
(xInspect 0,1011):p argv[3]
$5 =3D 0x0

I assumed that I should give that command a try from bash.

