From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI FIX)] git-gui: Fix handling of relative paths in blame.
Date: Sat, 6 Dec 2008 20:21:54 +0300
Organization: HOME
Message-ID: <200812062021.55061.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 06 18:24:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L90tK-0006iM-BO
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 18:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbYLFRXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 12:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbYLFRXM
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 12:23:12 -0500
Received: from mu-out-0910.google.com ([209.85.134.184]:54438 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbYLFRXK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 12:23:10 -0500
Received: by mu-out-0910.google.com with SMTP id g7so436248muf.1
        for <git@vger.kernel.org>; Sat, 06 Dec 2008 09:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4kvzR3PwtcYbM+4Ecp24vG/DKhCv6T458LSqQWkpNZ8=;
        b=PzL1dpzy9WyAVLM2EGQAuBw1Eg8MdPQUKmv05H7Hl9jZ0AL+eo0r3jux//aHFH8fOG
         ROW05OI9rZPz/Z5TPjCkGAELg3/M9DxK+tZh+HnJcHuL7tcPxFmObF+2+xgqB9SEI9in
         zZHdu+V7lO3Ugo5JwrtCqNTFHq+394bmqoMuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=d1JSSO7e+LR0z07lWvGRVlOr4/YJWmjknftsIxqJq5iDzjgCD6lxFd7fjCvSLOlwKs
         gBPFh447exvlttzeta4XJxXJgrfPSsD948YtZqlUNQ+ycaHusdMlSC/mGB4f8omTAjhe
         k1J/IhvTVj7dTSEX3V7LMnOUJ0uauhajRg0Ag=
Received: by 10.181.145.7 with SMTP id x7mr483294bkn.177.1228584187674;
        Sat, 06 Dec 2008 09:23:07 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id p17sm2126179fka.16.2008.12.06.09.23.06
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Dec 2008 09:23:07 -0800 (PST)
User-Agent: KMail/1.10.3 (Linux/2.6.27.5-123.fc10.i686; KDE/4.1.3; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102464>

Currently using '..' or '.' in the file path for gui blame
causes it to break, because the path is passed inside the 
SHA:PATH spec to cat-file, which apparently does not understand
such items. As a result, cat-file returns nothing, and the
viewer crashes because of an "index out of range" error.

This commit adds a simple function that normalizes such paths.
I choose not to use [file normalize], because it uses some data
from the file system, e.g. dereferences symlinks, and creates
an absolute path, while blame may be used to inspect historical
information that bears no relation to the current filesystem state.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	On Saturday 06 December 2008 13:56:45 Paul Mackerras wrote:
	> I have checked in a fix into my gitk.git repository at
	> git://git.kernel.org/pub/scm/gitk/gitk.git.  However, there seems to
	> be a bug in git gui blame; it gives a "list index out of range" error
	> sometimes.
	> 
	> Shawn, to see an example of the error, get a current kernel tree and
	> do:
	> 
	> $ cd arch/powerpc
	> $ git gui blame --line=1183 2c5e76158fcea6e3b9536a74efa7b5e2e846d374 \
	>   ../../net/sunrpc/svcsock.c

 git-gui.sh |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 8a4b42d..65dacf9 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2630,6 +2630,20 @@ proc usage {} {
 	exit 1
 }
 
+proc normalize_relpath {path} {
+	set elements {}
+	foreach item [file split $path] {
+		if {$item eq {.}} continue
+		if {$item eq {..} && [llength $elements] > 0
+		    && [lindex $elements end] ne {..}} {
+			set elements [lrange $elements 0 end-1]
+			continue
+		}
+		lappend elements $item
+	}
+	return [eval file join $elements]
+}
+
 # -- Not a normal commit type invocation?  Do that instead!
 #
 switch -- $subcommand {
@@ -2648,7 +2662,7 @@ blame {
 	foreach a $argv {
 		if {$is_path || [file exists $_prefix$a]} {
 			if {$path ne {}} usage
-			set path $_prefix$a
+			set path [normalize_relpath $_prefix$a]
 			break
 		} elseif {$a eq {--}} {
 			if {$path ne {}} {
@@ -2671,7 +2685,7 @@ blame {
 	unset is_path
 
 	if {$head ne {} && $path eq {}} {
-		set path $_prefix$head
+		set path [normalize_relpath $_prefix$head]
 		set head {}
 	}
 
-- 
1.6.0.4.30.gf4240
