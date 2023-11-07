Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8234430
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 03:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h8gMqKIS"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39953184
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 19:10:41 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A4971D0796;
	Mon,  6 Nov 2023 22:10:40 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jfG9hHiycIod
	DjIGXKdp8XbfmXdqPtf/uXsbEqxwh9c=; b=h8gMqKISGH+w/B0u+Mh6c64bmCbd
	iwuceUKmPTOP+DVhKiYaBh7yz1lO6PL4X7lxICi0ztl1ULY5R8GJSsTj4QMxmsUt
	ZfIzcCje2X2HnLnvMbeKg33mzjXnp/LrPbAYljvQmW77yxAKTMf5NEn7efokQM3o
	hxnGrN7ghBrDoek=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8065E1D0794;
	Mon,  6 Nov 2023 22:10:40 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CDF341D0793;
	Mon,  6 Nov 2023 22:10:39 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Sam James via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Sam James <sam@gentoo.org>
Subject: Re: [PATCH] diff: implement config.diff.renames=copies-harder
In-Reply-To: <CABPp-BEuvjduS4JiORJybKtoPWvJd+BbbR_JAvZdj4Px_v8H4A@mail.gmail.com>
	(Elijah Newren's message of "Mon, 6 Nov 2023 18:45:20 -0800")
References: <pull.1606.git.1699010701704.gitgitgadget@gmail.com>
	<CABPp-BEuvjduS4JiORJybKtoPWvJd+BbbR_JAvZdj4Px_v8H4A@mail.gmail.com>
Date: Tue, 07 Nov 2023 12:10:38 +0900
Message-ID: <xmqq7cmu9s29.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3AC4E3C6-7D1B-11EE-8A2F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Elijah Newren <newren@gmail.com> writes:

> On Fri, Nov 3, 2023 at 4:25=E2=80=AFAM Sam James via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Sam James <sam@gentoo.org>
>>
>> This patch adds a config value for 'diff.renames' called 'copies-harde=
r'
>> which make it so '-C -C' is in effect always passed for 'git log -p',
>> 'git diff', etc.
>>
>> This allows specifying that 'git log -p', 'git diff', etc should alway=
s act
>> as if '-C --find-copies-harder' was passed.
>>
>> I've found this especially useful for certain types of repository (lik=
e
>> Gentoo's ebuild repositories) because files are often copies of a prev=
ious
>> version.
>
> These must be very small repositories?  --find-copies-harder is really
> expensive...

True.  "often copies of a previous version" means that it is a
directory that has a collection of subdirectories, one for each
version?  In a source tree managed in a version control system,
files are often rewritten in place from the previous version,
so I am puzzled by that justification.

It is, in the proposed log message of our commits, a bit unusual to
see "This patch does X" and "I do Y", by the way, which made my
reading hiccup a bit, but perhaps it is just me?

>> diff --git a/Documentation/config/diff.txt b/Documentation/config/diff=
.txt
>> index bd5ae0c3378..d2ff3c62d41 100644
>> --- a/Documentation/config/diff.txt
>> +++ b/Documentation/config/diff.txt
>> @@ -131,7 +131,8 @@ diff.renames::
>>         Whether and how Git detects renames.  If set to "false",
>>         rename detection is disabled. If set to "true", basic rename
>>         detection is enabled.  If set to "copies" or "copy", Git will
>> -       detect copies, as well.  Defaults to true.  Note that this
>> +       detect copies, as well.  If set to "copies-harder", Git will t=
ry harder
>> +       to detect copies.  Defaults to true.  Note that this
>
> "try harder to detect copies" feels like an unhelpful explanation.

Yup.  "will spend extra cycles to find more copies", perhaps?
