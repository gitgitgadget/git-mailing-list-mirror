Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D7A3DB86
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705954618; cv=none; b=ELZDqNbD+jKSrNxkKWLIkIU2IS3es+YTOgV9HEya0wrWhHGky0OUHgKHOTJCihf+cPP5QPLpCoQFxfmQ8nVt3P+zJvif16WZGn31LK9CKv3+NM+65qgr/He75MlWw+VwnWQR1VYk9EK9yr7U8C1cHsg/ljSsXKnBVyC9yA6QEgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705954618; c=relaxed/simple;
	bh=MsxyM8HDbXIsuwFerGoX8krJWNqDS+ETDJnbD+p/RgE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sTK4uf827HA3OEU/KI7MWWF6nrEDP3auNkKvEYBxAiAMhYc3/ZePwMYzIl+WFo00s0zVwWu2vBKlAjbZn9LDiKqYSlUybMtZDm0EUTEjeDUrzp5MnwyWMsYh5w9eaYAGKj1DtCp1lOqUwso0SIxMMWATQ9VVqkFdNhBwL05d1Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LOKRAD3L; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LOKRAD3L"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 108641D2943;
	Mon, 22 Jan 2024 15:16:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MsxyM8HDbXIsuwFerGoX8krJWNqDS+ETDJnbD+
	p/RgE=; b=LOKRAD3Lj9/7f7gBt/FpeUiUn+EihCwdnAnWNCefOL4FvAeNDi1yBZ
	1IrEgY4pPIjJZ7LhyKmdUtUA3AsintW04vcp1v4G0FXtsiWqyc/D+kE4uwaZq1nC
	YDk98i3VKupgapsgMss/M+dXLeV8hphVEWfuQfzkbuEr7zfkKr+xc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 07D531D2942;
	Mon, 22 Jan 2024 15:16:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 722311D2941;
	Mon, 22 Jan 2024 15:16:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 4/7] sequencer: introduce functions to handle
 autostashes via refs
In-Reply-To: <a7712d26-7c63-4c77-b339-126d05be6b0d@gmail.com> (Phillip Wood's
	message of "Mon, 22 Jan 2024 19:54:58 +0000")
References: <cover.1705659748.git.ps@pks.im>
	<abcf1f5cf428072d19639dc4209e0c1554f3eb53.1705659748.git.ps@pks.im>
	<xmqqbk9hjdai.fsf@gitster.g> <Za5IoEjs0q7cf354@tanuki>
	<a7712d26-7c63-4c77-b339-126d05be6b0d@gmail.com>
Date: Mon, 22 Jan 2024 12:16:51 -0800
Message-ID: <xmqqy1chrumk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2E4DDA60-B963-11EE-9ED4-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>> ... These refs are not supposed to be accessed by the user in the
>> first place, and we do not document their existence to the best of my
>> knowledge. Also, `git rev-parse rebase-merge/autostash` would fail.
>
> Exactly "rebase-merge/autostash" is a detail of the rebase
> implementation, it is not a ref that users should be using.
>
>> So overall I think it's fine to leave this internal sequencer state as
>> self-contained as it is.
>
> That's my feeling too

Good.  As long as "git rev-parse rebase-merge/autostash" fails, and
regardless of the ref backend in use, we always do "read one line from
the on-disk file and run get_oid_hex() on it", I would be happy with
that direction.

Thanks.

[Footnote]

 * We seem to overuse strbuf_read_file() even when we expect that
   the file is a single-liner.  We have read_line_from_git_path() in
   wt-status.c that only reads one line and we may want to split it
   into two: one that takes a filename and calls the other with
   git_path("%s", filename), and the other that takes a path for any
   on-disk file, reads a single line, and returns the string that
   was read, or something like that.  We might later want to update
   the "other" function so that it errors out if there are extra
   trailing lines (i.e. we expect it is a single-liner, but that
   expectation is violated---now what?).
