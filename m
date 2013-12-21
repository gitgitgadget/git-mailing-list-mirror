From: fREW Schmidt <frioux@gmail.com>
Subject: git-mv-submodule
Date: Sat, 21 Dec 2013 03:48:33 -0600
Message-ID: <20131221094833.GA7917@wanderlust>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 10:48:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuJAt-0005dg-HY
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 10:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000Ab3LUJsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 04:48:40 -0500
Received: from mail-ob0-f172.google.com ([209.85.214.172]:46452 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab3LUJsh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 04:48:37 -0500
Received: by mail-ob0-f172.google.com with SMTP id gq1so3795475obb.31
        for <git@vger.kernel.org>; Sat, 21 Dec 2013 01:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=ssqUn2TkWKysIrfAJnw0x1OjnsCnDT4XekRlOZ1EUlU=;
        b=E+adeKCVZKblWcc4oVQ43TchgMjfPb7dBD9UaEfaqt7H2O6eEPoH3vUrwbzp8WWGvG
         JH5nuvn01iml1287eNJ9kk2V0BXoSd+Ng/P6WQ+rdJxR0VfMclnct6rAvYghbmLXdyVN
         4T2xHRzqFYBHkpJRw8GYZqkqfzBsseW6ue0UTElrZKxSfJJz3b/AXGe2NPRjN4nt8aop
         eCkVrS7jiGGnbO+IIcM+IfqvJEqSSO8YFj4f5rknR2ET0jz7zctWl4pUk/PSO8DSkLkn
         s8sH2UUEiAeyyPYJMJw+JkIjGt1QlDbhfN9zmLz4McIwmRL3Xns41HphC4hhYD3oXEpV
         tamw==
X-Received: by 10.60.233.9 with SMTP id ts9mr5752057oec.65.1387619316490;
        Sat, 21 Dec 2013 01:48:36 -0800 (PST)
Received: from localhost (24-182-106-91.dhcp.ftwo.tx.charter.com. [24.182.106.91])
        by mx.google.com with ESMTPSA id m7sm13960450obo.7.2013.12.21.01.48.34
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 21 Dec 2013 01:48:34 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239588>


--hHWLQfXTYDoKhP50
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all,

I was on a plane, moving around some of the many (30ish) submodules in
my dotfiles and got really annoyed at how much work it is (move the
dir, remove old from git, add new to git, fix .gitmodules, fix
=2Egit/config, fix all the parts of the submodule config) so I wrote a
perl script to work for the most common case.

As far as I know it should work for anyone not doing Something Weird,
ie manually fiddling with their submodules.  The main case it does not
support that I'd like to in the future is submodules containing
submodules, and also at some point I'd like to wrap git mv to invoke
this script on demand automatically.

Note that this script requires perl 5.10.1, released in 2009.  If you
are stuck with something inferior to that you can comment out the
version at the top and the autodie usage and it should work further
back, but won't be quite as robust.

Enjoy!
--=20
fREW Schmidt
http://blog.afoolishmanifesto.com

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=git-mv-submodule

#!/usr/bin/env perl

use 5.10.1;
use strict;
use warnings;

use autodie;
use File::Basename 'dirname';
use File::Path 'make_path';

die "you must pass both a from and a to" unless @ARGV == 2;

my ($from, $to) = @ARGV;

die "you have changes in your working copy!"
   unless is_clean();

# move the real dir
make_path(dirname($to));
safe_system('mv', $from, $to);

# move the git dir (not really that important)
make_path(dirname(".git/modules/$to"));
safe_system('mv', ".git/modules/$from", ".git/modules/$to");

# update .gitmodules and .git/config book keeping
spew($_, slurp($_) =~ s/\Q$from\E/$to/gr)
   for qw( .gitmodules .git/config );

my $dir_count = scalar split qr(/), $to =~ s(/$)()r;

my $derp = ('../' x (2 + $dir_count)) . $to;

# update .git/modules/$to/config book keeping
spew(
   ".git/modules/$to/config",
   slurp(".git/modules/$to/config") =~ s/worktree.*/worktree = $derp/gr
);

# update $to book keeping
spew(
   "$to/.git",
   'gitdir: ' . ('../' x $dir_count) . ".git/modules/$to"
);

safe_system(qw( git add -A ), $from, $to, '.gitmodules' );

sub safe_system {
   system(@_);

   die "@_ exited poorly :("
      if $? >> 8;
}

sub safe_capture {
   my $ret = qx(@_);

   die "@_ exited poorly :("
      if $? >> 8;

   return $ret;
}

sub slurp {
   open my $fh, '<', $_[0];
   local $/ = undef;
   scalar <$fh>
}

sub spew {
   open my $fh, '>', $_[0];
   print {$fh} $_[1]
}

sub is_clean { !safe_capture(qw(git status --porcelain)) }

--MGYHOYXEY6WxJCY8--

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAABCgAGBQJStWPuAAoJEG6zMC9zenWCvkEP/128ZrhyDq53jF7dHxT3Qntw
UuBhwPHFipEf2m34UBkrNqh+ci43RH1+VRf8qTyxYYEpP85118wOf1bba0eDktWJ
SMqkNcIUklU+VWPuhd6TCkjBwMtBtrHIQmKBs3v+AEpXapz/dSYZ/1O9tCz9qAsZ
0icPLiF6a6fzQB7qpg1bRhZmazSUfV+1bMFqdR0jPNg56myVLaWwk0vG+y6gW+QC
g53I9hEupjhPUXUppe5LuPwjtRXI0yVZgOofa+HXHwaViM5Rh5TQ3S0B2gCpFGVY
EiYmazz+DIDLB5BkkgCIIoqOpc7SbGvXXC0eeReYRdYe1tV0rYBVCuYkT+iGw4h5
O4NY9wzFT8EK4N2TEhUdgcoQbAOCQ0NK4Um847LvNn9sICeSOj/9irQ0Oo+iQPRi
SWRtPcOJLE9dAki2c8rr1S1h3DDLJakkSlwoGdMXFTYyOlyr7ZHX40tc233xPXYe
rwbu60l5V2jlR2xKh1cLLVdnOT5Rp4CYsxWM+zBjSN11EOhdFys4F4YYYOyvGd64
uGvyTPp5lPNI9396/vnd0BSPHariKoBLAI8x3aiIRveHbn9LuqYW70ejl3IXSZW8
HBy6OiS1aX81L9RCWpdrt0pDdqjjF6M8chpZzZDUqdK6OZztFRuuFK7YCll9DpYA
cWHa0cGfG7opzVrTrkTI
=fw1a
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
