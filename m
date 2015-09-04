From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] filter-branch: add passed/remaining seconds on progress
Date: Fri, 4 Sep 2015 16:15:15 -0400
Message-ID: <CAPig+cRh-7BDOoumLxyh6_tNspL3ANq_wCE5f_VoQt6UwUFckQ@mail.gmail.com>
References: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
	<xmqqk2s6f2zj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?R8OhYm9yIEJlcm7DoXQ=?= <bernat@primeranks.net>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Mikael Magnusson <mikachu@gmail.com>, cbailey32@bloomberg.net,
	Lee.Carver@servicenow.com, Michael Witten <mfwitten@gmail.com>,
	Gabor Bernat <gabor.bernat@gravityrd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 22:15:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXxOM-0007qf-Fd
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 22:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760557AbbIDUPR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Sep 2015 16:15:17 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33734 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760063AbbIDUPQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Sep 2015 16:15:16 -0400
Received: by ykei199 with SMTP id i199so31878357yke.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 13:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=wIs/DP2HiUz7kNzw2dBFoxDZLnH1Xp1VUGwQTD48peU=;
        b=vOcbvVGYOirl6ZAvnSvqri3MgekofunoQyMFfJVtvvhoV3z3PqCFBIy/bFRbgmJgU8
         DIpU8EedcPeK4q2/amD1+paGzuV11TPHs+DB3FEr1eLjbyjDNJgZE78cKMx2XuYqqYgL
         st7LhLvR5iS2pvhVdKV4yq/h2OxlnPdp9xW9vvJHteEbZGPEL6E7MtY4z9hqm9Ei7rja
         1gG9M3c53eBm1npNWS/JZ82Vej+woTaLslRHzUasIMVfdiJ9PVyfh6vUdUNtRsKnJ4qN
         tnE3HdgclwJY0G4F/qGOgOmQHz4A8khnQ35i64ZM+wy4xuYxsk5dH0vDwARAbM0Ozdhy
         XTyg==
X-Received: by 10.170.81.5 with SMTP id x5mr6371701ykx.82.1441397715673; Fri,
 04 Sep 2015 13:15:15 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Fri, 4 Sep 2015 13:15:15 -0700 (PDT)
In-Reply-To: <xmqqk2s6f2zj.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: yRgARP4O_3eK8evPPhDN88Y1Nu4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277332>

On Fri, Sep 4, 2015 at 2:34 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> G=C3=A1bor Bern=C3=A1t <bernat@primeranks.net> writes:
>> +echo $(date +%s) | grep -q '^[0-9]+$';  2>/dev/null && show_seconds=
=3Dt
>
> That is very strange construct.  I think you meant to say something
> like
>
>         if date '+%s' 2>/dev/null | grep -q '^[0-9][0-9]*$'
>         then
>                 show_seconds=3Dt
>         else
>                 show_seconds=3D
>         fi

The final format suggested[1] for this test was:

    { echo $(date +%s) | grep -q '^[0-9][0-9]*$'; } 2>/dev/null &&
        show_eta=3Dt

> A handful of points:
>
>  * "echo $(any-command)" is suspect, unless you are trying to let
>    the shell munge output from any-command, which is not the case.

Primarily my fault. I don't know what I was thinking when suggesting th=
at.

>  * "grep" without -E (or "egrep") takes BRE, which "+" (one or more)
>    is not part of.

This seems to have mutated from the suggested form.

>  * That semicolon is a syntax error.  I think whoever suggested you
>    to use it meant to squelch possible errors from "date" that does
>    not understand the "%s" format.

This also mutated. The suggested form wanted to suppress errors from
'date' if it complained about "%s", and from 'grep'. In retrospect,
applying it to 'grep' is questionable. I was recalling this warning
from the Autoconf manual[2]:

    Some of the options required by Posix are not portable in
    practice. Don't use =E2=80=98grep -q=E2=80=99 to suppress output, b=
ecause many
    grep implementations (e.g., Solaris) do not support -q. Don't use
    =E2=80=98grep -s=E2=80=99 to suppress output either, because Posix =
says -s does
    not suppress output, only some error messages; also, the -s
    option of traditional grep behaved like -q does in most modern
    implementations. Instead, redirect the standard output and
    standard error (in case the file doesn't exist) of grep to
    /dev/null. Check the exit status of grep to determine whether it
    found a match.

however, Git tests use 'grep -q' heavily, so perhaps we don't worry abo=
ut that.

>  * I do not think you are clearing show_seconds to empty anywhere,
>    so an environment variable the user may have when s/he starts
>    filter-branch will seep through and confuse you.

The empty assignment was implied in my example, but I should have been
more explicit and shown a more complete snippet:

    show_eta=3D
    ...
    { echo $(date +%s) | grep -q '^[0-9][0-9]*$'; } 2>/dev/null &&
        show_eta=3Dt

The suggested 'if' form has the attribute of being clearer.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/276531/focu=
s=3D276837
[2]: https://www.gnu.org/software/autoconf/manual/autoconf.html#grep
