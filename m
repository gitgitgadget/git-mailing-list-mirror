From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to run git-gui always in English?
Date: Tue, 23 Oct 2007 18:45:38 -0400
Message-ID: <20071023224537.GH14735@spearce.org>
References: <CCAD0DE0-65D4-4FEC-B02F-658010FECD04@zib.de> <5AD0C329-7136-42A3-9202-865E70A29B65@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Oct 24 00:46:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkSVY-0000TQ-WC
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 00:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbXJWWpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 18:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbXJWWpm
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 18:45:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52495 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbXJWWpl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 18:45:41 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IkSV7-0006bN-RV; Tue, 23 Oct 2007 18:45:30 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 19CD020FBAE; Tue, 23 Oct 2007 18:45:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <5AD0C329-7136-42A3-9202-865E70A29B65@zib.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62168>

Steffen Prohaska <prohaska@zib.de> wrote:
> On Oct 21, 2007, at 8:47 AM, Steffen Prohaska wrote:
> 
> >How can I switch msysgit's git-gui to English, independently of
> >the language selected for Windows? I recognized that git-gui
> >adjusts to the 'language selection' of Windows. How can I
> >disable this? I want git-gui to always display English. Nothing
> >else, never! I can't help people who use a different language
> >in the gui, because I'll not understand what they are talking
> >about and they'll not understand me.
> 
> And it's even worse. An error in the localization can completely
> break git-gui. Apparently the German localization included in
> msysgit's Git-1.5.3-preview20071019.exe _is_ broken (see
> attached png).
> 
> Shouldn't the localization code be a bit more fault tolerant?

Yes.  This is a possible workaround:

>From 410aa617e7ca8240500e90f0b0389bde7b7b40aa Mon Sep 17 00:00:00 2001
From: Shawn O. Pearce <spearce@spearce.org>
Date: Tue, 23 Oct 2007 18:44:55 -0400
Subject: [PATCH] git-gui: Protect against bad translation strings

If a translation string uses a format character we don't have an
argument for then it may throw an error when we attempt to format
the translation.  In this case switch back to the default format
that comes with the program (aka the English translation).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-gui.sh |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 38c6e59..a7227ac 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -88,13 +88,20 @@ if {![catch {set _verbose $env(GITGUI_VERBOSE)}]} {
 
 package require msgcat
 
-proc mc {fmt args} {
-	set fmt [::msgcat::mc $fmt]
+proc _mc_trim {fmt} {
 	set cmk [string first @@ $fmt]
 	if {$cmk > 0} {
-		set fmt [string range $fmt 0 [expr {$cmk - 1}]]
+		return [string range $fmt 0 [expr {$cmk - 1}]]
 	}
-	return [eval [list format $fmt] $args]
+	return $fmt
+}
+
+proc mc {en_fmt args} {
+	set fmt [_mc_trim [::msgcat::mc $en_fmt]]
+	if {[catch {set msg [eval [list format $fmt] $args]} err]} {
+		set msg [eval [list format [_mc_trim $en_fmt]] $args]
+	}
+	return $msg
 }
 
 proc strcat {args} {
-- 
1.5.3.4.1324.ga7925



-- 
Shawn.
