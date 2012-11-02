From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 04/14] Add new simplified git-remote-testgit
Date: Fri, 2 Nov 2012 16:42:42 +0100
Message-ID: <CAMP44s0n_O-7j329WyTxsWgVbCV2mEAnPG-WQeWBFdmHdfOjnQ@mail.gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
	<1351821738-17526-5-git-send-email-felipe.contreras@gmail.com>
	<5093D0DD.3050801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 16:42:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUJOa-0008KO-Gs
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 16:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757636Ab2KBPmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 11:42:43 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:42553 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757441Ab2KBPmm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 11:42:42 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so3760975oag.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 08:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YK7WoW59PAPEIh4JpMBwuJcrAvTas8Onp/NZ8CwoSqc=;
        b=lzpJqE4Xw08t1JBsXbicwaQ51NZBRwumfbwBqow3H8zwHyyaUPh25y3L9m32ew512q
         I66yn9zKEm1hOqbmo9TheRyafIii8gD0iZ7pFoALJ/ldIr1FW1su1tBZYi9ZkFFizfKH
         X/vAiYurSaBT3TMinfRe8FVHw3+f3rrcRnC552wsZuJnfdFBmaOqpdwD2Pc3F+IV9deD
         j2gZTpieT6srZydnpSRY6aQK6584xdTokCRV08glkrIa9+h7uFvqRfTI4HZ0rgxNTLnk
         WGcNl13POyCPpJIYl8YwSJ22dLMlZ8cW2KVRwzU++d+qH9sorH/P5usC6Gxu61SfcKSX
         6CZw==
Received: by 10.60.1.164 with SMTP id 4mr1679319oen.96.1351870962129; Fri, 02
 Nov 2012 08:42:42 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Fri, 2 Nov 2012 08:42:42 -0700 (PDT)
In-Reply-To: <5093D0DD.3050801@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208954>

On Fri, Nov 2, 2012 at 2:55 PM, Stefano Lattarini
<stefano.lattarini@gmail.com> wrote:

>> +#!/bin/bash
>>
> I think git can't assume the existence of bash unconditionally, neither
> in its scripts, nor in its tests (the exception being the tests on
> bash completion, of course).  This script probably need to be re-written
> to be a valid POSIX shell script.

Well, this is a _reference_ script, and that is used only for testing
purposes. The test itself can be like the bash completion tests, and
simply be skipped.

The reason I chose bash is because associative arrays, which you see
in a later patch.

> It almost is, anyway, apart from the nits below ...
>
>> +# Copyright (c) 2012 Felipe Contreras
>> +
>> +alias="$1"
>>
> Just FYI: the double quoting here (and in several variable assignments
> below) is redundant.  You can portably write it as:
>
>     alias=$1
>
> and still be safe in the face of spaces and metacharacters in $1.
> I'm not sure whether the Git coding guidelines suggest the use of
> quoting in this situation though; if this is the case, feel free
> to disregard my observation.

What happens when you call this with:

 ./script "alias with spaces"

>> +url="$2"
>> +
>> +# huh?
>> +url="${url#file://}"
>> +
>> +dir="$GIT_DIR/testgit/$alias"
>> +prefix="refs/testgit/$alias"
>> +refspec="refs/heads/*:${prefix}/heads/*"
>> +
>> +gitmarks="$dir/git.marks"
>> +testgitmarks="$dir/testgit.marks"
>> +
>> +export GIT_DIR="$url/.git"
>> +
> I believe this should be rewritten as:
>
>   GIT_DIR="$url/.git"; export GIT_DIR
>
> in order to be portable to all the POSIX shells targeted by Git.

_If_ we want this as POSIX, yeah.

>> +mkdir -p "$dir"
>> +
>> +test -e "$gitmarks" || echo -n > "$gitmarks"
>> +test -e "$testgitmarks" || echo -n > "$testgitmarks"
>> +
> The '-n' option to echo is not portable.  To create an empty
> file, you can just use
>
>    : > file
>
> or
>
>    true > file

All right, thanks.

>> +while read line; do
>> +    case "$line" in
>>
> Useless double quoting (my previous observation about Git coding
> guidelines applies here as well, of course).

What if line has multiple spaces? To me it makes sense to quote it.

>> +        echo "feature import-marks=$gitmarks"
>> +        echo "feature export-marks=$gitmarks"
>> +        git fast-export --use-done-feature --{import,export}-marks="$testgitmarks" $refs | \
>>
> Better avoid the tricky {foo,bar} bashism:
>
>     git fast-export --use-done-feature \
>                     --import-marks="$testgitmarks" \
>                     --export-marks="$testgitmarks" \
>                     $refs | \

If that's what we want, yeah.

-- 
Felipe Contreras
