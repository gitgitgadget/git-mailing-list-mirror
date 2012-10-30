From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v2] fix 'make test' for HP NonStop
Date: Tue, 30 Oct 2012 10:21:40 +0100
Message-ID: <005701cdb67f$f8b44d00$ea1ce700$@schmitz-digital.de>
References: <003101cdb29f$7c8d9490$75a8bdb0$@schmitz-digital.de> <20121029070642.GD5102@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Jeff King'" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 30 10:22:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT81O-00080b-Hm
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 10:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759Ab2J3JVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 05:21:54 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:50274 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab2J3JVx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 05:21:53 -0400
Received: from DualCore (dsdf-4d0a0818.pool.mediaWays.net [77.10.8.24])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LeQLR-1T3QIs0kKj-00pmAf; Tue, 30 Oct 2012 10:21:51 +0100
In-Reply-To: <20121029070642.GD5102@sigill.intra.peff.net>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIlX7q440WLF4KEDuwm97Lh97V6UQEakr3blxlm+mA=
Content-Language: de
X-Provags-ID: V02:K0:vVspftPRyUO4p30ucU6tdm0Oz4LS2f8fIYJqUnvKU+2
 AYkgUbIvmW2E6lSlzdII3/wb6Jmyg8YGz+B1oSq3NddpW3DAte
 vuYDa9lgs6c9D2bGIMWPjeQg+dxj/qZsmcNUlhESaRScpploxO
 07EatlaNtUDuIZhb/9QnnMKKtFFBJa3HuyDY5JeAGehdlCWGzb
 nzGGobYkZ1ARCEqo87QtLW7u7L9oMU55toB/AZcJkhfnJzjrVi
 Q6SNTSjd/Qzq9mF3J7/lGGBse2nEGFG8vvSRlEbSIVGpDrg7VT
 Ifpq4TSfRTLOsFmh2EgSQXb8Y/KMlPpuEuPdah5Ld9nfH+QIb3
 pX3ErE1cBxjO8OdsnXmcQ3NiYPNKK5hN/yu/D9yjRKiagr7S+7
 NSHN4GrZ3fAhg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208686>

> From: Jeff King [mailto:peff@peff.net]
> Sent: Monday, October 29, 2012 8:07 AM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH v2] fix 'make test' for HP NonStop
> 
> On Thu, Oct 25, 2012 at 12:57:10PM +0200, Joachim Schmitz wrote:
> 
> > diff --git a/Makefile b/Makefile
> > index f69979e..35380dd 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1381,6 +1381,15 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
> > 	MKDIR_WO_TRAILING_SLASH = YesPlease
> > 	# RFE 10-120912-4693 submitted to HP NonStop development.
> > 	NO_SETITIMER = UnfortunatelyYes
> > +
> > +	# for 'make test'
> > +	# some test don't work with /bin/diff, some fail with /bin/tar
> > +	# some need bash, and some need /usr/local/bin in PATH first
> > +	SHELL_PATH=/usr/local/bin/bash
> > +	SANE_TOOL_PATH=/usr/local/bin
> 
> I think we can drop these comments, as the reasoning really should just
> go in the commit message.

OK by me.
 
> > +	# as of H06.25/J06.14, we might better use this
> > +	#SHELL_PATH=/usr/coreutils/bin/bash
> > +	#SANE_TOOL_PATH=/usr/coreutils/bin:/usr/local/bin
> 
> Is there any reason not to put both into the default SANE_TOOL_PATH? If
> /usr/coreutils/bin does not exist on older versions, it will be a
> harmless no-op. I guess we arestuck with picking one $SHELL_PATH,
> though.

And because of that have to modify something anyway...
But I don't really mind about an extended SANE_TOOL_PATH
 
> -Peff

Bye, Jojo

-- 8< --
This fixes the vast majority of test failures on HP NonStop.
Some test don't work with /bin/diff, some fail with /bin/tar,
so let's put /usr/local/bin in PATH first. 
Some tests fail with /bin/sh (link to /bin/ksh) so use bash instead

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---

Makefile | 9 +++++++++
1 file changed, 9 insertions(+)

diff --git a/Makefile b/Makefile
index f69979e..35380dd 100644
--- a/Makefile
+++ b/Makefile
@@ -1381,6 +1381,10 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
	MKDIR_WO_TRAILING_SLASH = YesPlease
	# RFE 10-120912-4693 submitted to HP NonStop development.
	NO_SETITIMER = UnfortunatelyYes
+	SANE_TOOL_PATH=/usr/coreutils/bin:/usr/local/bin 
+	SHELL_PATH=/usr/local/bin/bash
+	# as of H06.25/J06.14, we might better use this
+	#SHELL_PATH=/usr/coreutils/bin/bash
endif
ifneq (,$(findstring MINGW,$(uname_S)))
	pathsep = ;
