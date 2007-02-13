From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-gc: run pack-refs by default unless the repo is bare
Date: Tue, 13 Feb 2007 14:01:42 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702131400280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7ium1k7s.fsf@assigned-by-dhcp.cox.net> <7vzm7iz8uv.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702131101400.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070213102951.GA14903@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Feb 13 14:01:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGxI4-0002N3-08
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 14:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbXBMNBo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 08:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbXBMNBo
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 08:01:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:42085 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751205AbXBMNBo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 08:01:44 -0500
Received: (qmail invoked by alias); 13 Feb 2007 13:01:42 -0000
X-Provags-ID: V01U2FsdGVkX19V1adrjf5VPcfYo9iA9sznHlx8nRQcSGv4Un0DIE
	Ytug==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070213102951.GA14903@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39521>


The config variable gc.packrefs is tristate now: "true", "false"
and "notbare", where "notbare" is the default.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	On Tue, 13 Feb 2007, Jeff King wrote:
	
	> I think a tri-state "yes/no/notbare" defaulting to "notbare" 
	> makes more sense.

	This is on top of Junio's patch.

 Documentation/config.txt |   13 +++++++------
 Documentation/git-gc.txt |    4 ++--
 git-gc.sh                |   14 +++++++++-----
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 36b2c4f..3865535 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -322,13 +322,14 @@ format.headers::
 	by mail.  See gitlink:git-format-patch[1].
 
 gc.packrefs::
-	`git gc` does not run `git pack-refs` by default
-	so that older dumb-transport clients can still fetch
+	`git gc` does not run `git pack-refs` in a bare repository by
+	default so that older dumb-transport clients can still fetch
 	from the repository.  Setting this to `true` lets `git
-	gc` to run `git pack-refs`.  Enable it only when you
-	know you do not have to support such clients.  The
-	default will change to run `git pack-refs` in some
-	future, and setting this to `false` will continue to
+	gc` to run `git pack-refs`.  Setting this to `false` tells
+	`git gc` never to run `git pack-refs`. The default setting is
+	`notbare`. Enable it only when you know you do not have to
+	support such clients.  The default setting will change to `true`
+	at some stage, and setting this to `false` will continue to
 	prevent `git pack-refs` from being run from `git gc`.
 
 gc.reflogexpire::
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index ca38c2e..910f12a 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -64,8 +64,8 @@ kept.  This defaults to 15 days.
 
 The optional configuration variable 'gc.packrefs' determines if
 `git gc` runs `git-pack-refs`.  Without the configuration, `git-pack-refs` 
-is not run by default to allow older dumb-transport clients
-fetch from the repository,  but this will change in the future.
+is not run in bare repositories by default, to allow older dumb-transport
+clients fetch from the repository,  but this will change in the future.
 
 See Also
 --------
diff --git a/git-gc.sh b/git-gc.sh
index 054f338..1a45de5 100755
--- a/git-gc.sh
+++ b/git-gc.sh
@@ -22,11 +22,15 @@ do
 	shift
 done
 
-if pack_refs=$(git config --bool --get gc.packrefs) &&
-   test "true" = "$pack_refs"
-then
-	git-pack-refs --prune
-fi &&
+case "$(git config --get gc.packrefs)" in
+notbare|"")
+	test $(is_bare_repository) = true || pack_refs=true;;
+*)
+	pack_refs=$(git config --bool --get gc.packrefs)
+esac
+
+test "true" != "$pack_refs" ||
+git-pack-refs --prune &&
 git-reflog expire --all &&
 git-repack -a -d -l &&
 $no_prune git-prune &&
-- 
1.5.0.rc4.2434.g472e7
