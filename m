From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 6/9] difftool: replace system call with Git::command_noisy
Date: Sat, 17 Mar 2012 11:50:57 +0100
Message-ID: <CALxABCYiOpQavW3qz+Xx-qjadaF3sAQ3DHAAwzRRBDXm6MAnOw@mail.gmail.com>
References: <1331949557-15146-1-git-send-email-tim.henigan@gmail.com> <CAJDDKr4+0iWoZhxo6kMVa0YUtDzmrH=XTZnDqQdbnM6TJ41UDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Henigan <tim.henigan@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 11:51:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8rEo-0007uD-9B
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 11:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065Ab2CQKvW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Mar 2012 06:51:22 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:39493 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756743Ab2CQKvV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 06:51:21 -0400
Received: by lbbgm6 with SMTP id gm6so2497382lbb.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 03:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=c1I+4Nlm6wr6PjYFhv24mDBneHM+CPEuWc7v8Bgoz3g=;
        b=1KMGIPkf3ersv765+W7BKcWTvR901t33apTcNDs+yHy3NYU4RtzSWMKiEP6lEVpIfg
         PRwWACijK79xsxkOlEeEcMVCadegdtzyDGYmvFyAhDfm08YNMPSunA4WYnJWimrP4YDE
         0VfqevU+Hb34Z5afkwdqrED3pTpWj3l2M3j9otpl88K7bP6qjqvoUVMPXaeSLTol3Blo
         dRyfL8s/xkZV9tKp1o2rHKESasZp1DT6/16zqc/x3PayeqvXKSDfveKKIEuv2GYWDJ9y
         F8Qv5di1j9AQdK3nxWYgkXnDUbJvuOX7+aTYBMXVLwktJ8MuiewH1L0v4RFOFeRZX/I/
         dP8Q==
Received: by 10.112.38.68 with SMTP id e4mr2158891lbk.38.1331981478144; Sat,
 17 Mar 2012 03:51:18 -0700 (PDT)
Received: by 10.152.146.65 with HTTP; Sat, 17 Mar 2012 03:50:57 -0700 (PDT)
In-Reply-To: <CAJDDKr4+0iWoZhxo6kMVa0YUtDzmrH=XTZnDqQdbnM6TJ41UDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193318>

Resend for vger archives. Damn that Android GMail client.

On Sat, Mar 17, 2012 at 03:48, David Aguilar <davvid@gmail.com> wrote:
> On Fri, Mar 16, 2012 at 6:59 PM, Tim Henigan <tim.henigan@gmail.com> =
wrote:
>> The Git.pm module includes functions intended to standardize working
>> with Git repositories in Perl scripts. This commit teaches difftool
>> to use Git::command_noisy rather than a system call to run the diff
>> command.
>
> Git::command_noisy() calls _cmd_exec() which calls _execv_git_cmd()
> which does a fork() + exec('git', @_) + waitpid();
>
> We were avoiding exec() for portability reasons, as Alex explained in
> 677fbff88f368ed6ac52438ddbb530166ec1d5d1:
>
> # ActiveState Perl for Win32 does not implement POSIX semantics of
> # exec* system call. It just spawns the given executable and finishes
> # the starting program, exiting with code 0.
> # system will at least catch the errors returned by git diff,
> # allowing the caller of git difftool better handling of failures.
>
> Is this no longer a concern? =C2=A0Does Git.pm need a similar portabi=
lity
> caveat, or =C2=A0does it avoid the problem altogether since it uses f=
ork()
> + exec() + waitpid()? =C2=A0(if this is true then it implies that thi=
s
> change is fine).

It _might_ work. Cygwin kind of has fork(2), it even works (kind of:
it is a *very* expensive thing to do). There are also other ifs and
whens, but it is worth a test. It's a nice clean up to have.
