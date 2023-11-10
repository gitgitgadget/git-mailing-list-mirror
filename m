Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAB86FAA
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 06:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AUfBp5JV"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EC56FB2
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 22:26:48 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C941F1B8FA2;
	Thu,  9 Nov 2023 23:09:57 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AJNFcX+bnA5e
	gj3xsseWegFUeLNGGoWwMF3mGB4IwtY=; b=AUfBp5JV3l6XxnOoRv7fRKK8Ern5
	Im/occjQVlWH36vOIR071zKDgDSsiARCya09v9VNm/7linYQiNMS5cnIcXGFSpMw
	nTLuhPdvaH0uT6K0E1ivQeTZRKMUNc/KQvfoPcEmpqeTs6k//uxFJq9HErn+qz1f
	xaBGEkHh9L7qpF0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C16D61B8FA1;
	Thu,  9 Nov 2023 23:09:57 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 27EFB1B8F9F;
	Thu,  9 Nov 2023 23:09:57 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Malik Rumi <malik.a.rumi@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: recover lost file
In-Reply-To: <CAKd6oBxF8m09QnqZ46joVpcR3mrR4MRSO+kL8vELGwVhD=rgXg@mail.gmail.com>
	(Malik Rumi's message of "Thu, 9 Nov 2023 21:02:39 -0600")
References: <CAKd6oBxF8m09QnqZ46joVpcR3mrR4MRSO+kL8vELGwVhD=rgXg@mail.gmail.com>
Date: Fri, 10 Nov 2023 13:09:55 +0900
Message-ID: <xmqqmsvmw8oc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 025552E4-7F7F-11EE-89E9-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Malik Rumi <malik.a.rumi@gmail.com> writes:

> I am looking for a lost file that was accidentally deleted about 18
> months ago. The docs I consulted are version 2.42.1. The git on my
> machine is version 2.34.1
>
> I followed the instructions on this page=E2=80=9D
> https://git-scm.com/book/en/v2/Git-Tools-Searching , the section =E2=80=
=9CLine
> Log Search=E2=80=9D. But I got an error.
>
> malikarumi@Tetuoan2:~/Projects/hattie$ git grep titlesplit
> malikarumi@Tetuoan2:~/Projects/hattie$ git grep filesplit
> malikarumi@Tetuoan2:~/Projects/hattie$ git log -L :titlesplit
> fatal: -L argument not 'start,end:file' or ':funcname:file': :titlespli=
t
> malikarumi@Tetuoan2:~/Projects/hattie$ git log -L :titlesplit:
> fatal: -L argument not 'start,end:file' or ':funcname:file': :titlespli=
t:
>
> I don=E2=80=99t know the purpose of the colon. Is it a boundary marker?=
 Does
> it belong at the front of the search object, the end, or both?
> 'start,end:file' sounds like the error message expects me to provide a
> start and an end, to which the obvious reply is - If I knew where it
> was, I wouldn=E2=80=99t be trying to find it.

Whatever documenttion that gave you "-L" perhaps did not give you a
good example. =20

    $ git log -L"20,+5:helloworld.c"
    $ git log -L"/^titlesplit(/,/^}/:helloworld.c"
    $ git log -L":titlesplit:helloworld.c"

are ways to follow, how the range of lines in the helloworld.c file
of the CURRENTLY CHECKED OUT version, came about throughout the
history, going backwards.  The way to specify the range in the
current version of helloworld.c file may be different (the examples
show "starting at line #20, for five lines", "starting at the line
that matches the pattern "^titlesplit(", and ending at the line that
matches the pattern "^}", or "the body of the 'titlesplit' function
(according to the xfuncname logic)"), but they share one important
detail that may make the feature unsuitable for your use case.  You
need to exactly know where in the current version of which file the
line range you want to follow resides, but from your description I
am getting an impression that you do not even know the name of the
file.

You only said "a lost file" without giving any specifics, so it is
totally unclear to readers of your message how strings like
"titlesplit" and "filesplit" relate to what you are looking for.  In
the above I randomly made a blind guess that it might be a function
name, but I may be totally off the mark.

 - Do you mean "I think the file I removed had a name with either
   titlesplit or filesplit in it?"

 - Or do you mean "I know that the file had a definition of a
   function whose name was either titlesplit or filesplit?"

 - Or something completely different from the above two?

If I know all of the followings are true:

 - I had the necessary contents committed in Git;

 - I do not remember the filename at all, but I am sure I deleted it
   and committed the deletion some time ago;

 - I know the lost contents I am looking for had a string "frotz" in
   it.

then I would probably try

    $ git log -Sfrotz --diff-filter=3DD -p

which will look for all file deletions throughout the history,
limiting the output to those that had string "frotz" in them.

But again, it is unclear what useful clue you have to locate the
lost file from your description, so ...

