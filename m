From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] fetch: honor the user-provided refspecs when pruning
 refs
Date: Fri, 7 Oct 2011 12:26:26 -0400
Message-ID: <20111007162625.GB4399@sigill.intra.peff.net>
References: <20111006205103.GA1271@erythro.kitwarein.com>
 <1317936107-1230-1-git-send-email-cmn@elego.de>
 <1317936107-1230-3-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	mathstuf@gmail.com
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Oct 07 18:26:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCDFq-0007xz-C6
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 18:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760106Ab1JGQ0a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 12:26:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54989
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753449Ab1JGQ03 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 12:26:29 -0400
Received: (qmail 23478 invoked by uid 107); 7 Oct 2011 16:26:29 -0000
Received: from 208.177.47.101.ptr.us.xo.net (HELO sigill.intra.peff.net) (208.177.47.101)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 07 Oct 2011 12:26:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Oct 2011 12:26:26 -0400
Content-Disposition: inline
In-Reply-To: <1317936107-1230-3-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183084>

On Thu, Oct 06, 2011 at 11:21:46PM +0200, Carlos Mart=C3=ADn Nieto wrot=
e:

> If the user gave us refspecs on the command line, we should use those
> when deciding whether to prune a ref instead of relying on the
> refspecs in the config.
>=20
> Previously, running
>=20
>     git fetch --prune origin refs/heads/master:refs/remotes/origin/ma=
ster
>=20
> would delete every other tag under the origin namespace because we

I assume you mean s/tag/branch/ in the last line?

> ---
>  builtin/fetch.c  |    6 ++--
>  builtin/remote.c |    2 +-
>  remote.c         |   78 ++++++++++++++++++++++++++++++++++++++++++++=
+++++-----
>  remote.h         |    3 +-
>  4 files changed, 77 insertions(+), 12 deletions(-)

Tests?

>  static int get_stale_heads_cb(const char *refname,
>  	const unsigned char *sha1, int flags, void *cb_data)
>  {
>  	struct stale_heads_info *info =3D cb_data;
>  	struct refspec refspec;
> +	int ret;
>  	memset(&refspec, 0, sizeof(refspec));
>  	refspec.dst =3D (char *)refname;
> -	if (!remote_find_tracking(info->remote, &refspec)) {
> -		if (!((flags & REF_ISSYMREF) ||
> -		    string_list_has_string(info->ref_names, refspec.src))) {
> -			struct ref *ref =3D make_linked_ref(refname, &info->stale_refs_ta=
il);
> -			hashcpy(ref->new_sha1, sha1);
> -		}
> +
> +	/*
> +	 * If the user speicified refspecs on the command line, we
> +	 * should only use those to check. Otherwise, look in the
> +	 * remote's configuration for the branch.
> +	 */
> +	if (info->ref_count)
> +		ret =3D find_in_refs(info->refs, info->ref_count, &refspec);
> +	else
> +		ret =3D remote_find_tracking(info->remote, &refspec);

Minor typo in the comment. But more importantly, this feels like a very
low-level place to be thinking about things like what the user gave us
on the command line.

Shouldn't get_stale_heads not get a remote at all, and just get a set o=
f
refspecs? Those should be the minimal information it needs to get its
answer, right?

-Peff
