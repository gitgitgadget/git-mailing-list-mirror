From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] fixes for ActiveState Perl
Date: Mon, 14 Feb 2011 13:49:23 +0100
Message-ID: <AANLkTimCXEbzZnR1k32u942hjB37nThN_RDBL5N7owHa@mail.gmail.com>
References: <4D5914C1.9050008@io.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: rkitover@io.com
X-From: git-owner@vger.kernel.org Mon Feb 14 13:49:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoxsM-00009K-Ao
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 13:49:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902Ab1BNMtq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 07:49:46 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38409 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab1BNMtp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 07:49:45 -0500
Received: by fxm20 with SMTP id 20so5163858fxm.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 04:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=OP0NKDH2MLT0r2IlPhqiuDbLk78A03UKH1Voulx1XK8=;
        b=azNkCGjSS+Y3lG228NY5z4jRDUIRjt8Hc1dtsJidWu0c4KfX1Hsim0qyNpnaTnXoaz
         OxlMEpEXNYgN8iOsW4ppcOTB7P9D/GJHebMRcHa6fkIcJ35sdSxs2sXZ9NE4rGm9lGWa
         itl5Hh2ydSEik4a4ttzE2Ns+2S4+YG8X0SpTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=UIy8sJpoIcaLxrDxl5OfhxBEXrKymBgxG4aSFGiCNelqAP4rGkyZuie8H58AN8xtD5
         MLSuCTrAhpc704T+dRAvFdHJvDiI4iv0kjvLmChtwdAlS0iHxwbBtJtm5LhaFkA0Ycsj
         hIoCbAWYQ1TOC1Ao3j0RyFrZnqNLj0N8zySEk=
Received: by 10.223.87.80 with SMTP id v16mr4495831fal.128.1297687783768; Mon,
 14 Feb 2011 04:49:43 -0800 (PST)
Received: by 10.223.116.210 with HTTP; Mon, 14 Feb 2011 04:49:23 -0800 (PST)
In-Reply-To: <4D5914C1.9050008@io.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166705>

On Mon, Feb 14, 2011 at 12:40 PM, Rafael Kitover <rkitover@io.com> wrot=
e:
> The make for perl is now retrieved from Perl's config. The make fragm=
ent in
> perl/Makefile.PL added in MY::postamble is disabled on Win32, as it r=
elies on
> GNU make syntax, and Win32 users are not likely to have an ancient EU=
::MM
> version.
>
> A Windows path for PERL_PATH is now supported as well, e.g.:
> make PERL_PATH=3DC:\\Perl\\bin\\perl
> or from cmd.exe:
> make PERL_PATH=3DC:\Perl\bin\perl
> .
>
> t9700-perl-git.sh now passes on ActiveState Perl. Some tweaks were ne=
cessary in
> Git.pm: a more correct check for absolute directory, exit code check =
on closing
> the "pipe", and always closing the cat_blob bidirectional pipe (with =
errors
> =A0ignored) so as not to leave zombie processes. The waitpid call on =
closing the
> bidirectional pipe is now timed and the process is killed if necessar=
y. Also
> added some binmode calls to t/t9700/test.pl to make the blob tests pa=
ss.
>
> Signed-off-by: Rafael Kitover <rkitover@cpan.org>
> ---
> =A0Makefile =A0 =A0 =A0 =A0 | =A0 =A08 ++++----
> =A0perl/Git.pm =A0 =A0 =A0| =A0 40 +++++++++++++++++++++++++++++++---=
------
> =A0perl/Makefile =A0 =A0| =A0 14 ++++++++++++--
> =A0perl/Makefile.PL | =A0 =A07 ++++++-
> =A0t/t9700/test.pl =A0| =A0 15 ++++++++++++++-
> =A05 files changed, 67 insertions(+), 17 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index d3dcfb1..3465ab5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -175,7 +175,7 @@ all::
> =A0# will work.
> =A0#
> =A0# Define NO_PERL_MAKEMAKER if you cannot use Makefiles generated b=
y perl's
> -# MakeMaker (e.g. using ActiveState under Cygwin).
> +# MakeMaker.
> =A0#
> =A0# Define NO_PERL if you do not want Perl scripts or libraries at a=
ll.
> =A0#
> @@ -1059,7 +1059,7 @@ ifeq ($(uname_S),Windows)
> =A0 =A0 =A0 =A0NO_MKSTEMPS =3D YesPlease
> =A0 =A0 =A0 =A0SNPRINTF_RETURNS_BOGUS =3D YesPlease
> =A0 =A0 =A0 =A0NO_SVN_TESTS =3D YesPlease
> - =A0 =A0 =A0 NO_PERL_MAKEMAKER =3D YesPlease
> + =A0 =A0 =A0 # NO_PERL_MAKEMAKER =3D YesPlease
> =A0 =A0 =A0 =A0RUNTIME_PREFIX =3D YesPlease
> =A0 =A0 =A0 =A0NO_POSIX_ONLY_PROGRAMS =3D YesPlease
> =A0 =A0 =A0 =A0NO_ST_BLOCKS_IN_STRUCT_STAT =3D YesPlease

This would break my MSVC builds, since I'm using msysGit + MSVC to
build (when using MSVC)... Not that that's a big deal, I can add
"NO_PERL_MAKEMAKER =3D YesPlease" to my config.mak.

But I do suspect that most people who build with MSVC will have the
same problem. Is it worth the hassle?

> @@ -1112,7 +1112,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
> =A0 =A0 =A0 =A0NO_MKDTEMP =3D YesPlease
> =A0 =A0 =A0 =A0NO_MKSTEMPS =3D YesPlease
> =A0 =A0 =A0 =A0NO_SVN_TESTS =3D YesPlease
> - =A0 =A0 =A0 NO_PERL_MAKEMAKER =3D YesPlease
> + =A0 =A0 =A0 # NO_PERL_MAKEMAKER =3D YesPlease
> =A0 =A0 =A0 =A0RUNTIME_PREFIX =3D YesPlease
> =A0 =A0 =A0 =A0NO_POSIX_ONLY_PROGRAMS =3D YesPlease
> =A0 =A0 =A0 =A0NO_ST_BLOCKS_IN_STRUCT_STAT =3D YesPlease

This would break Git for Windows, as we don't have makemaker
ExtUtils::MakeMaker in msysGit.

You could probably move the definition into the THIS_IS_MSYSGIT-check, =
though.

> @@ -1652,7 +1652,7 @@ perl/perl.mak: GIT-CFLAGS perl/Makefile perl/Ma=
kefile.PL
>
> =A0$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
> =A0 =A0 =A0 =A0$(QUIET_GEN)$(RM) $@ $@+ && \
> - =A0 =A0 =A0 INSTLIBDIR=3D`MAKEFLAGS=3D $(MAKE) -C perl -s --no-prin=
t-directory instlibdir` && \
> + =A0 =A0 =A0 INSTLIBDIR=3D`MAKEFLAGS=3D $(MAKE) -C perl -s --no-prin=
t-directory instlibdir | sed -e 's/\\\\/\\\\\\\\/g' -e "s/'//g"` && \
> =A0 =A0 =A0 =A0sed -e '1{' \
> =A0 =A0 =A0 =A0 =A0 =A0-e ' =A0 =A0 =A0 =A0s|#!.*perl|#!$(PERL_PATH_S=
Q)|' \
> =A0 =A0 =A0 =A0 =A0 =A0-e ' =A0 =A0 =A0 =A0h' \
> diff --git a/perl/Git.pm b/perl/Git.pm
> index 6cb0dd1..f7d99bd 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -101,6 +101,7 @@ use Error qw(:try);
> =A0use Cwd qw(abs_path);
> =A0use IPC::Open2 qw(open2);
> =A0use Fcntl qw(SEEK_SET SEEK_CUR);
> +use File::Spec ();
> =A0}
>
>
> @@ -184,7 +185,8 @@ sub repository {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ($dir) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $dir =3D~ m#^/# or $dir=
 =3D $opts{Directory} . '/' . $dir;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0File::Spec->file_nam=
e_is_absolute($dir)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 or $dir=
 =3D $opts{Directory} . '/' . $dir;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$opts{Repository} =3D =
abs_path($dir);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# If --git-dir went ok=
, this shouldn't die either.

Just for reference, this should still work as before on Git for
Windows, because we have a MSYS perl, so absolute paths starts with a
forward slash. And if we change to a MinGW perl, this would probably
be an improvement.

> diff --git a/perl/Makefile b/perl/Makefile
> index a2ffb64..1fa99cd 100644
> --- a/perl/Makefile
> +++ b/perl/Makefile
> @@ -3,18 +3,28 @@
> =A0#
> =A0makfile:=3Dperl.mak
>
> +# support PERL_PATH=3DC:\\Perl\\bin\\perl
> +PERL_PATH :=3D $(subst \,\\,$(PERL_PATH))
> +
> =A0PERL_PATH_SQ =3D $(subst ','\'',$(PERL_PATH))
> +PERL_MAKE :=3D MAKEFLAGS=3D"" $(subst \,\\,$(shell $(subst \,\\,$(PE=
RL_PATH)) -MConfig -le "print ((\%Config)->{make})"))
> +
> +ifneq (,$(findstring nmake,$(PERL_MAKE)))
> + =A0 =A0 =A0 PERL_MAKE :=3D $(PERL_MAKE) -nologo
> +endif
> +
> =A0prefix_SQ =3D $(subst ','\'',$(prefix))
>
> =A0ifndef V
> =A0 =A0 =A0 =A0QUIET =3D @
> =A0endif
>
> +

Why?
