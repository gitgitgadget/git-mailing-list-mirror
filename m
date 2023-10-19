Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65787354F2
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 21:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nerU61dB"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29476115
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 14:48:01 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8EF681BC286;
	Thu, 19 Oct 2023 17:47:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Nc+Nvv6RuO9exKAAEri1+VX7elrCExV5yGILWf
	AwYc8=; b=nerU61dBJQegKiXfysaa8nynwVjms7oaGDEnBdZI8OheFwzKwO552c
	/qpdPaujUmxvDEN6hBB7iBL5T98i9c1Ip9JJZM0bRvXcFeKRGn4lzTP84kXePox/
	MMyhwilQCF9ILgPiQ2LKW97KFmDVTi06Al4SH1VNWUzRqiHblnkuA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8761C1BC285;
	Thu, 19 Oct 2023 17:47:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB65E1BC284;
	Thu, 19 Oct 2023 17:47:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  "Eric W.
 Biederman" <ebiederm@gmail.com>,  Jeff King <peff@peff.net>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/7] merge-ort: implement support for packing objects
 together
In-Reply-To: <cover.1697736516.git.me@ttaylorr.com> (Taylor Blau's message of
	"Thu, 19 Oct 2023 13:28:38 -0400")
References: <cover.1697736516.git.me@ttaylorr.com>
Date: Thu, 19 Oct 2023 14:47:56 -0700
Message-ID: <xmqqpm1auvw3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2AC10BAE-6EC9-11EE-B504-25B3960A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> By factoring out a common
> "deflate object to pack" that takes an abstract bulk_checkin_source as a
> parameter, all of the earlier refactorings can be dropped since we
> retain only a single caller instead of multiple.

Ah, that is how we managed to lose the preparatory split of new
helper functions.  The names given to these functions that represent
steps of checkpointing were well thought out, and they served their
documentation purposes very well, but if they all have a single
caller, then that is fine ;-).

I _think_ I carefully followed the code/data flow of the new code to
see that we do identical things when streaming from a file to a pack
(in other words, this does not introduce regression), and nothing
objectionable stood out.  The order of presentation was a good way
to let readers to do so, and the actual "now we have everything
working as we want, let's teach the machinery to also read from an
in-core buffer" step being very small gives us extra confidence with
the result.  Very nicely done.
