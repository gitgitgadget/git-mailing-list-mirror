From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [RFC/PATCH 4/3] Simplify naming (versioning) of non-release tig tarball and rpm file
Date: Sun, 3 Jun 2007 11:11:26 +0200
Message-ID: <20070603091126.GA1419@diku.dk>
References: <200705281054.05376.jnareb@gmail.com> <200705300131.17137.jnareb@gmail.com> <20070531131615.GA27044@diku.dk> <200706021952.28426.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 11:14:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HumAR-000208-HG
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 11:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbXFCJOV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 05:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753213AbXFCJOV
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 05:14:21 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:33632 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752410AbXFCJOU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 05:14:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 08A7177001F;
	Sun,  3 Jun 2007 11:14:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C7QFVWeftnJw; Sun,  3 Jun 2007 11:14:17 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 3EBD5770059;
	Sun,  3 Jun 2007 11:11:27 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 1BFFE6DFD3D; Sun,  3 Jun 2007 11:09:20 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 213C162A5D; Sun,  3 Jun 2007 11:11:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200706021952.28426.jnareb@gmail.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48979>

Jakub Narebski <jnareb@gmail.com> wrote Sat, Jun 02, 2007:
> This is proposal to simplify naming of non-release tarballs and rpm file,
> both for tig and also for git itself. Instead of using whole git-describe
> output as version number in tarball/rpm name (BTW. it would be nice to
> have command line switch to git-describe which would return old output,
> without number of commits since given tag) use tag part as version number,
> and number of commits since (plus optional marking dirty) as release
> number.
> 
> What do you think about this?

I like the simpler and less confusing names. How about the simpler
version below?

BTW, I also added `make dist DIST_VERSION=X.Y` to make it easy to force
a version. I used it when building the documentation in the release
branch.

> diff --git a/Makefile b/Makefile
> index b49d7f8..1e67586 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -17,7 +17,13 @@ ifdef DIST_VERSION
>  VERSION	= $(DIST_VERSION)
>  endif
>  
> -RPM_VERSION = $(subst -,.,$(VERSION))
> +# $(GITDESC) looks like either x.y, or like x.y-z-g<sha1>
> +SPLIT_VERSION := $(shell echo $(GITDESC) | \
> +                   sed -e 's/^\(.*\)-\([0-9]\+\)-\(g[0-9a-f]\+\)$$/\1 \2 \3/g')
> +RPM_VERSION = $(subst -,.,$(word 1,$(SPLIT_VERSION)))
> +RPM_RELEASE = $(strip \
> +              $(subst -,.,$(if $(word 2,$(SPLIT_VERSION)),\
> +                               $(word 2,$(SPLIT_VERSION)),0)$(WTDIRTY)))
>  
>  LDLIBS	= -lcurses
>  CFLAGS	= -Wall -O2 '-DVERSION="$(VERSION)"'

diff --git a/Makefile b/Makefile
index 91cb097..622a916 100644
--- a/Makefile
+++ b/Makefile
@@ -17,7 +17,11 @@ ifdef DIST_VERSION
 VERSION = $(DIST_VERSION)
 endif
 
-RPM_VERSION = $(subst -,.,$(VERSION))
+# Split the version "TAG-OFFSET-gSHA1-DIRTY" into "TAG OFFSET"
+# and append 0 as a fallback offset for "exact" tagged versions.
+RPM_VERLIST = $(filter-out g% dirty,$(subst -, ,$(VERSION))) 0
+RPM_VERSION = $(word 1,$(RPM_VERLIST))
+RPM_RELEASE = $(word 2,$(RPM_VERLIST))$(if $(WTDIRTY),.dirty)
 
 LDLIBS	= -lcurses
 CFLAGS	= -Wall -O2

-- 
Jonas Fonseca
