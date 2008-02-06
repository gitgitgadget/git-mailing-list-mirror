From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] gitk: properly deal with tag names containing / (slash)
Date: Wed, 6 Feb 2008 07:06:08 +0000
Message-ID: <20080206070608.6881.qmail@096465580ae94c.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 08:06:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMeMR-00057m-Po
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 08:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382AbYBFHFv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Feb 2008 02:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754972AbYBFHFv
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 02:05:51 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:44794 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755231AbYBFHFt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 02:05:49 -0500
Received: (qmail 6882 invoked by uid 1000); 6 Feb 2008 07:06:08 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72761>

When creating a tag through gitk, and the tag name includes a slash (or
slashes), gitk errors out in a popup window.  This patch makes gitk cre=
ate
the necessary subdirectory(s) to successfully create the tag, and also
catches an error if a directory with the tag name to be created already
exists.

The problem was reported by Fr=E9d=E9ric Bri=E8re through
 http://bugs.debian.org/464104

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 gitk-git/gitk |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 5560e4d..56a8792 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -6136,9 +6136,16 @@ proc domktag {} {
 	error_popup [mc "Tag \"%s\" already exists" $tag]
 	return
     }
+    set dir [gitdir]
+    set fname [file join $dir "refs/tags" $tag]
+    if {[file isdirectory $fname]} {
+	error_popup [mc "A directory with the name \"%s\" exists in \"refs/ta=
gs\"" $tag]
+	return
+    }
     if {[catch {
-	set dir [gitdir]
-	set fname [file join $dir "refs/tags" $tag]
+	if {[file dirname $tag] !=3D "."} {
+	    file mkdir [file dirname $fname]
+	}
 	set f [open $fname w]
 	puts $f $id
 	close $f
--=20
1.5.4
