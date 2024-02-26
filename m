Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5AB249F9
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962767; cv=none; b=H+iYwZbOb2/3h/9hSUkKy81j+QEPXsRKeB7PxJ4cF4BzD+xJMSjPZ4nQSYdql+LItFKXAuEuZmr1c3G4MjgOar4SyTjTwRPUu2HndCK2KIVuIc6vGFeB2QFEXWmc9aii0Nn9rVI0RnPmYT6dD82dmdROfsnwGsb3yt255X3xgMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962767; c=relaxed/simple;
	bh=ugyoPtIQE7RGQHr9UP/+8IhjTnT2m63hOdeucTIHxB0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=tz6bp7VgSY89evVdsqgTFW4EH91LDzFBJ1j8T8JfjE+yfPByXRceKH3Gy3XzAMU5fKEtFZH8RssczOuG6EzTEqDVwmLo4MqAMxOhrMYXqiCPtC+lwmkAfnvDpJ3GBrbG4ObTe+0Z12dvwGrbpFg8uQVf34LQQ2jvfAgi09FC5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41QFqadY2154362
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 15:52:36 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <phillip.wood@dunelm.org.uk>,
        "=?utf-8?Q?'Torsten_B=C3=B6gershausen'?=" <tboegi@web.de>
Cc: <git@vger.kernel.org>, "'Patrick Steinhardt'" <ps@pks.im>
References: <01bd01da681a$b8d70a70$2a851f50$@nexbridge.com> <01be01da681e$0c349090$249db1b0$@nexbridge.com> <20240225191954.GA28646@tb-raspi4> <01ca01da682a$5f6a7b60$1e3f7220$@nexbridge.com> <5e807c1c-20a0-407b-9fc2-acd38521ba45@gmail.com>
In-Reply-To: <5e807c1c-20a0-407b-9fc2-acd38521ba45@gmail.com>
Subject: RE: [BUG] 2.44.0 t7704.9 Fails on NonStop ia64
Date: Mon, 26 Feb 2024 10:52:31 -0500
Organization: Nexbridge Inc.
Message-ID: <022001da68cb$d29a2c60$77ce8520$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQH6KeHXK3ktIx6cNmAt1sL267+NoQLej1jbAXwNbRICuPECnQG1wVidsJb49XA=

On Monday, February 26, 2024 10:32 AM, Philip Wood wrote:
>On 25/02/2024 20:36, rsbecker@nexbridge.com wrote:
>> On Sunday, February 25, 2024 2:20 PM, Torsten B=C3=B6gershausen =
wrote:
>>> On Sun, Feb 25, 2024 at 02:08:35PM -0500, rsbecker@nexbridge.com =
wrote:
>>>> On Sunday, February 25, 2024 1:45 PM, I wrote:
>>>>> To: git@vger.kernel.org
>>> But I think that this should be used:
>>> write_in_full()
>>
>> My mailer autocorrected, yes, xwrite. write_in_full() would be safe,
>> although a bit redundant since xwrite() does similar things and is
>> used by write_in_full().
>
>Note that unlike write_in_full(), xwrite() does not guarantee to write =
the whole
>buffer passed to it. In general unless a caller is writing a single =
byte or writing less
>than PIPE_BUF bytes to a pipe it should use write_in_full().
>
>> The question is which call is bad? The cruft stuff is relatively new
>> and I don't know the code.
>>
>>>> reftable/writer.c:              int n =3D w->write(w->write_arg, =
zeroed,
>>>> w->pending_padding);
>>>> reftable/writer.c:      n =3D w->write(w->write_arg, data, len);
>
>Neither of these appear to check for short writes and
>reftable_fd_write() is a thin wrapper around write(). Maybe
>reftable_fd_write() should be using write_in_full()?
>
>>>> run-command.c:                  len =3D write(io->fd, =
io->u.out.buf,
>
>This call to write() looks correct as it is in the io pump loop.
>
>>>> t/helper/test-path-utils.c:                     if (write(1, =
buffer,
>> count)
>>>> < 0) >>> t/helper/test-windows-named-pipe.c:             write(1, =
buf, nbr);
>>>> t/helper/test-windows-named-pipe.c:             write(1, buf, nbr);
>
>In principle these all look like they are prone to short writes.
>
>>>> trace2/tr2_dst.c:       bytes =3D write(fd, buf_line->buf, =
buf_line->len);
>
>This caller explicitly says it prefers short writes over retrying

The real issue is that t7704.9 fails as follows:

Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0) =
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Writing objects: 100% (3/3), done.
Total 3 (delta 0), reused 3 (delta 0), pack-reused 0 (from 0)
ls: cannot access '.git/objects/pack/pack-*.mtimes': No such file or =
directory
test_line_count: line count for cruft.after !=3D 2 not ok 9 - =
--max-cruft-size with pruning #

So something is not writing the mtimes file correctly. That's what I am =
trying to track down. The write issue is a possible cause but not =
necessarily the root cause.

--Randall

