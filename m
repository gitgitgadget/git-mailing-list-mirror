From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/8] Valgrind support: check for more than just programming
 errors
Date: Wed, 4 Feb 2009 00:26:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902040026080.9822@pacific.mpi-cbg.de>
References: <cover.1233702893u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 00:27:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUUfw-0007K0-E9
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 00:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbZBCXZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 18:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbZBCXZh
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 18:25:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:51387 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752273AbZBCXZh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 18:25:37 -0500
Received: (qmail invoked by alias); 03 Feb 2009 23:25:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp020) with SMTP; 04 Feb 2009 00:25:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199P58DWnR9X1A892EvZGnhskwxRNz9wKg57+p0yu
	8H9otLoJwG3p6x
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1233702893u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108269>

This patch makes --valgrind try to override _all_ Git binaries in the
PATH, and it makes it an error to call *.sh and *.perl scripts directly.

While it is not strictly necessary to look through the whole PATH to
find git binaries to override, it is in line with running an expensive
test (which valgrind is) to make extra sure that only binaries are
tested that actually come from the git.git checkout.

In the same spirit, we can test that neither our test suite nor our
scripts try to run the *.sh or *.perl scripts directly.

It's more like a "because we can" than a "this is tightly connected
to valgrind", but in the author's opinion "because we can" is "so we
should" in this case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index aa9f938..2567c74 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -531,6 +531,10 @@ else
 		then
 			symlink_target=../valgrind.sh
 		fi
+		case "$base" in
+		*.sh|*.perl)
+			symlink_target=../unprocessed-script
+		esac
 		# create the link, or replace it if it is out of date
 		make_symlink "$symlink_target" "$GIT_VALGRIND/bin/$base" || exit
 	}
@@ -542,6 +546,17 @@ else
 	do
 		make_valgrind_symlink $file
 	done
+	OLDIFS=$IFS
+	IFS=:
+	for path in $PATH
+	do
+		ls "$path"/git-* 2> /dev/null |
+		while read file
+		do
+			make_valgrind_symlink "$file"
+		done
+	done
+	IFS=$OLDIFS
 	PATH=$GIT_VALGRIND/bin:$PATH
 	GIT_EXEC_PATH=$GIT_VALGRIND/bin
 	export GIT_VALGRIND
-- 
1.6.1.2.582.g3fdd5
