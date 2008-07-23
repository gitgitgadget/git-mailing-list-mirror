From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] index-pack: never prune base_cache.
Date: Wed, 23 Jul 2008 14:52:26 +0200
Message-ID: <20080723125226.GA11679@atjola.homenet>
References: <20080722231745.GD11831@artemis.madism.org> <20080723101415.GA23769@atjola.homenet> <alpine.DEB.1.00.0807231246560.2830@eeepc-johanness> <20080723111931.GF15243@artemis.madism.org> <alpine.DEB.1.00.0807231235150.8986@racer> <20080723120045.GA21274@atjola.homenet> <20080723121118.GA20614@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	spearce@spearce.org, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 14:53:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLdqV-0001NF-I7
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 14:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbYGWMwb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 08:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752976AbYGWMwb
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 08:52:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:42307 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752936AbYGWMwa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 08:52:30 -0400
Received: (qmail invoked by alias); 23 Jul 2008 12:52:28 -0000
Received: from i577BBDAB.versanet.de (EHLO atjola.local) [87.123.189.171]
  by mail.gmx.net (mp067) with SMTP; 23 Jul 2008 14:52:28 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19zitNn21dzevpohYbDKbsTRPk6HCeGAnw/RCgNOx
	VLQ8ffCWS1GVPq
Content-Disposition: inline
In-Reply-To: <20080723121118.GA20614@artemis.madism.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89642>

On 2008.07.23 14:11:18 +0200, Pierre Habouzit wrote:
> It may belong to something (stdin) that is consumed.

Probably thanks to me, babbling about stdin without having a clue what
I'm talking about, that rationale is wrong.

We may not prune base_cache since that object might come from a
different pack than the one that we are processing. In such a case, we
would try to restore the data for that object from the pack we're
processing and fail miserably.


The patch itself should be fine.

>=20
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>=20
>     On Wed, Jul 23, 2008 at 12:00:45PM +0000, Bj=F6rn Steinbrink wrot=
e:
>     > On 2008.07.23 12:37:00 +0100, Johannes Schindelin wrote:
>     > > Hi,
>     > >=20
>     > > Well, I cannot.  However, I get some pread issue on i686.  To=
 be nice to=20
>     > > kernel.org, I downloaded the pack in question:
>     > >=20
>     > > 	http://pacific.mpi-cbg.de/git/thin-pack.pack
>     > >=20
>     > > You should be able to reproduce the behavior by piping this i=
nto
>     > >=20
>     > > git-index-pack --stdin -v --fix-thin --keep=3Dfetch-pack --pa=
ck_header=3D2,263
>     >=20
>     > OK, that gave me a seemingly sane backtrace. What seems to happ=
en (AFA
>     > my limited knowledge tells me):
>     >=20
>     > In fix_unresolved_deltas, we read base_obj from an existing pac=
k, other
>     > than the one we're reading. We then link that object to the bas=
e cache.=20
>     >=20
>     > Then in resolve_delta, we create the "result" base_data object =
and link
>     > that one, too. Now this triggers the pruning, and because the c=
ache is
>     > so small, we prune the object that we read from the existing pa=
ck! Fast
>     > forward a few function calls, we end up in get_base_data trying=
 to
>     > re-read the data for that object, but this time from the pack t=
hat we
>     > got on stdin. And boom it goes.
>     >=20
>     > Does that make any sense to you?
>=20
>       Yes, that's obvious, the pack that we read from stdin is consum=
ed, we
>     should *NEVER* prune base_cache. And indeed that little patch wor=
ks for
>     me.
>=20
>  index-pack.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/index-pack.c b/index-pack.c
> index ac20a46..eb81ed4 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -227,7 +227,7 @@ static void prune_base_data(struct base_data *ret=
ain)
>  	for (b =3D base_cache;
>  	     base_cache_used > delta_base_cache_limit && b;
>  	     b =3D b->child) {
> -		if (b->data && b !=3D retain) {
> +		if (b !=3D base_cache && b->data && b !=3D retain) {
>  			free(b->data);
>  			b->data =3D NULL;
>  			base_cache_used -=3D b->size;
