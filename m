Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06FA36083
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ov8lDD06"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1704481606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tS6Scv5F3A6T7zKoGdthLvtFQ/qhdkdmAEq9L1thf1c=;
	b=ov8lDD065Bz4f9xPWRZ9xLXEMPPLi3MphF7txMG1FW3cX8/Gmp7aqGc2nJ+as0FktivA5i
	anqljTPKe75+D3Kb/zWFy2atBHmFmj4QB/Nyn5LI1ZSQ3uf7yPrJZwDEjReV09v+IVstvo
	OOWlow0gkJJx8lblmuZBG7Ng6pWCXol70QRAzhFtZ71T0Db3T2qZcEXXz2HU9giNtWIabx
	qJWU6g7WzESNyMaW1s9pJFgYHKXRhbnYU4p1WwkNVnXxeARJ8CD/uYX09WeCiiCWdku3oJ
	8VGCoz8OdzERmiPsatVyX8yvi4AJbkiRBMXOoxEmNRRpAuzxHTT1wljdh4wcVA==
Date: Fri, 05 Jan 2024 20:06:46 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Subject: Re: [BUG] mv: can trigger assertion failure with three parameters
 (builtin/mv.c:481)
In-Reply-To: <xmqqil47obnw.fsf@gitster.g>
References: <d1f739fe-b28e-451f-9e01-3d2e24a0fe0d@app.fastmail.com>
 <xmqqil47obnw.fsf@gitster.g>
Message-ID: <7c689d58c63998e6a690207be00d3875@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-05 19:52, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:
> 
>> You can trigger an assertion by giving these arguments to `git mv`:
>> 
>>     <dir>/file <dir> <other dir>
>> ...
>>> What did you expect to happen? (Expected behavior)
>> 
>> A normal error message if the command is nonsensical (I don’t know; 
>> that’s
>> not the point). Also `.git/index.lock` to be cleaned up.
> 
> Good find.

Yes, thanks to Kristoffer for reporting this issue.

> Not just that, but when the command fails in the middle like this,
> it leaves the working tree in a half-updated state, i.e.
> 
>> ./bin-wrappers/git -C $dir mv $dir/a/a.txt $dir/a $dir/b
> 
> will first move a/a.txt to b/a.txt, then try to move a (actually,
> all contents of it, including a/a.txt) to b/a and finds that "the
> command is nonsensical" and aborts, and by that time, there is no
> a/a.txt (i.e. the working tree has been modified).  The failure
> should be made atomic, just like "git switch" to another branch may
> stop _without_ touching anything in the working tree when it may
> have to fail (e.g., due to a file being dirty).
> 
> Thanks for reporting, Kristoffer.
> 
> Any takers?

This looks like a rather interesting bugfix to me. :)  Though, I've 
unfortunately contracted some _nasty_ flu, so I'm still simply unable to 
work on pretty much anything in the next 5-6 days or so, at which point 
I hope to be operational again.

Thus, unless someone else can get it done faster, I should be able to 
start working on it in about a week or so.  Hopefully, that is.

> $ git shortlog --since=3.years -s -n -e --no-merges v2.43.0 
> builtin/mv.c
>     15	Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
>     10	Elijah Newren <newren@gmail.com>
>      5	Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>      2	Junio C Hamano <gitster@pobox.com>
>      1	Andrzej Hunt <ajrhunt@google.com>
>      1	Calvin Wan <calvinwan@google.com>
>      1	Derrick Stolee <stolee@gmail.com>
>      1	Sebastian Thiel <sebastian.thiel@icloud.com>
>      1	Torsten Bögershausen <tboegi@web.de>
