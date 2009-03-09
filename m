From: Michael Lai <myllai@gmail.com>
Subject: Re: [RFC PATCH] git-svn does not support intermediate directories?
Date: Mon, 9 Mar 2009 14:02:15 -0700
Message-ID: <21fc26450903091402u60d6cfcepd67ba7510af8f4a3@mail.gmail.com>
References: <21fc26450903031743x4beda8a3i835ecbd428817070@mail.gmail.com>
	 <20090304043019.GC20790@mail.rocksoft.com>
	 <21fc26450903051612u1400b2b4gd71c3eafa4418e37@mail.gmail.com>
	 <20090308044318.GA31205@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Mar 09 22:04:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgmdd-0002wv-Lc
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 22:03:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbZCIVCS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2009 17:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753520AbZCIVCS
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 17:02:18 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:50942 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbZCIVCR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2009 17:02:17 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1834220rvb.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 14:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=j1T9NXGgCIZaEdQMXf3jIOIT3a30RceufRAfLLIrHzQ=;
        b=vd6hGF5IThNh+JfxRHtWL925hOxPQM58vQ9THENnvFuvgRVYUSx0n+PS6Rf5HtNVvq
         pPSF7t2/O8GUs879bgMOOrYD96avQvaQ9uR3mv6d+/u7yQc+JMeDdsu1ZwHOxQU/7nCD
         mB1HFq+rSC5VyQF85URGEf5sMJfbTrBVgKwRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GLPuUNAh+RVUEwAFfpCEUzNvCtErgDtP1uy8D1Y9IXhTw+cbHAhZqKr1tNidSHAXm3
         sxVqlyE2QF/UtwW8+XFjqjEHwGqC7HVrl6IANAqsxvRc6C5uyrBsWEqTr9K7bFGB2PP+
         gZ4Tf4ttu84Hhzm/1d43ggh6kwZ+yXe5jRSiU=
Received: by 10.141.204.11 with SMTP id g11mr1551713rvq.117.1236632535456; 
	Mon, 09 Mar 2009 14:02:15 -0700 (PDT)
In-Reply-To: <20090308044318.GA31205@untitled>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112741>

> Your patch was whitespace damaged and lacked a proposed commit messag=
e.
> Please read Documentation/SubmittingPatches next time.
Hey Eric,

Sorry, I didn't notice that; I've read through it and hopefully my
patches should conform from now on.

>
> Anyhow, I fixed your patch up a bit. =C2=A0Can you sign-off on it
> if its right to you or let me know if it's broken? =C2=A0Thanks.

I looked through the patch and that would work, but at the same time I
had another idea which may be a little cleaner.  Let me know what you
think.

=46rom ae38acf85cfc86c075578c1c3f3c204d91d1d1f4 Mon Sep 17 00:00:00 200=
1
=46rom: Michael Lai <myllai@gmail.com>
Date: Mon, 9 Mar 2009 11:45:47 -0700
Subject: [PATCH] git-svn: support intermediate paths when matching tags=
/branches

=46or repositories laid out like the following:

[svn-remote "svn"]
      url =3D http://foo.com/svn/repos/bar
      fetch =3D myproject/trunk:refs/remotes/trunk
      branches =3D bar/myproject/branches/*:refs/remotes/*
      tags =3D bar/myproject/tags/*:refs/remotes/tags/*

The "bar" component above is considered the intermediate path
and was not handled correctly.

Signed-off-by: Michael Lai <myllai@gmail.com>
---
 git-svn.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 959eb52..8be6be0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2351,7 +2351,10 @@ sub match_paths {
 	if (my $path =3D $paths->{"/$self->{path}"}) {
 		return ($path->{action} eq 'D') ? 0 : 1;
 	}
-	$self->{path_regex} ||=3D qr/^\/\Q$self->{path}\E\//;
+	my $repos_root =3D $self->ra->{repos_root};
+	my $extended_path =3D $self->{url} . '/' . $self->{path};
+	$extended_path =3D~ s#^\Q$repos_root\E(/|$)##;
+	$self->{path_regex} ||=3D qr/^\/\Q$extended_path\E\//;
 	if (grep /$self->{path_regex}/, keys %$paths) {
 		return 1;
 	}
--=20
1.6.2

>
> From cddc7e5bde060eb963534156ae0daaf41c87c21a Mon Sep 17 00:00:00 200=
1
> From: Eric Wong <normalperson@yhbt.net>
> Date: Sat, 7 Mar 2009 20:22:29 -0800
> Subject: [PATCH] git-svn: support intermediate paths when matching ta=
gs/branches
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3Dutf-8
> Content-Transfer-Encoding: 8bit
>
> For repositories laid out like the following:
>
>> [svn-remote "svn"]
>> =C2=A0 =C2=A0 =C2=A0 url =3D http://foo.com/svn/repos/bar
>> =C2=A0 =C2=A0 =C2=A0 fetch =3D myproject/trunk:refs/remotes/trunk
>> =C2=A0 =C2=A0 =C2=A0 branches =3D bar/myproject/branches/*:refs/remo=
tes/*
>> =C2=A0 =C2=A0 =C2=A0 tags =3D bar/myproject/tags/*:refs/remotes/tags=
/*
>
> The "bar" component above is considered the intermediate path
> and was not handled correctly.
>
> This patch was originally by Michael Lai (without a commit
> message) with some minor fixes:
>
> =C2=A0* extraneous slash removed from $intermediate_path,
> =C2=A0 =C2=A0this was causing tests to fail.
>
> =C2=A0* fixed a case where $intermediate_path could be "0" and
> =C2=A0 =C2=A0considered false by Perl, preventing the necessary
> =C2=A0 =C2=A0slash from being appended.
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
> =C2=A0git-svn.perl | =C2=A0 =C2=A06 +++++-
> =C2=A01 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 959eb52..745dd03 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2351,7 +2351,11 @@ sub match_paths {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (my $path =3D $paths->{"/$self->{path}"=
}) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ($path-=
>{action} eq 'D') ? 0 : 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 $self->{path_regex} ||=3D qr/^\/\Q$self->{path=
}\E\//;
> + =C2=A0 =C2=A0 =C2=A0 my $repos_root =3D $self->ra->{repos_root};
> + =C2=A0 =C2=A0 =C2=A0 my $intermediate_path =3D $self->{url};
> + =C2=A0 =C2=A0 =C2=A0 $intermediate_path =3D~ s#^\Q$repos_root\E(/|$=
)##;
> + =C2=A0 =C2=A0 =C2=A0 $intermediate_path .=3D '/' if length($interme=
diate_path) > 0;
> + =C2=A0 =C2=A0 =C2=A0 $self->{path_regex} ||=3D qr/^\/\Q$intermediat=
e_path$self->{path}\E\//;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (grep /$self->{path_regex}/, keys %$pat=
hs) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> --
> Eric Wong
>
