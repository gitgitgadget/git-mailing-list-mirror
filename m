From: Jeff King <peff@peff.net>
Subject: Re: Implementing branch attributes in git config
Date: Thu, 11 May 2006 05:51:58 -0400
Message-ID: <20060511095158.GA23620@coredump.intra.peff.net>
References: <BAYC1-PASMTP02C02EAC2F64AC00BB5801AEA90@CEZ.ICE> <BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE> <Pine.LNX.4.64.0605091543100.3718@g5.osdl.org> <BAYC1-PASMTP037EBB0237B35C5F92FB0BAEAE0@CEZ.ICE> <Pine.LNX.4.64.0605091854380.3718@g5.osdl.org> <46a038f90605100019q3b44b87kf49e456668f2e249@mail.gmail.com> <Pine.LNX.4.64.0605100823350.3718@g5.osdl.org> <46a038f90605101617x1aa9bd2du959ead77ebf61795@mail.gmail.com> <Pine.LNX.4.64.0605101629230.3718@g5.osdl.org> <Pine.LNX.4.64.0605101656110.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 11 11:52:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fe7q6-0004ju-NM
	for gcvg-git@gmane.org; Thu, 11 May 2006 11:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWEKJwB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 May 2006 05:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWEKJwA
	(ORCPT <rfc822;git-outgoing>); Thu, 11 May 2006 05:52:00 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:11457 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1030207AbWEKJwA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 May 2006 05:52:00 -0400
Received: (qmail 21471 invoked from network); 11 May 2006 09:51:58 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 11 May 2006 09:51:58 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2006 05:51:58 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605101656110.3718@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19903>

On Wed, May 10, 2006 at 05:11:17PM -0700, Linus Torvalds wrote:

> I also think we could do with a few scripts to just do setup of a remote 
> repo:
> 
> 	git remote clone <remoteaddress>
> 	git remote branch <remoteaddress> [-D]
> 	git remote fsck <remoteaddress>
> 	git remote repack <remoteaddress> -a -d

Here's a 'git remote' that handles the easy commands. It makes things
like 'git remote origin repack -a -d' do what you expect. The biggest
problems are:
  - it only works for ssh remotes
  - it assumes your remote path is a git dir (do we have a usual way of
    deciding between $path and $path/.git?)
  - ssh'ing will mangle your shell quoting in the command arguments
  - the url parsing is somewhat ad-hoc (do we have a usual way of
    parsing urls for shell scripts?)

---
Add braindead git-remote script.

This script is a convenience wrapper for performing remote commands on a
repository using ssh.

---

 Makefile      |    2 +-
 git-remote.sh |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletions(-)
 create mode 100644 git-remote.sh

8810ae2524d3339b8a8341b34b2d3f14ddb9c899
diff --git a/Makefile b/Makefile
index 37fbe78..58eddd8 100644
--- a/Makefile
+++ b/Makefile
@@ -125,7 +125,7 @@ SCRIPT_SH = \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh git-grep.sh \
-	git-lost-found.sh
+	git-lost-found.sh git-remote.sh
 
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
diff --git a/git-remote.sh b/git-remote.sh
new file mode 100644
index 0000000..04b1ce9
--- /dev/null
+++ b/git-remote.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+USAGE='<remote> <command> [options]'
+. git-sh-setup
+. git-parse-remote
+
+case "$#" in
+  0|1) usage ;;
+esac
+
+remote=`get_remote_url "$1"` shift;
+case "$remote" in
+  ssh://*|git+ssh://*|ssh+git://*)
+    host=`echo "$remote" | sed 's!^[^/]*://\([^/]*\).*!\1!'`
+    path=`echo "$remote" | sed 's!^[^/]*://[^/]*\(.*\)!\1!'`
+    exec ssh -n $host "GIT_DIR=$path git $@"
+    ;;
+  *) die "unhandled protocol: $remote" ;;
+esac
-- 
1.3.1
