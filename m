From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: make rebuild respect rewriteRoot option
Date: Sat, 21 Jun 2008 14:39:33 -0700
Message-ID: <20080621213911.GA19691@untitled>
References: <20080620003359.0dbb7725@neuron>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git mailing list <git@vger.kernel.org>
To: Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Sat Jun 21 23:41:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAApV-0004Xe-79
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 23:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbYFUVjf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Jun 2008 17:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752202AbYFUVjf
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 17:39:35 -0400
Received: from hand.yhbt.net ([66.150.188.102]:60523 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752038AbYFUVje (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 17:39:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id B58862DC08B;
	Sat, 21 Jun 2008 14:39:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080620003359.0dbb7725@neuron>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85728>

Jan Kr=FCger <jk@jk.gs> wrote:
> Suppose someone fetches git-svn-ified commits from another repo and t=
hen
> attempts to use 'git-svn init --rewrite-root=3Dfoo bar'. Using git sv=
n rebase
> after that will fail badly:
>=20
>  * For each commit tried by working_head_info, rebuild is called indi=
rectly.
>  * rebuild will iterate over all commits and skip all of them because=
 the
>    URL does not match. Because of that no rev_map file is generated a=
t all.
>  * Thus, rebuild will run once for every commit. This takes ages.
>  * In the end there still isn't any rev_map file and thus working_hea=
d_info
>    fails.
>=20
> Addressing this behaviour fixes an apparently not too uncommon proble=
m with
> providing git-svn mirrors of Subversion repositories. Some repositori=
es are
> accessed using different URLs depending on whether the user has push
> privileges or not. In the latter case, an anonymous URL is often used=
 that
> differs from the push URL. Providing a mirror that is usable in both =
cases
> becomes a lot more possible with this change.
>=20
> Signed-off-by: Jan Kr=FCger <jk@jk.gs>
> ---
> Since this patch focuses on a case that is discouraged by the git-svn
> manpage (use rewriteRoot even though commits already exist), a bit of
> discussion might be helpful. On the up side, I think it doesn't affec=
t any
> other cases.
>=20
> The specific problem situation looks like this:
>=20
> % git fetch git://.../clone-of-some-svn-repo (...)
> % git svn init -s --rewrite-root=3D<url contained in fetched commits>=
 <url \
>       we want to use>
> % git svn rebase
> [Boom]
>=20
> This patch passes all existing git-svn tests; feel free to suggest
> additional test(s) to cover this sort of situation.

Seems to make sense to me...  If you have a test case for this
it'd be nicer :)

Acked-by: Eric Wong <normalperson@yhbt.net>

>  git-svn.perl |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/git-svn.perl b/git-svn.perl
> index a54979d..4c9c59b 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2577,8 +2577,8 @@ sub rebuild {
>  	my ($log, $ctx) =3D
>  	    command_output_pipe(qw/rev-list --pretty=3Draw --no-color --rev=
erse/,
>  	                        $self->refname, '--');
> -	my $full_url =3D $self->full_url;
> -	remove_username($full_url);
> +	my $metadata_url =3D $self->metadata_url;
> +	remove_username($metadata_url);
>  	my $svn_uuid =3D $self->ra_uuid;
>  	my $c;
>  	while (<$log>) {
> @@ -2596,7 +2596,7 @@ sub rebuild {
>  		# if we merged or otherwise started elsewhere, this is
>  		# how we break out of it
>  		if (($uuid ne $svn_uuid) ||
> -		    ($full_url && $url && ($url ne $full_url))) {
> +		    ($metadata_url && $url && ($url ne $metadata_url))) {
>  			next;
>  		}
> =20
