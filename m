From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFH] eol=lf on existing mixed line-ending files
Date: Sat, 9 Apr 2011 22:58:59 +0400
Message-ID: <BANLkTimBewshVRYBibXJ7nDNoX0S0iDaUQ@mail.gmail.com>
References: <20110407231556.GA10868@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Mislav Marohnic <mislav@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 09 20:59:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8dNT-0002VM-HM
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 20:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316Ab1DIS7D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Apr 2011 14:59:03 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:55807 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106Ab1DIS7B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Apr 2011 14:59:01 -0400
Received: by qyk7 with SMTP id 7so500585qyk.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 11:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PGSMrtcVkPay8lJdYXkxK1UkhXpDowhEiVh9MNVDigs=;
        b=LwRQVQ9aYvgqqb5G/611KJnrWmlTi8w+Jxtrh6miLcPyHnC+1UjSag0+QONspA6hLS
         ZnbCpTLno5+Qoj404R85G87w7Sci0DRPEE7hMokd9akSQHn4X8yVJGw7kmOlVd+4FV1f
         Zv1dgTedk8sYzQtTMK91pP1Uz6tNWBe3M8ezc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F719jpZpIO8AG6lRYbXpf6H1u4lGiJBebRNccSvY7xukCnchzX3g99Uau40ey0oLBN
         7raI2SwSxQ/1uxrd1BcwoCulic+pCHWrIATBwkZtM82NEKK8F/ww/U6uuu/JiRkGuLhK
         ZYOpKbptTjMYxFBHmJoKAlomf5OPuirm7MTy0=
Received: by 10.229.66.151 with SMTP id n23mr2730622qci.268.1302375540039;
 Sat, 09 Apr 2011 11:59:00 -0700 (PDT)
Received: by 10.229.241.201 with HTTP; Sat, 9 Apr 2011 11:58:59 -0700 (PDT)
In-Reply-To: <20110407231556.GA10868@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171201>

On Fri, Apr 8, 2011 at 3:15 AM, Jeff King <peff@peff.net> wrote:
>
> =A0git init repo &&
> =A0cd repo &&
> =A0{
> =A0 =A0printf 'one\n' &&
> =A0 =A0printf 'two\r\n'
> =A0} >mixed &&
> =A0git add mixed &&
> =A0git commit -m one &&
> =A0echo '* eol=3Dlf' >.gitattributes
>
> Now if we run "git status" or "git diff", it will let us know that
> "mixed" is modified, insofar as adding and committing it would perfor=
m
> the LF conversion.

Well, git _may_ report that file is modified, but usually when you
change .gitattributes, git does not notice changes to file endings
until you touch those files. You can force git to notice changes in
all files by doing:

 $ touch -d 2000-1-1 .git/index

so it will re-read all files, but I guess it should be do that
automatically, otherwise many people end up with having inconsistent
file endings in their repository as result of editing .gitattributes
(or by just pulling a new version from the upstream).

>
> Now we come to the first confusing behavior. Generally one would expe=
ct
> the working directory to be clean after a "git reset --hard". But not
> here:
>
> =A0git reset --hard &&
> =A0git status
>
> will still show "mixed" as modified.

It is because you discard all changes except to .gitattributes.  If
=2Egitattributes were tracked, "reset" would discard them too, and you
would get clean original state.

> So that kind of makes sense. But it isn't all that helpful, if I just
> want to reset my working tree to something sane without making a new
> commit (more on this later).

If we do not discard changes to .gitattributes then the question is
what a sane state is? It is really difficult to define what is sane
when conversion to the work tree and back gives a different result.

> But here's an extra helping of confusion on top. Every once in a whil=
e,
> doing the reset _won't_ keep "mixed" as modified. I can trigger it
> reliably by inserting an extra sleep into git:

you can have the same effect by doing:

git reset --hard HEAD && sleep 1 && git touch .git/index

Ironically, that the race that you observed is result of fixing another
race in git when files are changed too fast, so they may have the same
timestamp. To prevent this race, git checks timestamp of .git/index
and a trcking file. If .git/index timestamp is older or same as that fi=
le,
this file is considered dirty. So, it is re-read from the disk to check
if there are any changes. This works well but only if conversion to the
work tree and back produces the same result.

> So we get two different outcomes, depending on the index raciness. Wh=
ich
> one is right, or is it right for it to be non-deterministic?

I like everything being deterministic, but in this case I do not see
how it is possible without making the normal case much slower.

> And one final question. Let's say I don't immediately convert this mi=
xed
> file to the correct line-endings.

IMHO, adding .gitattributes that specifies line endings while not
fixing actual line endings of existing files is really a bad idea.

As with any other filter, the rule is that conversion from git to
the working tree and back should give the same result for any file
in the repository, otherwise you will have a lot of troubles later.

> Hopefully my example made sense and was reproducible. The real repo
> which triggered this puzzle was jquery. You can try:
>
> =A0git clone git://github.com/jquery/jquery.git &&
> =A0cd jquery &&
> =A0git checkout 1.4.2 &&
> =A0git checkout master
>
> which will fail (but may succeed racily on a slow enough machine).
> Obviously they need to fix the mixed line-ending files in their repo.
> But that fix would be on HEAD, and "git checkout 1.4.2" will be forev=
er
> broken. Is there a way to fix that?

You cannot change the past history. Well, you can overwrite that
setting using .git/info/attributes. It does not make sense to do
that in general, but it may be useful if you do git bisect.

BTW, nowadays, we have much better alternative than using

* crlf=3Dinput

Instead of it, you probably want to use:

* text=3Dauto

which will automatically detect text files, so you won't have problems
with binary files. All text files are put into the repository with LF,
but users may have different endings in their working tree if they like=
=2E


Dmitry
