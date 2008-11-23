From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH] bisect: teach "skip" to accept special arguments like
 "A..B"
Date: Sun, 23 Nov 2008 22:02:49 +0100
Message-ID: <20081123220249.2e7f30a5.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 23 22:02:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4M6X-0000Yd-Nm
	for gcvg-git-2@gmane.org; Sun, 23 Nov 2008 22:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbYKWVBG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Nov 2008 16:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbYKWVBF
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 16:01:05 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:42748 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736AbYKWVBE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Nov 2008 16:01:04 -0500
Received: from smtp4-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 59A9B3EA0DD;
	Sun, 23 Nov 2008 22:01:02 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g19.free.fr (Postfix) with SMTP id C95E73EA141;
	Sun, 23 Nov 2008 22:01:01 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101578>

The current "git bisect skip" syntax is "git bisect skip [<rev>...]"
so it's already possible to skip a range of revisions using
something like:

$ git bisect skip $(git rev-list A..B)

where A and B are the bounds of the range we want to skip.

This patch teaches "git bisect skip" to accept:

$ git bisect skip A..B

as an abbreviation for the former command.

This is done by checking each argument to see if it contains two
dots one after the other ('..'), and by expending it using
"git rev-list" if that is the case.

Note that this patch will not make "git bisect skip" accept all
that "git rev-list" accepts, as things like "^A B" for exemple
will not work. But things like "A B..C D E F.. ..G H...I" should
work as expected.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

	Dscho wrote:
	> Would it not be more intuitive to have support for
	>
=A0=A0=A0=A0=A0=A0=A0=A0> git bisect skip A..B
	>
	> ?

	Here is a patch to do that. I am not sure it's worth it
	because this is a special case in many ways.

diff --git a/git-bisect.sh b/git-bisect.sh
index 0d0e278..6706bc1 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -191,6 +191,21 @@ check_expected_revs() {
 	done
 }
=20
+bisect_skip() {
+        all=3D''
+	for arg in "$@"
+	do
+	    case "$arg" in
+            *..*)
+                revs=3D$(git rev-list "$arg") || die "Bad rev input: $=
arg" ;;
+            *)
+                revs=3D"'$arg'" ;;
+	    esac
+            all=3D"$all $revs"
+        done
+        bisect_state 'skip' $all
+}
+
 bisect_state() {
 	bisect_autostart
 	state=3D$1
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
--=20
1.6.0.4.768.g22eb.dirty
