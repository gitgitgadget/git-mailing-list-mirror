Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C1D208AA
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 18:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cXG33mBv"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC2DD61
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 11:06:06 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 94F9D1C3BE1;
	Fri, 20 Oct 2023 14:06:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9U2n1TJ5t2KS
	NtiKsV2oVuo1bGgXjpx0mzSMhWNNZd0=; b=cXG33mBvPVTiwxMB+n8VsTMNYSz6
	m13IsgDxG4aSu1QYfWLj2lErZt+kRhUVhXuAsGmIc7rzGVX5PTp0AZyH91wQqRub
	Qkq3+q75iBYY7WGb0o0wwv9wOZfGC2igtfNA0VL0SNDR7O8NfzWvVkukuaV9hJfm
	lXkFZpcBC5j6aow=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A2B31C3BE0;
	Fri, 20 Oct 2023 14:06:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D20711C3BDF;
	Fri, 20 Oct 2023 14:06:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  ks1322@gmail.com,
  git@vger.kernel.org
Subject: Re: [PATCH v2] grep: die gracefully when outside repository
In-Reply-To: <CAPig+cTBYw9=Wo=TR8MD5xX9hgurnfR2Xzc_wHSYnL1R00=xpw@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 20 Oct 2023 13:05:03 -0400")
References: <087c92e3904dd774f672373727c300bf7f5f6369.1697317276.git.code@khaugsbakk.name>
	<5c8ef6bec1c99e0fae7ada903885a8e77f8137f9.1697819838.git.code@khaugsbakk.name>
	<CAPig+cTBYw9=Wo=TR8MD5xX9hgurnfR2Xzc_wHSYnL1R00=xpw@mail.gmail.com>
Date: Fri, 20 Oct 2023 11:06:03 -0700
Message-ID: <xmqqcyx9qid0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 55F2783A-6F73-11EE-A1B5-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Oct 20, 2023 at 12:40=E2=80=AFPM Kristoffer Haugsbakk
> <code@khaugsbakk.name> wrote:
>> Die gracefully when `git grep --no-index` is run outside of a Git
>> repository and the path is outside the directory tree.
>>
>> If you are not in a Git repository and say:
>>
>>     git grep --no-index search ..
>>
>> You trigger a `BUG`:
>>
>>     BUG: environment.c:213: git environment hasn't been setup
>>     Aborted (core dumped)
>>
>> Because `..` is a valid path which is treated as a pathspec. Then
>> `pathspec` figures out that it is not in the current directory tree. T=
he
>> `BUG` is triggered when `pathspec` tries to advice the user about how =
the
>> path is not in the current (non-existing) repository.
>
> s/advice/advise/
>
> (probably not worth a reroll)

The only remaining niggle I have is that the effect of this change
would be much wider than just "grep", but in "git shortlog" output
it may appear that this is specific to it, making later developers'
life a bit harder when they are hunting for the cause of a behaviour
change that is outside "grep", but still caused by this patch.

But I think I am worried too much in this particular case.  Once
this codepath is entered, the code will die no matter what, and we
are merely making it die a bit more nicely.

There still is the "we say different things depending on the path
outside the hierarchy exists or not" raised by Peff remaining, but
for now, let's declare a victory and merge it to 'next'.

Thanks.


