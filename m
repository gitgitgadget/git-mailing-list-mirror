From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] gitk: Fallback to po2msg if msgfmt is not available
Date: Wed, 5 Mar 2008 02:17:38 -0500
Message-ID: <20080305071738.GA23079@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 08:18:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWntL-0005uM-VI
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 08:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060AbYCEHRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 02:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753571AbYCEHRm
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 02:17:42 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38173 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbYCEHRl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 02:17:41 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWnsg-0003ar-Hq; Wed, 05 Mar 2008 02:17:38 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5B42F20FBAE; Wed,  5 Mar 2008 02:17:38 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76181>

If msgfmt is not in our PATH, or it is but it does not seem to honor the
--tcl command line option then we need to fallback to po2msg.  This is
rather common on Mac OS X systems, but also can show up on a Linux OS
if GNU gettext is not installed on the system.

This particular block of code was copied from git-gui's Makefile,
where we have already (reasonably) vetted this fallback system.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Makefile |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index ae2b80b..49a9209 100644
--- a/Makefile
+++ b/Makefile
@@ -22,6 +22,14 @@ ifdef NO_MSGFMT
 	MSGFMT ?= $(TCL_PATH) po/po2msg.sh
 else
 	MSGFMT ?= msgfmt
+	ifeq ($(shell $(MSGFMT) >/dev/null 2>&1 || echo $$?),127)
+		MSGFMT := $(TCL_PATH) po/po2msg.sh
+	endif
+	ifeq (msgfmt,$(MSGFMT))
+	ifeq ($(shell $(MSGFMT) --tcl -l C -d . /dev/null 2>/dev/null || echo $?),1)
+		MSGFMT := $(TCL_PATH) po/po2msg.sh
+	endif
+	endif
 endif
 
 PO_TEMPLATE = po/gitk.pot
-- 
1.5.4.3.529.gb25fb
