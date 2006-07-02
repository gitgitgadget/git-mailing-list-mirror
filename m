From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Git.pm: Don't #define around die
Date: Sun, 2 Jul 2006 22:57:17 +0200
Message-ID: <20060702205717.GH29115@pasky.or.cz>
References: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0606280928540.29667@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0606280938420.29667@wbgn013.biozentrum.uni-wuerzburg.de> <20060701234832.GD29115@pasky.or.cz> <Pine.LNX.4.63.0607021141260.29667@wbgn013.biozentrum.uni-wuerzburg.de> <7v4pxz4yki.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 22:57:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx90N-0005Q6-Ii
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 22:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWGBU5T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 16:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWGBU5T
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 16:57:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:21465 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750825AbWGBU5S (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 16:57:18 -0400
Received: (qmail 4568 invoked by uid 2001); 2 Jul 2006 22:57:17 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4pxz4yki.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23117>

Dear diary, on Sun, Jul 02, 2006 at 09:05:33PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > Error: 'const char *' not in typemap in Git.xs, line 69
> > Error: 'const char *' not in typemap in Git.xs, line 79
> > make: *** [Git.c] Error 1
> >
> > It seems like my typemap starts like this:
> >...
> > So, no "const char *". See next mail for a minimal patch.
> 
> An alternative would be to carry our own typemap but I think
> your fix is less intrusive and fine.  Pasky?

Yes, it should be fine.

> > The warning 
> > (IIRC that was mentioned already on the list) still persists:
> >
> > cc -c -I. -I.. -g -pipe -pipe -fno-common -no-cpp-precomp -flat_namespace 
> > -DHAS_TELLDIR_PROTOTYPE -fno-strict-aliasing -Os     -DVERSION=\"0.01\" 
> > -DXS_VERSION=\"0.01\"  -I/System/Library/Perl/darwin/CORE -I/sw/include 
> > -DSHA1_HEADER='<openssl/sha.h>' -DNO_STRCASESTR -DNO_STRLCPY 
> > -DGIT_VERSION='"1.4.1.g3b26"' Git.c
> > In file included from /System/Library/Perl/darwin/CORE/perl.h:500,
> >                  from Git.xs:15:
> > /System/Library/Perl/darwin/CORE/embed.h:156:1: warning: "die" redefined
> > Git.xs:11:1: warning: this is the location of the previous definition
> 
> I see the same here.

-8<-

Back in the old days, we called Git's die() from the .xs code, but we had to
hijack Perl's die() for that. Now we don't call Git's die() so no need to do
the hijacking and it silences a compiler warning.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 perl/Git.xs |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/perl/Git.xs b/perl/Git.xs
index 51bfac3..1e6c1eb 100644
--- a/perl/Git.xs
+++ b/perl/Git.xs
@@ -8,15 +8,11 @@ #include <ctype.h>
 #include "../cache.h"
 #include "../exec_cmd.h"
 
-#define die perlyshadow_die__
-
 /* XS and Perl interface */
 #include "EXTERN.h"
 #include "perl.h"
 #include "XSUB.h"
 
-#undef die
-
 
 static char *
 report_xs(const char *prefix, const char *err, va_list params)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
