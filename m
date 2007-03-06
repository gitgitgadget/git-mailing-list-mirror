From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] bundle: fix wrong check of read_header()'s return value &
 add tests
Date: Tue, 6 Mar 2007 22:57:07 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703062256200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Mar 06 22:57:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOhek-00069K-LL
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 22:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbXCFV5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 16:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbXCFV5K
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 16:57:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:42565 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030321AbXCFV5J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 16:57:09 -0500
Received: (qmail invoked by alias); 06 Mar 2007 21:57:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 06 Mar 2007 22:57:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/UucoRbpnUedTnHsXWQS5iYDDfzvCnxjHs87LvEu
	EqUrYp3sx69X7R
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41597>


If read_header() fails, it returns <0, not 0. Further, an open(/dev/null)
was not checked for errors.

Also, this adds two tests to make sure that the bundle file looks
correct, by checking if it has the header has the expected form, and that
the pack contains the right amount of objects.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-bundle.c |    4 +++-
 t/t5510-fetch.sh |   14 ++++++++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index d0c3617..3b3bc25 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -404,6 +404,8 @@ static int unbundle(struct bundle_header *header, int bundle_fd,
 	if (verify_bundle(header, 0))
 		return -1;
 	dev_null = open("/dev/null", O_WRONLY);
+	if (dev_null < 0)
+		return error("Could not open /dev/null");
 	pid = fork_with_pipe(argv_index_pack, &bundle_fd, &dev_null);
 	if (pid < 0)
 		return error("Could not spawn index-pack");
@@ -440,7 +442,7 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 
 	memset(&header, 0, sizeof(header));
 	if (strcmp(cmd, "create") &&
-			!(bundle_fd = read_header(bundle_file, &header)))
+			(bundle_fd = read_header(bundle_file, &header)) < 0)
 		return 1;
 
 	if (!strcmp(cmd, "verify")) {
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index fa76662..ce96b4b 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -90,6 +90,13 @@ test_expect_success 'create bundle 1' '
 	git bundle create bundle1 master^..master
 '
 
+test_expect_success 'header of bundle looks right' '
+	head -n 1 "$D"/bundle1 | grep "^#" &&
+	head -n 2 "$D"/bundle1 | grep "^-[0-9a-f]\{40\} " &&
+	head -n 3 "$D"/bundle1 | grep "^[0-9a-f]\{40\} " &&
+	head -n 4 "$D"/bundle1 | grep "^$"
+'
+
 test_expect_success 'create bundle 2' '
 	cd "$D" &&
 	git bundle create bundle2 master~2..master
@@ -101,6 +108,13 @@ test_expect_failure 'unbundle 1' '
 	git fetch "$D/bundle1" master:master
 '
 
+test_expect_success 'bundle 1 has only 3 files ' '
+	cd "$D" &&
+	sed "1,4d" < bundle1 > bundle.pack &&
+	git index-pack bundle.pack &&
+	test 4 = $(git verify-pack -v bundle.pack | wc -l)
+'
+
 test_expect_success 'unbundle 2' '
 	cd "$D/bundle" &&
 	git fetch ../bundle2 master:master &&
-- 
1.5.0.3.2559.g30d3b
