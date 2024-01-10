Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AEC4D580
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xKJjqaj1"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F0D4E3F0E5;
	Wed, 10 Jan 2024 13:44:32 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2B59wilCVGJ8iTPy/l+WFc/n1QvS35+iVeakUd
	7a+wM=; b=xKJjqaj1tVwy2hT55Vvb9fPnMlrf1qFeEXkYHrSRhwi0ILs3l7ZOno
	/lt+3+rnqOmUCoFSxUAUZuqhwSyhdFVFj3Y4XtYY1AQJlbHKcpUuUr9StqA9EfHj
	/8fcGzwrQsFwwx1NcFugFGkYcja/fRwp1O7Bi9cWRNS2uxeSh2Tbw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E83F93F0E4;
	Wed, 10 Jan 2024 13:44:32 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 262593F0E3;
	Wed, 10 Jan 2024 13:44:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Mohit Marathe <mohitmarathe@proton.me>
Cc: Christian Couder <christian.couder@gmail.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>,  "britton.kerin@gmail.com"
 <britton.kerin@gmail.com>,  "peff@peff.net" <peff@peff.net>
Subject: Re: [GSoC][RFC] Replace use of atoi() with strtol_i(), as a
 microproject
In-Reply-To: <F6ejgAfr2IMRNR3Tq0CDTHeT9xMWzJ9ley8M_fnSX97ayRNRp_CEgA62WdtOooi9bha1WJPGB53ptJYQFII2lCbIflwgNvbIaefw7nK8w7M=@proton.me>
	(Mohit Marathe's message of "Wed, 10 Jan 2024 17:38:07 +0000")
References: <OqD4xQ_p-jcftCbAw0ovvrBztfiuoMGcTonCc0i6x7Ziy-hx3uA-Hoz4-3tfRI39KMj-V5OZIGgOe66b1eyX3YrKZNThMYjjMkn6g4-Ww8c=@proton.me>
	<CAP8UFD1d7FSa=mUzzUA5e3eSEcCVfaymxWewo5GjdDBi4GyE-g@mail.gmail.com>
	<F6ejgAfr2IMRNR3Tq0CDTHeT9xMWzJ9ley8M_fnSX97ayRNRp_CEgA62WdtOooi9bha1WJPGB53ptJYQFII2lCbIflwgNvbIaefw7nK8w7M=@proton.me>
Date: Wed, 10 Jan 2024 10:44:27 -0800
Message-ID: <xmqqa5pdav04.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 49470EF6-AFE8-11EE-B717-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Mohit Marathe <mohitmarathe@proton.me> writes:

> I took a closer look at `builtin/patch-id.c` and it seems replacing 
> `atoi()` (which is used to parse numbers in the hunk header) wouldn't
> improve anything, unless I'm missing something.

You can of course notice an invalid patch that places non-digit to
the hunk header and error out with such a change.  If we are reading
output from Git that we are invoking, hopefully we will not see such
an invalid patch, but the command is designed to read arbitrary
input like a patch e-mail you received over the network, so I do not
think it is fair to say there is no merit to such a change, even
though I agree that it may not matter all that much.

A corrupt patch may be getting a nonsense patch-ID with the current
code and hopefully is not matching other patches that are not
corrupt, but with such a change, a corrupt patch may not be getting
any patch-ID and a loop that computes patch-ID for many files and
try to match them up might need to be rewritten to take the new
failure case into account.
