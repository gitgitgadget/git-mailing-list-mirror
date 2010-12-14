From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 08/14] help.c: Fix detection of custom merge strategy on cygwin
Date: Tue, 14 Dec 2010 21:07:28 +0100
Message-ID: <AANLkTimt3w9GVCXa_n1_HXivyRmnRyUhhdSArrHOT6fs@mail.gmail.com>
References: <4D07B786.2060602@ramsay1.demon.co.uk>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, j6t@kdbg.org,
	jrnieder@gmail.com, vmiklos@frugalware.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 14 21:07:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSbAB-0004z2-Qc
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 21:07:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759841Ab0LNUHv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 15:07:51 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:48142 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759591Ab0LNUHu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 15:07:50 -0500
Received: by fxm18 with SMTP id 18so1173727fxm.2
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 12:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=IBgMcvGkd5e2ByXMsC3IA7UpabKDLwfYB8jWsUhPEKw=;
        b=TSRhWhd51O1aubYY7YRdGBjm28kVVbIm1KPKHQidDUpWfyHNoRA5L3WU8sk6lsDElu
         l3lOspQ7pScc1Enfz+BjkR9h1hIsb78Nx0P8CM0JjLDM4ntTxOVFCpo+hdQtsZZ/dEJ8
         HQmiB2/6o6VVIeOS6RytOWZnpJkvnYK4UB5hQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=rezjxXAOlI+mD2aYLbS1K4lmRJvm51dTCqaaFx/ILuum5j6awPm+mhwagPuWNwM2wm
         CCEbInDgL6NgfE/rYLRDt0QfxBwAdrSxNXUHwkUkijCC9c5tVcMHp+sOnKBKcdclyWG0
         2HTdMRKEdyTChAI2kUf4/Vnu7kVUSIBSCrIzg=
Received: by 10.223.73.199 with SMTP id r7mr6477995faj.76.1292357269117; Tue,
 14 Dec 2010 12:07:49 -0800 (PST)
Received: by 10.223.96.71 with HTTP; Tue, 14 Dec 2010 12:07:28 -0800 (PST)
In-Reply-To: <4D07B786.2060602@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163685>

On Tue, Dec 14, 2010 at 7:29 PM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
>
> Test t7606-merge-custom.sh fails on cygwin when git-merge fails
> with an "Could not find merge strategy 'theirs'" error, despite
> the test correctly preparing an (executable) git-merge-theirs
> script.
>
> The cause of the failure is the mis-detection of the executable
> status of the script, by the is_executable() function, while the
> load_command_list() function is searching the path for additional
> merge strategy programs.
>
> Note that the l/stat() "functions" on cygwin are somewhat
> schizophrenic (see commits adbc0b6, 7faee6b and 7974843), and
> their behaviour depends on the timing of various git setup and
> config function calls. In particular, until the "git_dir" has
> been set (have_git_dir() returns true), the real cygwin (POSIX
> emulating) l/stat() functions are called. Once "git_dir" has
> been set, the "native Win32 API" implementations of l/stat()
> may, or may not, be called depending on the setting of the
> core.filemode and core.ignorecygwinfstricks config variables.
>
> We also note that, since commit c869753, core.filemode is forced
> to false, even on NTFS, by git-init and git-clone. A user (or a
> test) can, of course, reset core.filemode to true explicitly if
> the filesystem supports it (and he doesn't use any problematic
> windows software). The test-suite currently runs all tests on
> cygwin with core.filemode set to false.
>
> Given the above, we see that the built-in merge strategies are
> correctly detected as executable, since they are checked for
> before "git_dir" is set, whereas all custom merge strategies are
> not, since they are checked for after "git_dir" is set.
>
> In order to fix the mis-detection problem, we change the code in
> is_executable() to re-use the conditional WIN32 code section,
> which actually looks at the content of the file to determine if
> the file is executable. On cygwin we also make the additional
> code conditional on the executable bit of the file mode returned
> by the initial stat() call. (only the real cygwin function would
> set the executable bit in the file mode.)
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
> =A0help.c | =A0 =A05 ++++-
> =A01 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/help.c b/help.c
> index 7f4928e..eabadc9 100644
> --- a/help.c
> +++ b/help.c
> @@ -126,7 +126,10 @@ static int is_executable(const char *name)
> =A0 =A0 =A0 =A0 =A0 =A0!S_ISREG(st.st_mode))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> -#ifdef WIN32
> +#if defined(WIN32) || defined(__CYGWIN__)
> +#if defined(__CYGWIN__)
> +if ((st.st_mode & S_IXUSR) =3D=3D 0)
> +#endif

Perhaps the first check should simply be changed to check for _WIN32
instead of WIN32? IIRC _WIN32 is set on Cygwin, but I could be
mistaken...
