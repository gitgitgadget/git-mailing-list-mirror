From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] valgrind: do not require valgrind 3.4.0 or newer
Date: Thu, 5 Feb 2009 19:34:27 +0100 (CET)
Message-ID: <b204f01577584835f1c0252c77ffbfab33442a79.1233858507u.git.johannes.schindelin@gmx.de>
References: <cover.1233858507u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: peff@peff.net
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 05 19:36:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV94z-0007sW-JM
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 19:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513AbZBESed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 13:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754104AbZBESed
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 13:34:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:54881 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753928AbZBESec (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 13:34:32 -0500
Received: (qmail invoked by alias); 05 Feb 2009 18:34:30 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp066) with SMTP; 05 Feb 2009 19:34:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/v5WZwDZvv5S7MEIXxKtPhfLzYKn4pzJyIQcXRSd
	C2sqo4ohQPCtAD
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1233858507u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108598>

Valgrind 3.4.0 is pretty new, and even if --track-origins is a nice
feature, it is not the end of the world if that is not available.  So
play nice and use that option only when only an older version of
valgrind is available.

In the same spirit, refrain from the use of '...' in suppression
files, which is also a feature only valgrind 3.4 and newer understand.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This patch is on top of my valgrind series.

	In related news, Mark Adler has prepared a patch for the zlib vs 
	valgrind issue which has a low impact on performance, yet keeps 
	valgrind happy.

	I fully expect this patch to hit the next zlib version.

	Note that with the current suppressions, there was only a 
	hard-to-fix issue with certain gcc compilers in conjunction with 
	-DUNALIGNED_OK -O3 flags when compiling zlib, so not many users 
	are affected anyway (ahem, except for all the Ubuntu users, ahem).

 t/valgrind/default.supp |    4 +++-
 t/valgrind/valgrind.sh  |    8 +++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/valgrind/default.supp b/t/valgrind/default.supp
index 5f341b8..9e013fa 100644
--- a/t/valgrind/default.supp
+++ b/t/valgrind/default.supp
@@ -38,6 +38,8 @@
 	writing-data-from-zlib-triggers-even-more-errors
 	Memcheck:Param
 	write(buf)
-	...
+	obj:/lib/ld-*.so
+	fun:write_in_full
+	fun:write_buffer
 	fun:write_loose_object
 }
diff --git a/t/valgrind/valgrind.sh b/t/valgrind/valgrind.sh
index dc92612..a77023a 100755
--- a/t/valgrind/valgrind.sh
+++ b/t/valgrind/valgrind.sh
@@ -2,11 +2,17 @@
 
 base=$(basename "$0")
 
+TRACK_ORIGINS=
+case "$(valgrind --version)" in
+valgrind-{3.[4-9],3.[1-3][0-9],[4-9],[1-3][0-9]}*)
+	TRACK_ORIGINS=--track-origins=yes
+esac
+
 exec valgrind -q --error-exitcode=126 \
 	--leak-check=no \
 	--suppressions="$GIT_VALGRIND/default.supp" \
 	--gen-suppressions=all \
-	--track-origins=yes \
+	$TRACK_ORIGINS \
 	--log-fd=4 \
 	--input-fd=4 \
 	$GIT_VALGRIND_OPTIONS \
-- 
1.6.1.1.598.g140d5
