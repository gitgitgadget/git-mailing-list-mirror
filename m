Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3423418E01
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 01:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uiJmXk4G"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 87D6023367;
	Fri, 12 Jan 2024 20:16:35 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1Zt9RT8hEUZ8SzGasN4ahzOQqdMnMs8tm0yuPI
	zv0DM=; b=uiJmXk4GwBjxTI7CpcqW5w9oyHSl1ZjnygdUe5+5TDHqTIZ/Hw0M7/
	omzn6seSyBlFJkrzNOOdCCrQxQFVgvc4K6nTZhxSJyuhIFT5kB4SwpU+uv0hHIRv
	/P60gUWsByVrMyCGtivl0zPdJPGN3Gn9ZlHd/qE5MUJymqvVTLNkA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7FDBB23366;
	Fri, 12 Jan 2024 20:16:35 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F29DC23365;
	Fri, 12 Jan 2024 20:16:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  christian.couder@gmail.com
Subject: Re: [PATCH v4 1/2] t7501: add tests for --include and --only
In-Reply-To: <20240112180109.59350-2-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Fri, 12 Jan 2024 23:30:16 +0530")
References: <20240110163622.51182-2-shyamthakkar001@gmail.com>
	<20240112180109.59350-1-shyamthakkar001@gmail.com>
	<20240112180109.59350-2-shyamthakkar001@gmail.com>
Date: Fri, 12 Jan 2024 17:16:29 -0800
Message-ID: <xmqqmsta58ya.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 62359412-B1B1-11EE-A588-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> +test_expect_success '-i/--include includes staged changes' '
> +	echo newcontent >file &&
> +	echo newcontent >baz &&
> +	git add file &&
> +	git commit --include -m "file baz" baz  &&

I may have said this already, but the command invocation that does
not result in an error smells like a bug, and I doubt that we want
to etch the current behaviour into stone, which may make it harder
to fix [*].

Another related behaviour that I suspect is a bug is that if you did

    git add -u baz

instead of this "git commit -i baz", I think the command will
silently succeed without doing anything.  They may be the same bug,
because "git commit -i <pathspec>" is an equivalent to "git add -u
<pathspec>" followed by "git commit" after all.  Both should say
"there is no such path to update that matches the pathspec <baz>"
and error out, I suspect.

Thanks.

[Footnote]

 * A reasonable way out to unblock this particular patch may be to
   clarify that this test is only documenting the current behaviour
   without necessarily endorsing it.  Perhaps

	echo more >>file &&
	echo more >>baz &&
	git add file &&

	# Note: "git commit -i baz" is like "git add -u baz"
	# followed by "git commit" but because baz is untracked,
	# only "file" is committed.
	# This test only documents this current behaviour, which we
	# may want to fix, and when it happens, this needs to be
	# adjusted to the new behaviour.
	git commit -i -m "file and baz" baz &&

   or something, probably.
