Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F6FFBEC
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 06:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z6CTFF2f"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5E7FF2B467;
	Sat, 13 Jan 2024 01:22:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DotqVSgbUtzAtBIyy6HKLCtVPYh48RDk2Yi7Pq
	WBfL0=; b=Z6CTFF2fMIRbGAcap7+b3BlIXFcdDTEq36QUZkj0GoMTnqjrO8AfGD
	7ib5D/Te1SjEdHMNtbKrI2nbxj2oOe7mNuhMticZHnlzTRadb5cilvjXHCUbThzb
	yZEKGypIB1Ho6+vg0pI1ygBpe4PiTIzMcLz/COEX9ZwVEQcC9llxA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 56A7B2B466;
	Sat, 13 Jan 2024 01:22:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8B73A2B464;
	Sat, 13 Jan 2024 01:22:01 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] diffcore-delta: avoid ignoring final 'line' of file
In-Reply-To: <CABPp-BGp0NMQKLYg=OxJgnVxARffNF57B_N2bLmwT2R2EZqhdA@mail.gmail.com>
	(Elijah Newren's message of "Fri, 12 Jan 2024 17:45:08 -0800")
References: <pull.1637.git.1705006074626.gitgitgadget@gmail.com>
	<xmqqedenearc.fsf@gitster.g>
	<CABPp-BGp0NMQKLYg=OxJgnVxARffNF57B_N2bLmwT2R2EZqhdA@mail.gmail.com>
Date: Fri, 12 Jan 2024 22:21:59 -0800
Message-ID: <xmqqil3x69dk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 10162806-B1DC-11EE-82BD-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Elijah Newren <newren@gmail.com> writes:

>> I am not very happy with the hardcoded 97.  You are already using
>> the non-standard 10% threshold.  If the delta detection that
>> forgets about the last line is so broken as your proposed log
>> message noted, shouldn't you be able to construct a sample pair of
>> preimage and postimage for which the broken version gives so low
>> similarity to be judged not worth treating as a rename, while the
>> fixed version gives reasonable similarity to be made into a rename,
>> by the default threshold?  That way, the test only needs to see if
>> we got a rename (with any similarity) or a delete and an add.
>
> Oops, the threshold is entirely unnecessary here; not sure why I
> didn't remember to take it out (originally used the threshold while
> testing without the fix to just how low of a similarity git thought
> these nearly identical files had).
>
> Since you don't like the threshold, and since we don't seem to have a
> summary format that reports on the rename without the percentage, I
> guess I need to munge the output with sed:
>
>       sed -e "s/^R[0-9]* /R /" actual >actual.munged &&

Heh, I was hoping that we should be able to use "diff --name-only".

 $ git mv Makefile Breakfile
 $ git diff --name-only -M HEAD
 Breakfile
 $ git reset --hard
 $ git rm Makefile
 $ >Breakfile && git add Breakfile
 $ git diff --name-only -M HEAD
 Breakfile
 Makefile
 $ git reset --hard
