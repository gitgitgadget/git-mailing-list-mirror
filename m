From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v2] bisect: teach "skip" to accept special arguments
 like "A..B"
Date: Mon, 24 Nov 2008 17:33:13 +0100
Message-ID: <20081124173313.90cff3a0.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Nov 24 17:32:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4eMh-0005Lt-A7
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 17:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbYKXQbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 11:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753158AbYKXQbb
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 11:31:31 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:54545 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713AbYKXQba (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 11:31:30 -0500
Received: from smtp4-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp4-g19.free.fr (Postfix) with ESMTP id EE5773EA115;
	Mon, 24 Nov 2008 17:31:28 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g19.free.fr (Postfix) with SMTP id 4B4D03EA0FA;
	Mon, 24 Nov 2008 17:31:28 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101614>

The current "git bisect skip" syntax is "git bisect skip [<rev>...]"
so it's already possible to skip a range of revisions using
something like:

$ git bisect skip $(git rev-list A..B)

where A and B are the bounds of the range we want to skip.

This patch teaches "git bisect skip" to accept:

$ git bisect skip A..B

as an abbreviation for the former command.

This is done by checking each argument to see if it contains two
dots one after the other ('..'), and by expanding it using
"git rev-list" if that is the case.

Note that this patch will not make "git bisect skip" accept all
that "git rev-list" accepts, as things like "^A B" for exemple
will not work. But things like "A B..C D E F.. ..G H...I" should
work as expected.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

	Change since last time: s/expend/expand/

	I am still not sure if this patch is worth it because
	this is a special case in many ways.

diff --git a/git-bisect.sh b/git-bisect.sh
index 0d0e278..6706bc1 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -191,6 +191,21 @@ check_expected_revs() {
 	done
 }
 
+bisect_skip() {
+        all=''
+	for arg in "$@"
+	do
+	    case "$arg" in
+            *..*)
+                revs=$(git rev-list "$arg") || die "Bad rev input: $arg" ;;
+            *)
+                revs="'$arg'" ;;
+	    esac
+            all="$all $revs"
+        done
+        bisect_state 'skip' $all
+}
+
 bisect_state() {
 	bisect_autostart
 	state=$1
@@ -630,8 +645,10 @@ case "$#" in
         git bisect -h ;;
     start)
         bisect_start "$@" ;;
-    bad|good|skip)
+    bad|good)
         bisect_state "$cmd" "$@" ;;
+    skip)
+        bisect_skip "$@" ;;
     next)
         # Not sure we want "next" at the UI level anymore.
         bisect_next "$@" ;;
-- 
1.6.0.4.617.g39d03
