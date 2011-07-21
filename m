From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [RFC/PATCH] grep --no-index: allow to grep without git exclusions
Date: Thu, 21 Jul 2011 09:11:25 +0200
Message-ID: <CAKPyHN2TMu2yO4sZDAqCce9P-5==Z2jKQVoU=zUsmUQJhHoeQg@mail.gmail.com>
References: <82218b89c89f733dc0759d648b3a60bca6e20f3e.1311165328.git.bert.wesarg@googlemail.com>
	<7vzkk86577.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 09:11:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjnPy-00010p-3b
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 09:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600Ab1GUHL1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jul 2011 03:11:27 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:65206 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498Ab1GUHL0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jul 2011 03:11:26 -0400
Received: by vws1 with SMTP id 1so700661vws.19
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 00:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=UN0EnOJsVEpi00Q2CBU3SEIoYXGVxrnWzCvcG1i4EIM=;
        b=Vvk8EuvZxD9E9Q+Mvv0ieB/KfrA317Yl+F47t+WE1WK5Bgadw32jiDsZIn2Q0D4Ne/
         8YCbS+/TEA6pPrr/sZY+1d7ALKAr3tkLfKFKQ0StrnARPFiRRAAvki+VNQw0MWHv+fXo
         45RkVLmlwI4AA8chWBm9TgwKQWsXczTjxiI3k=
Received: by 10.52.94.137 with SMTP id dc9mr9139689vdb.262.1311232285489; Thu,
 21 Jul 2011 00:11:25 -0700 (PDT)
Received: by 10.52.107.228 with HTTP; Thu, 21 Jul 2011 00:11:25 -0700 (PDT)
In-Reply-To: <7vzkk86577.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 20, 2011 at 22:57, Junio C Hamano <gitster@pobox.com> wrote=
:
> Taken in total isolation, this patch does allow a use case where we d=
id
> not allow, but when considered in a larger picture of what "grep" is =
used
> for and how different use cases the command should support, a few ran=
dom
> thoughts come to mind:
>
> =C2=A0- Like "diff --no-index", "grep --no-index" is about a director=
y that is
> =C2=A0 not managed by git at all with random collection of files. Do =
we even
> =C2=A0 want to be using any "exclude" in such a use case? Wouldn't it=
 actually
> =C2=A0 be a bug that we pay attention to standard-exlcludes in the cu=
rrent
> =C2=A0 code, as .gitignore files scattered in such a directory should=
 _not_
> =C2=A0 mean anything, as it is not a git working tree at all?
>
> =C2=A0- Even in a git managed directory, you _could_ use "grep --no-i=
ndex" to
> =C2=A0 find hits from both tracked and untracked files. In this parti=
cular use
> =C2=A0 case, it makes some sense to pay attention to "exclude", as th=
at would
> =C2=A0 catch what _could_ be committed, and paths that would be exclu=
ded won't
> =C2=A0 be part of that set (unless you use "add -f"). But wouldn't th=
at use
> =C2=A0 case better be covered by a switch that is different from --no=
-index
> =C2=A0 (which means "These are not managed by git at all")? It is sti=
ll about
> =C2=A0 files in a git working tree, it is just that the user wants us=
 to pay
> =C2=A0 attention also to untracked files, e.g. "grep --untracked-too"=
?
>
> So I think the patch identified a good problem to solve, but it might=
 be a
> wrong solution that encourages a use of a wrong option (i.e. --no-ind=
ex)
> only because we do not have the right one (i.e. "I am in the working =
tree,
> but I want untracked ones also considered.").
>
> What do people think if we did this a bit differently?
>
> =C2=A0- Since 3081623 (grep --no-index: allow use of "git grep" outsi=
de a git
> =C2=A0 repository, 2010-01-15) and 59332d1 (Resurrect "git grep --no-=
index",
> =C2=A0 2010-02-06), "grep --no-index" incorrectly paid attention to t=
he
> =C2=A0 exclude patterns. We shouldn't have, and we'd fix that bug.

I considered this when I noticed this, but feared the
backward-incompatibility. If you call it a bug, than we can change for
the better.

>
> =C2=A0- It might be useful to be able to "git grep" both tracked and =
untracked
> =C2=A0 (i.e. new files you may want to "git add") paths, but there is=
 no good
> =C2=A0 way to do so. Introduce a new option --untracked-too (or more =
suitable
> =C2=A0 name --- I am bad at naming and not married to this one) to al=
low
> =C2=A0 this. This mode always takes "exclude" into account.

My proposal would be to name it --include-untracked.

>
> Opinions?
>
> Regarding the patch:
>
>> + =C2=A0 =C2=A0 /* --no-exclude-standard needs --no-index */
>> + =C2=A0 =C2=A0 if (use_index && !exclude_standard)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die(_("--no-exclude-stan=
dard does not make sense without --no-index."));
>
> For that matter,
>
> =C2=A0 =C2=A0$ git grep --no-exclude-standard --exclude-standard --ca=
ched -e foo
>
> should be an error, no?
>

It should be. But I think that unveils one of the shortcomings of the
(any) option parser: You wont get notified when an option was given,
regardless of its value. To handle the above I would have to use
OPTION_CALLBACK to set an addition flag exc_given (like it is done in
git-ls-files) and test against this. The same problem is possible for
a number option, if you want to know whether the option was actually
given on the command line, one need to invent an invalid value (which
isn't always possible) and use this as the initializer or use
OPTION_CALLBACK again.

Bert
