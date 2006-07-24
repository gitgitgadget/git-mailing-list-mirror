From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Makefile checks for DarwinPorts / Fink
Date: Mon, 24 Jul 2006 00:28:28 -0400
Message-ID: <20060724042828.GB9066@spearce.org>
References: <f3d7535d0607210758m4410cddfw16329ce473404fd8@mail.gmail.com> <7vhd19itu2.fsf@assigned-by-dhcp.cox.net> <20060722161914.GA10754@spearce.org> <20060723054531.GA12559@spearce.org> <e9vrsf$foc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 24 06:29:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4s3r-0002cT-3j
	for gcvg-git@gmane.org; Mon, 24 Jul 2006 06:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWGXE2c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Jul 2006 00:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWGXE2c
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 00:28:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:5863 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751394AbWGXE2c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jul 2006 00:28:32 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G4s3S-00017D-9V; Mon, 24 Jul 2006 00:28:30 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8047F20FB77; Mon, 24 Jul 2006 00:28:28 -0400 (EDT)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <e9vrsf$foc$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24113>

Jakub Narebski <jnareb@gmail.com> wrote:
> Could you _please_ document this option in commentary part in main
> Makefile?

OK.

I left them out originally as it seemed like other platform specific
items weren't in the main commentary part, but since these are
new defines I guess it makes perfect sense that they should be
documented before they get included into the main Makefile.  :-)

Hopefully this is the final version of this patch...

-->8--
Disable linking with Fink or DarwinPorts.

It may be desirable for the compiler to disable linking against Fink
or DarwinPorts, especially if both are installed on the system and
the user wants GIT to be linked specifically to only one of them.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Makefile |   30 ++++++++++++++++++++++--------
 1 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index a1666e2..5432636 100644
--- a/Makefile
+++ b/Makefile
@@ -32,6 +32,18 @@ # Define NO_SVN_TESTS if you want to ski
 # tests.  These tests take up a significant amount of the total test time
 # but are not needed unless you plan to talk to SVN repos.
 #
+# Define NO_FINK if you are building on Darwin/Mac OS X, have Fink
+# installed in /sw, but don't want GIT to link against any libraries
+# installed there.  If defined you may specify your own (or Fink's)
+# include directories and library directories by defining CFLAGS
+# and LDFLAGS appropriately.
+#
+# Define NO_DARWIN_PORTS if you are building on Darwin/Mac OS X,
+# have DarwinPorts installed in /opt/local, but don't want GIT to
+# link against any libraries installed there.  If defined you may
+# specify your own (or DarwinPort's) include directories and
+# library directories by defining CFLAGS and LDFLAGS appropriately.
+#
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
 #
@@ -267,15 +279,17 @@ ifeq ($(uname_S),Darwin)
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_STRLCPY = YesPlease
-	## fink
-	ifeq ($(shell test -d /sw/lib && echo y),y)
-		BASIC_CFLAGS += -I/sw/include
-		BASIC_LDFLAGS += -L/sw/lib
+	ifndef NO_FINK
+		ifeq ($(shell test -d /sw/lib && echo y),y)
+			BASIC_CFLAGS += -I/sw/include
+			BASIC_LDFLAGS += -L/sw/lib
+		endif
 	endif
-	## darwinports
-	ifeq ($(shell test -d /opt/local/lib && echo y),y)
-		BASIC_CFLAGS += -I/opt/local/include
-		BASIC_LDFLAGS += -L/opt/local/lib
+	ifndef NO_DARWIN_PORTS
+		ifeq ($(shell test -d /opt/local/lib && echo y),y)
+			BASIC_CFLAGS += -I/opt/local/include
+			BASIC_LDFLAGS += -L/opt/local/lib
+		endif
 	endif
 endif
 ifeq ($(uname_S),SunOS)
-- 
1.4.2.rc1.ge711
