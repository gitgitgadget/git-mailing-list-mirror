From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: find-rev and rebase for SVN::Mirror repositories
Date: Mon, 14 Jul 2008 21:25:19 -0700
Message-ID: <20080715042519.GA30382@untitled>
References: <7bf6f1d20807081908kdf9f615taa532ae579b457d7@mail.gmail.com> <20080714091243.GA27794@untitled> <7bf6f1d20807140827u56abc74fs4e289384db054a0e@mail.gmail.com> <7bf6f1d20807140828ve04bc16u96d0245209491b2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Jo=E3o?= Abecasis <joao@abecasis.name>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 06:26:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIc7I-0005Ox-QW
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 06:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbYGOEZW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jul 2008 00:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbYGOEZW
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 00:25:22 -0400
Received: from hand.yhbt.net ([66.150.188.102]:39710 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513AbYGOEZV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 00:25:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id CE733814022;
	Mon, 14 Jul 2008 21:25:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7bf6f1d20807140828ve04bc16u96d0245209491b2e@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88517>

Jo=E3o Abecasis <joao@abecasis.name> wrote:
> find-rev and rebase error out on svm because git-svn doesn't trace th=
e
> original svn revision numbers back to git commits. The updated test
> case, included in the patch, shows the issue and passes with the rest=
 of
> the patch applied.
>=20
> This fixes Git::SVN::find_by_url to find branches based on the
> svm:source URL, where useSvmProps is set. Also makes sure cmd_find_re=
v
> and working_head_info use the information they have to correctly trac=
k
> the source repository. This is enough to get find-rev and rebase
> working.
>=20
> Signed-off-by: Jo=E3o Abecasis <joao@abecasis.name>

Thanks Jo=E3o,

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-svn.perl                     |   39 ++++++++++++++++++++++++++++=
++++++---
>  t/t9110-git-svn-use-svm-props.sh |    9 ++++++++
>  2 files changed, 44 insertions(+), 4 deletions(-)
>=20
> diff --git a/git-svn.perl b/git-svn.perl
> index a366c89..0aa994a 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -537,13 +537,13 @@ sub cmd_find_rev {
>  		my $head =3D shift;
>  		$head ||=3D 'HEAD';
>  		my @refs;
> -		my (undef, undef, undef, $gs) =3D working_head_info($head, \@refs)=
;
> +		my (undef, undef, $uuid, $gs) =3D working_head_info($head, \@refs)=
;
>  		unless ($gs) {
>  			die "Unable to determine upstream SVN information from ",
>  			    "$head history\n";
>  		}
>  		my $desired_revision =3D substr($revision_or_hash, 1);
> -		$result =3D $gs->rev_map_get($desired_revision);
> +		$result =3D $gs->rev_map_get($desired_revision, $uuid);
>  	} else {
>  		my (undef, $rev, undef) =3D cmt_metadata($revision_or_hash);
>  		$result =3D $rev;
> @@ -1162,7 +1162,7 @@ sub working_head_info {
>  		if (defined $url && defined $rev) {
>  			next if $max{$url} and $max{$url} < $rev;
>  			if (my $gs =3D Git::SVN->find_by_url($url)) {
> -				my $c =3D $gs->rev_map_get($rev);
> +				my $c =3D $gs->rev_map_get($rev, $uuid);
>  				if ($c && $c eq $hash) {
>  					close $fh; # break the pipe
>  					return ($url, $rev, $uuid, $gs);
> @@ -1416,11 +1416,17 @@ sub fetch_all {
>=20
>  sub read_all_remotes {
>  	my $r =3D {};
> +	my $use_svm_props =3D eval { command_oneline(qw/config --bool
> +	    svn.useSvmProps/) };
> +	$use_svm_props =3D $use_svm_props eq 'true' if $use_svm_props;
>  	foreach (grep { s/^svn-remote\.// } command(qw/config -l/)) {
>  		if (m!^(.+)\.fetch=3D\s*(.*)\s*:\s*refs/remotes/(.+)\s*$!) {
>  			my ($remote, $local_ref, $remote_ref) =3D ($1, $2, $3);
>  			$local_ref =3D~ s{^/}{};
>  			$r->{$remote}->{fetch}->{$local_ref} =3D $remote_ref;
> +			$r->{$remote}->{svm} =3D {} if $use_svm_props;
> +		} elsif (m!^(.+)\.usesvmprops=3D\s*(.*)\s*$!) {
> +			$r->{$1}->{svm} =3D {};
>  		} elsif (m!^(.+)\.url=3D\s*(.*)\s*$!) {
>  			$r->{$1}->{url} =3D $2;
>  		} elsif (m!^(.+)\.(branches|tags)=3D
> @@ -1437,6 +1443,23 @@ sub read_all_remotes {
>  			}
>  		}
>  	}
> +
> +	map {
> +		if (defined $r->{$_}->{svm}) {
> +			my $svm;
> +			eval {
> +				my $section =3D "svn-remote.$_";
> +				$svm =3D {
> +					source =3D> tmp_config('--get',
> +					    "$section.svm-source"),
> +					replace =3D> tmp_config('--get',
> +					    "$section.svm-replace"),
> +				}
> +			};
> +			$r->{$_}->{svm} =3D $svm;
> +		}
> +	} keys %$r;
> +
>  	$r;
>  }
>=20
> @@ -1563,13 +1586,21 @@ sub find_by_url { # repos_root and, path are =
optional
>  		}
>  		my $p =3D $path;
>  		my $rwr =3D rewrite_root({repo_id =3D> $repo_id});
> +		my $svm =3D $remotes->{$repo_id}->{svm}
> +			if defined $remotes->{$repo_id}->{svm};
>  		unless (defined $p) {
>  			$p =3D $full_url;
>  			my $z =3D $u;
> +			my $prefix =3D '';
>  			if ($rwr) {
>  				$z =3D $rwr;
> +			} elsif (defined $svm) {
> +				$z =3D $svm->{source};
> +				$prefix =3D $svm->{replace};
> +				$prefix =3D~ s#^\Q$u\E(?:/|$)##;
> +				$prefix =3D~ s#/$##;
>  			}
> -			$p =3D~ s#^\Q$z\E(?:/|$)## or next;
> +			$p =3D~ s#^\Q$z\E(?:/|$)#$prefix# or next;
>  		}
>  		foreach my $f (keys %$fetch) {
>  			next if $f ne $p;
> diff --git a/t/t9110-git-svn-use-svm-props.sh b/t/t9110-git-svn-use-s=
vm-props.sh
> index 047659f..04d2a65 100755
> --- a/t/t9110-git-svn-use-svm-props.sh
> +++ b/t/t9110-git-svn-use-svm-props.sh
> @@ -49,4 +49,13 @@ test_expect_success 'verify metadata for /dir' "
>  	   grep '^git-svn-id: $dir_url@1 $uuid$'
>  	"
>=20
> +test_expect_success 'find commit based on SVN revision number' "
> +        git-svn find-rev r12 |
> +	    grep `git rev-parse HEAD`
> +        "
> +
> +test_expect_success 'empty rebase' "
> +	git-svn rebase
> +	"
> +
>  test_done
> --=20
> 1.5.6
