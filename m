Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B463814F13A
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564392; cv=none; b=Ny5WcD8KQlPW4TfsucRRiTC6mcrhriRmMTY81mqgGIVDgFgLonHtBciIOXq6Mk9DMZIAHjnSQfDcM0ly78zDQ1/3QUkIOMgpXX5dPrAkcpO4nt+Bd1mO6ew/WdhZyNOE6+KamPQtSj/wPzpkIJhbXtVpH/QynV3/K6IFWwxDn/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564392; c=relaxed/simple;
	bh=LMsafZn38vQSfV4EWbH8fFgltL76efl8qfen4vnX7UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXuXw/j1LnoIyNfLRZrAz9AZ1440/uKtFSoVpz7+HljZeG7UXQ5m9ysSCIdHsRbqdgWJxvYao1ZhQ9dtmZ4TTMechSwIce4uHwq+DSf+8DaSSsJj+yhaKuVNCpfV+Mzev5D1SMgP+4/kaTGn/DOGS4gPwg5T6PCNvFqGEa/il4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=avGmnGF+; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="avGmnGF+"
Received: from [10.2.12.48] (unknown [10.2.12.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id 4D9741A05EAF;
	Wed, 27 Mar 2024 19:33:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1711564380; bh=LMsafZn38vQSfV4EWbH8fFgltL76efl8qfen4vnX7UA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=avGmnGF+mlSijpZcZHacQiwRWFlqPoged7/srJ4yYrpGoLAxLfNv9jNMjrXARwD3/
	 K71S54lM6JI8A9xlb3N71rt7U0wkdXKAgCQeG6tCISwBJ1Lf6VvH4hBLtluBhGGUXa
	 HXi2z1B+pjUYWeKCuRZ7mXGy5gJ9Ycbtvezt1T3k=
Message-ID: <7556a3de-a6a6-4284-8c36-3635ae43c653@schinagl.nl>
Date: Wed, 27 Mar 2024 19:33:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Allow git bisect to auto-skip
To: Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>
Cc: Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
References: <3d835c4b-d026-4c6a-b68e-6989a7a2065f@schinagl.nl>
 <xmqqwmptzyny.fsf@gitster.g>
 <01e09c64-4d62-406d-85fe-9fb77939cf63@haller-berlin.de>
 <xmqqle68x008.fsf@gitster.g>
 <e896da79-c87b-4475-9890-10051d8ddf76@haller-berlin.de>
 <CAP8UFD2DhkmVias+RfMESJz9Z-rKKHWHB+MFHcDb9QLO16TOhg@mail.gmail.com>
 <xmqq8r27sclp.fsf@gitster.g>
Content-Language: nl
From: Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <xmqq8r27sclp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24-03-2024 19:34, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
>> Also, how much better would this be compared to tracking  "git bisect
>> run" scripts in the repo, even if they have to be copied somewhere
>> else before they are launched? I wonder about this because writing the
>> conditions that decide whether the current commit is good or bad might
>> not be so easy either. So if the goal is to simplify things for users,
>> then simplifying all the way by providing example scripts with
>> comments about how they could be customized might be even better.
> 
> If we are driving our bisection session via "bisect run" script,
> computing the condition that we need to skip in the script is the
> most natural and obvious thing to do, but the way I guessed (because
> it was not explicitly written down) what the OP wanted was a way for
> bisect_next() called after even a manual "git bisect (good|bad)" to
> automatically skip certain set of commits.

I think you understood what I failed to properly explain :)

To come up with an RFC, I was trying to study the git code, and while 
some things are quite readable, others are a bit complex.

After some poking, I was thinking of using `find_bisection()`, or rather 
`do_find_bisection()` but got lost there.

What made sense initially was, that in `find_bisection()` there is a 
simple for loop that goes over the list of commits to count them. But 
writing this down, I realize the list of commits is already there in 
`struct commit_list *list`, so I should probably go find out where the 
list is being created!

Anyway, want I was thinking of, based a key somewhere in the message 
body (GIT_BISECT_SKIP=1 for example), mark the commit in the list to be 
skipped, as `git bisect skip` would. This so the skipped commit actualyl 
ends up on the list of skipped commits (`refs/bisect/skip-*`).

But being a bit lost, it would be nice to get some directional pointers.

Is this even possible? What is the easiest way to get the message from 
the `struct commit_list *list` item, are there helpers to parse the 
message at all?

Thanks,
Olliver

>  Because there are cases
> where you have to be testing manually and cannot afford to write
> "bisect run" script, giving a manual bisection a way to compute if a
> commit need to be skipped may be worth having, and that was where my
> "git bisect --skip-when <script>" came from.  It would not be
> necessary if you are doing "bisect run", which can dynamically tell
> if the commit is untestable.  And if the user is going to decide
> after manually testing the one that is suggested, it is not useful
> either, as the point would be to avoid even asking to test ones that
> need to be skipped.  So it is likely that the set of commits that
> need skipping is known a-priori before the bisect session even
> begins.  The end user experience may look like:
> 
>   * "git bisect start" takes "--skip-when <script>" and remembers it,
>     together with other options "start" can take (like <good>, <bad>,
>     <terms>, <pathspec>).
> 
>   - If <good> and <bad> are already given upon "start", the command
>     may check out a revision and ask you to test.
> 
>   * Every time the command checks out a revision to be tested by the
>     user, the command guarantees if it satisfies the --skip-when
>     condition (and internally doing "git bisect skip").
> 
>   * Otherwise the interaction between the user and the session is
>     exactly the same as usual.
> 
