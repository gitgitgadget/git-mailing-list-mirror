From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-mv: succeed even if source is a prefix of destination
Date: Wed, 16 Aug 2006 02:20:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608160209150.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060815205150.GA467@c165.ib.student.liu.se>
 <Pine.LNX.4.63.0608151401510.3965@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 02:20:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD99C-0002I0-8G
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 02:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWHPAUf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 20:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWHPAUe
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 20:20:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:31365 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750724AbWHPAUe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Aug 2006 20:20:34 -0400
Received: (qmail invoked by alias); 16 Aug 2006 00:20:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 16 Aug 2006 02:20:32 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: David Rientjes <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608151401510.3965@chino.corp.google.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25494>


As noted by Fredrik Kuivinen, without this patch, git-mv fails on

	git-mv README README-renamed

because "README" is a prefix of "README-renamed".

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	On Tue, 15 Aug 2006, David Rientjes wrote:

	> On Tue, 15 Aug 2006, Fredrik Kuivinen wrote:
	> > With the current master I get the following:
	> > 
	> >     $ git-mv README README-renamed
	> >     fatal: can not move directory into itself, source=README, destination=README-renamed
	> > 
	> 
	> Please try the following patch.
	> 
	> -		if (!bad &&
	> -		    !strncmp(destination[i], source[i], strlen(source[i])))
	> +		if (!bad && !strcmp(destination[i], source[i]))

	This is not sufficient. It will not catch something like

		git-mv some/path some/path/and/some/more/


 builtin-mv.c  |    5 ++++-
 t/t7001-mv.sh |    4 ++++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index a731f8d..e7b5eb7 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -119,6 +119,7 @@ int cmd_mv(int argc, const char **argv, 
 
 	/* Checking */
 	for (i = 0; i < count; i++) {
+		int length;
 		const char *bad = NULL;
 
 		if (show_only)
@@ -204,7 +205,9 @@ int cmd_mv(int argc, const char **argv, 
 		}
 
 		if (!bad &&
-		    !strncmp(destination[i], source[i], strlen(source[i])))
+		    (length = strlen(source[i])) >= 0 &&
+		    !strncmp(destination[i], source[i], length) &&
+		    (destination[i][length] == 0 || destination[i][length] == '/'))
 			bad = "can not move directory into itself";
 
 		if (!bad && cache_name_pos(source[i], strlen(source[i])) < 0)
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 900ca93..e5e0bb9 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -60,6 +60,10 @@ test_expect_success \
      grep -E "^R100.+path0/README.+path2/README"'
 
 test_expect_success \
+    'succeed when source is a prefix of destination' \
+    'git-mv path2/COPYING path2/COPYING-renamed'
+
+test_expect_success \
     'moving whole subdirectory into subdirectory' \
     'git-mv path2 path1'
 
-- 
1.4.2.g2e3b
