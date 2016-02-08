From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 02/15] branch: die on error in setting up tracking
 branch
Date: Mon, 8 Feb 2016 15:03:48 +0100
Message-ID: <20160208140348.GB697@pks-xps>
References: <1454413916-31984-1-git-send-email-ps@pks.im>
 <1454413916-31984-3-git-send-email-ps@pks.im>
 <xmqq60y6suqx.fsf@gitster.mtv.corp.google.com>
 <20160208134232.GA697@pks-xps>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Patrick Steinhardt <mail@pks.im>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 15:03:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSmPz-0003Zj-20
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 15:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855AbcBHODw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 09:03:52 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36720 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752765AbcBHODv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2016 09:03:51 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 6494F201F3
	for <git@vger.kernel.org>; Mon,  8 Feb 2016 09:03:50 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Mon, 08 Feb 2016 09:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=YKAf+fj1ru+urtmOMQFEyOGsjmE=; b=tx9gg
	4VH9GSZxdVjpjz/WQLpwFmkHEdOCPjRQait2DL3+ye55/p7T002PNDy9UtmujNC4
	o3iHXfMG0ZII4WDnHDWgfjClNHFwbIVFH0a1q6EDY0ZvsakV1hPA2PGqID1tlYSX
	a7unixP8JerTc3gbM4WVr85/RzGWb6Y61Z9iLg=
X-Sasl-enc: JWHpRuT0xF8MMCGpnglrQg0urBd2I0e5BVUXI9GYyphE 1454940229
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id DFF4FC0001B;
	Mon,  8 Feb 2016 09:03:49 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20160208134232.GA697@pks-xps>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285766>


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 08, 2016 at 02:42:32PM +0100, Patrick Steinhardt wrote:
> On Tue, Feb 02, 2016 at 12:49:26PM -0800, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >=20
> > > The setup_tracking function calls install_branch_config, which
> > > may fail writing the configuration due to a locked configuration
> > > file or other error conditions. setup_tracking can also fail when
> > > trying to track ambiguous information for a reference. While this
> > > condition is checked for and an error code is returned, this
> > > error is not checked by the caller.
> > >
> > > Fix both issues by dying early when error occur.
> >=20
> > Hmph.  I think create_branch() is written in such a way that all
> > die() come before the actual ref transaction attempts to create the
> > branch, but this change means that we have already created the
> > branch and then die without undoing the damage that is already done.
> >=20
> > "The error is not checked by the caller" is very true, but can the
> > caller do something better than just die?  I personally do not think
> > it is such a big deal if we just died here, but I may have overlooked
> > something.

Hum. I've actually forgot about the function not being static. It
is actually used in transport.c:transport_push() and
builtin/clone.c.

For the clone command I do not regard it as important as on
failure the user can simply re-invoke the command and clone a new
copy. Sure, this may me inefficient for large repos, but it is
still far more sensible than leaving the user with an
inconsistent repository.

In transport.c we skip updating local tracking refs when
we die. As such, we might leave refs that have been deleted on
the remote. I guess those cases are easy to fix when followed
up with a fetch or `fetch --prune`.

As said before, if we want to improve the just-die case we might
propose how the user may fix up his repository afterwards.

>=20
> Well, when dying here we do not record the tracking branch
> configuration for the newly set up branch. This is the only thing
> that we are missing as right after setting up the tracking branch
> we've finished and exit the command.
>=20
> That being said it's somewhat unfortunate to die here as the user
> cannot simply try to repeat creating a branch and hope it works
> this time as the branch has already been created and the command
> would error out. Maybe we should instead die with an improved
> error message hinting the user how to fix the issue, something
> along the lines of
>=20
> "We were unable to set the remote tracking information for the
> newly created branch due to <REASON>. After fixing the underlying
> problem you may set the remote tracking branch by executing `git
> branch --set-upstream-to=3D<BRANCH>."
>=20
> > > ---
> > >  branch.c          | 19 +++++++++----------
> > >  branch.h          |  1 +
> > >  t/t3200-branch.sh |  9 ++++++++-
> > >  3 files changed, 18 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/branch.c b/branch.c
> > > index 7ff3f20..7106369 100644
> > > --- a/branch.c
> > > +++ b/branch.c
> > > @@ -64,16 +64,16 @@ void install_branch_config(int flag, const char *=
local, const char *origin, cons
> > >  	}
> > > =20
> > >  	strbuf_addf(&key, "branch.%s.remote", local);
> > > -	git_config_set(key.buf, origin ? origin : ".");
> > > +	git_config_set_or_die(key.buf, origin ? origin : ".");
> > > =20
> > >  	strbuf_reset(&key);
> > >  	strbuf_addf(&key, "branch.%s.merge", local);
> > > -	git_config_set(key.buf, remote);
> > > +	git_config_set_or_die(key.buf, remote);
> > > =20
> > >  	if (rebasing) {
> > >  		strbuf_reset(&key);
> > >  		strbuf_addf(&key, "branch.%s.rebase", local);
> > > -		git_config_set(key.buf, "true");
> > > +		git_config_set_or_die(key.buf, "true");
> > >  	}
> > >  	strbuf_release(&key);
> > > =20
> > > @@ -109,8 +109,8 @@ void install_branch_config(int flag, const char *=
local, const char *origin, cons
> > >   * to infer the settings for branch.<new_ref>.{remote,merge} from the
> > >   * config.
> > >   */
> > > -static int setup_tracking(const char *new_ref, const char *orig_ref,
> > > -			  enum branch_track track, int quiet)
> > > +static void setup_tracking(const char *new_ref, const char *orig_ref,
> > > +			   enum branch_track track, int quiet)
> > >  {
> > >  	struct tracking tracking;
> > >  	int config_flags =3D quiet ? 0 : BRANCH_CONFIG_VERBOSE;
> > > @@ -118,7 +118,7 @@ static int setup_tracking(const char *new_ref, co=
nst char *orig_ref,
> > >  	memset(&tracking, 0, sizeof(tracking));
> > >  	tracking.spec.dst =3D (char *)orig_ref;
> > >  	if (for_each_remote(find_tracked_branch, &tracking))
> > > -		return 1;
> > > +		return;
> > > =20
> > >  	if (!tracking.matches)
> > >  		switch (track) {
> > > @@ -127,18 +127,17 @@ static int setup_tracking(const char *new_ref, =
const char *orig_ref,
> > >  		case BRANCH_TRACK_OVERRIDE:
> > >  			break;
> > >  		default:
> > > -			return 1;
> > > +			return;
> > >  		}
> > > =20
> > >  	if (tracking.matches > 1)
> > > -		return error(_("Not tracking: ambiguous information for ref %s"),
> > > -				orig_ref);
> > > +		die(_("Not tracking: ambiguous information for ref %s"),
> > > +		    orig_ref);
> > > =20
> > >  	install_branch_config(config_flags, new_ref, tracking.remote,
> > >  			      tracking.src ? tracking.src : orig_ref);
> > > =20
> > >  	free(tracking.src);
> > > -	return 0;
> > >  }
> > > =20
> > >  int read_branch_desc(struct strbuf *buf, const char *branch_name)
> > > diff --git a/branch.h b/branch.h
> > > index 58aa45f..8ce22f8 100644
> > > --- a/branch.h
> > > +++ b/branch.h
> > > @@ -43,6 +43,7 @@ void remove_branch_state(void);
> > >  /*
> > >   * Configure local branch "local" as downstream to branch "remote"
> > >   * from remote "origin".  Used by git branch --set-upstream.
> > > + * Dies if unable to install branch config.
> > >   */
> > >  #define BRANCH_CONFIG_VERBOSE 01
> > >  extern void install_branch_config(int flag, const char *local, const=
 char *origin, const char *remote);
> > > diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> > > index cdaf6f6..dd776b3 100755
> > > --- a/t/t3200-branch.sh
> > > +++ b/t/t3200-branch.sh
> > > @@ -446,6 +446,13 @@ test_expect_success '--set-upstream-to fails on =
a non-ref' '
> > >  	test_must_fail git branch --set-upstream-to HEAD^{}
> > >  '
> > > =20
> > > +test_expect_success '--set-upstream-to fails on locked config' '
> > > +	test_when_finished "rm -f .git/config.lock" &&
> > > +	>.git/config.lock &&
> > > +	git branch locked &&
> > > +	test_must_fail git branch --set-upstream-to locked
> > > +'
> > > +
> > >  test_expect_success 'use --set-upstream-to modify HEAD' '
> > >  	test_config branch.master.remote foo &&
> > >  	test_config branch.master.merge foo &&
> > > @@ -579,7 +586,7 @@ test_expect_success 'avoid ambiguous track' '
> > >  	git config remote.ambi1.fetch refs/heads/lalala:refs/heads/master &&
> > >  	git config remote.ambi2.url lilili &&
> > >  	git config remote.ambi2.fetch refs/heads/lilili:refs/heads/master &&
> > > -	git branch all1 master &&
> > > +	test_must_fail git branch all1 master &&
> > >  	test -z "$(git config branch.all1.merge)"
> > >  '



--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWuKBEAAoJEBF8Z7aeq/EsGwAP/AkqLSBLw6Zc6DiCQWvHR/JV
n2O13vr3UpVWW1KlrGt3E+N0yG30y6NQKAvFBoaiXRVc+RafJxrMwlHHJPPMoeAL
lqxJAi5nseHtYi0qaGyUJCGTzNSNQa5GkiZAGh7sB3NRvha+ENpwPE6c/HRKdC11
PlEE3feHohKvgbQm/eB+N6NkUOae+XgEpLgdDDmsSMi/op3KnHcDQI7Wbf5+zzuQ
YICHR/BeBlhaLtmG8spNI5ZY4sMch+afxu7fJAsAOQZe2PKKuIw0RzfJp5qDKpcE
qU7wi77fJNkFAaOJNhpaJuOkuyjG5dA7hx0WlOe0e6oxQjVINE/hWdG/Ri3dV4GU
Pfu1aqeBB9CiiHccfRyI34zql5+9r/g8CVV6Z/aFpuxxofQb/o3eAUtUY0NeC9jk
Zb/mggs69Pz0U2yGzn0LbTkney8OHZ7JTObgskS9sAF5QJAScVuFusT+yOjwBey2
sMRhp4SLfwLuE4BZ3iITXuj2JaImRIaePMVnvxiyY223TSDgYYOPX0B8ghkzaRHx
CYSq9IyFNRC8CKI4OHO/XZOM7eoVuEx2FWdjAlSe35htlYdEGvS3a2s3nI9MlvrZ
eSZZDpUVnpekxyJtn7lymkSLsLJxLOve1/GP7RFuzIh3NTHwKfQN7E0vVpeEzams
6LJtqYA2gWoPBHPH9a5C
=sYoE
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
