Received: from smtp83.ord1d.emailsrvr.com (smtp83.ord1d.emailsrvr.com [184.106.54.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A1C1C69D
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 02:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791772908; cv=none; b=j2qi9itKVRGzYwwqQIXg1Vt6CnrlumcJNmeX0jj7MMwDvHherlBVVNSF0lRmGbJoSGJu2NX29xo1bZZzz6TJe2nquDiRYCwzQrGZR/Qjfb0ZUx2/D0v1nAb2m+wtHCNuGTKFsyfyvXKUwYgQ/V+Xw6SL4zNRbNB0O1hPDFy+wMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791772908; c=relaxed/simple;
	bh=VCRQ0jwTevMgbuMy1gSQHL49nVVnNTLUEm2X25gfNaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqTwrFBO1Y8kHgjmKQZOSKr7hO4geRCjRbg83BpIMXrTi7B+tQwpZLXyGSZc+r9DxqHD1HvyTFBrXiELGFvOrcNHTX91GPWjtP/VWkcOkhpic3AkmI7nOaHCwyR0kZDH6Jn/6KzWu2JscTINOOaho5OkGe+UFYoeeYUocI+s0a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=VEMuYTEJ; arc=none smtp.client-ip=184.106.54.83
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="VEMuYTEJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791769609;
	bh=VCRQ0jwTevMgbuMy1gSQHL49nVVnNTLUEm2X25gfNaI=;
	h=Date:Subject:To:From:From;
	b=VEMuYTEJl+AF8BlyambVnVl1aKnHbyGsgL+wN4/C2QTvyI1Z9J+/rHczdRb0Q5+3s
	 DGABT/Rcq2yjm/0WnuKki5mHR22G9RsAVqOyK/cvbY+CRtcCbBoyeLMO9QnuKhz2hp
	 AlUdQCUobk/M/XcXwwz9vVQypkX2d2K5hNSZdbq0=
X-Auth-ID: jon@jonsimons.org
Received: by smtp3.relay.ord1d.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 5D95F6029A;
	Sun, 11 Oct 2026 21:46:49 -0400 (EDT)
Message-ID: <4978013d-36c4-4441-a93c-68f1f35c06d0@jonsimons.org>
Date: Sun, 11 Oct 2026 21:46:48 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] SubmittingPatches: avoid add-failing-test-then-fix
 anti-pattern
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Patrick Steinhardt <ps@pks.im>
References: <20261011153206.72386-1-jon@jonsimons.org>
 <xmqq5wz7dcpx.fsf@gitster.g>
Content-Language: en-US
From: Jon Simons <jon@jonsimons.org>
In-Reply-To: <xmqq5wz7dcpx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Classification-ID: fc811441-f3c0-4178-bef0-82ce49c56ddb-1-1

On 10/11/26 7:44 PM, Junio C Hamano wrote:
> Jon Simons <jon@jonsimons.org> writes:
> 
>> +When fixing a bug, you may find it useful to first write a test using
>> +`test_expect_failure` to confirm that the test exposes the bug.
>> +However, unless there is a strong reason not to, submit the test as
>> +`test_expect_success` in the same commit as your code change that
>> +fixes the bug.  A separate commit that only changes `test_expect_failure`
>> +to `test_expect_success` can leave the behavior being tested out of the
>> +diff context, making the fix harder to review.  Reviewers who want to
>> +verify that your test reproduces the bug can temporarily undo the code
>> +changes while keeping the test.
> 
> This indeed matches what contributors have been told to do.
> 
> But do we even need to say the first two and a half lines?  One
> might find it convenient not to write any tests, or to be satisfied
> with manual testing, or to send test_expect_failure() separately
> and early.  None of these is what we recommend.
> 
> As you described, adding a test_expect_failure() test with a large
> body alone in one patch, and fixing the code in another patch would
> show a change from test_expect_failure() to test_expect_success()
> without showing much of the body of the test in the second patch,
> making the review unnecessarily cumbersome.  If the test is trivial
> and small, it may fit within the diff context and avoid such a
> problem, but then there is no need to add such a small test as a
> failing one in a separate patch in the first place, unless the goal
> is to inflate the commit count.
> 
> So, unless we can think of concrete cases that qualify as a
> "strong reason", I do not think we want to write everything before
> and up to "a strong reason not to" in your text.

Ack, I think this makes sense.  I do not have a list of concrete cases
that would fit a "strong reason" and be applicable in the general sense.

> How about a short and sweet sentence like this instead?
> 
>     A bugfix patch should include tests in test_expect_success()
>     blocks that demonstrate the breakage when the code change that
>     implements the fix is omitted.

Much crisper, I will apply this to a v2.


Thanks,
-Jon
