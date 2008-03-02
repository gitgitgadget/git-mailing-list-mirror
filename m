From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix make_absolute_path() for parameters without a slash
Date: Sun, 2 Mar 2008 07:40:33 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803020739530.22527@racer.site>
References: <alpine.LSU.1.00.0803020717060.22527@racer.site> <alpine.LSU.1.00.0803020730170.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Mar 02 08:41:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVipV-0002dd-UM
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 08:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbYCBHlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 02:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbYCBHlR
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 02:41:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:40811 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752068AbYCBHlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 02:41:16 -0500
Received: (qmail invoked by alias); 02 Mar 2008 07:41:14 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp007) with SMTP; 02 Mar 2008 08:41:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/yCYIrQfTyAbNa29cUWTcWVw0LOkBdNvXn3f/oq7
	klpO+k+qTBTxtu
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0803020730170.22527@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75741>


When passing "xyz" to make_absolute_path(), make_absolute_path()
erroneously tried to chdir("xyz"), and then append "/xyz".  Instead,
skip the chdir() completely when no slash was found.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

On Sun, 2 Mar 2008, Johannes Schindelin wrote:

> Will stop posting patches for today, and fix tomorrow.

It was just too embarassing.

 path.c           |    4 +++-
 t/t0000-basic.sh |    2 ++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/path.c b/path.c
index 4260952..af27161 100644
--- a/path.c
+++ b/path.c
@@ -311,8 +311,10 @@ const char *make_absolute_path(const char *path)
 			if (last_slash) {
 				*last_slash = '\0';
 				last_elem = xstrdup(last_slash + 1);
-			} else
+			} else {
 				last_elem = xstrdup(buf);
+				*buf = '\0';
+			}
 		}
 
 		if (*buf) {
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 92de088..27b54cb 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -304,6 +304,8 @@ test_expect_success 'absolute path works as expected' '
 	test "$dir" = "$(test-absolute-path $dir2)" &&
 	file="$dir"/index &&
 	test "$file" = "$(test-absolute-path $dir2/index)" &&
+	basename=blub &&
+	test "$dir/$basename" = $(cd .git && test-absolute-path $basename) &&
 	ln -s ../first/file .git/syml &&
 	sym="$(cd first; pwd -P)"/file &&
 	test "$sym" = "$(test-absolute-path $dir2/syml)"
-- 
1.5.4.3.446.gbe8932

