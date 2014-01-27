From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: Re: [PATCH 2/2] setup: Don't dereference in-tree symlinks for absolute paths
Date: Mon, 27 Jan 2014 01:07:29 +0100
Message-ID: <1390781250-20389-1-git-send-email-martinerikwerner@gmail.com>
References: <52E5439D.7060002@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: richih@debian.org
To: tboegi@web.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 27 01:08:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7ZkP-0007fv-4n
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 01:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbaA0AIM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Jan 2014 19:08:12 -0500
Received: from mail-la0-f53.google.com ([209.85.215.53]:57585 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbaA0AIM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 19:08:12 -0500
Received: by mail-la0-f53.google.com with SMTP id e16so3921287lan.26
        for <git@vger.kernel.org>; Sun, 26 Jan 2014 16:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=y40xphRF+7QjYnNlZuU1UIx1pV9evCdB2Rkkn3iId7M=;
        b=yMspIMGK2PMpo7xVq9p6GNpvl7+Y6aigZQ5i1uizkekJOCB/PYtbMar+fCWvfsi7h8
         Amx6KYqfbn0fX+BhNRokzgbjM0t/ZTKCTnoe/KJ32QUBrg0nvBAaUO6AdTNTbnlnk/uE
         L1E3+Yc/iPFJ33topMHegWf/UJEcM0mnaaZkSRun1xUnkDhfAJagsze5zWgzqt6vhlFs
         EwTHfMHZ1iK/ZlDN8NPqsi34z3kIvSZYR565w+cKkFkN77pFdnsvoKZS2QzUtEhRhteO
         iJ2mzdauaJKhW9PeoyOIZfdTq4Q40/Ek8CLE3LNHebH7lt0bMZWDO6fIEiOvhfC2T4RK
         ppIg==
X-Received: by 10.112.45.108 with SMTP id l12mr15087521lbm.21.1390781290284;
        Sun, 26 Jan 2014 16:08:10 -0800 (PST)
Received: from mule.student.uu.se (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id mx3sm10067695lbc.14.2014.01.26.16.08.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Jan 2014 16:08:09 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <52E5439D.7060002@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241119>

On Sun, Jan 26, 2014 at 06:19:25PM +0100, Torsten B=C3=B6gershausen wro=
te:
> On 2014-01-26 15.22, Martin Erik Werner wrote:
> > The prefix_path_gently() function currently applies real_path to
> > everything if given an absolute path, dereferencing symlinks both
> > outside and inside the work tree. In order to manipulate symliks in=
 the
> > work tree using absolute paths, symlinks should only be dereference=
d
> > outside the work tree.
> >=20
> > Modify prefix_path_gently() to first normalize the path in order to
> > make sure path levels are separated by '/', then use this separator=
 to
> > check the real path of each level of the path until it has found th=
e
> > length that corresponds to the work tree.
> >=20
> > For absolute paths, the function did not, nor does now do, any actu=
al
> > prefixing, hence we simply remove the path corresponding to the wor=
k
> > tree and return the remaining in-tree part of the path.
> >=20
> > Fixes t0060-82.
> >=20
> > Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
> > ---
> >  setup.c               | 54 ++++++++++++++++++++++++++++++++-------=
------------
> >  t/t0060-path-utils.sh |  2 +-
> >  2 files changed, 35 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/setup.c b/setup.c
> > index 6c3f85f..bec587e 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -22,11 +22,41 @@ char *prefix_path_gently(const char *prefix, in=
t len,
> >  	const char *orig =3D path;
> >  	char *sanitized;
> >  	if (is_absolute_path(orig)) {
> > -		const char *temp =3D real_path(path);
> > -		sanitized =3D xmalloc(len + strlen(temp) + 1);
> > -		strcpy(sanitized, temp);
> > +		char npath[strlen(path)];
> Is this portable ?
> This is variable-length array, isn't it ?
> Using xmalloc() may be better
Ah, right, that looks bad now that you mention it.
> >  		if (remaining_prefix)
> >  			*remaining_prefix =3D 0;
> > +		if (normalize_path_copy_len(npath, path, remaining_prefix))
> > +			return NULL;
> > +		const char *work_tree =3D get_git_work_tree();
> declaration after statements should be avoided (not only here)
>=20
Indeed, I somehow guessed that declaration-after-statement was ok and
tried to keep them close to usage, bad guess, evidently.

I've rerolled the last v1 patch accordingly:
* Use xmalloc() when initializing char* from strlen()
* Separate and move declarations to beginning of scope
* Fix a strcpy that should've been a strcat (which would've nuked DOS
  prefixes, I think)

  [PATCH v2 2/2] setup: Don't dereference in-tree symlinks for absolute=
 paths

 setup.c               | 64 +++++++++++++++++++++++++++++++++++--------=
--------
 t/t0060-path-utils.sh |  2 +-
 2 files changed, 45 insertions(+), 21 deletions(-)

--
Martin Erik Werner <martinerikwerner@gmail.com>
