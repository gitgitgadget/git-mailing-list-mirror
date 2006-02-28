From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Darwin: Ignore missing /sw/lib
Date: Tue, 28 Feb 2006 09:03:48 -0500
Message-ID: <20060228140348.GA25504@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Feb 28 15:04:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE5SL-0003h9-JQ
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 15:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWB1ODw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 09:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWB1ODw
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 09:03:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:29900 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750768AbWB1ODw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 09:03:52 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FE5S6-0004SV-9m
	for git@vger.kernel.org; Tue, 28 Feb 2006 09:03:46 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id 670EC20FBA0; Tue, 28 Feb 2006 09:03:48 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16936>

When on Darwin platforms don't include Fink or DarwinPorts
into the link path unless the related library directory
is actually present.  The linker on MacOS 10.4 complains
if it is given a directory which does not exist.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---
 I don't have Fink installed, consequently the linker is whining
 about /sw/lib not existing every time I link a GIT executable.
 I'd rather not see complaints from the linker unless they are
 important.

 Makefile |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

base f3a4ec48e402a7b49d410bdcb23470e9723788b0
last 84434f9549d56e522a2eb4de370100f0a6e5e041
diff --git a/Makefile b/Makefile
index 6c59cee41490d4bfba0fb43102555d8de3371d01..19578fc93a60cc41c31883ceac37a0f1ec4202d7 100644
--- a/Makefile
+++ b/Makefile
@@ -223,11 +223,15 @@ ifeq ($(uname_S),Darwin)
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	## fink
-	ALL_CFLAGS += -I/sw/include
-	ALL_LDFLAGS += -L/sw/lib
+	ifeq ($(shell test -d /sw/lib && echo y),y)
+		ALL_CFLAGS += -I/sw/include
+		ALL_LDFLAGS += -L/sw/lib
+	endif
 	## darwinports
-	ALL_CFLAGS += -I/opt/local/include
-	ALL_LDFLAGS += -L/opt/local/lib
+	ifeq ($(shell test -d /opt/local/lib && echo y),y)
+		ALL_CFLAGS += -I/opt/local/include
+		ALL_LDFLAGS += -L/opt/local/lib
+	endif
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
-- 
1.2.3.gf3a4
