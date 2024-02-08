Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC8A4F1FA
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707428693; cv=none; b=jXkpAyHSjRz7iMyCe9CpVO75Z7WJLCIN6+5hd2x1MUrdepDLkgc6elirXeOxGHiw+AebSIATC7gIynsQvxksjBq0x9fa2cCml/yN8+xjzbeSInfQT3UNwqD+WwyX86dR1B2FXAWefwRbD6CBGXBMkgHRi1e85E7t8oSjjzU+ty0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707428693; c=relaxed/simple;
	bh=2y8tEkddVneuUbsi4KLG/kburC1j6+GZ4faH2yd1x/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C5O8wI7RsNj2xHxlpZdV+CmZ3hBC3skqT9CVWFy/3iLGYmWg8mwTkzsaHsOBF+h1RrGljwYdsFnVYDlVleQWFItvu+Svv81hjQZURQgOSTdNxQXqkpkxE+lILwyxfy19x/aWjP8RHiNBZg6J4GSc7eC296QRcPxaKKG4f//swdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SLZh3Lq0; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SLZh3Lq0"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DEC71E3560;
	Thu,  8 Feb 2024 16:44:50 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2y8tEkddVneuUbsi4KLG/kburC1j6+GZ4faH2y
	d1x/k=; b=SLZh3Lq0Lpbtq+a2htsLtH+EJdOg+zXePOOFbSEQjfLQwE9KogtyPb
	9uCtcaTORdKOuPdH6KhiQaJ7T3qOZexu5hvcsgykcZ9SkrqQjDP6ueCRKVrb2zuz
	yfY0nmo15CNNvYeoGbu2Ylu69wIl75MLDMULqnKd/bXHANErmg+pc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 54F231E355F;
	Thu,  8 Feb 2024 16:44:50 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B4A041E355E;
	Thu,  8 Feb 2024 16:44:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Chandra Pratap via
 GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Chandra Pratap
 <chandrapratap376@gmail.com>,  Chandra Pratap
 <chandrapratap3519@gmail.com>
Subject: Re: [PATCH] commit.c: ensure strchrnul() doesn't scan beyond range
In-Reply-To: <20240208214137.GB1090198@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 8 Feb 2024 16:41:37 -0500")
References: <pull.1652.git.1707153705840.gitgitgadget@gmail.com>
	<ce83bd09-dbd2-4c9e-8197-6e4800935523@web.de>
	<20240208010040.GB1059751@coredump.intra.peff.net>
	<8313d9d6-f6bd-4fae-be9c-e7a8129768eb@web.de>
	<xmqqil2yn3ey.fsf@gitster.g>
	<20240208214137.GB1090198@coredump.intra.peff.net>
Date: Thu, 08 Feb 2024 13:44:48 -0800
Message-ID: <xmqqcyt6my0f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 48D3FBF6-C6CB-11EE-9C09-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

>   1. It is not possible for the buf/len pair we pass to check_nonce() to
>      contain a NUL. And thus there is no caller of find_header_mem()
>      that can contain an embedded NUL. So switching from strchrnul() to
>      just memchr() should be OK there.

Correct.

>   2. That raises the question of whether parse_signed_buffer() has a
>      similar walk-too-far problem. ;) The answer is no, because we feed
>      it from a strbuf. But it's not a great pattern overall.

True, too.

Thanks.
