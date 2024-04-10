Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54AE159218
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745556; cv=none; b=Wf/5sWHML5qzSj+C11g5kAcqi4tCv8kVzmNEZ0FUhJxMGdjlDJMslRiBm12PaO8n/0fDvoYv7sigGRHWfYlU0T7DlmdkWFnE+JTeCMLj35/c0liXyHRXfYf56IWfp5Qr4bTtQJFjg3utjyiwW++O0a+h6W4u7Uw2e2LfSoeGA9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745556; c=relaxed/simple;
	bh=yk2R0DPHvN3p6akq4HfwEb77VpafPgwvmCXUTOmytW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bALD0Qs5ntJnGLEtYEmb9RpQD3yEJNLG+6LOJJdFYOmNwSVibNZRvcIrNoKH83mtbM1HOG3Yw1Opl3TQPQ2HpmYKBi7sIUZhfEZ4ykztlapPa951EvhIhzfkeYMmvcIQfWsq+ccbKvCeyuMRBTTQIpddDGwuzD3dMTgr5yKhRxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=M2jEEnFs; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="M2jEEnFs"
Received: from [10.2.12.77] (unknown [10.2.12.77])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id 8F1221A1E807;
	Wed, 10 Apr 2024 12:39:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1712745543; bh=yk2R0DPHvN3p6akq4HfwEb77VpafPgwvmCXUTOmytW4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=M2jEEnFsC3C2ZCert9fulwNuaps3LoGnIXSJ608E6PcbjZBOojbFvV7QU/LTAeDZD
	 9NSFHAc6AIVO8WpBBn1+7BB4Dbr12KLBpGym6neHzTF1fnpG6XL6DjeiiPHND5MKxX
	 2fnam0og3WY4aTG47g5yv2bxMZksnQ7zLheig9ew=
Message-ID: <116dd27e-2e30-4915-a131-6c71c999fccd@schinagl.nl>
Date: Wed, 10 Apr 2024 12:39:03 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] bisect: Introduce skip-when to automatically skip commits
To: Junio C Hamano <gitster@pobox.com>, phillip.wood123@gmail.com
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org,
 Christian Couder <christian.couder@gmail.com>,
 Stefan Haller <lists@haller-berlin.de>
References: <20240330081026.362962-2-oliver@schinagl.nl>
 <864b0f22-b07b-469b-8fc2-56940fd89a8b@schinagl.nl>
 <xmqqcyr3s3gj.fsf@gitster.g>
 <b194ba7c-454b-494f-bef2-e9eac7ca87f1@schinagl.nl>
 <4bedcad2-218a-4b16-88a7-cc70cc126af3@gmail.com>
 <6dd4a5a4-9999-4c04-a854-09fc238c91bb@schinagl.nl>
 <d10bd772-2cf1-4838-bec2-ea2a639cabab@gmail.com>
 <2542ebd6-11ce-496b-b10b-b55c3a211705@schinagl.nl>
 <c4ed3e05-ae9f-42dd-835e-a52e710e70fd@gmail.com> <xmqqzfu3dcl1.fsf@gitster.g>
Content-Language: nl
From: Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <xmqqzfu3dcl1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08-04-2024 18:49, Junio C Hamano wrote:
> phillip.wood123@gmail.com writes:
>
>>>> get_terms() wants to read the first line into `term_bad` and the
>>>> second line into `term_good` so it makes sense that it uses two
>>>> calls to `strbuf_getline()` to do that. It does not want to read
>>>> the whole file into a single buffer as we do here.
>>> Right, but I why not use strbuf_getline()?
>> Because you want the whole file, not just one line as the script name
>> could potentially contain a newline
> It is technically true, but it somehow sounds like an implausible
> scenario to me.  The real reason why read_file() is preferrable is
> because you do not have to write, and we do not want to see you write,
> the whole "open (and handle error), read, chomp, and return" sequence.
>
> I would even suspect that get_terms() is a poorly written
> anti-pattern.  If I were adding that function to the system today, I
> wouldn't be surprised if I did read_file() the whole thing and
> worked in-core to split two items out.

So I've peaked at it, and think something like:

+int bisect_read_terms(const char **read_bad, const char **read_good)
+{
+       struct strbuf sb = STRBUF_INIT;
+
+       if (!strbuf_read_file(&sb, git_path_bisect_terms(), 0)) {
+               *read_bad = "bad";
+               *read_good = "good";
+               return -1;
+       }
+
+       terms = strbuf_split(&sb);
+       *term_bad = strbuf_detach(terms[0], NULL);
+       *term_good = strbuf_detach(terms[1], NULL);
+
+       strbuf_release(&sb);
+
+       return 0;
+}

would do the trick. This function could then be called from 
builtin/bisect.c as well to have a single interface. Right now, there's 
two ways to do the same thing, just because the arguments to the 
function are different, and the body is slightly different, but the same.

Shall I send a MR with this?

>
>> If I understand correctly we're encouraging the user to run "git
>> bisect skip" from the post checkout script. Doesn't that mean we'll
>> end up with a set of processes that look like
>>
>> 	- git bisect start
>> 	  - post checkout script
>>              - git bisect skip
>>                - post checkout script
>>                  - git bisect skip
>>                    ...
>>
>> as the "git bisect start" is waiting for the post checkout script to
>> finish running, but that script is waiting for "git bisect skip" to
>> finish running and so on. Each of those processes takes up system
>> resources, similar to how a recursive function can exhaust the
>> available stack space by calling itself over and over again.
> True.  What such a post-checkout script can do is to only mark the
> HEAD as "untestable", just like a run script given to "bisect run"
> signals that fact by returnint 125.  And at that point, I doubt it
> makes sense to add such a post-checkout script for the purpose of
> allowing "bisect skip".
>
> Having said that, a post-checkout script and pre-resume script may
> have a huge value in helping those whose tests cannot be automated
> (in other words, they cannot do "git bisect run") when they need to
> tweak the working tree during bisection.  We all have seen, during a
> bisection session that spans a segment of history that has another
> bug that affects our test *but* is orthogonal to the bug we are
> chasing, that we "cherry-pick --no-commit" the fix for that other
> problem inside "git bisect run" script.  It might look something
> like
>
>      #!/bin/sh
>      if git merge-base --is-ancestor $the_other_bug HEAD
>      then
> 	# we need the fix
> 	git cherry-pick --no-commit $fix_for_the_other_bug ||
> 	exit 125
>      fi
>
>      make test
>      status=$?
>      git reset --hard ;# undo the cherry-pick
>      exit $status
>
> But to those whose test is not a good match to "git bisect run", if
> we had a mechanism to tweak the checked out working tree after the
> "bisect next" (which is an internal mechanism that "bisect good",
> "bisect bad", and "bisect skip" share to give you the next HEAD and
> the working tree to test) checks out the working tree before it
> gives the control back to you, we could split the above script into
> two parts and throw the "conditionally cherry-pick the fix" part
> into that mechanism.  We'd need to have a companion script to "redo
> the damage" (the "reset --hard" in the above illustration) if this
> were to work seamlessly.  That obviously is totally orthogonal to
> what we are discussing in this thread, but may make a good #leftoverbits
> material (but not for novices).

While completly orthonogal, I agree; it would be nice to have and 
'abuse' for the bisect-skip usecase. So if we ignore the fact that it 
can be abused for this (which I don't think is a bad thing, it just 
risks the recursive issue Phillip mentioned.


As I'm not familiar with the deeps of bisect, I just use it as a dumb 
simple user, e.g. start; good, bad; I'm not sure the usecase you are 
describing is completly clear to me.

Are you saying 'git bisect run` is great, but not useful in all 
situations, and so in some cases, we want what you just said? Or would 
this also be part of git bisect run?

I've drafted the post-checkout and pre-resume here: 
https://gitlab.com/olliver/git/-/commit/6b5415377600551c0d94a359fd4b8ca7a3678dcf 
where I'm not clear on what the best points are for for the pre/post 
points. I've put the 'pre' bit in the bisect_state function, as that was 
being triggered by many suboptions, but might not be correct based on 
your answer to the above 
(https://gitlab.com/olliver/git/-/commit/6b5415377600551c0d94a359fd4b8ca7a3678dcf#46324e17f99db64a67eb9a5983ffc3a680914ee3_1001_1028). 
The post-checkout part, I've put in bisect_next 
(https://gitlab.com/olliver/git/-/commit/43993fca32f174f1005c7a445887c0ba5c4036b5#46324e17f99db64a67eb9a5983ffc3a680914ee3_672_717) 
which seems to match what you described.


Olliver

