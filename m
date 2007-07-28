From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] git-stash last-minute fixes
Date: Fri, 27 Jul 2007 23:59:45 -0700
Message-ID: <7vbqdxui72.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 09:00:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEgHR-00045P-3f
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 09:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756373AbXG1G7t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 28 Jul 2007 02:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756282AbXG1G7t
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 02:59:49 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:36987 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755071AbXG1G7s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jul 2007 02:59:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070728065948.PQSD1393.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Jul 2007 02:59:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Uuzn1X0051kojtg0000000; Sat, 28 Jul 2007 02:59:47 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53996>

Here are a small patch series to git-stash.

 [1/2] Fix git-stash apply --index

 This fixes two rather embarrasing bugs in "apply --index".

 [2/2] git-stash apply --index: optimize postprocessing

 This builds on top of the previous one to avoid unnecessary
 index manipulations that is later wiped by a read-tree.

There also is a bugfix I received privately from Nana for the
breakage I introduced with 7ab3cc70.  I've already queued it for
'master'.

-- >8 --

=46rom: =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93=
 <nanako3@bluebottle.com>
Date: Sat, 28 Jul 2007 10:44:48 +0900
Subject: [PATCH] git-stash: Make sure reflog is created for refs/stash

Earlier commit 7ab3cc70 fixed "stash clear" but broke save_stash,
because it forgot to make sure the reflog file exists before saving.

Signed-off-by: Nanako Shiraishi <nanako3@bluebottle.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/git-stash.sh b/git-stash.sh
index f90dffd..0073e9d 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -36,6 +36,9 @@ save_stash () {
 	test -f "$GIT_DIR/logs/$ref_stash" ||
 		clear_stash || die "Cannot initialize stash"
=20
+	# Make sure the reflog for stash is kept.
+	: >>"$GIT_DIR/logs/$ref_stash"
+
 	# state of the base commit
 	if b_commit=3D$(git rev-parse --verify HEAD)
 	then
