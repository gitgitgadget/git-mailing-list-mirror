From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: find-rev and rebase for SVN::Mirror repositories
Date: Mon, 14 Jul 2008 02:12:43 -0700
Message-ID: <20080714091243.GA27794@untitled>
References: <7bf6f1d20807081908kdf9f615taa532ae579b457d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Jo=E3o?= Abecasis <joao@abecasis.name>
X-From: git-owner@vger.kernel.org Mon Jul 14 11:13:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIK7u-0001t6-8p
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 11:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756202AbYGNJMq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2008 05:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756102AbYGNJMq
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 05:12:46 -0400
Received: from hand.yhbt.net ([66.150.188.102]:38608 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755939AbYGNJMo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 05:12:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id B07412DC095;
	Mon, 14 Jul 2008 02:12:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7bf6f1d20807081908kdf9f615taa532ae579b457d7@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88403>

Jo=E3o Abecasis <joao@abecasis.name> wrote:
> find-rev and rebase error out on svm because git-svn doesn't trace th=
e original
> svn revision numbers back to git commits. The updated test case, incl=
uded in the
> patch, shows the issue and passes with the rest of the patch applied.
>=20
> This fixes Git::SVN::find_by_url to find branches based on the svm:so=
urce URL,
> where useSvmProps is set. Also makes sure cmd_find_rev and working_he=
ad_info use
> the information they have to correctly track the source repository. T=
his is
> enough to get find-rev and rebase working.
>=20
> Signed-off-by: Jo=E3o Abecasis <joao@abecasis.name>
> ---
> Incidentally, I've tried submitting these fixes before, but failed to
> get much attention, so I could be doing something wrong... Any input
> on the patch or my approach to this list is appreciated. This time I
> reworded the commit message and added Eric Wong to the CC list, since
> he seems to be Ack'ing git-svn patches.

Hi Jo=E3o,

Sorry, I haven't been following the mailing list much lately, and
even keeping up with my inbox is getting to be a chore :(

The commit message should be wrapped at 72 characters or less.
Some further notes below (mostly whitespace issues, but one
regression).

>  sub read_all_remotes {
>  	my $r =3D {};
> +        my $usesvmprops =3D eval { command_oneline(qw/config --bool
> +            svn.useSvmProps/) };
> +        $usesvmprops =3D $usesvmprops eq 'true' if $usesvmprops;

Always use tabs for indentation (but spaces for alignment is alright).

I'd also rather not propagate the crazy alllowercasewithoutunderscores
convention of git-config into code, either.  $uses_svm_props is much
easier to parse when I'm half-awake :)

>  	foreach (grep { s/^svn-remote\.// } command(qw/config -l/)) {
>  		if (m!^(.+)\.fetch=3D\s*(.*)\s*:\s*refs/remotes/(.+)\s*$!) {
>  			my ($remote, $local_ref, $remote_ref) =3D ($1, $2, $3);
>  			$local_ref =3D~ s{^/}{};
>  			$r->{$remote}->{fetch}->{$local_ref} =3D $remote_ref;
> +			$r->{$remote}->{svm} =3D {} if $usesvmprops;
> +		} elsif (m!^(.+)\.usesvmprops=3D\s*(.*)\s*$!) {
> +			$r->{$1}->{svm} =3D {};
>  		} elsif (m!^(.+)\.url=3D\s*(.*)\s*$!) {
>  			$r->{$1}->{url} =3D $2;
>  		} elsif (m!^(.+)\.(branches|tags)=3D
> @@ -1437,6 +1443,21 @@ sub read_all_remotes {
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
> +					source =3D> tmp_config('--get', "$section.svm-source"),
> +					replace =3D> tmp_config('--get', "$section.svm-replace"),
> +				}
> +			};
> +			$r->{$_}->{svm} =3D $svm;
> +		}
> +	} keys %$r;
> +

Please wrap all code at 80-columns.

> @@ -1563,13 +1584,21 @@ sub find_by_url { # repos_root and, path are =
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
> +			$p =3D~ s#^\Q$z\E(?=3D/|$)#$prefix# or next;

This broke t9100 for me at: 'able to dcommit to a subdirectory'
Changing the ?=3D back to ?: works.

Thanks for the patch, please let us know if that change is OK.

--=20
Eric Wong
