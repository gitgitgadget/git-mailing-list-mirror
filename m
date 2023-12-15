Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B1318027
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 22:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="c4ubBoGG"
Received: from [10.0.2.15] ([146.198.40.91])
	by smtp with ESMTPA
	id EGuXrrmSQJsy1EGuYrKTZL; Fri, 15 Dec 2023 22:44:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1702680243; bh=ric/+RoP7KOwA7IFPBvrzVFjWKXHeYnqhCg+VdVUwwA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=c4ubBoGG+Wkkn0f153DNcAqdTyEXbdoQnEaXqjI0VReqxgnNQRSZ1rzlJ+hcFi4iN
	 AoiZnYOEA6EwhwQqzkZk7nX5PeplWhKV9NA6ESOxMAXUvcsWctuJ1+168OyiuDWguW
	 eyl1CQ2ygnhJeZHhiR9d8+sP2XL8FA0CNeWGwtWXWHa3hztGD7Ma9/w40oA5mc9Gj5
	 b7V7/4naAbINetznxwzLY+nWvKmsspCG/BYrhx1VWl+QpBtPkq/F29QlaZlpN0A+WE
	 ZdEJ6JVEDe90AkCIJvyUzOJKx5pcHB96EeaAMKbZppKlgVPrZnHH3PT2fzOHifAyZY
	 jDEMBFnbOa2zQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=AOje/3mm c=1 sm=1 tr=0 ts=657cd6b3
 a=KA9ncW3+NP+rNtcBcdh9kA==:117 a=KA9ncW3+NP+rNtcBcdh9kA==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=prjRKK4mz11dLhNY2iwA:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Message-ID: <321b8084-fddb-4b5d-86af-7f88cb3edf7b@ramsayjones.plus.com>
Date: Fri, 15 Dec 2023 22:44:01 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] make room for "special ref"
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
References: <20231215203245.3622299-1-gitster@pobox.com>
 <xmqq5y0zkvqx.fsf@gitster.g>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqq5y0zkvqx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfH7V66Rob24OpoTAW4rkoico1LFgWKaWEiIT50lJYeG/3PTy7381IJ6XrTK079c4ogK5xkk4dS0SiHL2rGD2h9DDFHmceLsgz5EJ8/i0VOWbn84XE/rB
 Rn14G/UYbotaKW2sVCBfgssqiq9Pi0kKeMb2gg2Zulr33Tvnb1bt/Q0qPmaWPoAMQ5IjF0h3aSlLzdbn90w5n4oTMeoRgulzjW8=



On 15/12/2023 21:21, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> ...  For example, FETCH_HEAD currently stores not
>> just a single object name, but can and is used to store multiple
>> object names, each with annotations to record where they came from.
>> There indeed may be a need to introduce a new term to refer to such
>> "special refs".
> 
> The "may be" here vaguely hints another possibility.  If we manage
> to get rid of the "special refs", we do not even have to mention
> "special refs", and more importantly, we do not need extra code to
> deal with them.
> 
> For FETCH_HEAD, for example, I wonder if an update along this line
> is possible:
> 
>  * Teach "git fetch" to store what it writes to FETCH_HEAD to a
>    different file, under a distinctly different filename (e.g.,
>    $GIT_DIR/fetched-tips).  Demote FETCH_HEAD to a pseudoref, and
>    store the first object name in that "fetched-tips" file to it.
> 
>  * Teach "git pull" to learn what it used to learn from FETCH_HEAD
>    (i.e., list of fetched tips, each annotated with what ref at what
>    repository it came from and if it is to be merged) from the new
>    "fetched-tips" file.
> 
> The "special" ness of FETCH_HEAD is really an implementation detail
> of how "git pull" works and how the findings of "git fetch" are
> communicated to "git pull".  The general refs API should not have to
> worry about it, and the refs backends should not have to worry about
> storing more than just an object name (or if it is a symbolic ref,
> the target refname).
> 
> An end-user command like "git log ORIG_HEAD..FETCH_HEAD" would not
> be affected by changes along the above line, because the current
> FETCH_HEAD, when used as a revision, will work as if it stores the
> single object name that is listed first in the file.
> 
> If somebody is reading FETCH_HEAD and acting on its contents (rather
> than merely consuming it as a ref of the first object), perhaps
> feeding it to "git fmt-merge-msg", they will be broken by such a
> change (indeed, our own "git pull" will be broken by the change to
> "git fetch", and the second bullet point above is about fixing the
> exact fallout from it), but I am not sure if that is a use case worth
> worrying about.
> 
> Hmm?
> 

Yes, I was going to suggest exactly this, after Patrick pointed out
that there were only two 'special psuedo-refs' (I had a vague feeling
there were some more than that) FETCH_HEAD and MERGE_HEAD.

ATB,
Ramsay Jones


