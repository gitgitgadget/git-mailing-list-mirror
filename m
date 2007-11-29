From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Remove unnecessary Git::SVN::Util package
Date: Thu, 29 Nov 2007 00:01:26 -0800
Message-ID: <20071129080126.GD32277@soma>
References: <2CB65B86-3BEF-46C2-86F8-EFAB2AE6D353@develooper.com> <1195759080-20132-1-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: ask@develooper.com, git@vger.kernel.org
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Thu Nov 29 09:01:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxeLC-00054G-Sr
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 09:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176AbXK2IB2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Nov 2007 03:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755166AbXK2IB2
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 03:01:28 -0500
Received: from hand.yhbt.net ([66.150.188.102]:42627 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754619AbXK2IB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 03:01:27 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 8052B7DC10A;
	Thu, 29 Nov 2007 00:01:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1195759080-20132-1-git-send-email-ddkilzer@kilzer.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66514>

"David D. Kilzer" <ddkilzer@kilzer.net> wrote:
> Digest::MD5 is loaded regardless of the package in which it's
> declared, so move its 'use' statement and the md5sum() function
> into the main package.
>=20
> Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>=20
> Ask Bj=F8rn Hansen <ask@develooper.com> wrote:
> > On Nov 21, 2007, at 11:57, David D. Kilzer wrote:
> > > Created new Git::SVN::Util package with an md5sum() function.  A
> > > new package was created so that Digest::MD5 did not have to be
> > > loaded in the main package.
> > Huh?  It's all in the same file anyway, so what difference does it
> > make?
>=20
> None!

I have floated the idea of splitting git-svn into several files to make
it easier to maintain and navigate.  However, I'm not looking foward to
doing a install system for that...

Maybe it'll just cat all the files together during build and
still install as one file... *shrug*

>  git-svn.perl |   23 +++++++++--------------
>  1 files changed, 9 insertions(+), 14 deletions(-)
>=20
> diff --git a/git-svn.perl b/git-svn.perl
> index 62801c8..17d3020 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -35,6 +35,7 @@ push @Git::SVN::Ra::ISA, 'SVN::Ra';
>  push @SVN::Git::Editor::ISA, 'SVN::Delta::Editor';
>  push @SVN::Git::Fetcher::ISA, 'SVN::Delta::Editor';
>  use Carp qw/croak/;
> +use Digest::MD5;
>  use IO::File qw//;
>  use File::Basename qw/dirname basename/;
>  use File::Path qw/mkpath/;
> @@ -48,8 +49,7 @@ BEGIN {
>  	foreach (qw/command command_oneline command_noisy command_output_pi=
pe
>  	            command_input_pipe command_close_pipe/) {
>  		for my $package ( qw(SVN::Git::Editor SVN::Git::Fetcher
> -			Git::SVN::Migration Git::SVN::Log Git::SVN
> -			Git::SVN::Util),
> +			Git::SVN::Migration Git::SVN::Log Git::SVN),
>  			__PACKAGE__) {
>  			*{"${package}::$_"} =3D \&{"Git::$_"};
>  		}
> @@ -835,19 +835,19 @@ sub cmd_info {
>  			    command_output_pipe(qw(cat-file blob), "HEAD:$path");
>  			if ($file_type eq "link") {
>  				my $file_name =3D <$fh>;
> -				$checksum =3D Git::SVN::Util::md5sum("link $file_name");
> +				$checksum =3D md5sum("link $file_name");
>  			} else {
> -				$checksum =3D Git::SVN::Util::md5sum($fh);
> +				$checksum =3D md5sum($fh);
>  			}
>  			command_close_pipe($fh, $ctx);
>  		} elsif ($file_type eq "link") {
>  			my $file_name =3D
>  			    command(qw(cat-file blob), "HEAD:$path");
>  			$checksum =3D
> -			    Git::SVN::Util::md5sum("link " . $file_name);
> +			    md5sum("link " . $file_name);
>  		} else {
>  			open FILE, "<", $path or die $!;
> -			$checksum =3D Git::SVN::Util::md5sum(\*FILE);
> +			$checksum =3D md5sum(\*FILE);
>  			close FILE or die $!;
>  		}
>  		$result .=3D "Checksum: " . $checksum . "\n";
> @@ -1187,11 +1187,6 @@ sub find_file_type_and_diff_status {
>  	return ("file", $diff_status);
>  }
> =20
> -package Git::SVN::Util;
> -use strict;
> -use warnings;
> -use Digest::MD5;
> -
>  sub md5sum {
>  	my $arg =3D shift;
>  	my $ref =3D ref $arg;
> @@ -2926,7 +2921,7 @@ sub apply_textdelta {
> =20
>  		if (defined $exp) {
>  			seek $base, 0, 0 or croak $!;
> -			my $got =3D Git::SVN::Util::md5sum($base);
> +			my $got =3D ::md5sum($base);
>  			die "Checksum mismatch: $fb->{path} $fb->{blob}\n",
>  			    "expected: $exp\n",
>  			    "     got: $got\n" if ($got ne $exp);
> @@ -2945,7 +2940,7 @@ sub close_file {
>  	if (my $fh =3D $fb->{fh}) {
>  		if (defined $exp) {
>  			seek($fh, 0, 0) or croak $!;
> -			my $got =3D Git::SVN::Util::md5sum($fh);
> +			my $got =3D ::md5sum($fh);
>  			if ($got ne $exp) {
>  				die "Checksum mismatch: $path\n",
>  				    "expected: $exp\n    got: $got\n";
> @@ -3300,7 +3295,7 @@ sub chg_file {
>  	$fh->flush =3D=3D 0 or croak $!;
>  	seek $fh, 0, 0 or croak $!;
> =20
> -	my $exp =3D Git::SVN::Util::md5sum($fh);
> +	my $exp =3D ::md5sum($fh);
>  	seek $fh, 0, 0 or croak $!;
> =20
>  	my $pool =3D SVN::Pool->new;
> --=20
> 1.5.3.4
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Eric Wong
