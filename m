From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 0/1] Support updating working trees when pushing into
 non-bare repos
Date: Thu, 13 Nov 2014 20:18:09 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1411132001290.13845@s15462909.onlinehome-server.info>
References: <cover.1415629053.git.johannes.schindelin@gmx.de> <cover.1415876330.git.johannes.schindelin@gmx.de> <xmqqbnob2ds7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-1925862511-1415906290=:13845"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 20:18:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XozuR-0000s7-0s
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 20:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933675AbaKMTSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 14:18:17 -0500
Received: from mout.gmx.net ([212.227.17.20]:61732 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932939AbaKMTSP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 14:18:15 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0LZzY9-1YGP670DEL-00lp6S;
 Thu, 13 Nov 2014 20:18:10 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqbnob2ds7.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:/Fs5lGaCER+zmFlP2vshPX/I9ABoorD78FixoesOa+La0AKr3dS
 qQLlo997gZGXYyBWtVgPrESE7eX5PmFUTBWk3Zv90+u2t5jh7tav5awaduLm9RRO/RQgEJ2
 POmfNqbupS0B+UgRXXqMmsEp/5HOLjeT/e+ZBdmHEtJzBW62qLko2FydKQ8sbYRPkzcqXxk
 slF5GHNYCZhCqDNXQ0f6Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-1925862511-1415906290=:13845
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Thu, 13 Nov 2014, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>=20
> > This patch series adds support for a new receive.denyCurrentBranch sett=
ing
> > to update the working directory (which must be clean, i.e. there must n=
ot be
> > any uncommitted changes) when pushing into the current branch.
> >
> > The scenario in which the 'updateInstead' setting became a boon in this
> > developer's daily work is when trying to get a bug fix from a Windows
> > computer, a virtual machine or a user's machine onto his main machine (=
in
> > all of those cases it is only possible to connect via ssh in one direct=
ion,
> > but not in the reverse direction).
> >
> > Interdiff vs v2 below the diffstat.
> >
> > Johannes Schindelin (1):
> >   Add another option for receive.denyCurrentBranch
> >
> >  Documentation/config.txt |  5 ++++
> >  builtin/receive-pack.c   | 78 ++++++++++++++++++++++++++++++++++++++++=
++++++--
> >  t/t5516-fetch-push.sh    | 17 +++++++++++
> >  3 files changed, 98 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 4f9fe81..c384515 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -2134,10 +2134,6 @@ Another option is "updateInstead" which will upd=
ate the working
> >  directory (must be clean) if pushing into the current branch. This opt=
ion is
> >  intended for synchronizing working directories when one side is not ea=
sily
> >  accessible via ssh (e.g. inside a VM).
> > -+
> > -Yet another option is "detachInstead" which will detach the HEAD if up=
dates
> > -are pushed into the current branch; That way, the current revision, th=
e
> > -index and the working directory are always left untouched by pushes.
>=20
> I think we had an exchange to clarify the workflow in which
> updateInstead is useful and how to help readers, but I do not see
> any change on that in this part of documentation.  Forgot to revise?

I had revised it for v2 already. It now reads:

-- snip --
Another option is "updateInstead" which will update the working directory
(must be clean) if pushing into the current branch. This option is
intended for synchronizing working directories when one side is not easily
accessible via ssh (e.g. inside a VM).
-- snap --

In my mind, this strikes the balance between sketching a scenario where
the setting makes sense on the one hand and abducting config.txt to tell
my life's story on the other.

> > @@ -737,36 +733,66 @@ static int update_shallow_ref(struct command *cmd=
, struct shallow_info *si)
> >  =09return 0;
> >  }
> > =20
> > -static const char *merge_worktree(unsigned char *sha1)
> > +static const char *update_worktree(unsigned char *sha1)
> >  {
> >  =09const char *update_refresh[] =3D {
> >  =09=09"update-index", "--ignore-submodules", "--refresh", NULL
> >  =09};
> > +=09const char *diff_index[] =3D {
> > +=09=09"diff-index", "--quiet", "--cached", "--ignore-submodules",
> > +=09=09"HEAD", "--", NULL
> > +=09};
> >  =09const char *read_tree[] =3D {
> >  =09=09"read-tree", "-u", "-m", sha1_to_hex(sha1), NULL
> >  =09};
>=20
> OK.
>=20
> "update-index --refresh && diff-files && diff-index --cached" is how
> we traditionally ensure the working tree is absolutely clean (see
> require_clean_work_tree in git-sh-setup.sh), but I do not think of a
> reason why diff-files step is not redundant.

I fear that my double-negation-fu is still stuck somewhere in dreamland.
Do you mean to say "I could imagine that the diff-files step is
redundant"? If that is what you are telling me, then your explanation of
the exit code of update-index --refresh would suggest so, and so would
https://github.com/git/git/blob/f5709437/read-cache.c#L1201-L1230 *except*
in the case where refresh_cache_ent() returns an updated cache entry:
https://github.com/git/git/blob/f5709437/read-cache.c#L1116-L1131 =E2=80=93=
 but I
could not figure out quickly when this code path is hit.

Ciao,
Johannes
--1784107012-1925862511-1415906290=:13845--
