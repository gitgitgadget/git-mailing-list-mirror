From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Problem with git-gui and relative directories
Date: Fri, 24 Aug 2007 23:18:35 -0400
Message-ID: <20070825031834.GW27913@spearce.org>
References: <868x81vynk.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 25 05:18:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOmAl-0008VX-9Y
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 05:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbXHYDSj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 23:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbXHYDSj
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 23:18:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51341 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbXHYDSi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 23:18:38 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IOmAK-00065L-U3; Fri, 24 Aug 2007 23:18:25 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 205E620FBAE; Fri, 24 Aug 2007 23:18:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <868x81vynk.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56618>

David Kastrup <dak@gnu.org> wrote:
> Doing something like
...
> errors out with
> 
> fatal: cannot stat path woozle/plop: No such file or directory
> 
> Obviously, git-gui is confused about relative paths here.

Yes, it is.  I'm committing this, to be included in 0.8.2:

-->8--
git-gui: Correct 'git gui blame' in a subdirectory

David Kastrup pointed out that the following sequence was not
working as we had intended:

  $ cd lib
  $ git gui blame console.tcl
  fatal: cannot stat path lib/console.tcl: No such file or directory

The problem here was we disabled the chdir to the root of the
working tree when we are running with a "bare allowed" feature
such as blame or browser, but we still kept the prefix we found via
`git rev-parse --show-prefix`.  This caused us to try and look for
the file "console.tcl" within the subdirectory but also include
the subdirectory's own path from the root of the working tree.
This is unlikely to succeed, unless the user just happened to have
a "lib/lib/console.tcl" file in the repository, in which case we
would produce the wrong result.

In the case of a bare repository we shouldn't get back a value from
`rev-parse --show-prefix`, so really $_prefix should only be set
to the non-empty string if we are in a working tree and we are in a
subdirectory of that working tree.  If this is true we really want
to always be at the top level of the working tree, as all paths are
accessed as though they were relative to the top of the working tree.
Converting $_prefix to a ../ sequence is a fairly simple approach
to moving up the requisite levels.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-gui.sh |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 743b7d4..fa30ccc 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -703,7 +703,15 @@ if {![file isdirectory $_gitdir]} {
 	error_popup "Git directory not found:\n\n$_gitdir"
 	exit 1
 }
-if {![is_enabled bare]} {
+if {$_prefix ne {}} {
+	regsub -all {[^/]+/} $_prefix ../ cdup
+	if {[catch {cd $cdup} err]} {
+		catch {wm withdraw .}
+		error_popup "Cannot move to top of working directory:\n\n$err"
+		exit 1
+	}
+	unset cdup
+} elseif {![is_enabled bare]} {
 	if {[lindex [file split $_gitdir] end] ne {.git}} {
 		catch {wm withdraw .}
 		error_popup "Cannot use funny .git directory:\n\n$_gitdir"
-- 
1.5.3.rc6.17.g1911

-- 
Shawn.
