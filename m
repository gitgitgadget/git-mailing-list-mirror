From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3 v2] Enable parallel tests
Date: Fri, 8 Aug 2008 13:08:37 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808081302180.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808080754230.9611@pacific.mpi-cbg.de.mpi-cbg.de> <489BF95F.1070000@lsrfire.ath.cx> <alpine.DEB.1.00.0808081236010.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2100350575-1218193717=:9611"
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Aug 08 13:05:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRPmP-0006mg-Ct
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 13:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412AbYHHLEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 07:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754311AbYHHLEG
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 07:04:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:36592 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754212AbYHHLEE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 07:04:04 -0400
Received: (qmail invoked by alias); 08 Aug 2008 11:04:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 08 Aug 2008 13:04:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/RzYw6X9/Q9zd3Snu0BlXGA65gB1itaq3ZQZ+pZ
	JJA3FAaFhSzQH6
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0808081236010.9611@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91655>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2100350575-1218193717=:9611
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT


On multiprocessor machines, or with I/O heavy tests (that leave the
CPU waiting a lot), it makes sense to parallelize the tests.

However, care has to be taken that the different jobs use different
trash directories.

This commit does so, by creating the trash directories with a suffix
that is unique with regard to the test, as it is the test's base name.

Further, the trash directory is removed in the test itself if
everything went fine, so that the trash directories do not
pile up only to be removed at the very end.

If a test failed, the trash directory is not removed.  Chances are
that the exact error message is lost in the clutter, but you can still
see what test failed from the name of the trash directory, and repeat
the test (without -j).

If all was good, you will see the aggregated results.

Suggestions to simplify this commit came from Junio and René.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	> On Fri, 8 Aug 2008, René Scharfe wrote:
	> 
	> > The implementation would be a bit simpler (no -j detection 
	> > needed) and the documentation would be simpler, too.

	Oh well, here it goes.

 t/Makefile    |    1 -
 t/test-lib.sh |    8 +++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index aa952e1..ed49c20 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -39,4 +39,3 @@ full-svn-test:
 	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=0 LC_ALL=en_US.UTF-8
 
 .PHONY: pre-clean $(T) aggregate-results clean
-.NOTPARALLEL:
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 11c0275..75c8a36 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -449,6 +449,11 @@ test_done () {
 		# we will leave things as they are.
 
 		say_color pass "passed all $msg"
+
+		test ! -z "$remove_trash" &&
+		cd "$(dirname "$remove_trash")" &&
+		rm -rf "$(basename "$remove_trash")"
+
 		exit 0 ;;
 
 	*)
@@ -485,7 +490,8 @@ fi
 . ../GIT-BUILD-OPTIONS
 
 # Test repository
-test="trash directory"
+test="trash directory.$(basename "$0" .sh)"
+remove_trash="$(pwd)/$test"
 rm -fr "$test" || {
 	trap - exit
 	echo >&5 "FATAL: Cannot prepare test area"
-- 
1.6.0.rc2.23.gd08e9

--8323329-2100350575-1218193717=:9611--
