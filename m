From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Teach cvsexportcommit to add new files
Date: Fri, 6 Jan 2006 21:54:41 +0100
Message-ID: <20060106205441.GA32585@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jan 06 21:52:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuyZP-0002OX-QX
	for gcvg-git@gmane.org; Fri, 06 Jan 2006 21:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbWAFUwQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 15:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752561AbWAFUwP
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 15:52:15 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:51434 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1752560AbWAFUwP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jan 2006 15:52:15 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id F0A8D44032
	for <git@vger.kernel.org>; Fri,  6 Jan 2006 21:52:08 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1Euybh-0008Vy-Qw
	for git@vger.kernel.org; Fri, 06 Jan 2006 21:54:41 +0100
To: GIT list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14213>

Teach cvsexportcommit to add new files
"cvs add" support was already there, but the "unknown" status
returned when querying a file not yet known to cvs caused the
script to abort prematurely.

---
commit 7e1b8a9af653c9a4f8d2a6a4b34ccf56a2f48526
tree f94f057ec672b715ffda28e359bd5d672fdfb6b3
parent 58e3fb40f7ca1c28f9105c15166884f80bb22e55
author Yann Dirson <ydirson@altern.org> Fri, 06 Jan 2006 21:31:21 +0100
committer Yann Dirson <dwitch@gandelf.nowhere.earth> Fri, 06 Jan 2006 21:31:21 +0100

 git-cvsexportcommit.perl |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 5a8c011..d5fbee7 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -103,8 +103,16 @@ undef @files; # don't need it anymore
 
 # check that the files are clean and up to date according to cvs
 my $dirty;
-foreach my $f (@afiles, @mfiles, @dfiles) {
-    # TODO:we need to handle removed in cvs and/or new (from git) 
+foreach my $f (@afiles) {
+    my $status = `cvs -q status "$f" | grep '^File: '`;
+
+    unless ($status =~ m/Status: Unknown$/) {
+	$dirty = 1;
+	warn "File $f is already known in your CVS checkout!\n";
+    }
+}
+foreach my $f (@mfiles, @dfiles) {
+    # TODO:we need to handle removed in cvs
     my $status = `cvs -q status "$f" | grep '^File: '`;
 
     unless ($status =~ m/Status: Up-to-date$/) {

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
