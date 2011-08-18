From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH resend] Makefile: Use computed header dependencies if the
 compiler supports it
Date: Thu, 18 Aug 2011 20:34:39 +0200
Message-ID: <20110818183439.GA21560@fredrik-Q430-Q530>
References: <1313347512-7815-1-git-send-email-frekui@gmail.com>
 <20110814190050.GA16819@elie.gateway.2wire.net>
 <CALx8hKRBjXr44gM1JA+d=RU80pmruPV56s-G3JvViz87eJ=ajQ@mail.gmail.com>
 <20110814200255.GC16819@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 20:34:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu7QX-0004D2-Le
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 20:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234Ab1HRSeo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 14:34:44 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56774 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab1HRSeo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 14:34:44 -0400
Received: by bke11 with SMTP id 11so1667159bke.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 11:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7HmY3TGT/1W9bSjwSADhjUue5QDVS9p65nK2DZYNMnU=;
        b=uM4UNGw/EIf8uJwpa/v8r3/1zT7tXyGc6G3Q+BOYDPqs6/c1dRf7WwxcuiHsUB2+Sz
         1t4T+vowwE/vYsI7SgKmWEhyca+B1CL7N8Yawmg92NWWeVogb1n+KlwFrqlAbXH3nQ5P
         bYdEiAieuCXG+2TO3fG6w/DxRgwsd8dmFPy+s=
Received: by 10.204.185.65 with SMTP id cn1mr515204bkb.109.1313692482829;
        Thu, 18 Aug 2011 11:34:42 -0700 (PDT)
Received: from fredrik-Q430-Q530 (c83-250-151-53.bredband.comhem.se [83.250.151.53])
        by mx.google.com with ESMTPS id u14sm803061bkt.62.2011.08.18.11.34.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 11:34:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110814200255.GC16819@elie.gateway.2wire.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179610>

On Sun, Aug 14, 2011 at 03:02:55PM -0500, Jonathan Nieder wrote:
> Fredrik Kuivinen wrote:
> > On Sun, Aug 14, 2011 at 21:00, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:
>=20
> >> I wonder if we can make do with a faster check, like
> >>
> >> =A0 =A0 =A0 =A0$(CC) -c -MF /dev/null -MMD -MP git.c --help >/dev/=
null 2>&1
> >>
> >> What do you think?
> [...]
> > Without patch (with COMPUTE_HEADER_DEPENDENCIES=3DYes):
>=20
> The case to compare against is when COMPUTE_HEADER_DEPENDENCIES is no=
t
> set, I'd think, since that is the status quo.  And I was talking abou=
t
> commands like "make clean" that do not care about that feature, not
> "make all".

There is no measurable difference between setting and unsetting
COMPUTE_HEADER_DEPENDENCIES for me (not surprising as nothing is
actually built). "make clean" (in a clean tree) takes more time than
"make" (in a fully built tree), so the relative overhead in the make
clean case is even smaller. The absolute overhead is, of course, the
same.

> [...]
> > With patch, but changed to use git.c instead of ++empty.c:
>=20
> Did you try with "--help"?

Oh, I missed "--help". But for me gcc always exits with status code 0
when I give it "--help", regardless of what other flags I
provide. Therefore, I don't see how "--help" can be used to test for
support of -MMD.

Here is an updated patch. It avoids the ++empty.c file by giving "-x
c" to the compiler. It also avoids the auto-detection when
COMPUTE_HEADER_DEPENDENCIES is set, so if you want to avoid the
overhead you can set that in you config.mak.


-- 8< --

Subject: [PATCH] Makefile: Use computed header dependencies if the comp=
iler supports it

Previously you had to manually define COMPUTE_HEADER_DEPENDENCIES to
enable this feature. It seemed a bit sad that such a useful feature
had to be enabled manually.

To avoid the small overhead we don't do the auto-detection if
COMPUTE_HEADER_DEPENDENCIES is already set.

Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>
---
 Makefile |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 89cc624..c131439 100644
--- a/Makefile
+++ b/Makefile
@@ -250,10 +250,6 @@ all::
 #   DEFAULT_EDITOR=3D'$GIT_FALLBACK_EDITOR',
 #   DEFAULT_EDITOR=3D'"C:\Program Files\Vim\gvim.exe" --nofork'
 #
-# Define COMPUTE_HEADER_DEPENDENCIES if your compiler supports the -MM=
D option
-# and you want to avoid rebuilding objects when an unrelated header fi=
le
-# changes.
-#
 # Define CHECK_HEADER_DEPENDENCIES to check for problems in the hard-c=
oded
 # dependency rules.
 #
@@ -1236,6 +1232,15 @@ endif
 ifdef CHECK_HEADER_DEPENDENCIES
 COMPUTE_HEADER_DEPENDENCIES =3D
 USE_COMPUTED_HEADER_DEPENDENCIES =3D
+else
+ifndef COMPUTE_HEADER_DEPENDENCIES
+dep_check =3D $(shell sh -c \
+	'$(CC) -c -MF /dev/null -MMD -MP -x c /dev/null -o /dev/null 2>&1; \
+	echo $$?')
+ifeq ($(dep_check),0)
+COMPUTE_HEADER_DEPENDENCIES=3DYesPlease
+endif
+endif
 endif
=20
 ifdef COMPUTE_HEADER_DEPENDENCIES
--=20
1.7.5.3.368.g8b1b7.dirty
