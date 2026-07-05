Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B11360EC0
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290242; cv=none; b=UczurylcjI/mrvevMxWnI3KAfPKkPS9z5mWi4QEYdpWWdaSS0fugSn6QY1rMVnLzPwpoLiZu93/X6QV1XoAKjvPTk2PbBQKT+f7VLEmv8quubXd7sJwOYsIrZOU8miz29Kly80sMzWjumjMVqCeNWmwaAGUwC4WlHgm4uY9dzOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290242; c=relaxed/simple;
	bh=mSXOC39TXFrBPyJ5fxgNiTFQiV3+3xLnN0xGYNElWBY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=GF9CumT4VDsYZehGQfWHyQyQzTVbdrB76UBGAqXPganDMTGv1D/eapycaT/fOMGm/GB/oEtX9FbvIs+1cAJPF3DWm9Gd4aIl1VIBi2ZxrFQEb1i6i+W7cjuvM+6Gt5wX2j62R+gKPfqhrM+IcZR3RUUp44NeUNWDm+xJn55ZcVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=qlWI3Z8i; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="qlWI3Z8i"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 192D760006;
	Sun,  5 Jul 2026 22:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1783290233; bh=mSXOC39TXFrBPyJ5fxgNiTFQiV3+3xLnN0xGYNElWBY=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=qlWI3Z8iO2LJjKqFiXFB6R8thDWvbe4hpg10iMEjI8zxgfxxZs7JgPK2YLdojfFWl
	 RXvEIOvTbnDN9sY9vXeO/MuF+MKVvpujd0b3Nv5b5cpL5UbqDIcePYwdXN/0ykWz0h
	 neQS+T/N7CzVe+pbrEueA6AvHazEsk05LQcAZaUI=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Jul 2026 18:23:52 -0400
Message-Id: <DJQZMN6UIPBY.Z6WBNUP1E3U2@lfurio.us>
Cc: <git@vger.kernel.org>, "Jeff King" <peff@peff.net>, "Stefan Haller"
 <lists@haller-berlin.de>, "Derrick Stolee" <stolee@gmail.com>, "Phillip
 Wood" <phillip.wood@dunelm.org.uk>
To: "Junio C Hamano" <gitster@pobox.com>, "Trevor Gross"
 <tg@trevorgross.com>
From: "Matt Hunter" <m@lfurio.us>
Subject: Re: [PATCH] rebase -i: introduce `pick -x` to add "cherry picked
 from commit ..."
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260705140931.98262-2-tg@trevorgross.com>
 <xmqqldbpclhh.fsf@gitster.g>
In-Reply-To: <xmqqldbpclhh.fsf@gitster.g>

On Sun Jul 5, 2026 at 2:58 PM EDT, Junio C Hamano wrote:
> Trevor Gross <tg@trevorgross.com> writes:
>> @@ -5524,7 +5533,7 @@ static int single_pick(struct repository *r,
>>  		       struct replay_opts *opts)
>>  {
>>  	int check_todo;
>> -	struct todo_item item;
>> +	struct todo_item item =3D { 0 };
>
> This may be a good change, but I do not think the proposed commit log
> message touched upon it.  It should.  Is it a bug that we somehow were
> lucky that nobody made an access to uninitialized piece of memory here?

On a first glance, do_pick_commit() was only referencing the 'command'
and 'commit' fields of struct todo_item.  Trevor added a reference to
item->flags which created the need to initialize it here.

However, on a second glance, there _is_ a pre-existing reference to
item->flags in do_pick_commit() as well, at line 2410 on master
(e9019fcafe00):

    if (command =3D=3D TODO_REWORD)
        reword =3D 1;
    else if (is_fixup(command)) {
        if (update_squash_messages(r, command, commit,
                       opts, item->flags)) {
            res =3D -1;
            goto leave;
        }

It doesn't look like this code is actually reachable from single_pick()
as written, since it is guarded by is_fixup(command) and single_pick()
doesn't set such a command.
