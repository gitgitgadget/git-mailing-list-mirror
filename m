From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC/PATCH] git-repack: shortcut in case of just one pack, and no
 loose objects
Date: Sun, 25 Feb 2007 01:49:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702250144530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Feb 25 01:49:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HL7Zl-000552-Nu
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 01:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932869AbXBYAtO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Feb 2007 19:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933606AbXBYAtO
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 19:49:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:46737 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932869AbXBYAtN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Feb 2007 19:49:13 -0500
Received: (qmail invoked by alias); 25 Feb 2007 00:49:12 -0000
X-Provags-ID: V01U2FsdGVkX186dmQEh046Hpxds0pTjPXZeiXGo1rrNe9lj71kij
	0hcg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40527>


When there is at most one pack, and there are no loose objects,
the result should be one pack _and_ reuse of deltas is allowed,
there is no need to repack, really.

The code does not check for *.keep files; they are either sign of
an ongoing repack, or of packs which do not matter for repacking
purposes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I _think_ this is correct, but I might have missed something 
	obvious...

 git-repack.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index ddfa8b4..15094b3 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -25,6 +25,16 @@ do
 	shift
 done
 
+if test "z$all_into_one" = zt -a "z$no_reuse_delta" = z; then
+	# check if no loose objects are around, and only up to one pack
+	objdirs="$(ls "$GIT_DIR"/objects/?? 2>/dev/null)"
+	packs="$(cd "$GIT_DIR/objects/pack/"; ls *.pack 2>/dev/null)"
+	case "$objdirs,$packs" in
+	*.pack*.pack*) ;;
+	,*) echo "No need to repack" >&2; exit 0
+	esac
+fi
+
 # Later we will default repack.UseDeltaBaseOffset to true
 default_dbo=false
 
-- 
1.5.0.1.2390.g7757
