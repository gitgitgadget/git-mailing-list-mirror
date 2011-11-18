From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Makefile: add option to disable automatic dependency
 generation
Date: Thu, 17 Nov 2011 22:57:42 -0600
Message-ID: <20111118045742.GA25145@elie.hsd1.il.comcast.net>
References: <CACsJy8BZMDyf4MCiKxPJ5Z+XS+C-MC82SpMFyWgiXmb9xCnScw@mail.gmail.com>
 <20111118034142.GA25228@elie.hsd1.il.comcast.net>
 <CACsJy8A44PFtYrm8NQU+48sVkOe8mjJyO9opO5-TwRtAd-TKsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Fredrik Kuivinen <frekui@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 05:58:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRGWW-0001rT-GI
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 05:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756628Ab1KRE5z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 23:57:55 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36422 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756332Ab1KRE5z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2011 23:57:55 -0500
Received: by ghbz2 with SMTP id z2so124542ghb.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 20:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RVTdQ4PwQfuytvWkIJueHGSVdzEVgRkPkLwLksiSh/A=;
        b=FLGvV9R9di6FljeSdg0Rjj9goAhDidOtXUdrItqJCfKhxrVR//GAOLvaC9rHF+9spr
         wQ3xnNISjFhNUYLyCoqxVL7HomdhD1DjD6le/NFiBu9duqTIN4+/fuFoqWzPLTseCwPC
         UQbtG4epNJXgsuNDRs+VPdNlAKgdy0Pf7xR4E=
Received: by 10.101.6.3 with SMTP id j3mr350057ani.49.1321592274490;
        Thu, 17 Nov 2011 20:57:54 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id j25sm9385642yhm.12.2011.11.17.20.57.53
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 20:57:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACsJy8A44PFtYrm8NQU+48sVkOe8mjJyO9opO5-TwRtAd-TKsQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185631>

Duy noticed that now that the COMPUTE_HEADER_DEPENDENCIES feature is
turned on automatically for compilers that support it (see
v1.7.8-rc0~142^2~1, 2011-08-18), there is no easy way to force it off.
=46or example, setting COMPUTE_HEADER_DEPENDENCIES to the empty string
in config.mak just tells the makefile to treat it as undefined and
run a test command to see if the -MMD option is supported.

Introduce a new NO_COMPUTE_HEADER_DEPENDENCIES variable that forces
the feature off.  The new semantics:

 - If NO_COMPUTE_HEADER_DEPENDENCIES is set to a nonempty string,
   the -MMD option will not be used.  The build relies on hard-coded
   dependencies in the "ifndef USE_COMPUTED_HEADER_DEPENDENCIES"
   section of the Makefile instead.

 - If COMPUTE_HEADER_DEPENDENCIES is empty and NO_COMPUTE_... is
   nonempty, the build uses gcc's on-the-fly dependency generation
   feature.

 - If neither is nonempty, the makefile runs a quick test command
   to decide whether the compiler supports the -MMD option and
   whether to enable this feature.

Inspired-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Nguyen Thai Ngoc Duy wrote:

> Hmm.. I guess it's my compiler's fault then. Next question, how can I
> disable this feature?

"make COMPUTE_HEADER_DEPENDENCIES=3D" works.  But there's no way aside
from "override COMPUTE_HEADER_DEPENDENCIES=3D" to do that in config.mak=
=2E
And yuck.

By the way, I'm not convinced it's your compiler's fault.  It might be
my compiler's fault.  More reading to do...

 Makefile |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index ee34eab8..e4a658f6 100644
--- a/Makefile
+++ b/Makefile
@@ -250,6 +250,13 @@ all::
 #   DEFAULT_EDITOR=3D'$GIT_FALLBACK_EDITOR',
 #   DEFAULT_EDITOR=3D'"C:\Program Files\Vim\gvim.exe" --nofork'
 #
+# Define COMPUTE_HEADER_DEPENDENCIES if your compiler supports the -MM=
D option
+# and you want to avoid rebuilding objects when an unrelated header fi=
le
+# changes.
+#
+# Define NO_COMPUTE_HEADER_DEPENDENCIES if you want to disable automat=
ic
+# dependency generation even though your compiler is detected to suppo=
rt it.
+#
 # Define CHECK_HEADER_DEPENDENCIES to check for problems in the hard-c=
oded
 # dependency rules.
 #
@@ -1245,10 +1252,16 @@ endif
 endif
=20
 ifdef CHECK_HEADER_DEPENDENCIES
+NO_COMPUTE_HEADER_DEPENDENCIES =3D YesPlease
+endif
+
+ifdef NO_COMPUTE_HEADER_DEPENDENCIES
 COMPUTE_HEADER_DEPENDENCIES =3D
 USE_COMPUTED_HEADER_DEPENDENCIES =3D
-else
+endif
+
 ifndef COMPUTE_HEADER_DEPENDENCIES
+ifndef NO_COMPUTE_HEADER_DEPENDENCIES
 dep_check =3D $(shell $(CC) $(ALL_CFLAGS) \
 	-c -MF /dev/null -MMD -MP -x c /dev/null -o /dev/null 2>&1; \
 	echo $$?)
--=20
1.7.8.rc2
