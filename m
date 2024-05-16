Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5DBD271
	for <git@vger.kernel.org>; Thu, 16 May 2024 19:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715887322; cv=none; b=R/HH/DDFowvfOxavSO/5QToGtwxMD1oEt/8X4eXFJFuwRrXVTBodjtW6U/4nY6IXozD3H1ntFFG4bbZz/Cxx1bCLBFOS77d+GnO2jGuv7Ry/6pZBQZrj9O/cuD8RmrghR+eNh2XuJo/H7pNo7AHRzYzs1yPt+OAAPXX2rPFaI3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715887322; c=relaxed/simple;
	bh=2QzWhk5wmiJDCOwqLG85dltT79hrW3ZNErisd8I+X2k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bagYkBVqFCxzJ/EDzeEkmFIYHkx+UGW6iHT/yA3OM5QQrXaZd0g8ropKa4252WNcRYlEQnsVaA7bp9anR+GDF4xQ7djLsxAYUggLtDI5R4ubxIoBvC5agCMH/KgmUQpwLujN+4qXfS9EKnbM69HmSuIv+ouu2IKy0ii72IATTEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jB6e35tJ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jB6e35tJ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5455427EBF;
	Thu, 16 May 2024 15:22:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=2
	QzWhk5wmiJDCOwqLG85dltT79hrW3ZNErisd8I+X2k=; b=jB6e35tJWSvaS+ic6
	Fnql560oSfwnb8v8IlJGVe6NdMv/ae+nIybHiHbCkAzaxddVHOPgO7u2+Nl7n9RH
	pmEJV/bN0x5LybFiKgNEY5Fwo9TlircMqUwB+ICE+6l93olSR0JhJWgAxTo1D2mr
	Cc3PMK0eqevzCkgX3d10PMJ+UY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C87E27EBE;
	Thu, 16 May 2024 15:22:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DB2C327EBD;
	Thu, 16 May 2024 15:21:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [Q] rebase -i: turn "pick" to "edit", make no change, what should
 happen?
Date: Thu, 16 May 2024 12:21:55 -0700
Message-ID: <xmqqy189o94c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8F7ED50E-13B9-11EF-BCED-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

What should happen when I turn "pick" to "edit" in a "rebase -i"
session, check what got checked out in the working tree, find it
satisfactory and decide not to make any change to the files, and say
"rebase --continue"?

The current implementation seems to just move to the next step,
without offering a chance to edit the log message.  I do not know
offhand if this is something we changed recently, or if it has been
that way forever.

I personally found this a bit unintuitive, because in my metal
model, "reword" is a mere subset of "edit": the latter would give me
chances to change both the contents and the log, while the former
only would offer me a chance to change the log.

But the actual behaviour does not match that mental model.  "edit"
is purely about editing the worktree files, and only if files (hence
the tree recorded) are modified, a chance to edit the log is offered
to adjust the message to what the new tree brings on top of the
parent commit.

Of course, we can work it around with "git rebase --edit-todo"
before saying "git rebase --continue".  But the current behaviour
somehow feels optimized for a wrong case.  Admittedly, it is logical
that it does not offer a chance to edit the log message if we did
not make any change to the working tree.  After all, the reason why
it may become necessary to edit the log is because the user made
some changes to the tree in the first place.  And by not opening the
editor, only to close it without making any change, the command is
saving the user some keystrokes.

But given that saying "edit" and not making any changes is a rare
case, it feels wrong thing to optimize for.

Anyway.
