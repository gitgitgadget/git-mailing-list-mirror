From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] valgrind: do not require valgrind 3.4.0 or newer
Date: Thu, 5 Feb 2009 22:03:00 +0100 (CET)
Message-ID: <349b2bb9b8f5a6762cccb7834d82125ee4382436.1233867737u.git.johannes.schindelin@gmx.de>
References: <7vzlh0bp6f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 05 22:05:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVBPC-0005DK-6f
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 22:05:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbZBEVDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 16:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753551AbZBEVDF
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 16:03:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:54934 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753547AbZBEVDD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 16:03:03 -0500
Received: (qmail invoked by alias); 05 Feb 2009 21:03:01 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp061) with SMTP; 05 Feb 2009 22:03:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+r2q5MaDurfgRDcFNnLDPJ1QG34yTN/7/N0HHpcm
	uvM919Yi8N648m
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vzlh0bp6f.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108622>

Valgrind 3.4.0 is pretty new, and even if --track-origins is a nice
feature, it is not the end of the world if that is not available.  So
play nice and use that option only when only an older version of
valgrind is available.

In the same spirit, refrain from the use of '...' in suppression
files, which is also a feature only valgrind 3.4 and newer understand.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/valgrind/default.supp |    4 +++-
 t/valgrind/valgrind.sh  |   11 ++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

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
index dc92612..582b4dc 100755
--- a/t/valgrind/valgrind.sh
+++ b/t/valgrind/valgrind.sh
@@ -2,11 +2,20 @@
 
 base=$(basename "$0")
 
+TRACK_ORIGINS=
+
+VALGRIND_VERSION=$(valgrind --version)
+VALGRIND_MAJOR=$(expr "$VALGRIND_VERSION" : '[^0-9]*\([0-9]*\)')
+VALGRIND_MINOR=$(expr "$VALGRIND_VERSION" : '[^0-9]*[0-9]*\.\([0-9]*\)')
+test 3 -gt "$VALGRIND_MAJOR" ||
+test 3 -eq "$VALGRIND_MAJOR" -a 4 -gt "$VALGRIND_MINOR" ||
+TRACK_ORIGINS=--track-origins=yes
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
1.6.1.1.636.gf819e
