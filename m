From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 7/9] difftool: teach difftool to handle directory diffs
Date: Fri, 16 Mar 2012 20:08:55 -0700
Message-ID: <CAJDDKr4mc7OwUzE9d51KkgMaMauVJx_T=rdmXnhEc_a0hc0LGQ@mail.gmail.com>
References: <1331949574-15192-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 04:09:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8k0t-0001GD-Bq
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 04:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217Ab2CQDI5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Mar 2012 23:08:57 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33594 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514Ab2CQDI4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Mar 2012 23:08:56 -0400
Received: by gghe5 with SMTP id e5so4797504ggh.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 20:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ng6P0vYc0Fk5ibCS4yPGCmCSY/d1ltEfAO4GrFDuJE8=;
        b=YxJO5nrIx/Cctf1lgeTXueCpNinu7ioEkt8qs8ItjGSTBwB3aQX4wPrh7YT52Um0+y
         P1mH6hNM3fEacZMOxBu7XOZMuk7lF/51ttMh8Czj4BsElBRQLgXXqd3StC0cC+7VVPiY
         FiDNDQ2FOvUeAdZW2uFiTiR9iffz5soDMcBF03hGXVYEkBAXdEgl6BarSZZ2DXC2O5gT
         Ymp2a617fq4j/+Fkoq/+77Bg6CiWi9tCLQ6xalXTEwDWkulVtv7/jFox9nI4R7H9mi93
         6EbZcoX+qcQJ66JUqX/D45WSE/q8xddlSRNwr/ZwOfrD1L31vRRqFNkpO67EOqq2R8jQ
         hOuQ==
Received: by 10.236.138.110 with SMTP id z74mr4818657yhi.114.1331953735976;
 Fri, 16 Mar 2012 20:08:55 -0700 (PDT)
Received: by 10.147.143.4 with HTTP; Fri, 16 Mar 2012 20:08:55 -0700 (PDT)
In-Reply-To: <1331949574-15192-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193302>

On Fri, Mar 16, 2012 at 6:59 PM, Tim Henigan <tim.henigan@gmail.com> wr=
ote:
> Prior to this commit, the difftool utility could only open files one
> at a time. =C2=A0The new '--dir-diff' option copies all the modified =
files
> to a temporary location and runs a directory diff on them.
>
> Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
> ---
>
> =C2=A0Documentation/git-difftool.txt | =C2=A0 =C2=A06 ++
> =C2=A0git-difftool--helper.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 20 =
++++--
> =C2=A0git-difftool.perl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0142 ++++++++++++++++++++++++++++++++++++----
> =C2=A03 files changed, 150 insertions(+), 18 deletions(-)
>
> diff --git a/git-difftool.perl b/git-difftool.perl
> index 8498089..0262c7a 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -22,15 +28,109 @@ sub usage
> =C2=A0 =C2=A0 =C2=A0 =C2=A0print << 'USAGE';
> =C2=A0usage: git difftool [-t|--tool=3D<tool>] [-x|--extcmd=3D<cmd>]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 [-y|--no-prompt] =C2=A0 [-g|--gui]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
[-d|--dir-diff]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 ['git diff' options]
> =C2=A0USAGE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0exit($exitcode);
> =C2=A0}
>
> +sub setup_dir_diff
> +{
> + =C2=A0 =C2=A0 =C2=A0 # Run the diff; exit immediately if no diff fo=
und
> + =C2=A0 =C2=A0 =C2=A0 my $repo =3D Git->repository();
> + =C2=A0 =C2=A0 =C2=A0 my $diffrtn =3D $repo->command_oneline(['diff'=
, '--raw', '--no-abbrev', '-z', @ARGV]);
> + =C2=A0 =C2=A0 =C2=A0 exit(0) if (length($diffrtn) =3D=3D 0);
> +
> + =C2=A0 =C2=A0 =C2=A0 # Setup temp directories
> + =C2=A0 =C2=A0 =C2=A0 my $tmpdir =3D tempdir('/tmp/git-diffall.XXXXX=
', CLEANUP =3D> 1);

Is it okay to hardcode /tmp here, or should we instead do something lik=
e this?:

    my $tmp =3D $ENV{TMPDIR} || '/tmp';
--=20
David
