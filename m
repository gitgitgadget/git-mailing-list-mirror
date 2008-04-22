From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH] gitattributes: Fix subdirectory attributes specified from root directory
Date: Tue, 22 Apr 2008 12:19:12 -0600
Message-ID: <1208888352-7519-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 20:20:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoN64-0005V6-JJ
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 20:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899AbYDVSTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 14:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbYDVSTR
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 14:19:17 -0400
Received: from qmta04.emeryville.ca.mail.comcast.net ([76.96.30.40]:54965 "EHLO
	QMTA04.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755899AbYDVSTQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Apr 2008 14:19:16 -0400
Received: from OMTA11.emeryville.ca.mail.comcast.net ([76.96.30.36])
	by QMTA04.emeryville.ca.mail.comcast.net with comcast
	id Ghox1Z0020mlR8UA402l00; Tue, 22 Apr 2008 18:17:35 +0000
Received: from fast.fake.domain.org ([75.70.160.185])
	by OMTA11.emeryville.ca.mail.comcast.net with comcast
	id GiK21Z00240J0Bv8X00000; Tue, 22 Apr 2008 18:19:03 +0000
X-Authority-Analysis: v=1.0 c=1 a=uPQqhlI9bmoA:10 a=69n_jvr-rVoA:10
 a=Lkl8DkVUIC6kuO6bM3IA:9 a=7nwYR9BrVYNI9AZJPtOKNMqGDckA:4 a=3cjVDzgxsZYA:10
 a=JcB9aHnUDh0A:10
Received: from localhost.localdomain(really [127.0.0.1]) by fast.fake.domain.org
	via sendmail with esmtp
	id <m1JoN5D-000twPC@fast.fake.domain.org>
	for <mmogilvi_git@miniinfo.net>; Tue, 22 Apr 2008 12:19:11 -0600 (MDT)
	(Smail-3.2 1996-Jul-4 #13 built 1998-Aug-8)
X-Mailer: git-send-email 1.5.5.1.57.g5909c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80154>

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---

I've been working on adding crlf attribute support for git-cvsserver, and
noticed this little issue.  I've included some tests and a fix.
The cvsserver stuff is still incomplete and not included.

There are a couple of things I'm not sure about, but seem to make
the most sense the way I coded it:

1. A test of the form "attr_check /a/i a/i" (notice the prefixed '/'
in the pathname) will "pass" without this patch, but will not
"pass" with this patch.  This seems slightly more correct, but
I'm not sure.

2. The first (non-setup) test in t0003-attributes.sh actually
batches up several checks as one test.  I figured there should be
some limit on how many individual checks get batched into one,
so I started a second test, but I could see an argument to just
include the new checks in the existing batch.

 attr.c                |    4 +++-
 t/t0003-attributes.sh |    8 ++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/attr.c b/attr.c
index 64b77b1..1a15fad 100644
--- a/attr.c
+++ b/attr.c
@@ -546,7 +546,9 @@ static int path_matches(const char *pathname, int pathlen,
 	    (baselen && pathname[baselen] != '/') ||
 	    strncmp(pathname, base, baselen))
 		return 0;
-	return fnmatch(pattern, pathname + baselen + 1, FNM_PATHNAME) == 0;
+	if (baselen != 0)
+		baselen++;
+	return fnmatch(pattern, pathname + baselen, FNM_PATHNAME) == 0;
 }
 
 static int fill_one(const char *what, struct match_attr *a, int rem)
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 3faf135..c56d2fb 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -21,6 +21,7 @@ test_expect_success 'setup' '
 	mkdir -p a/b/d a/c &&
 	(
 		echo "f	test=f"
+		echo "a/i test=a/i"
 	) >.gitattributes &&
 	(
 		echo "g test=a/g" &&
@@ -46,4 +47,11 @@ test_expect_success 'attribute test' '
 
 '
 
+test_expect_success 'root subdir attribute test' '
+
+	attr_check a/i a/i &&
+	attr_check subdir/a/i unspecified
+
+'
+
 test_done
-- 
1.5.5.1.57.g5909c
