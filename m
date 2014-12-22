From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 18/18] git receive-pack: support excluding objects from
 fsck'ing
Date: Mon, 22 Dec 2014 23:19:32 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412222319040.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <bafa42210f8885335aeacac41a81380a9a7eef24.1418055173.git.johannes.schindelin@gmx.de> <xmqqvbljgy8y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-564851146-1419286772=:21312"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 23:19:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3BKO-00024g-0b
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 23:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614AbaLVWTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 17:19:44 -0500
Received: from mout.gmx.net ([212.227.17.20]:61561 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755366AbaLVWTn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 17:19:43 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0Metpl-1YEV2b1bqr-00Obbs;
 Mon, 22 Dec 2014 23:19:32 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqvbljgy8y.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:8Hi0KtVOGXjbBYSbhlfvqEugzZmQYUpcar4VB+tq8ZiDqET8h+O
 Vn3e7aQQv2omDYBcU9vCWP6unuUB1g+ibYwS0MBSYayJdSmQDmMsv/avuIrrtT3gHmjFFfh
 81bcqD43J8bi+LO1y/h9oMuo+ocdoR6Vn+vPiAId6+wx0BMKq0PlS5ri3qZl2pfZy9PVZb6
 5EYJEuzL1/Tf7Ll0f6Qog==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261683>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-564851146-1419286772=:21312
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Wed, 10 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>=20
> > The optional new config option `receive.fsck.skip-list` specifies the p=
ath
> > to a file listing the names, i.e. SHA-1s, one per line, of objects that
> > are to be ignored by `git receive-pack` when `receive.fsckObjects =3D t=
rue`.
> >
> > This is extremely handy in case of legacy repositories where it would
> > cause more pain to change incorrect objects than to live with them
> > (e.g. a duplicate 'author' line in an early commit object).
> >
> > The intended use case is for server administrators to inspect objects
> > that are reported by `git push` as being too problematic to enter the
> > repository, and to add the objects' SHA-1 to a (preferably sorted) file
> > when the objects are legitimate, i.e. when it is determined that those
> > problematic objects should be allowed to enter the server.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/receive-pack.c          |  9 +++++++
> >  fsck.c                          | 59 +++++++++++++++++++++++++++++++++=
++++++--
> >  fsck.h                          |  2 ++
> >  t/t5504-fetch-receive-strict.sh | 12 +++++++++
> >  4 files changed, 80 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > index 111e514..5169f1f 100644
> > --- a/builtin/receive-pack.c
> > +++ b/builtin/receive-pack.c
> > @@ -110,6 +110,15 @@ static int receive_pack_config(const char *var, co=
nst char *value, void *cb)
> >  =09=09return 0;
> >  =09}
> > =20
> > +=09if (starts_with(var, "receive.fsck.skip-list")) {
>=20
> s/skip-list/skiplist/;
>=20
> > +=09=09const char *path =3D is_absolute_path(value) ?
> > +=09=09=09value : git_path("%s", value);
> > +=09=09if (fsck_strict_mode.len)
> > +=09=09=09strbuf_addch(&fsck_strict_mode, ',');
> > +=09=09strbuf_addf(&fsck_strict_mode, "skip-list=3D%s", path);
> > +=09=09return 0;
> > +=09}
> > +
> >  =09if (starts_with(var, "receive.fsck.")) {
> >  =09=09if (fsck_strict_mode.len)
> >  =09=09=09strbuf_addch(&fsck_strict_mode, ',');
> > diff --git a/fsck.c b/fsck.c
> > index 154f361..00693f2 100644
> > --- a/fsck.c
> > +++ b/fsck.c
> > @@ -7,6 +7,7 @@
> >  #include "tag.h"
> >  #include "fsck.h"
> >  #include "refs.h"
> > +#include "sha1-array.h"
> > =20
> >  #define FOREACH_MSG_ID(FUNC) \
> >  =09/* fatal errors */ \
> > @@ -56,7 +57,9 @@
> >  =09FUNC(ZERO_PADDED_FILEMODE) \
> >  =09/* infos (reported as warnings, but ignored by default) */ \
> >  =09FUNC(INVALID_TAG_NAME) \
> > -=09FUNC(MISSING_TAGGER_ENTRY)
> > +=09FUNC(MISSING_TAGGER_ENTRY) \
> > +=09/* special value */ \
> > +=09FUNC(SKIP_LIST)
>=20
> This feels like a kludge to me without comment on what "special
> value" means.  Does it mean "this object has an error (which by
> default is ignored) of being on the skip list?"  Should we be able
> to optionally warn an object on the skip-list exists with the same
> mechansim the rest of the series uses to tweak the error level?

I addressed both concerns =E2=80=93 I hope... ;-)

Ciao,
Dscho
--1784107012-564851146-1419286772=:21312--
