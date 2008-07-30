From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Look for gitk in $PATH, not $LIBEXEC/git-core
Date: Tue, 29 Jul 2008 22:42:57 -0700
Message-ID: <20080730054257.GG7225@spearce.org>
References: <80915B5E107BED488500050294C6F48712136B@ex2k.bankofamerica.com> <20080724132853.GA25313@toroid.org> <20080725220544.GD23202@spearce.org> <80915B5E107BED488500050294C6F48712137A@ex2k.bankofamerica.com> <20080729164856.GB1730@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Abhijit Menon-Sen <ams@toroid.org>, git@vger.kernel.org
To: "Murphy, John" <john.murphy@bankofamerica.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 07:44:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO4Te-0005oA-Nd
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 07:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbYG3Fm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 01:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbYG3Fm6
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 01:42:58 -0400
Received: from george.spearce.org ([209.20.77.23]:38467 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbYG3Fm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 01:42:58 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6F621383A4; Wed, 30 Jul 2008 05:42:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080729164856.GB1730@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90747>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> "Murphy, John" <john.murphy@bankofamerica.com> wrote:
> > I have rebuilt git-gui with version 0.10.2.18.gc629 it is still not finding gitk.
> > I have done some debugging in proc _which
> > I have found the issue is with the following line:
> > 
> > set p [file join $p $what$_search_exe]
> > 
> > The variable $p = gitk.exe
> > 
> > And there is no such animal
> > 
> > When I copy gitk to gitk.exe in /usr/local/git/bin, it works fine.
> 
> This is definately a git-gui bug.

And this should fix it.

--8<--
git-gui: Fix gitk search in $PATH to work on Windows

Back in 15430be5a1 ("Look for gitk in $PATH, not $LIBEXEC/git-core")
git-gui learned to use [_which gitk] to locate where gitk's script
is as Git 1.6 will install gitk to $prefix/bin (in $PATH) and all
of the other tools are in $gitexecdir.

This failed on Windows because _which adds the ".exe" suffix as it
searches for the program on $PATH, under the assumption that we can
only execute something from Tcl if it is a proper Windows executable.

When scanning for gitk on Windows we need to omit the ".exe" suffix.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-gui.sh |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index ce941ad..14b2d9a 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -317,7 +317,7 @@ proc _git_cmd {name} {
 	return $v
 }
 
-proc _which {what} {
+proc _which {what args} {
 	global env _search_exe _search_path
 
 	if {$_search_path eq {}} {
@@ -340,8 +340,14 @@ proc _which {what} {
 		}
 	}
 
+	if {[is_Windows] && [lsearch -exact $args -script] >= 0} {
+		set suffix {}
+	} else {
+		set suffix $_search_exe
+	}
+
 	foreach p $_search_path {
-		set p [file join $p $what$_search_exe]
+		set p [file join $p $what$suffix]
 		if {[file exists $p]} {
 			return [file normalize $p]
 		}
@@ -1686,7 +1692,7 @@ proc do_gitk {revs} {
 	# -- Always start gitk through whatever we were loaded with.  This
 	#    lets us bypass using shell process on Windows systems.
 	#
-	set exe [_which gitk]
+	set exe [_which gitk -script]
 	set cmd [list [info nameofexecutable] $exe]
 	if {$exe eq {}} {
 		error_popup [mc "Couldn't find gitk in PATH"]
-- 
1.6.0.rc1.166.gbbfa8


-- 
Shawn.
