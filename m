From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v4 0/4] Handling of in-tree symlinks for absolute paths
Date: Sun,  2 Feb 2014 02:59:07 +0100
Message-ID: <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
References: <20140131202142.GA9731@mule>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: richih@debian.org, tboegi@web.de, gitster@pobox.com,
	pclouds@gmail.com, Martin Erik Werner <martinerikwerner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 02 02:59:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9mLl-0007jg-Fm
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 02:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbaBBB7x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Feb 2014 20:59:53 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:63372 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbaBBB7w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Feb 2014 20:59:52 -0500
Received: by mail-lb0-f177.google.com with SMTP id z5so4467162lbh.36
        for <git@vger.kernel.org>; Sat, 01 Feb 2014 17:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BWFXqTjAxjq1GpdobCC1dIRVc4mv6Q/K8dOINxVFj8M=;
        b=gTEQs7kZ/XXJs1VL7bJoec42ZDt1I/Q0EMnKTYoARExCOVlqGUWzifpbkCgN59t2Df
         hqq5SzbojdfOo6et9reIcqOvU54INY5K/R0FtCJED7f8bVWrB5AqIamgqR8hP20IIEoy
         ZFO9aSQT4znox+62PEytrRY2fpKI+NiGR82gJ/IJNN6m5pJcmNLiRece4Zvf0bbP2RwB
         mQ1vRqQIfcRp2nnCFi+IR2TXrhjA069FqZDOSO3pHjrMqc9JQB1ARzBDHQpzaa4Gh5oG
         fvrDOlpf8/2Eft+dg/3NXQiMlKctkwuWioTt3fAWsWcVzIX3mkhaWDLBI9smB7pvg1kP
         qtfg==
X-Received: by 10.152.205.163 with SMTP id lh3mr19692634lac.10.1391306391680;
        Sat, 01 Feb 2014 17:59:51 -0800 (PST)
Received: from mule.student.uu.se (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id g8sm22136585lae.1.2014.02.01.17.59.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Feb 2014 17:59:50 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <20140131202142.GA9731@mule>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241346>

Hmm, maybe fourth time's the ch...nevermind.

On Sat, Feb 01, 2014 at 02:31:21AM +0100, Martin Erik Werner wrote:
> On Fri, Jan 31, 2014 at 11:37:29PM +0100, Torsten B=C3=B6gershausen w=
rote:
> > On 2014-01-31 21.22, Martin Erik Werner wrote:
(...)
> > > diff --git a/cache.h b/cache.h
> > > index ce377e1..242f27d 100644
> > > --- a/cache.h
> > > +++ b/cache.h
> > > @@ -426,6 +426,7 @@ extern void verify_filename(const char *prefi=
x,
> > >                       int diagnose_misspelt_rev);
> > >  extern void verify_non_filename(const char *prefix, const char *=
name);
> > >  extern int path_inside_repo(const char *prefix, const char *path=
);
> > > +extern int abspath_part_inside_repo(char *dst, const char *path)=
;
> > abspath_part_inside_repo() is only used in setup.c, isn't it?
> > In this case we don't need it in cache.h, it can be declared inside=
 setup.c as
> >=20
> > static int abspath_part_inside_repo(char *dst, const char *path);
> > (or "static inline" )
> >=20
> > -----------------
> > (And not in this patch: see the final setup.c:)
> >=20
> >         if (g) {
> >             free(npath);
> >             return NULL;
> >         }
> >=20
> > If this is the only caller of abspath_part_inside_repo(),
> > then  do we need npath 2 times as a parameter ?
> > Or can we re-write it to look like this:
> >=20
> > static inline int abspath_part_inside_repo(char *path)
> > [
> > ]
>=20
> I guess I've over-generalised it a bit too much, that should rather b=
e
> done if-and-when, I presume?
>=20
> It is indeed only used in setup.c and only by the prefix_path_gently
> function so static inline then?
>=20
> Hmm, for single-parameter it should suffice to simply move the parame=
ter
> down into the function, like so?:
>   const char* src;
>   src =3D dst;
> and carry on as before (obviously also renaming the variables sensibl=
y),
> or did you have something else in mind?
>=20
> (I added two parameters since I was glancing at 'normalize_path_copy_=
len'
> for inspiration, and was thinking about (purely theoretical) re-use i=
n
> other cases rather than minimizing it for the time being.)
>=20
> What do you mean with the "(And not in this patch"... bit; what "fina=
l
> setup.c"?

As per Torsten's suggestions I've re-worked abspath_part_inside_repo fu=
nction
to only take one parameter and also put it as 'static inline' before
'prefix_path_gently' since currently only used once. (The change turned
out larger/nicer than I first guessed, since the 'src' pointer and copy=
ing
could be dropped completely.)

On Sat, Feb 01, 2014 at 09:31:26AM +0700, Duy Nguyen wrote:
> On Sat, Feb 1, 2014 at 3:22 AM, Martin Erik Werner
> <martinerikwerner@gmail.com> wrote:
(...)
> > +       // check root level
>=20
> Um.. no C++ style comments. And there should be a test that work_tree
> is the prefix of src (common case). If so we can return early and do
> not need to do real_path() on every path component.
(...)

Oops, comments fixed.

I've added the check for work tree as existing prefix, which also had t=
he nice
side-effect of checking the case of the work tree being the root of the
filesystem as a bonus.

This new single-buffer version also uses 'offset_1st_component' to move=
 past
the root (since not having to worry about copying).

Martin Erik Werner (4):
  t0060: Add test for manipulating symlinks via absolute paths
  t0060: Add test for prefix_path when path =3D=3D work tree
  setup: Add 'abspath_part_inside_repo' function
  setup: Don't dereference in-tree symlinks for absolute paths

 setup.c               | 93 ++++++++++++++++++++++++++++++++++++++++---=
--------
 t/t0060-path-utils.sh | 11 ++++++
 2 files changed, 84 insertions(+), 20 deletions(-)

--=20
1.8.5.2
