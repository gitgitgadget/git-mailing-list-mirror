From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [RFC PATCH] repack: make repack -a equivalent to repack -A and
	drop previous -a behavior
Date: Fri, 14 Nov 2008 02:25:02 +0100
Message-ID: <20081114012502.GC5285@atjola.homenet>
References: <7xh1_tFsJkHTjg4Hjm-R4mGSRfYyGFmLI62OMmaNg32f86EbVIYvYrGiYpEGkvooY4pUM1e7CHk@cipher.nrlssc.navy.mil> <20081114000219.GB5285@atjola.homenet> <jKWdt94ZxgNW0UAgUUW-qjTtpWohpQXMfvw-AUmOXND8SD5yFw0N8w@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Nov 14 02:27:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0nSr-0007cK-PX
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 02:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756705AbYKNBZ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2008 20:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756873AbYKNBZ1
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 20:25:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:55076 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756591AbYKNBZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 20:25:25 -0500
Received: (qmail invoked by alias); 14 Nov 2008 01:25:04 -0000
Received: from i577B96AD.versanet.de (EHLO atjola.local) [87.123.150.173]
  by mail.gmx.net (mp053) with SMTP; 14 Nov 2008 02:25:04 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19bASMlD+ZbwTablt+3GVZOm92jQy2KFAkBKmPFI2
	UBH0oDgFK/nkvz
Content-Disposition: inline
In-Reply-To: <jKWdt94ZxgNW0UAgUUW-qjTtpWohpQXMfvw-AUmOXND8SD5yFw0N8w@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100943>

On 2008.11.13 18:53:29 -0600, Brandon Casey wrote:
> Bj=F6rn Steinbrink wrote:
> > I didn't check all the (proposed) commits for that branch, so just =
let
> > me know if I'm missing anything, but doesn't this change mean that =
you
> > just lose what "-ad" did?
>=20
> yes.
>=20
> > We have:
> > 	-a	Create a new pack, containing all reachable objects
> > 	-A	Same as -a
> > 	-ad	Same as -a, and drop all old packs and loose objects
>=20
> by loose objects, I assume you mean packed unreachable objects.

No, actually I just totally ignored the fact that -a of course already
deletes the loose objects. The packed unreachable objects are in the ol=
d
packs, so they're already included in the first half of my sentence ;-)

> > 	-Ad	Sama as -ad, but keep unreachable objects loose
> >=20
> > -Ad is nice regarding it's safety-net value, but eg. after a large
> > filter-branch run, when refs/original and the reflogs have been cle=
aned,
> > you just want to get rid of all those old unreachable objects,
> > immediately. For example after importing and massaging some large
> > history from SVN, the -Ad behaviour is definitely _not_ what I want
> > there. Writing a few thousand loose objects just to prune them is j=
ust a
> > waste of time.
>=20
> hmm. That's a good point. Even though I think it is likely that the t=
housand
> loose objects that are written will be small commit objects and not b=
lobs,

When you only fix up merge commits, author information and such things,
then yes, most objects will be commits. And then it's not even that bad=
=2E

But a more interesting case is when in your old SCM you had multiple
projects in one repo, and you can't sanely separate them before the
import. So you might end up using the subdirectory filter a few times,
or even just drop a bunch of branches in each copy of your import.

And another one is when you had accidently commited some huge, useless
files, and as you're switching to git now anyway, you want to get rid o=
f
them, so you use an index-filter to drop them.

=46or those two cases, -Ad vs -ad can make a huge difference. I remembe=
r
someone on #git using a subdirectory filter on some project and trying
to get the repo to a sane size afterwards. -Ad took basically forever,
while -ad finished in 5 seconds or so.

> this use case may be enough to trump the safety benefit provided by t=
he
> proposed change.

IMHO, "git gc" already provides enough safety. I tend to see "gc" as th=
e
regular "just use it" tool, while repack gives me more control over how
I want things to be done, without forcing me to use the real plumbing o=
r
to fumble around with the configuration for gc. And when I want control=
,
I'm generally prepared to shoot myself in the foot.

Bj=F6rn
