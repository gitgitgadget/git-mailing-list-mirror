From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Include local config before platform tweaks
Date: Tue, 5 Sep 2006 23:31:51 -0400
Message-ID: <20060906033151.GB30540@spearce.org>
References: <9434EEBD-57BE-46D7-A2FF-069BB960AA44@silverinsanity.com> <7vlkoyarnx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 09:04:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKrSP-0004LM-JA
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 09:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWIFHES (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 03:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWIFHES
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 03:04:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:10682 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751256AbWIFHEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 03:04:16 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GKrS9-0002Pa-JI; Wed, 06 Sep 2006 03:04:06 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9C396212694; Tue,  5 Sep 2006 23:31:51 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkoyarnx.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26503>

Junio C Hamano <junkio@cox.net> wrote:
> Brian Gernhardt <benji@silverinsanity.com> writes:
> 
> > Having config.mak included after the platform tweaks ignores NO_FINK
> > or NO_DARWIN_PORTS in that file.  Simply including the config earlier
> > fixes that.
> 
> I vaguely recall that this was brought up before, and the
> conclusion was that the include location is correct but the way
> darwin bits were done was wrong.  I do not recall the details
> but does anybody on the list know?

I think we just need to move the NO_FINK stuff below the include;
like this:


diff --git a/Makefile b/Makefile
index 164dbcf..748907b 100644
--- a/Makefile
+++ b/Makefile
@@ -328,18 +333,6 @@ ifeq ($(uname_S),Darwin)
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_STRLCPY = YesPlease
-	ifndef NO_FINK
-		ifeq ($(shell test -d /sw/lib && echo y),y)
-			BASIC_CFLAGS += -I/sw/include
-			BASIC_LDFLAGS += -L/sw/lib
-		endif
-	endif
-	ifndef NO_DARWIN_PORTS
-		ifeq ($(shell test -d /opt/local/lib && echo y),y)
-			BASIC_CFLAGS += -I/opt/local/include
-			BASIC_LDFLAGS += -L/opt/local/lib
-		endif
-	endif
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
@@ -433,6 +426,21 @@ else
 	endif
 endif
 
+ifeq ($(uname_S),Darwin)
+	ifndef NO_FINK
+		ifeq ($(shell test -d /sw/lib && echo y),y)
+			BASIC_CFLAGS += -I/sw/include
+			BASIC_LDFLAGS += -L/sw/lib
+		endif
+	endif
+	ifndef NO_DARWIN_PORTS
+		ifeq ($(shell test -d /opt/local/lib && echo y),y)
+			BASIC_CFLAGS += -I/opt/local/include
+			BASIC_LDFLAGS += -L/opt/local/lib
+		endif
+	endif
+endif
+
 ifndef NO_CURL
 	ifdef CURLDIR
 		# This is still problematic -- gcc does not always want -R.
