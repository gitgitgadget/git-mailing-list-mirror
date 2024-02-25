Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7D317BBD
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 20:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708893419; cv=none; b=HQSczy5zzo6yhh7wnVMcml9wdKsmenN39UtnHIOSEvQ7VBbABepe9EUJ75VYQn3NO0Q30J1T9s2wFSDBvDwLlid88V+CsTfk9Rt4qCgM2cTH8snNq6/6ds2GZuWtywQEKBWbTmJqNaYKqFTX3aR9JlZnZRSxASggsDmmQ9A53bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708893419; c=relaxed/simple;
	bh=M+qJ0FNeFRh3XV6JJyjd1wBLeyybBk0COobHI5Q3pw8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=mjUs1jF+qoqeFmboxFfL3lCC9vfgo0WEsWJ5mDmAT582ixVqKhMo3IFbHKUksVJBSx6dVEjjfKcdhmlI+SgP2gBc3esWA+/UJjQv8DuFCHOB4fU0bMhUEE7Qx/5cCiWat71aT/TvUjJu8cAL2Ypd3FyU0SdiOj0JSn7VizdD9+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41PKasFJ2011459
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Feb 2024 20:36:54 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "=?iso-8859-1?Q?'Torsten_B=F6gershausen'?=" <tboegi@web.de>
Cc: <git@vger.kernel.org>
References: <01bd01da681a$b8d70a70$2a851f50$@nexbridge.com> <01be01da681e$0c349090$249db1b0$@nexbridge.com> <20240225191954.GA28646@tb-raspi4>
In-Reply-To: <20240225191954.GA28646@tb-raspi4>
Subject: RE: [BUG] 2.44.0 t7704.9 Fails on NonStop ia64
Date: Sun, 25 Feb 2024 15:36:49 -0500
Organization: Nexbridge Inc.
Message-ID: <01ca01da682a$5f6a7b60$1e3f7220$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQH6KeHXK3ktIx6cNmAt1sL267+NoQLej1jbAXwNbRKwuStHcA==

On Sunday, February 25, 2024 2:20 PM, Torsten B=F6gershausen wrote:
>On Sun, Feb 25, 2024 at 02:08:35PM -0500, rsbecker@nexbridge.com wrote:
>> On Sunday, February 25, 2024 1:45 PM, I wrote:
>> >To: git@vger.kernel.org
>> >Subject: [BUG] 2.44.0 t7704.9 Fails on NonStop ia64
>> >
>> >This appears to be a new issue introduced at 2.44.0. It only occurs
>> >on
>> NonStop ia64
>> >1..9
>[snip]
>>
>> I did find the following calls to write(), one of which might be
involved.
>> write() should not be used directly unless the count is clearly very
small.
>> Xwrite() should be used instead. There are other calls but those are
>> either small or not on platform.
>
>(Probably a typ0: Xwrite() -> xwrite()
>
>But I think that this should be used:
>write_in_full()

My mailer autocorrected, yes, xwrite. write_in_full() would be safe,
although a bit redundant since xwrite() does similar things and is used =
by
write_in_full(). The question is which call is bad? The cruft stuff is
relatively new and I don't know the code.

>> reftable/writer.c:              int n =3D w->write(w->write_arg, =
zeroed,
>> w->pending_padding);
>> reftable/writer.c:      n =3D w->write(w->write_arg, data, len);
>> run-command.c:                  len =3D write(io->fd, io->u.out.buf,
>> t/helper/test-path-utils.c:                     if (write(1, buffer,
count)
>> < 0)
>> t/helper/test-windows-named-pipe.c:             write(1, buf, nbr);
>> t/helper/test-windows-named-pipe.c:             write(1, buf, nbr);
>> trace2/tr2_dst.c:       bytes =3D write(fd, buf_line->buf, =
buf_line->len);

