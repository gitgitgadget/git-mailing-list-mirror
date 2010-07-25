From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/WIP] git-svn: tweak log format to match "svn log" output
Date: Sun, 25 Jul 2010 03:37:08 -0500
Message-ID: <20100725083708.GB22213@burratino>
References: <20100423134611.GA3440@merkur.sol.de>
 <20100426132710.GA9930@progeny.tock>
 <20100427112656.GB16323@merkur.sol.de>
 <20100725023114.GB18606@burratino>
 <20100725081057.GA22373@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Seidel <jensseidel@users.sf.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jul 25 10:38:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocwj0-0004Ij-LU
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 10:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254Ab0GYIiR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 04:38:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39029 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab0GYIiO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 04:38:14 -0400
Received: by mail-iw0-f174.google.com with SMTP id 7so1772172iwn.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 01:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=lYyrNNf+KfFXYLDb6l/V1bHagNaggzEwRL97+r80Emc=;
        b=JDz6ODqn2fSMO4/17YSbFflGjh0/mXgLARhGPuk6NlCkJscQUrU6d9IEGK4VM1K+P9
         MtU+uqKSjLR7AyzC73S2UFBOh8TebHVp45XrZ6IqcAWqbcVm3U0PNJYSoEI8nllDvm1L
         GPMc66raVUf3XXf27fDvnC0u+GGHu05JtBTcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=BVBG+XmXJS5O2n/ar5wq9LeTIiD2LrampB7x+84g96qKB6WT8G4w8fmCss4iofpFbG
         TVE9+pQSiVBfI2RcZBESrv3AKQSlUtl9UTrCW7oWDEx207p2VkW7K3bzJ5sBGu2yGwWB
         JkEtt35uNcyK+MZSAe+p14Y6mWijCQeCkWiQ0=
Received: by 10.231.30.136 with SMTP id u8mr1829510ibc.19.1280047091085;
        Sun, 25 Jul 2010 01:38:11 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r3sm2292314ibk.1.2010.07.25.01.38.10
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 01:38:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100725081057.GA22373@dcvr.yhbt.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151712>

Eric Wong wrote:

> @@ -5646,8 +5644,8 @@ sub show_commit_normal {
> =20
>  	if ($can_localize) {
>  		my $d =3D Locale::gettext->domain("subversion");
> -		$sing_fmt =3D $d->nget(" | %d line", " | %d lines", 1);
> -		$plur_fmt =3D $d->nget(" | %d line", " | %d lines", 10);
> +		$sing_fmt =3D $d->nget($sing_fmt, $plur_fmt, 1);
> +		$plur_fmt =3D $d->nget($sing_fmt, $plur_fmt, 10);

This change gives me pause: wouldn=E2=80=99t it be a problem in
non-English locales, where $sing_fmt changes before it is
used to set $plur_fmt?

Of course there is no problem because the code is equivalent to

		$sing_fmt =3D $d->get($sing_fmt);
		$plur_fmt =3D $d->get($plur_fmt);

(or at least Locale::gettext is advertised to work that way.)

diff --git i/git-svn.perl w/git-svn.perl
index 5252722..75e7165 100755
--- i/git-svn.perl
+++ w/git-svn.perl
@@ -5644,8 +5644,8 @@ sub show_commit_normal {
=20
 	if ($can_localize) {
 		my $d =3D Locale::gettext->domain("subversion");
-		$sing_fmt =3D $d->nget($sing_fmt, $plur_fmt, 1);
-		$plur_fmt =3D $d->nget($sing_fmt, $plur_fmt, 10);
+		$sing_fmt =3D $d->get($sing_fmt);
+		$plur_fmt =3D $d->get($plur_fmt);
 	}
 	if (my $l =3D $c->{l}) {
 		while ($l->[$#$l] eq "\n" && $#$l > 0
--=20
