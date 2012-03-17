From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 6/9] difftool: replace system call with Git::command_noisy
Date: Fri, 16 Mar 2012 19:48:56 -0700
Message-ID: <CAJDDKr4+0iWoZhxo6kMVa0YUtDzmrH=XTZnDqQdbnM6TJ41UDg@mail.gmail.com>
References: <1331949557-15146-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 03:49:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8jhY-0002He-La
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 03:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021Ab2CQCs6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Mar 2012 22:48:58 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53301 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab2CQCs5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Mar 2012 22:48:57 -0400
Received: by gghe5 with SMTP id e5so4794153ggh.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 19:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=FWyGmcRuDBp+9NrhdQh0+g0B3BpJZ3G9/kQFq9A0Npo=;
        b=pdxJ/61FRs4i2KSIPBZF7KQZslpTKC8uz9T3JDryfIwbuyganuP/MzLq8IisIW359d
         PFCuLTBj8adTjdZYds19CnCgVMPSKaSW9ZPJAJmObeYxPCYWyvkZUSuwYc317DReQ2e4
         yUrfBfHOTecPIJfS8DYJCuDz+41SUJI4PnJCacAu0Os4z8o8qlu888tblc9c0c4VMpnD
         hxwqtIuLYecd4sPuNkl9NXTmI16Mnd+TeqHq2nwdYqqiJNRrtxGt+5QyVa3NdXhwiwJz
         yLn/RCL7ExHmk8OZ6CYgkNAF1IUKLEmXbD2PO/4dYEgxKseMLQxpCPZQ0TvtOdxj8WMd
         sLIw==
Received: by 10.236.156.232 with SMTP id m68mr4784309yhk.97.1331952536827;
 Fri, 16 Mar 2012 19:48:56 -0700 (PDT)
Received: by 10.147.143.4 with HTTP; Fri, 16 Mar 2012 19:48:56 -0700 (PDT)
In-Reply-To: <1331949557-15146-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193301>

On Fri, Mar 16, 2012 at 6:59 PM, Tim Henigan <tim.henigan@gmail.com> wr=
ote:
> The Git.pm module includes functions intended to standardize working
> with Git repositories in Perl scripts. This commit teaches difftool
> to use Git::command_noisy rather than a system call to run the diff
> command.

Git::command_noisy() calls _cmd_exec() which calls _execv_git_cmd()
which does a fork() + exec('git', @_) + waitpid();

We were avoiding exec() for portability reasons, as Alex explained in
677fbff88f368ed6ac52438ddbb530166ec1d5d1:

# ActiveState Perl for Win32 does not implement POSIX semantics of
# exec* system call. It just spawns the given executable and finishes
# the starting program, exiting with code 0.
# system will at least catch the errors returned by git diff,
# allowing the caller of git difftool better handling of failures.

Is this no longer a concern?  Does Git.pm need a similar portability
caveat, or  does it avoid the problem altogether since it uses fork()
+ exec() + waitpid()?  (if this is true then it implies that this
change is fine).

I have not read the rest of this series yet, so apologies if these
questions were answered elsewhere.

In general, I am a little nervous about having difftool copy worktree
content somewhere temporary only to copy it back in later.  Is there
some way to make the diff machinery reuse the worktree?  I was under
the impression that we could do some GIT_INDEX tricks to do it, though
I will admit that I did not read that suggestion in depth, nor did I
grasp whether this was the problem it was meant to address.

Thoughts?


>
> Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
> ---
> =C2=A0git-difftool.perl | =C2=A0 10 +---------
> =C2=A01 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/git-difftool.perl b/git-difftool.perl
> index 9495f14..8498089 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -72,12 +72,4 @@ elsif (defined($no_prompt)) {
>
> =C2=A0$ENV{GIT_PAGER} =3D '';
> =C2=A0$ENV{GIT_EXTERNAL_DIFF} =3D 'git-difftool--helper';
> -my @command =3D ('git', 'diff', @ARGV);
> -
> -# ActiveState Perl for Win32 does not implement POSIX semantics of
> -# exec* system call. It just spawns the given executable and finishe=
s
> -# the starting program, exiting with code 0.
> -# system will at least catch the errors returned by git diff,
> -# allowing the caller of git difftool better handling of failures.
> -my $rc =3D system(@command);
> -exit($rc | ($rc >> 8));
> +git_cmd_try { Git::command_noisy(('diff', @ARGV)) } 'exit code %d';
> --
> 1.7.9.1.290.gbd444
>



--=20
David
