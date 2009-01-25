From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] Valgrind support: check for more than just programming
 errors
Date: Mon, 26 Jan 2009 00:20:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901260019160.14855@racer>
References: <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net> <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302>
 <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302> <20090121001219.GA18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210209580.19014@racer> <20090121190201.GA21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212137130.3586@pacific.mpi-cbg.de>
 <20090121215318.GA9107@sigill.intra.peff.net> <alpine.DEB.1.00.0901212332030.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901260014470.14855@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 00:21:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LREI1-0007Yh-LB
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbZAYXTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 18:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbZAYXTw
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 18:19:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:47796 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750879AbZAYXTw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 18:19:52 -0500
Received: (qmail invoked by alias); 25 Jan 2009 23:19:50 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp039) with SMTP; 26 Jan 2009 00:19:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX198Q/4G7Yh8T1TpXGTj3y1waevtR264T0OGbeo+kc
	gjhpFJ0nSKFi6B
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0901260014470.14855@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107124>


This patch makes --valgrind try to override _all_ Git binaries in the
PATH, and it will make calling *.sh and *.perl scripts directly an
error.

While it is not strictly necessary to look through the whole PATH to
find git binaries to override, it is in line with running an expensive
test (which valgrind is) to make extra sure that no binary is tested
that actually comes from the git.git checkout.

In the same spirit, we can test that neither our test suite nor our
scripts try to run the *.sh or *.perl scripts directly.

It's more like a "because we can" than a "this is tightly connected
to valgrind", but in the author's opinion "because we can" is "so we
should" in this case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	As I said, I vividly remember chasing a bug which turned out to be 
	a Git program that was installed, but no longer in git.git, yet 
	the test suite used it.

	This would catch it.

 t/test-lib.sh |   42 +++++++++++++++++++++++++++---------------
 1 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 67d7883..bdfb30f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -496,23 +496,35 @@ else
 	# override all git executables in TEST_DIRECTORY/..
 	GIT_VALGRIND=$TEST_DIRECTORY/valgrind
 	mkdir -p "$GIT_VALGRIND"/bin
-	ls $TEST_DIRECTORY/../git* 2> /dev/null |
-	while read symlink_target
+	OLDIFS=$IFS
+	IFS=:
+	for path in $PATH $TEST_DIRECTORY/..
 	do
-		# handle only executables
-		test -x "$symlink_target" || continue
-
-		base=$(basename "$symlink_target")
-		# do not override scripts
-		if test ! -d "$symlink_target" &&
-		    test "#!" != "$(head -c 2 < "$symlink_target")"
-		then
-			symlink_target=../valgrind.sh
-		fi
-		# create the link, or replace it if it is out of date
-		make_symlink "$symlink_target" \
-			"$GIT_VALGRIND/bin/$base" || exit
+		ls "$path"/git "$path"/git-* 2> /dev/null |
+		while read file
+		do
+			# handle only executables
+			test -x "$file" || continue
+
+			base=$(basename "$file")
+			symlink_target=$TEST_DIRECTORY/../$base
+			# do not override scripts
+			if test -x "$symlink_target" &&
+			    test ! -d "$symlink_target" &&
+			    test "#!" != "$(head -c 2 < "$symlink_target")"
+			then
+				symlink_target=../valgrind.sh
+			fi
+			case "$base" in
+			*.sh|*.perl)
+				symlink_target=../unprocessed-script
+			esac
+			# create the link, or replace it if it is out of date
+			make_symlink "$symlink_target" \
+				"$GIT_VALGRIND/bin/$base" || exit
+		done
 	done
+	IFS=$OLDIFS
 	PATH=$GIT_VALGRIND/bin:$PATH
 	GIT_EXEC_PATH=$GIT_VALGRIND/bin
 	export GIT_VALGRIND
-- 
1.6.1.482.g7d54be
