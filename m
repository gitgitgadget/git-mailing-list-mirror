From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 2/2 resend] git-gui: use `git --html-path` to get the location of installed HTML docs
Date: Sun, 5 Apr 2009 03:48:21 +0200
Message-ID: <200904050348.22103.markus.heidelberg@web.de>
References: <200904050333.46453.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 03:50:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqHUm-0005Fj-SM
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 03:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755626AbZDEBsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 21:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755341AbZDEBsX
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 21:48:23 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:57629 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787AbZDEBsW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 21:48:22 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 05B9DFC7EEE7;
	Sun,  5 Apr 2009 03:48:20 +0200 (CEST)
Received: from [89.59.94.8] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LqHT9-0000sS-00; Sun, 05 Apr 2009 03:48:19 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200904050333.46453.markus.heidelberg@web.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18weZI6V5RUXQSFAfcfppN0b0ASa8b5Yc2elhz7
	6jGQs+U0k5dBE649c/9Q2pBCSX0mJqRs+hOGue0k0z3HhT+ihZ
	WqbNmGXjL2OQBCnnUFpg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115618>

Previously a hardcoded path $GIT_EXEC_PATH/../Documentation/ was used to
search for the documentation, when the user has asked for it via menu
"Help -> Online Documentation".
This didn't work for the default directory structure.

To find the path reliably, use the new git command line option, which
returns the correct path.

If the output of `git --html-path` is empty because git is not found or
the option is not yet supported in the installed git, the documentation
from kernel.org is launched. There is no additional guessing of the
right location of the installed docs.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

Resend since the other mail didn't reach the list. This problem happens
far too often to me.

 git-gui.sh |   33 +++++++++++++++++++++++++++++----
 1 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index b3aa732..259251b 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -122,6 +122,7 @@ unset oguimsg
 set _appname {Git Gui}
 set _gitdir {}
 set _gitexec {}
+set _githtmldir {}
 set _reponame {}
 set _iscygwin {}
 set _search_path {}
@@ -168,6 +169,28 @@ proc gitexec {args} {
 	return [eval [list file join $_gitexec] $args]
 }
 
+proc githtmldir {args} {
+	global _githtmldir
+	if {$_githtmldir eq {}} {
+		if {[catch {set _githtmldir [git --html-path]}]} {
+			# Git not installed or option not yet supported
+			return {}
+		}
+		if {[is_Cygwin]} {
+			set _githtmldir [exec cygpath \
+				--windows \
+				--absolute \
+				$_githtmldir]
+		} else {
+			set _githtmldir [file normalize $_githtmldir]
+		}
+	}
+	if {$args eq {}} {
+		return $_githtmldir
+	}
+	return [eval [list file join $_githtmldir] $args]
+}
+
 proc reponame {} {
 	return $::_reponame
 }
@@ -2591,11 +2614,13 @@ if {![is_MacOSX]} {
 }
 
 
-set doc_path [file dirname [gitexec]]
-set doc_path [file join $doc_path Documentation index.html]
+set doc_path [githtmldir]
+if {$doc_path ne {}} {
+	set doc_path [file join $doc_path index.html]
 
-if {[is_Cygwin]} {
-	set doc_path [exec cygpath --mixed $doc_path]
+	if {[is_Cygwin]} {
+		set doc_path [exec cygpath --mixed $doc_path]
+	}
 }
 
 if {[file isfile $doc_path]} {
-- 
1.6.2.2.405.ge9fc3
