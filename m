From: David Aguilar <davvid@gmail.com>
Subject: Re: t7800-difftool.sh failure on pu
Date: Fri, 30 Mar 2012 21:05:30 -0700
Message-ID: <CAJDDKr50oDwih2fyb5iuFqYDsXSD3EXje4vZJwO=1_JBvuMYsA@mail.gmail.com>
References: <4F74A604.3040402@ramsay1.demon.co.uk>
	<7v7gy3qesv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, tim.henigan@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 06:06:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDpZo-0001cx-NJ
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 06:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016Ab2CaEFc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Mar 2012 00:05:32 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56544 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab2CaEFb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Mar 2012 00:05:31 -0400
Received: by yenl12 with SMTP id l12so715609yen.19
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 21:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XDgpnCg23rlTZ7U6xa06ULvhqncbpFqCPrVVSMyLSeI=;
        b=KZdfkvvR+1pz9CNGr7URyLSplLi0uREQO87w56u/o7eHt8BIyQfjQ9KVcKBTG19KzB
         i6MWxTowD89DN945R2Mvs2OqKqIHVFhK/gBv+ZOcEmp7KKKi0EdFzkly1VTOPGrUy+uI
         NAoOexD6AcPn2gWyOui87x3zkEfMWCDULtf+vWlt3c7Y+no4xo/XsMTzHN88rBCvZANp
         c4tccgJcA23M2FNAiBEKDWPWPjZ+CWLr1+Md6AufmRS8yb0qJ0XgDxetpOUWugPmPynV
         4DWk7x2jsPRLTmaV4d4QAIF8YlNHJu2WqHu4BZqfaw/MvX/hm4TENx0pCsjN9PC/l+v6
         6Jug==
Received: by 10.236.157.9 with SMTP id n9mr615351yhk.96.1333166730535; Fri, 30
 Mar 2012 21:05:30 -0700 (PDT)
Received: by 10.147.128.8 with HTTP; Fri, 30 Mar 2012 21:05:30 -0700 (PDT)
In-Reply-To: <7v7gy3qesv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194430>

On Thu, Mar 29, 2012 at 2:26 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>
>> Hi Tim,
>>
>> With the current pu branch, I have t7800.3 (difftool ignores bad --t=
ool values)
>> failing on Linux (I haven't tried cygwin or mingw yet). The failure =
is caused
>> by the test for the value of the exit code; for me the exit code is =
9 not 1.
>>
>> I have investigated, briefly, and found *two* alternatives for a fix=
=2E ;-)
>>
>> The first option is to (effectively) revert commit 0440ed72 ("diffto=
ol: replace
>> system call with Git::command_noisy", 22-03-2012), like so:
>>
>> -- >8 --
>> diff --git a/git-difftool.perl b/git-difftool.perl
>> index e1754ff..49613b1 100755
>> --- a/git-difftool.perl
>> +++ b/git-difftool.perl
>> @@ -237,5 +237,7 @@ if (defined($dirdiff)) {
>>
>> =C2=A0 =C2=A0 =C2=A0 $ENV{GIT_PAGER} =3D '';
>> =C2=A0 =C2=A0 =C2=A0 $ENV{GIT_EXTERNAL_DIFF} =3D 'git-difftool--help=
er';
>> - =C2=A0 =C2=A0 git_cmd_try { Git::command_noisy(('diff', @ARGV)) } =
'exit code %d';
>> + =C2=A0 =C2=A0 my @command =3D ('git', 'diff', @ARGV);
>> + =C2=A0 =C2=A0 my $rc =3D system(@command);
>> + =C2=A0 =C2=A0 exit($rc | ($rc >> 8));
>> =C2=A0}
>> -- 8< --
>
> I would prefer this, regardless of the issue.
>
> I actually recall asking Tim about the exit status when I reviewed th=
is
> change.

I would also prefer this.

A question for the msysgit/cygwin folks:

would we need to go back to use "git.exe" as well?
--=20
David
