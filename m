Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B3CC0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 08:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjHAIfo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 04:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjHAIfm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 04:35:42 -0400
X-Greylist: delayed 129169 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Aug 2023 01:35:37 PDT
Received: from mail.korelogic.com (mail.korelogic.com [205.134.174.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC33DA
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 01:35:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1]) by mail.korelogic.com with ESMTPSA id C30CA1EE0125 for <git@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=korelogic.com;
        s=mail; t=1690878936;
        bh=sFHifBsSWXZvR7ns5XDnsqdRd9NgI19QK2LK8Le4deU=;
        h=Date:From:To:Subject:Reply-To;
        b=bA/y8nFFPkTyywLXdhtU1VMueKRfySwP4X08eFR4GyZ+Iko+lECbOQvQpqC31ZxH9
         gS9jqbh+iA35WvtkZM7o+b2ibv/o5XGeTOwvsMmKx8IbWvDuVO/fhxj3sX7orHKKXp
         0405lO3LwIblscUJ0llLDxlVRx3iubIQ5dMsj4r4=
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail.korelogic.com
Date:   Tue, 1 Aug 2023 02:35:35 -0600
From:   Hank Leininger <hlein@korelogic.com>
To:     git@vger.kernel.org
Subject: Re: [BUG] Git 2.39.0+ Git.pm ignores Directory=> argument for bare
 repos
Message-ID: <20230801010041.c3ff0dbd-0115-4a4d-a742-3ca7b4838d23@korelogic.com>
Reply-To: Hank Leininger <hlein@korelogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sKA+Dgd4WNchMcpF"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sKA+Dgd4WNchMcpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

tl;dr: in the process of digging into this I've identified a case where
Git.pm still fails safe directory checking; skip to the end.

On 2023-07-31, Junio C Hamano wrote:
> > Hank Leininger <hlein@korelogic.com> writes:

> > Recent git versions (2.39.0 through 2.41.0) Git.pm seems to forget its
> > Directory argument for bare repos. Initial creation of a
> > Git->repository object will succeed, but subsequent $repo->command()
> > fails unless the repo is in pwd or is set in the GIT_DIR environment
> > argument.

> $ git log --oneline v2.38.0..v2.39.0 -- perl/Git.pm
> 20da61f25f Git.pm: trust rev-parse to find bare repositories
> 77a1310e6b Git.pm: add semicolon after catch statement

> My guess is 20da61f25f is likely the source of the differences, but
> it is unclear if that should be called a "bug", as it was done as a
> fix for misbehaviour.
>
> commit 20da61f25f8f61a2b581b60f8820ad6116f88e6f
> Author: Jeff King <peff@peff.net>
> Date:   Sat Oct 22 18:08:59 2022 -0400
=2E..
>     But it gets worse. Since 8959555cee (setup_git_directory(): add an ow=
ner
>     check for the top-level directory, 2022-03-02), it's actively wrong (=
and
>     dangerous). The perl code doesn't implement the same ownership checks.
>     And worse, after "finding" the bare repository, it sets GIT_DIR in the
>     environment, which tells any subsequent Git commands that we've
>     confirmed the directory is OK, and to trust us. I.e., it re-opens the
>     vulnerability plugged by 8959555cee when using Git.pm's repository
>     discovery code.

Thanks for looking.  I think you're right that 20da61f25f is what's
responsible, but... of course it is a bug? (At the risk of you saying
"Don't quote the deep lore to me, I was there when it was written".)

Git.pm's documentation says that it supports passing a Directory
argument to specify where to look, and in the case of a bare repository:

  [...] If no ".git" directory was found, the "Directory" is assumed to
  be a bare repository, "Repository" is set to point at it and
  "WorkingCopy" is left undefined.

But it seems this isn't happening any more.

For non-bare repos, Directory is used for the initial rev-parse
--is-bare-repository check and for subsequent operations.

For bare repos, Directory is used for the initial rev-parse
--is-bare-repository check but then _not_ for subsequent operations.

Either breaking bare repo support for Directory is unintentional, in
which case this is a bug, or it's intentional, in which case the
documentation still stating Directory is supported for bare repos is a
bug.

However, this did point me at a workaround: the Repository argument
*does* work, so one can call:

  Git->repository(Repository=3D>"/path/to/foo.git")

=2E..On a bare repo that is not pwd and things will work as intended.

Hm, then I wondered why that worked, looked closer at the logic, and
found a remaining safe.directory problem.

When considering these arguments and checking if a repo is bare, Git.pm
does:

        if (defined $opts{Directory}) {
                -d $opts{Directory} or throw Error::Simple("Directory not f=
ound: $opts{Directory} $!");

                my $search =3D Git->repository(WorkingCopy =3D> $opts{Direc=
tory});
=2E..
                  $out =3D $search->command([qw(rev-parse --is-bare-reposit=
ory --git-dir)],
                                          STDERR =3D> 0);
=2E..
                chomp $out;
                my ($bare, $dir) =3D split /\n/, $out, 2;
=2E..
                if ($bare ne 'true') {
                        File::Spec->file_name_is_absolute($dir) or $dir =3D=
 $opts{Directory} . '/' . $dir;
                        $opts{Repository} =3D Cwd::abs_path($dir);
=2E..
               } else {
                        $opts{Repository} =3D Cwd::abs_path($dir);

So:

- First we create a new Git->repository object with WorkingCopy set to
  the specified directory

- Then we run rev-parse --is-bare-repository --git-dir ...

- ...Which internally cd's to the path currently set in WorkingCopy.
  strace shows a child forking and chdir'ing to the specified path prior
  to execve("git", "rev-parse",...)

- Because it has cd'd first, rev-parse --is-bare-repository output is:
  true
  .

- We peel that . off, get its absolute path, and set Repository to that.
  Except, we didn't chdir, only the child did, and we discarded
  WorkingCopy and the original Repository argument here.  We are sitting
  in the program's original pwd, not the Repository path.

- Satisifed that we're looking at a valid bare git repo, we proceed, but
  any subsequent ->command() or whatever will be looking at our
  clobbered Directory / Repository, not the one specified.

So that explains why setting Directory for bare repos currently fails.

Conversely, if Repository is specified and Directory is not, then all
the above logic gets sidestepped, and the provided Repository is simply
remembered and used with zero other complications:

        if (not defined $opts{Repository} and not defined $opts{WorkingCopy}
                and not defined $opts{Directory}) {
=2E..[not followed]
        }
        if (defined $opts{Directory}) {
=2E..[not followed]
                  $out =3D $search->command([qw(rev-parse --is-bare-reposit=
ory --git-dir)],
=2E..
        }
        $self =3D { opts =3D> \%opts };
        bless $self, $class;

Which, come to think of it, is a problem.

In the case where $opts{Repository} is defined, then no git rev-parse...
is ever done. We rely on that initial git rev-parse to enforce git's
ownership (safe.directory again). Therefore, using Repository=3D> is
unsafe:

  patsy@ultron ~/tmp/repo-test $ ls -ld test3.git
  drwxrwxr-x 6 hlein hlein 4096 Aug  1 01:57 test3.git

  # Git.pm is willing
  patsy@ultron ~/tmp/repo-test $ perl -MGit -e 'my $repo =3D Git->repositor=
y(Repository=3D>"/home/patsy/tmp/repo-test/test3.git")||die "git open faile=
d: $!\n"; $repo->command("rev-list", "--all", "-1"); print "rev-list succee=
ded\n"'=20
  rev-list succeeded

  # regular git is not
  patsy@ultron ~/tmp/repo-test $ git -C test3.git rev-parse --is-bare-repos=
itory --git-dir=20
  fatal: detected dubious ownership in repository at '/home/patsy/tmp/repo-=
test/test3.git'
  To add an exception for this directory, call:

        git config --global --add safe.directory /home/patsy/tmp/repo-test/=
test3.git

  patsy@ultron ~/tmp/repo-test/test3.git $ git rev-parse --is-bare-reposito=
ry --git-dir=20
  fatal: detected dubious ownership in repository at '/home/patsy/tmp/repo-=
test/test3.git'
  To add an exception for this directory, call:

        git config --global --add safe.directory /home/patsy/tmp/repo-test/=
test3.git

So in the case of Git->repository(Repository=3D>"..."), Git.pm misses the
safe directory check entirely. I think that's for the same reason called
out in that earlier commit message: once it has decided the specified
path is good (in this case by doing no checks whatsoever), that path
will be set in $GIT_DIR prior to launching user-specified git commands,
disabling  those checks - exactly the concern discussed in the commit
message for 20da61f25f.

Thanks,

--=20

Hank Leininger <hlein@korelogic.com>
9606 3BF9 B593 4CBC E31A  A384 6200 F6E3 781E 3DD7

--sKA+Dgd4WNchMcpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElgY7+bWTTLzjGqOEYgD243gePdcFAmTIw9cACgkQYgD243ge
PdcnEw/9EwFjKK4tInUQfVLh6pMQLpTyVNkEl05yTZFjdWtbF3XqI97lokFcMrZO
NlF0lrE0UvJMXY7B8zixIsGDM/xEv23Hv7KJGSjR6s939QljlCkdMZl8eTXUq79W
DJc1G5+pI7jqBJroCBBm1fAo16cfUcv2hGumtYpz/VDRCGVNSokauTSbyf7e0x70
Lvdfih/I8DrvbKBd2yf0LooI9k8vSvy4mMPNehor1vzy1mHUYKP31weaWx9Fhjq5
wOHji15u/hWSCIBVIDlaCTTUDRotQ2EHAsdLJ64AEVw/MGjZoUth5s3VYgX4Mifh
nOwDXN0sMFRNErnTjsLfZuvsFAvfxLe0//l3IOucIfJ+DWx99z3AcmU68nvnuzAN
cmBLxLO9PuZd1dp5N17s7TVdDZ/Uz53Lxa53jtjrPwhXSfJ6XwZrWrOnoizP9ZIM
rWMa9eGHlUQ7U92wALWZggBehCUtiZ1AFpnD6glCWmWnOa8BjE3dVkTFgXF+JJMx
YJov0hLaGXRI9IV7E5xpSOJGeqp5kQsoNQ943qT8bKHn0+FG4qXX9f+1C9WBMw97
uZ9Gn5bpzl6KYrcQ02FIosRpzpYkaqZJ22lvhkqi6yCg5buQh8O0EPClEfPl0J4I
bVRq7Xc3R2pCNyz9EBrhpuAYzXwJoppAbfwsTjzwMM6vmHQRBCk=
=nTv6
-----END PGP SIGNATURE-----

--sKA+Dgd4WNchMcpF--
