Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F8A1A2567
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568150; cv=none; b=HW5u0rhhypQ0T8UsxnJvXDrmMqeK32PmaE8lUolBlX7i0EnOsMf8E47GHEZTJqBtfgANIIUHyoYqRd2PljSuA8lhyrEBchiDKs7jgX1mUY9flUWelakbg0Eql1HVeIdCcAVL9Y1WsahDV7n46ZivjqWt+q0qH37EwP96zvDYUEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568150; c=relaxed/simple;
	bh=YV/21fF4TO1dXfPbbI8t2sZfGhHOCe/48bePTCWZ53k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ETV77Z8vCIxAhYEeBNzQDUtaLc2/XrFJOiG5KDkLwNKjQMxpwDSmEmYQd0ci4kzufwdSEQW4LdraGULZhh+WTE5MiKCdHHbtKLgdT5Jn7Fr5sf855kUqdazjr+4jT6uEG+pnz8pFjEzD0pwOh0rrJhBPO4zJYVncq6PSlJ0priM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=igCtKcqf; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="igCtKcqf"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 659A435DD1;
	Tue, 13 Aug 2024 12:55:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YV/21fF4TO1dXfPbbI8t2sZfGhHOCe/48bePTC
	WZ53k=; b=igCtKcqfFznwj1qun/wpeV2eKyPGX3yT+5OeARZz2yAzL/qievrysd
	iUqSgJawO+5Ao1zphMLVSzbUtKwBXF+G3Rmbpvg5ANUGsuQLStJEvSnOW8HLKwj3
	7BqhZAhXsrhD9twCO/3L2347WWoDzaVj9PkWs9lo939IemE3nhEis=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5E42835DCC;
	Tue, 13 Aug 2024 12:55:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A140235DCB;
	Tue, 13 Aug 2024 12:55:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  James Liu <james@jamesliu.io>,  karthik nayak
 <karthik.188@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 18/22] builtin/format-patch: fix various trivial
 memory leaks
In-Reply-To: <c048b54a2c493658b2dd256b301491a79cfa99a1.1723540931.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 13 Aug 2024 11:32:02 +0200")
References: <cover.1722933642.git.ps@pks.im> <cover.1723540931.git.ps@pks.im>
	<c048b54a2c493658b2dd256b301491a79cfa99a1.1723540931.git.ps@pks.im>
Date: Tue, 13 Aug 2024 09:55:43 -0700
Message-ID: <xmqqa5hg746o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E199BA5E-5994-11EF-A642-BF444491E1BC-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> There are various memory leaks hit by git-format-patch(1). Basically all
> of them are trivial, except that un-setting `diffopt.no_free` requires
> us to unset the `diffopt.file` because we manually close it already.

Ah, I misread the patch.  Clearly diffopt.file is about
double-closing.  Makes sense.
