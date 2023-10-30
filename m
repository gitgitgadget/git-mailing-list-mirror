Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D60F7EE
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bVTrCNXk"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08824BF
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 18:59:18 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A0D802D65A;
	Sun, 29 Oct 2023 21:59:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=f+xytVevKh5xOIyS3MGy7oXQJNLks3lLLIst0C
	sS5no=; b=bVTrCNXkK29ngspWQ85Y+LUT2Q/GsddfhczvrTZFxRYPUFUaDH64oj
	JF2A3xJWZD3UOfSR8jdsq5q/+YBIp9oo1q7LrMoNLi/Ww4ut9mxW3s7oAt1TcGee
	3H8YfvBWGHn1nuBeiRV3WBkPJGlIeIb76maKAP+BDjjK/91uuBDpQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 97E642D659;
	Sun, 29 Oct 2023 21:59:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2AD3C2D657;
	Sun, 29 Oct 2023 21:59:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  emilyshaffer@google.com,
  git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>,  Sheik
 <sahibzone@gmail.com>,  Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v3] bugreport: reject positional arguments
In-Reply-To: <xmqqpm0xeyp9.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	30 Oct 2023 09:33:22 +0900")
References: <20231026005542.872301-1-nasamuffin@google.com>
	<20231026155459.2234929-1-nasamuffin@google.com>
	<CAPig+cTmYtWR=QN3LeN9yw3HmsKEmD2fUiRjKf=eJHhAZyT-yA@mail.gmail.com>
	<3e15f266-c790-4b71-84b6-1328339425c1@gmail.com>
	<xmqqv8apez0o.fsf@gitster.g> <xmqqpm0xeyp9.fsf@gitster.g>
Date: Mon, 30 Oct 2023 10:59:13 +0900
Message-ID: <xmqqcywwg9am.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 ED9A1264-76C7-11EE-A51F-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>> It is rather unfortunate that test_i18ngrep was deprecated without
>>> providing an alternative that offers the same debugging
>>> experience.
>> ...
>> We could rename test_i18ngrep to test_grep (and make test_i18ngrep
>> into a thin wrapper with warnings).
>>
>> 	test_grep -e must-exist file &&
>> 	test_grep ! -e must-not-exist file
>
> ... as the only remaining part in test_18ngrep has no hack to work
> around the tainted localization tests, so "was deprecated without"
> is a bit too strong.  There is nothing we have lost yet.

Having said all that, when re-reading the test_i18ngrep with a fresh
pair of eyes, I somehow doubt there was much upside in "debugging
experience" with test_i18ngrep in the first place, and I doubt if
retaining it with a new name test_grep has much value.

Given that test_i18ngrep (hence test_grep) requires you to have the
haystack in a file, between

    test_i18ngrep must-exist file &&
    test_i18ngrep ! must-not-exist file

and

    grep must-exist file &&
    ! grep must-not-exist file

I do not see any difference in "debugging experience" when you run
the test with "-i [-v] -d".   The two cases you care about are

 (1) the test expects the string "must-exist" in the file "file" but
     the string is not there.

 (2) the test expects the string "must-not-exist" missing from the
     file "file", but the string is there.

The latter can clearly be seen in output from "-i -v -d" (the "grep"
outputs a line with "must-not-exist" on it).  The former will show
silence but since you are debugging with "-d", and your haystack is
in a file, after such a step fails, the test stops, and without
removing the "file" even if the test piece had test_when_finished
to remove it (i.e. running tests in debugging mode "-d" and
immediately stopping upon failure "-i" behaves this way exactly to
help you debugging), so you can go there to the TRASH_DIRECTORY
yourself and inspect "file" to see what is going on anyway.

So, I dunno.  Surely with a long &&-chain of steps, where a grep
that expects lack of something is in the middle, it is hard to see
if the lack of hit is because an earlier step failed (and the
control did not reach "grep must-exist file") or because the
haystack lacked the "must-exist" needle, so from that point of view,
it may be nicer that "did not find an expected match" is explicitly
stated.
