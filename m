From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1.5/2] config: add options to list only variable names
Date: Thu, 28 May 2015 14:06:40 +0200
Message-ID: <CAP8UFD32erihiEqkwaR6B09rEW7WJJ=Aq955KqErr3MdfQ3S_w@mail.gmail.com>
References: <1432757240-4445-2-git-send-email-szeder@ira.uka.de>
	<1432757503-5787-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu May 28 14:07:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxwaV-0001qn-71
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 14:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185AbbE1MGr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2015 08:06:47 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37026 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110AbbE1MGl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2015 08:06:41 -0400
Received: by wifw1 with SMTP id w1so59278618wif.0
        for <git@vger.kernel.org>; Thu, 28 May 2015 05:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=X778yW0sjLjy1eCKRf57b+6Uf4FH6MiVLwGdLUtuhNE=;
        b=YUXAPP619LViNoxYRHTT3T3n4ZAh5fYXRQF0WT34uo5dBXckVzf/R0nwPB+MH0pUpQ
         K0+N3gPwA3RmuiPz9vSDjHFkQWzinWZPcOKeg6VQvCwfmCc76vtbwcfoRUQg8reH625p
         asK5FfQfWBb42AHrSIZYU7OWIBkD5PQBaKB1IS8v1wEGUREPiimDY8M2gX1PsZQlZzxT
         DX4wcwBfFqCarWExcBT0zbE8Qna7oTi88Zopr0AUoQUG+jC9LOrC/gEOuEzaOZr3gFHl
         DYtfNm+gNkMx/T4dWBcwRp0spI+bf6lUZRMSzmm5OBJYFD46RbC3J+VP0VYkic5Dkw2r
         zbzQ==
X-Received: by 10.194.242.195 with SMTP id ws3mr4789750wjc.155.1432814800656;
 Thu, 28 May 2015 05:06:40 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Thu, 28 May 2015 05:06:40 -0700 (PDT)
In-Reply-To: <1432757503-5787-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270139>

On Wed, May 27, 2015 at 10:11 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:
> Recenty I created a multi-line branch description with '.' and '=3D'
> characters on one of the lines, and noticed that fragments of that li=
ne
> show up when completing set variable names for 'git config', e.g.:
>
>   $ git config --get branch.b.description
>   Branch description to fool the completion script with a
>   second line containing dot . and equals =3D characters.
>   $ git config --unset <TAB>
>   ...
>   second line containing dot . and equals
>   ...
>
> The completion script runs 'git config --list' and processes its outp=
ut to
> strip the values and keep only the variable names.  It does so by loo=
king
> for lines containing '.' and '=3D' and outputting everything before t=
he '=3D',
> which was fooled by my multi-line branch description.
>
> A similar issue exists with aliases and pretty format aliases with
> multi-line values, but in that case 'git config --get-regexp' is run =
and
> subsequent lines don't have to contain either '.' or '=3D' to fool th=
e
> completion script.
>
> Though 'git config' can produce null-terminated output for newline-sa=
fe
> parsing, that's of no use in this case, becase we can't cope with nul=
ls in
> the shell.
>
> Help the completion script by introducing the '--list-names' and
> '--get-names-regexp' options, the "names-only" equivalents of '--list=
' and
> '--get-regexp', so it doesn't have to separate variable names from th=
eir
> values anymore.

Why don't you just add a '--name-only' option that can be used only
with '--list' and '--get-regexp'?

Like:

'git config' [<file-option>] [-z|--null] [--name-only] --get-regexp nam=
e_regex

and

'git config' [<file-option>] [-z|--null] [--name-only] -l | --list

?

It seems to me that it would reduce the number of options, and later
if we want to pass a format we could have maybe:

'git config' [<file-option>] [-z|--null] [--name-only |
--format=3D<format>] --get-regexp name_regex

and

'git config' [<file-option>] [-z|--null] [--name-only |
--format=3D<format>] -l | --list

Thanks,
Christian.
