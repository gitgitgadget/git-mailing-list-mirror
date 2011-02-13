From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] git-gui: give more advice when detaching HEAD
Date: Sun, 13 Feb 2011 13:31:52 +0100
Message-ID: <20110213123151.GA31375@book.hvoigt.net>
References: <20110212070538.GA2459@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Pat Thoyts <patthoyts@googlemail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 13 13:32:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pob7f-0007qu-8E
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 13:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202Ab1BMMbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 07:31:55 -0500
Received: from darksea.de ([83.133.111.250]:40930 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754094Ab1BMMby (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 07:31:54 -0500
Received: (qmail 13799 invoked from network); 13 Feb 2011 13:31:52 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 13 Feb 2011 13:31:52 +0100
Content-Disposition: inline
In-Reply-To: <20110212070538.GA2459@sigill.intra.peff.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166662>

Hi,

On Sat, Feb 12, 2011 at 02:05:38AM -0500, Jeff King wrote:
>   1. Give some indication or warning during commit that you're in a
>      detached state. The CLI template says "You are not on any branch"
>      when editing the commit message, and mentions "detached HEAD" as
>      the branch in the post-commit summary. As far as I can tell,
>      git-gui says nothing at all.

How about something like this:

---8<----
From 8e2b61cd5e8d85f43ed6f00935a757f0dfa56b3b Mon Sep 17 00:00:00 2001
From: Heiko Voigt <hvoigt@hvoigt.net>
Date: Sun, 13 Feb 2011 13:25:04 +0100
Subject: [PATCH] git-gui: warn when trying to commit on a detached head

The commandline is already warning when checking out a detached head.
Since the only thing thats potentially dangerous is to create commits
on a detached head lets warn in case the user is about to do that.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
The wording of the warning might need some cleanup and documentation of
the configuration variable is still missing but if you like it I will
add it.

 git-gui/git-gui.sh     |    1 +
 git-gui/lib/commit.tcl |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index d3acf0d..5314a3f 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -831,6 +831,7 @@ set default_config(gui.fontdiff) [font configure font_diff]
 # TODO: this option should be added to the git-config documentation
 set default_config(gui.maxfilesdisplayed) 5000
 set default_config(gui.usettk) 1
+set default_config(gui.warndetachedcommit) 1
 set font_descs {
 	{fontui   font_ui   {mc "Main Font"}}
 	{fontdiff font_diff {mc "Diff/Console Font"}}
diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
index 7f459cd..9bef8ee 100644
--- a/git-gui/lib/commit.tcl
+++ b/git-gui/lib/commit.tcl
@@ -259,8 +259,22 @@ proc commit_prehook_wait {fd_ph curHEAD msg_p} {
 }
 
 proc commit_commitmsg {curHEAD msg_p} {
+	global is_detached repo_config
 	global pch_error
 
+	if {$is_detached && $repo_config(gui.warndetachedcommit)} {
+		set msg [mc "You are about to commit on a detached head.
+This is a potentially dangerous thing to do because
+if you switch to another branch you will loose your
+changes and it can be difficult to get them back.
+
+Do you really want to proceed?"]
+		if {[ask_popup $msg] ne yes} {
+			unlock_index
+			return
+		}
+	}
+
 	# -- Run the commit-msg hook.
 	#
 	set fd_ph [githook_read commit-msg $msg_p]
-- 
1.7.4.rc3.4.g155c4
