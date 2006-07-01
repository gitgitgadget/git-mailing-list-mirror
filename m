From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Git.pm: Avoid ppport.h
Date: Sun, 2 Jul 2006 01:48:32 +0200
Message-ID: <20060701234832.GD29115@pasky.or.cz>
References: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0606280928540.29667@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0606280938420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 01:48:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwpCY-0001JW-9f
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 01:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWGAXsf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 19:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWGAXsf
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 19:48:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46982 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964857AbWGAXse (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 19:48:34 -0400
Received: (qmail 3626 invoked by uid 2001); 2 Jul 2006 01:48:32 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606280938420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23083>

  Hi,

Dear diary, on Wed, Jun 28, 2006 at 09:39:46AM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> on my iBook, make in pu outputs:
> 
> GIT_VERSION = 1.4.1.rc1.gf5d3
>     * new build flags or prefix
> (cd perl && /usr/bin/perl Makefile.PL \
>      PREFIX='/Users/gene099' \
>      DEFINE=' -I/sw/include -DSHA1_HEADER='\''<openssl/sha.h>'\'' 
> -DNO_STRCASESTR -DNO_STRLCPY -DGIT_VERSION='\''"1.4.1.rc1.gf5d3"'\''' \
>      LIBS=' -L/sw/lib -lz  -liconv  -lcrypto -lssl')
> Can't locate Devel/PPPort.pm in @INC (@INC contains: 
> /System/Library/Perl/darwin /System/Library/Perl /Library/Perl/darwin 
> /Library/Perl /Library/Perl /Network/Library/Perl/darwin 
> /Network/Library/Perl /Network/Library/Perl .) at Makefile.PL line 29.
> BEGIN failed--compilation aborted at Makefile.PL line 29.
> make: *** [perl/Makefile] Error 2

  ow, Devel::PPPort might not be around all the way back to 5.6.0. What
is your Perl version, BTW?

->8-

This makes us not include ppport.h which seems not to give us anything real
anyway; it is useful for checking for portability warts but since Devel::PPPort
is a portability wart itself, we shouldn't require it for build. You can check
for portability problems by calling make check in perl/.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 perl/Git.xs      |    2 --
 perl/Makefile.PL |   10 +++++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/perl/Git.xs b/perl/Git.xs
index cb23261..51bfac3 100644
--- a/perl/Git.xs
+++ b/perl/Git.xs
@@ -15,8 +15,6 @@ #include "EXTERN.h"
 #include "perl.h"
 #include "XSUB.h"
 
-#include "ppport.h"
-
 #undef die
 
 
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 25ae54a..97ee9af 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -5,6 +5,11 @@ sub MY::postamble {
 instlibdir:
 	@echo '$(INSTALLSITEARCH)'
 
+check:
+	perl -MDevel::PPPort -le 'Devel::PPPort::WriteFile(".ppport.h")' && \
+	perl .ppport.h --compat-version=5.6.0 Git.xs && \
+	rm .ppport.h
+
 MAKE_FRAG
 }
 
@@ -24,8 +29,3 @@ WriteMakefile(
 	MYEXTLIB        => '../libgit.a',
 	INC             => '-I. -I..',
 );
-
-
-use Devel::PPPort;
-
--s 'ppport.h' or Devel::PPPort::WriteFile();

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
