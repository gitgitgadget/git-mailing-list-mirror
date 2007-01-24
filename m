From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 5/3] merge-one-file: make sure that leading directories exist
Date: Wed, 24 Jan 2007 12:27:20 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701241226360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Jan 24 12:29:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9gJY-0006Yt-Iv
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 12:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbXAXL1X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 06:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbXAXL1X
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 06:27:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:46074 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751287AbXAXL1V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 06:27:21 -0500
Received: (qmail invoked by alias); 24 Jan 2007 11:27:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 24 Jan 2007 12:27:20 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37628>


This ports half of the reasoning of v0.99~298 to the builtin version.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
	When trying to verify that checkout-index was there for the
	sole purpose of setting the modes correctly, I found (thanks
	to annotate!) that the leading directories were the
	motivation, not the modes.

 merge-file.c              |    8 ++++++++
 t/t6025-merge-one-file.sh |   10 ++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/merge-file.c b/merge-file.c
index ba54c96..b585b69 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -138,9 +138,17 @@ int remove_from_index(const char *path)
 int update_file(const char *path, void *buffer, unsigned long size,
 		int mode, int update_index)
 {
+	int ret;
+	char *p;
 	if (update_index && remove_from_index(path))
 		return -1;
 
+	p = xstrdup(path);
+	ret = safe_create_leading_directories(p);
+	free(p);
+	if (ret)
+		return error("Could not create leading path for %s", path);
+
 	if (S_ISLNK(mode)) {
 		char *target = buffer;
 		target[size] = '\0';
diff --git a/t/t6025-merge-one-file.sh b/t/t6025-merge-one-file.sh
index 6b79202..0b367af 100644
--- a/t/t6025-merge-one-file.sh
+++ b/t/t6025-merge-one-file.sh
@@ -59,6 +59,16 @@ test_expect_success "created identically" \
 
 test_expect_success "-> correct file" "test z$(cat two) = zone"
 
+git-update-index --index-info << EOF
+10644 $hash_one 2	a/sub/dir/two
+10644 $hash_one 3	a/sub/dir/two
+EOF
+
+test_expect_success "created identically, in subdir" \
+	"git-merge-one-file '' $hash_one $hash_one a/sub/dir/two '' 0644 0644"
+
+test_expect_success "-> correct file" "test z$(cat a/sub/dir/two) = zone"
+
 cat one three > thirteen
 hash_13=$(git-hash-object -t blob -w thirteen)
 
-- 
1.5.0.rc2.gee75e-dirty
