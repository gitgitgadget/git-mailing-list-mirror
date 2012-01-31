From: Paul Berry <stereotype441@gmail.com>
Subject: Re: [BUG] git clean -X skips a directory containing only ignored files
Date: Tue, 31 Jan 2012 09:39:02 -0800
Message-ID: <CA+yLL65OWXMGnftKzpLLnESd_-Ogyj_UXg2m7h0FSyriuh91pw@mail.gmail.com>
References: <CA+yLL67J-7U9z7HVvq5wTc1g4_UCtqYfEyqdt7XR5zDqvQN5NA@mail.gmail.com>
	<4F27FF01.6040706@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 18:39:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsHfv-00015U-2E
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 18:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682Ab2AaRjF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Jan 2012 12:39:05 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:65403 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270Ab2AaRjE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2012 12:39:04 -0500
Received: by bkcjm19 with SMTP id jm19so190131bkc.19
        for <git@vger.kernel.org>; Tue, 31 Jan 2012 09:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Kg7jetEpHID6Gar/hnmKwNzilU73dAsF4dKPsxQ3UCU=;
        b=BZ1Jr+qhIvxaURf1aTHRcpReKaoyH5fzqoi2aGGS8pgoULd+K7VGs4gc2DVPzHDlpF
         rkm3GX2iGsGHUp6HqpDywQ3pNmcs0wP9cLeHYP3jpBc95iw+OF5LoH/Yi9z31slrDZjf
         yPSJaHhh5bU3x06gxeojlriwXKo7K5PKf2B74=
Received: by 10.205.127.17 with SMTP id gy17mr10902118bkc.110.1328031542144;
 Tue, 31 Jan 2012 09:39:02 -0800 (PST)
Received: by 10.205.112.203 with HTTP; Tue, 31 Jan 2012 09:39:02 -0800 (PST)
In-Reply-To: <4F27FF01.6040706@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189460>

On 31 January 2012 06:47, Michael Schubert <mschub@elegosoft.com> wrote=
:
> On 01/31/2012 12:36 AM, Paul Berry wrote:
>> I am trying to use "git clean -X" to remove object files (which
>> are gitignored) from my source tree, but it appears to miss
>> object files that are in a subdirectory without any git-tracked
>> files:
>>
>> $ git init test
>> Initialized empty Git repository in /home/pberry/tmp/test/.git/
>> $ cd test
>> $ mkdir foo
>> $ touch foo/bar.o
>> $ echo '*.o' > .gitignore
>> $ git add .gitignore
>> $ git commit -mgitignore
>> [master (root-commit) 6b5ffcb] gitignore
>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>> =A0create mode 100644 .gitignore
>> $ git status
>> # On branch master
>> nothing to commit (working directory clean)
>> $ git clean -d -X -f
>> $ ls foo
>> bar.o
>>
>> It seems to me that bar.o should have been removed, because
>> according to the git-clean docs, -X means "Remove only files
>> ignored by git", and bar.o is definitely being ignored by git.
>>
>>
>> It looks like a very similar bug was reported back in 2010, but
>> not fixed:
>> http://git.661346.n2.nabble.com/BUG-git-clean-X-behaviour-when-gitig=
nore-has-sub-directory-entries-td5575307.html.
>> I've confirmed that the workaround mentioned by Jonathan Nieder
>> in that thread fixes my problem too (removing "dir.flags |=3D
>> DIR_SHOW_OTHER_DIRECTORIES;" from builtin/clean.c). =A0However I'm
>> guessing from Jonathan's comments that it would be better to fix
>> this bug elsewhere (somewhere in dir.c perhaps).
>
> Removing DIR_SHOW_OTHER_DIRECTORIES just happens to not trigger
> this particular "bug" but breaks pretty much everything else.

Yeah, I had a feeling that might be the case.

>
> As a workaround, you could explicitly add the directory to your
> gitignore file.
>
> Here's a test:
>
> -- >8 --
>
> Subject: [PATCH] t7300-clean: show known breakage with "git clean -d =
-X"
>
> "git clean -d -X" fails for directories containing only untracked fil=
es.
> Example:
>
> =A0 =A0 =A0 =A0$ ls -R .
> =A0 =A0 =A0 =A0.:
> =A0 =A0 =A0 =A0foo
> =A0 =A0 =A0 =A0./foo:
> =A0 =A0 =A0 =A0bar.o
> =A0 =A0 =A0 =A0$ cat .gitignore
> =A0 =A0 =A0 =A0*.o
> =A0 =A0 =A0 =A0$ git clean -d -X -f
> =A0 =A0 =A0 =A0$ ! test -d foo || echo fail
>
> Reported-by: Paul Berry <stereotype441@gmail.com>
> Signed-off-by: Michael Schubert <mschub@elegosoft.com>
> ---
> =A0t/t7300-clean.sh | =A0 =A07 +++++++
> =A01 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index 800b536..0b6d545 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -332,6 +332,13 @@ test_expect_success 'git clean -d -X' '
>
> =A0'
>
> +test_expect_failure 'git clean -d -X' '
> + =A0mkdir -p a/b &&
> + =A0touch a/b/c.o &&
> + =A0git clean -d -X &&
> + =A0! test -d a

Thanks for the test case.  BTW, you might consider changing this last
line to "! test -f a/b/c.o".  Reasoning: it is clear from the docs
that c.o should be removed by "git clean -X" (since c.o is an ignored
file).  It is less clear whether the directories a and a/b should be
removed by "git clean -X", since those directories are not in
themselves ignored, only their contents.

> +'
> +
> =A0test_expect_success 'clean.requireForce defaults to true' '
>
> =A0 =A0 =A0 =A0git config --unset clean.requireForce &&
> --
> 1.7.9.174.g356eff6
