From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Makefile checks for DarwinPorts / Fink
Date: Sat, 22 Jul 2006 12:19:14 -0400
Message-ID: <20060722161914.GA10754@spearce.org>
References: <f3d7535d0607210758m4410cddfw16329ce473404fd8@mail.gmail.com> <7vhd19itu2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Pfetzing <stefan.pfetzing@gmail.com>, git@vger.kernel.org,
	merlyn@stonehenge.com
X-From: git-owner@vger.kernel.org Sat Jul 22 18:19:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4KCU-0002yX-C3
	for gcvg-git@gmane.org; Sat, 22 Jul 2006 18:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWGVQTV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Jul 2006 12:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWGVQTV
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Jul 2006 12:19:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:63139 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750862AbWGVQTU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jul 2006 12:19:20 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G4KC6-000735-FE; Sat, 22 Jul 2006 12:19:10 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1370A20FB77; Sat, 22 Jul 2006 12:19:15 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd19itu2.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24073>

Junio C Hamano <junkio@cox.net> wrote:
> "Stefan Pfetzing" <stefan.pfetzing@gmail.com> writes:
> 
> > while I was updating the DarwinPorts Portfile for git, I saw some
> > really suspicious lines in the Makefile of Git for DarwinPorts/Fink.
> >
> > --- snip ---
> >        ## fink
> >        ifeq ($(shell test -d /sw/lib && echo y),y)
> >                ALL_CFLAGS += -I/sw/include
> >                ALL_LDFLAGS += -L/sw/lib
> >        endif
> >        ## darwinports
> >        ifeq ($(shell test -d /opt/local/lib && echo y),y)
> >                ALL_CFLAGS += -I/opt/local/include
> >                ALL_LDFLAGS += -L/opt/local/lib
> >        endif
> > --- snap ---
> >
> > IMHO, Git should definetely not include /sw/include and /sw/lib, just
> > if it *exists*.
[snip]
> But I suspect that the "official" portfile (or whatever it is
> called in the Darwin world) should be able to override whatever
> is done in there --- otherwise we would need to remove them or
> comment them out, but I am hoping it does not have to come to
> that; I think they serve as good hint to help people who are
> building from the source.

The quoted section of the Makefile was mostly my fault.  GIT used
to build only against Fink but when I switched to DarwinPorts it
was first not even looking for them and second when I removed Fink
the Mac OS X linker was warning about /sw/lib not existing.

I completely agree that its incorrect to be doing this all of the
time as a higher-level build driver (e.g. Portfile) should be able
to have more direct control CFLAGS and LDFLAGS.  Perhaps something
like this?

diff --git a/Makefile b/Makefile
index a1666e2..0a48c32 100644
--- a/Makefile
+++ b/Makefile
@@ -268,14 +268,18 @@ ifeq ($(uname_S),Darwin)
 	NEEDS_LIBICONV = YesPlease
 	NO_STRLCPY = YesPlease
 	## fink
-	ifeq ($(shell test -d /sw/lib && echo y),y)
-		BASIC_CFLAGS += -I/sw/include
-		BASIC_LDFLAGS += -L/sw/lib
+	ifndef NO_FINK
+		ifeq ($(shell test -d /sw/lib && echo y),y)
+			BASIC_CFLAGS += -I/sw/include
+			BASIC_LDFLAGS += -L/sw/lib
+		endif
 	endif
+	ifndef NO_DARWIN_PORTS
 	## darwinports
-	ifeq ($(shell test -d /opt/local/lib && echo y),y)
-		BASIC_CFLAGS += -I/opt/local/include
-		BASIC_LDFLAGS += -L/opt/local/lib
+		ifeq ($(shell test -d /opt/local/lib && echo y),y)
+			BASIC_CFLAGS += -I/opt/local/include
+			BASIC_LDFLAGS += -L/opt/local/lib
+		endif
 	endif
 endif
 ifeq ($(uname_S),SunOS)

-- 
Shawn.
