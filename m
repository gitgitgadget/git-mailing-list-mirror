Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82278F57
	for <git@vger.kernel.org>; Sun, 31 Dec 2023 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="mSQ0yxvh"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1704044476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HPIhIftQ4Mvu6TnvYLHcjRdJH3YLYYogRBDDULN/XlI=;
	b=mSQ0yxvh4BylwHVON6/zwT8riv0xe99jpTuDU3A/T66Ug6WJbaIx1nroNxqj1vK5QnBa+Y
	o1EpSUsxgiya8XypZHyeLFympczJAcp57piH2OTux3DAYB5af4Me1fa63L05WJ/UWQZvAL
	SmQxQjSrhJhp8oiQPr1jWnox7jKXcMqGsjgGNwBtVbV0CrhcW/Wbx9OPsFrHd7GqTARhvY
	aEg9ST4Xv/fpriYMfEiYGpjRr6RdEZ68C+dPSbjteKr/Za9+iTq0IXvSI2AOQfSgwVzFE5
	YV/IsXKK1dbrvCRDiJuspw/MybKVk2/M+tU41Tf4fxSdlegqENg8N7FwjLn/JQ==
Date: Sun, 31 Dec 2023 18:41:15 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
Subject: Re: Concurrent fetch commands
In-Reply-To: <xmqqy1daffk8.fsf@gitster.g>
References: <c11ca0b3-aaf4-4a8d-80a1-3832954aa7aa@haller-berlin.de>
 <xmqqy1daffk8.fsf@gitster.g>
Message-ID: <f7d4f092ea8955113c2d6c0346932b70@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-12-31 18:27, Junio C Hamano wrote:
> Stefan Haller <lists@haller-berlin.de> writes:
> 
>> I can reliably reproduce this by doing
>> 
>>    $ git fetch&; sleep 0.1; git pull
>>    [1] 42160
>>    [1]  + done       git fetch
>>    fatal: Cannot rebase onto multiple branches.
> 
> I see a bug here.
> 
> How this _ought_ to work is
> 
>  - The first "git fetch" wants to report what it fetched by writing
>    into the $GIT_DIR/FETCH_HEAD file ("git merge FETCH_HEAD" after
>    the fetch finishes can consume its contents).
> 
>  - The second "git pull" runs "git fetch" under the hood.  Because
>    it also wants to write to $GIT_DIR/FETCH_HEAD, and because there
>    is already somebody writing to the file, it should notice and
>    barf, saying "fatal: a 'git fetch' is already working" or
>    something.
> 
> But because there is no "Do not overwrite FETCH_HEAD somebody else
> is using" protection, "git merge" or "git rebase" that is run as the
> second half of the "git pull" ends up working on the contents of
> FETCH_HEAD that is undefined, and GIGO result follows.
> 
> The "bug" that the second "git fetch" does not notice an already
> running one (who is in possession of FETCH_HEAD) and refrain from
> starting is not easy to design a fix for---we cannot just abort by
> opening it with O_CREAT|O_EXCL because it is a normal thing for
> $GIT_DIR/FETCH_HEAD to exist after the "last" fetch.  We truncate
> its contents before starting to avoid getting affected by contents
> leftover by the last fetch, but when there is a "git fetch" that is
> actively running, and it finishes _after_ the second one starts and
> truncates the file, the second one will end up seeing the contents
> the first one left.  We have the "--no-write-fetch-head" option for
> users to explicitly tell which invocation of "git fetch" should not
> write FETCH_HEAD.
> 
> Running "background/priming" fetches (the one before "sleep 0.1" you
> have) is not a crime by itself, but it is a crime to run them
> without the "--no-fetch-head" option.  Since you have *NO* intention
> of using its contents to feed a "git merge" (or equivalent)
> yourself, you are breaking your "git pull" step in your example
> reproduction yourself.

Thank you very much for this highly detailed explanation.
