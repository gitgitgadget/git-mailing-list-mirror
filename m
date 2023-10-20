Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CD2200C7
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uRPCVeFH"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0DBD7
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:31:21 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FA081C385E;
	Fri, 20 Oct 2023 13:31:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/4prPvbi7DFh
	LOr5i0frTu9ObZ11UUsorF84Fxh/Lyk=; b=uRPCVeFHQ9HXnkhj6dmIpiqA+6ai
	p0lnyQT7MnpnM4kJ81UGbeWc0HwfSOXs0C3nkcUWlE6o8FcvtJHf8KaGVxTzXVaW
	FmXqdkX5cKQap0yRjZhvm4vTPTgNxzsONxdrrKK2t0JDtVW9aBstMIgpYvWD8kxM
	d6A9KAjbGIf1LOY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 40F7C1C385D;
	Fri, 20 Oct 2023 13:31:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97E801C385A;
	Fri, 20 Oct 2023 13:31:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Isoken June Ibizugbe <isokenjune@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com
Subject: Re: [PATCH v2] builtin/branch.c: adjust error messages to coding
 guidelines
In-Reply-To: <331e1ab3-2e8c-497d-a05d-ef197d664188@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Thu, 19 Oct 2023 21:20:24 +0200")
References: <e08b2ec4-786a-4c18-b7af-0a6a250ae0f0@gmail.com>
	<20231019084052.567922-1-isokenjune@gmail.com>
	<331e1ab3-2e8c-497d-a05d-ef197d664188@gmail.com>
Date: Fri, 20 Oct 2023 10:31:18 -0700
Message-ID: <xmqqwmvhqjyx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7B0A0110-6F6E-11EE-A4DD-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> On 19-oct-2023 09:40:51, Isoken June Ibizugbe wrote:
>
>> As per the CodingGuidelines document, it is recommended that a single-=
line
>> message provided to error messages such as die(), error() and warning(=
),
>
> This is confusing; some multi-line messages are fixed in this series.
>
>> should start with a lowercase letter and should not end with a period.
>> Also this patch fixes the tests broken by the changes.

"Also this patch fixes the tests broken by the changes" -> "Adjust
tests to match updated messages".

> Well done, describing why the tests are touched.

Nicely reviewed.  But it is unclear to me how we want to mention
updates to multi-line messages.  Do we have a good reference in the
guidelines we can copy?

The general desire is for a single-liner to look like so:

    error: the branch 'foo' is not fully merged

and an untold assumption is that we strongly prefer a single
sentence in a single-liner error message---a full-stop to separate
multiple sentences can be omitted for brevity.

But we have follow-up sentences that are not strictly "errors" in
some messages, e.g.,

>> -		error(_("The branch '%s' is not fully merged.\n"
>> +		error(_("the branch '%s' is not fully merged.\n"
>>  		      "If you are sure you want to delete it, "
>> -		      "run 'git branch -D %s'."), branchname, branchname);
>> +		      "run 'git branch -D %s'"), branchname, branchname);

In a modern codebase with facilities from advice.c, we would
probably do "a single-liner error message, optionally followed by a
hint message", i.e.

    error: the branch 'foo' is not fully merged
    hint: If you are sure you want to delete it,
    hint: run "git branch -D foo".

but this message apparently predates wide use of the advice_if() and
friends.

But rewriting this error message to use advice is probably outside
the scope of this patch.  But for completeness it would probably
look something like this (with necessary ADVICE_FOO defined):

	error(_("the branch '%s' is not fully merged"), branchname);
	advice_if_enabled(ADVICE_DELETE_BRANCH,
                	  _("If you are sure you want to delete it,"
			    "run 'git branch -D %s'."));

If I were doing this patch, I'd probably just add

	/* NEEDSWORK: turn the remainder ofthe message into advice */

in front of the existing error() call for this one without touching
the message itself, as it will have to be touched again when such a
change happens.

Thanks.
