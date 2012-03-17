From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 6/9] difftool: replace system call with Git::command_noisy
Date: Sat, 17 Mar 2012 10:48:42 -0400
Message-ID: <CAFouethChs_2ZhYDjOqRTSoDMZ60DeMkS1A=Ke4G5G_pKPKrYA@mail.gmail.com>
References: <1331949557-15146-1-git-send-email-tim.henigan@gmail.com>
	<CAJDDKr4+0iWoZhxo6kMVa0YUtDzmrH=XTZnDqQdbnM6TJ41UDg@mail.gmail.com>
	<CALxABCYiOpQavW3qz+Xx-qjadaF3sAQ3DHAAwzRRBDXm6MAnOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 15:48:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8uw4-0004vE-M8
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 15:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701Ab2CQOso convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Mar 2012 10:48:44 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62249 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633Ab2CQOsn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 10:48:43 -0400
Received: by iagz16 with SMTP id z16so6933774iag.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 07:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=/oYey5Vp7mNSKb+z59N10Y5XVqtsgnF0ZOjnrs1a33Y=;
        b=cYRUHfUkJ5eYIbGxR6w6eWxunEL8I+S1uZKIRpT514b8lHRVesJcvElLtMY7xKBb4R
         xiTKZHcb14Q70FVflYhpNlnC8ttLJCCIG7Ugbqg/2t06oR0bJTFTLr6xYnVpohsgJvhT
         m/UZ8QHn/y5MOhqjiQbN8u8MI5QH1CzJUsq/JRHJcoG7c16qapQqxQDvk4VUV8rE3rL6
         N5XTLMaN/bQUE3zjZVsbSi4XwH67amt7P8Y5CjMm6g7pqdYXyo2qcKysdBOJzGIsGFmo
         Z9Aym2VFWNRt4Ar7Ho5vKWaMXm/IJ5cLqsDNAWOwAtZnWiZ4aM8j1MuX00O8u+adzvf4
         1XuA==
Received: by 10.50.187.231 with SMTP id fv7mr2007107igc.51.1331995722651; Sat,
 17 Mar 2012 07:48:42 -0700 (PDT)
Received: by 10.42.218.65 with HTTP; Sat, 17 Mar 2012 07:48:42 -0700 (PDT)
In-Reply-To: <CALxABCYiOpQavW3qz+Xx-qjadaF3sAQ3DHAAwzRRBDXm6MAnOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193331>

On Sat, Mar 17, 2012 at 6:50 AM, Alex Riesen <raa.lkml@gmail.com> wrote=
:
> Resend for vger archives. Damn that Android GMail client.
>
> On Sat, Mar 17, 2012 at 03:48, David Aguilar <davvid@gmail.com> wrote=
:
>> On Fri, Mar 16, 2012 at 6:59 PM, Tim Henigan <tim.henigan@gmail.com>=
 wrote:
>>> The Git.pm module includes functions intended to standardize workin=
g
>>> with Git repositories in Perl scripts. This commit teaches difftool
>>> to use Git::command_noisy rather than a system call to run the diff
>>> command.
>>
>> Git::command_noisy() calls _cmd_exec() which calls _execv_git_cmd()
>> which does a fork() + exec('git', @_) + waitpid();
>>
>> We were avoiding exec() for portability reasons, as Alex explained i=
n
>> 677fbff88f368ed6ac52438ddbb530166ec1d5d1:
>>
>> # ActiveState Perl for Win32 does not implement POSIX semantics of
>> # exec* system call. It just spawns the given executable and finishe=
s
>> # the starting program, exiting with code 0.
>> # system will at least catch the errors returned by git diff,
>> # allowing the caller of git difftool better handling of failures.
>>
>> Is this no longer a concern? =C2=A0Does Git.pm need a similar portab=
ility
>> caveat, or =C2=A0does it avoid the problem altogether since it uses =
fork()
>> + exec() + waitpid()? =C2=A0(if this is true then it implies that th=
is
>> change is fine).

I need to spend more time testing this.  On Windows, I have tested
with msysgit but not cygwin.  Was ActiveState Perl used with cygwin
git?


> It _might_ work. Cygwin kind of has fork(2), it even works (kind of:
> it is a *very* expensive thing to do). There are also other ifs and
> whens, but it is worth a test. It's a nice clean up to have.

Even it fork(2) is expensive, in this case it seems reasonable. Given
the time needed to spawn the diff tool, the fork(2) time seems
negligible.
