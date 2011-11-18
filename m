From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] Makefile: add option to disable automatic dependency
 generation
Date: Fri, 18 Nov 2011 03:58:21 -0600
Message-ID: <20111118095820.GF25145@elie.hsd1.il.comcast.net>
References: <CACsJy8BZMDyf4MCiKxPJ5Z+XS+C-MC82SpMFyWgiXmb9xCnScw@mail.gmail.com>
 <20111118034142.GA25228@elie.hsd1.il.comcast.net>
 <CACsJy8A44PFtYrm8NQU+48sVkOe8mjJyO9opO5-TwRtAd-TKsQ@mail.gmail.com>
 <20111118045742.GA25145@elie.hsd1.il.comcast.net>
 <7vty62klg9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Fredrik Kuivinen <frekui@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 10:58:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRLDP-0003R9-VY
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 10:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755570Ab1KRJ6b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Nov 2011 04:58:31 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40103 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611Ab1KRJ63 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2011 04:58:29 -0500
Received: by ggnb2 with SMTP id b2so2248848ggn.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 01:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Rax81LUJ884bTaiYILGehvgH9+HFykE9Qlbaf1bZVQQ=;
        b=m/mvIvZ3fiEBkiT5kF5SBHZC9ySB33jW9LODT2dhRQNubgJj1esycMcmnlU8AckHv6
         I6FYIKoCRUEnW0cuqoayaeft5sIhB1DSrqSP6D/6g8ml8v1mmb0r+K9N/YyuoB+VIxNu
         6EGrx3vA+NhYpHu7q9AFQB50Sfa+CO5CSNG84=
Received: by 10.50.194.231 with SMTP id hz7mr2614940igc.7.1321610309051;
        Fri, 18 Nov 2011 01:58:29 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id el2sm982913ibb.10.2011.11.18.01.58.28
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Nov 2011 01:58:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vty62klg9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185644>

Now that the COMPUTE_HEADER_DEPENDENCIES feature is turned on
automatically for compilers that support it (see v1.7.8-rc0~142^2~1,
2011-08-18), there is no easy way to force it off.  For example,
setting COMPUTE_HEADER_DEPENDENCIES to the empty string in config.mak
just tells the makefile to treat it as undefined and run a test
command to see if the -MMD option is supported.

So allow setting COMPUTE_HEADER_DEPENDENCIES=3Dno to explicitly force
the feature off.  The new semantics:

 - "yes" means to explicitly enable the feature
 - "no" means to disable it
 - "auto" means to autodetect

The default is still "auto".  Any value other than these three will
cause the build to error out with a descriptive message so typos and
stale settings in config.mak don't result in mysterious behavior.

	Makefile:1278: *** please set COMPUTE_HEADER_DEPENDENCIES to
	yes, no, or auto (not "1").  Stop.

So now when someone using a compiler without -MMD support reports
trouble building git, you can reproduce it by running "make
COMPUTE_HEADER_DEPENDENCIES=3Dno".

Suggested-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> Eek. At least at the end user UI level, couldn't we do this as a tris=
tate?

Nice idea.  Here it is.

 Makefile |   31 ++++++++++++++++++++++++-------
 1 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 34ac7957..b1c80a67 100644
--- a/Makefile
+++ b/Makefile
@@ -250,6 +250,12 @@ all::
 #   DEFAULT_EDITOR=3D'$GIT_FALLBACK_EDITOR',
 #   DEFAULT_EDITOR=3D'"C:\Program Files\Vim\gvim.exe" --nofork'
 #
+# Define COMPUTE_HEADER_DEPENDENCIES to "yes" if you want dependencies=
 on
+# header files to be automatically computed, to avoid rebuilding objec=
ts when
+# an unrelated header file changes.  Define it to "no" to use the hard=
-coded
+# dependency rules.  The default is "auto", which means to use compute=
d header
+# dependencies if your compiler is detected to support it.
+#
 # Define CHECK_HEADER_DEPENDENCIES to check for problems in the hard-c=
oded
 # dependency rules.
 #
@@ -1246,21 +1252,32 @@ endif
 endif
=20
 ifdef CHECK_HEADER_DEPENDENCIES
-COMPUTE_HEADER_DEPENDENCIES =3D
+COMPUTE_HEADER_DEPENDENCIES =3D no
 USE_COMPUTED_HEADER_DEPENDENCIES =3D
-else
+endif
+
 ifndef COMPUTE_HEADER_DEPENDENCIES
+COMPUTE_HEADER_DEPENDENCIES =3D auto
+endif
+
+ifeq ($(COMPUTE_HEADER_DEPENDENCIES),auto)
 dep_check =3D $(shell $(CC) $(ALL_CFLAGS) \
 	-c -MF /dev/null -MMD -MP -x c /dev/null -o /dev/null 2>&1; \
 	echo $$?)
 ifeq ($(dep_check),0)
-COMPUTE_HEADER_DEPENDENCIES=3DYesPlease
-endif
+override COMPUTE_HEADER_DEPENDENCIES =3D yes
+else
+override COMPUTE_HEADER_DEPENDENCIES =3D no
 endif
 endif
=20
-ifdef COMPUTE_HEADER_DEPENDENCIES
+ifeq ($(COMPUTE_HEADER_DEPENDENCIES),yes)
 USE_COMPUTED_HEADER_DEPENDENCIES =3D YesPlease
+else
+ifneq ($(COMPUTE_HEADER_DEPENDENCIES),no)
+$(error please set COMPUTE_HEADER_DEPENDENCIES to yes, no, or auto \
+(not "$(COMPUTE_HEADER_DEPENDENCIES)"))
+endif
 endif
=20
 ifdef SANE_TOOL_PATH
@@ -1907,7 +1924,7 @@ OBJECTS :=3D $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_O=
BJS)
 dep_files :=3D $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
 dep_dirs :=3D $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
=20
-ifdef COMPUTE_HEADER_DEPENDENCIES
+ifeq ($(COMPUTE_HEADER_DEPENDENCIES),yes)
 $(dep_dirs):
 	@mkdir -p $@
=20
@@ -1920,7 +1937,7 @@ Please unset CHECK_HEADER_DEPENDENCIES and try ag=
ain)
 endif
 endif
=20
-ifndef COMPUTE_HEADER_DEPENDENCIES
+ifneq ($(COMPUTE_HEADER_DEPENDENCIES),yes)
 ifndef CHECK_HEADER_DEPENDENCIES
 dep_dirs =3D
 missing_dep_dirs =3D
--=20
1.7.8.rc2
