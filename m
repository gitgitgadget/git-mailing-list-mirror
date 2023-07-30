Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AD9C001DC
	for <git@archiver.kernel.org>; Sun, 30 Jul 2023 20:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjG3Uv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Jul 2023 16:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjG3Uv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2023 16:51:58 -0400
X-Greylist: delayed 546 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 30 Jul 2023 13:51:55 PDT
Received: from pukcab.korelogic.com (unknown [139.138.148.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF5110C0
        for <git@vger.kernel.org>; Sun, 30 Jul 2023 13:51:55 -0700 (PDT)
Received: from mail.korelogic.com (mail.korelogic.com [205.134.174.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.korelogic.com", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by pukcab.korelogic.com (Postfix) with ESMTPS id 96C112B2005D
        for <git@vger.kernel.org>; Sun, 30 Jul 2023 16:42:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1]) by mail.korelogic.com with ESMTPSA id B3FB51EE0114 for <git@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=korelogic.com;
        s=mail; t=1690749766;
        bh=XOdnLWg8mwEPBigq5oOSRqMJc8rjTbtXwtkH8+70ADQ=;
        h=Date:From:To:Subject:Reply-To;
        b=e5rNA8KKazQY5uqlf5XhJEC5nKQcCw6VGBYj0qf41xLP6R3XtaFl0BJ+QnBnqoI82
         iqX9qrpdhKud1fPAnfCofLnwT9gzdKy1h++Z+82rTPUD/qbnyvHGCacDElVSk5yASt
         YxJmae1Km1x3Ut0wnAtTAUT7PLsZk994496Eu5qc=
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail.korelogic.com
Date:   Sun, 30 Jul 2023 14:42:44 -0600
From:   Hank Leininger <hlein@korelogic.com>
To:     git@vger.kernel.org
Subject: [BUG] Git 2.39.0+ Git.pm ignores Directory=> argument for bare repos
Message-ID: <20230730140659.0cc15491-00d2-4e58-af57-aaf5e74b5827@korelogic.com>
Reply-To: Hank Leininger <hlein@korelogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lTkMOvO1Zvd9KI91"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lTkMOvO1Zvd9KI91
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Recent git versions (2.39.0 through 2.41.0) Git.pm seems to forget its
Directory argument for bare repos. Initial creation of a
Git->repository object will succeed, but subsequent $repo->command()
fails unless the repo is in pwd or is set in the GIT_DIR environment
argument.

  patsy@ultron ~/tmp/repo-test $ git init --bare test1.git
  Initialized empty Git repository in /home/patsy/tmp/repo-test/test1.git/

  # success with 2.38.4
  patsy@ultron ~/tmp/repo-test $ git --version
  git version 2.38.4
  patsy@ultron ~/tmp/repo-test $ perl -MGit -e 'my $repo =3D Git->repositor=
y(Directory=3D>"/home/patsy/tmp/repo-test/test1.git/")||die "git open faile=
d: $!\n"; $repo->command("rev-list", "--all", "-1"); print "rev-list succee=
ded\n"'
  rev-list succeeded

  # fail with 2.41.0
  patsy@ultron ~/tmp/repo-test $ git --version
  git version 2.41.0
  patsy@ultron ~/tmp/repo-test $ perl -MGit -e 'my $repo =3D
  Git->repository(Directory=3D>"/home/patsy/tmp/repo-test/test1.git/")||die=
 "git open failed: $!\n"; $repo->command("rev-list", "--all", "-1"); print =
"rev-list succeeded\n"'
  fatal: not a git repository: '/home/patsy/tmp/repo-test'
  rev-list --all -1: command returned error: 128

  # success with 2.41.0 after cd
  patsy@ultron ~/tmp/repo-test $ cd test1.git/
  patsy@ultron ~/tmp/repo-test/test1.git $ perl -MGit -e 'my $repo =3D Git-=
>repository(Directory=3D>"/home/patsy/tmp/repo-test/test1.git/")||die "git =
open failed: $!\n"; $repo->command("rev-list", "--all", "-1"); print "rev-l=
ist succeeded\n"'
  rev-list succeeded

  # success with 2.41.0 with GIT_DIR=3D set
  patsy@ultron ~/tmp/repo-test $
  GIT_DIR=3D/home/patsy/tmp/repo-test/test1.git/ perl -MGit -e 'my $repo =
=3D Git->repository(Directory=3D>"/home/patsy/tmp/repo-test/test1.git/")||d=
ie "git open failed: $!\n"; $repo->command("rev-list", "--all", "-1"); prin=
t "rev-list succeeded\n"'
  rev-list succeeded

It seems to be only bare repos that are a problem:

  # success with 2.41.0 for a non-bare repo
  patsy@ultron ~/tmp/repo-test $ git --version
  git version 2.41.0
  patsy@ultron ~/tmp/repo-test $ git init test2
  Initialized empty Git repository in /home/patsy/tmp/repo-test/test2/.git/
  patsy@ultron ~/tmp/repo-test $ perl -MGit -e 'my $repo =3D Git->repositor=
y(Directory=3D>"/home/patsy/tmp/repo-test/test2")||die "git open failed: $!=
\n"; $repo->command("rev-list", "--all", "-1"); print "rev-list succeeded\n=
"'
  rev-list succeeded

When stracing both, I can see that Git.pm does an initial execve of
git rev-parse --is-bare-repository --git-dir, and it *does* cd prior to
that. But running the specified command is done in a new child which
does not chdir first. For non-bare repos, the child executing the
command does chdir.

Thanks,

--=20

Hank Leininger <hlein@korelogic.com>
9606 3BF9 B593 4CBC E31A  A384 6200 F6E3 781E 3DD7

--lTkMOvO1Zvd9KI91
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElgY7+bWTTLzjGqOEYgD243gePdcFAmTGy0QACgkQYgD243ge
PddFSQ//Svuka1tgw18brEbBh8KmYJHGIzI+ImOoKnMFzm7lYHz/XGim9EbR3xuI
xNzgwHzHCxzzwEFM/NYH8Uyn2Bbi2wxEY+glj67Br6K6pYz3AHlRdEDf8XVaHENw
1d1w+nWF36HT8Mp6vKq012XOG5PYqMMRD1TfBuZ9Ippu0I7KNul6cLtUnm/zob1h
za1iuOzSu9spGZeMQP+0OsjVo1bpD9eesJQppqry7H3bLpCUebQnT6Oio/akuWtb
OaU/IU2nHyAneALz1gZ6NbzX0d+fpgHfhWGw8rc522Px39UPDaYQDdum8HdV5m9C
wCHsl/7FGMwjaPHY6asCcf9rHoE80MoG1NtB48sX8C2lJ6WIDfguasT/1eUtGtdv
tyRtCfO5Px8quLcqVkRTiKe6KtF79Ti+B0R6GsLWYuIIy2CMBJRtviIDJgo7fqs2
Iu2QhmJRIBwxbXCyEDukpStqBeaLRkF16S9ifECErrVX0A5euywH5x/MLktH65jE
bGMo8VfsMTAEiSBM0tdgpyn3EXlbBDKaa7M7N3mkfqqNXngLdQt9Am8L8/+olI/H
SrgPiMfH2ysZbufDfGJoqZvgAxUmIugXZTvqaYqaBgyUCPjzVRRFjpuRNHbuzwid
scBCc8vGOos3cUDIoc7Tur7lgq8oppKYDMaVbjMchzWchFGC35E=
=/v1T
-----END PGP SIGNATURE-----

--lTkMOvO1Zvd9KI91--
