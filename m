From: marcnarc@xiplink.com
Subject: [PATCH 3/3] fetch: Use the remote's ref name to decide how to describe new refs.
Date: Mon, 16 Apr 2012 18:08:50 -0400
Message-ID: <1334614130-31826-4-git-send-email-marcnarc@xiplink.com>
References: <1334591542-25136-1-git-send-email-marcnarc@xiplink.com>
 <1334614130-31826-1-git-send-email-marcnarc@xiplink.com>
Cc: Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 00:08:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJu6L-0006Tr-Hi
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 00:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443Ab2DPWIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 18:08:36 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:35855 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754741Ab2DPWI3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 18:08:29 -0400
Received: from xiplink.com (rincewind.xiplink.com [192.168.1.166])
	by farnsworth.xiplink.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id q3GM8QLR000947;
	Mon, 16 Apr 2012 18:08:27 -0400
X-Mailer: git-send-email 1.7.10.2.ge89da.dirty
In-Reply-To: <1334614130-31826-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195709>

From: Marc Branchaud <marcnarc@xiplink.com>

Also, only call a new ref a "branch" if it's under refs/heads/.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 builtin/fetch.c  |   14 ++++++++++++--
 t/t5510-fetch.sh |   28 ++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6c19975..3ede8fd 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -294,14 +294,24 @@ static int update_local_ref(struct ref *ref,
 		const char *msg;
 		const char *what;
 		int r;
-		if (!strncmp(ref->name, "refs/tags/", 10)) {
+		/*
+		 * Nicely describe the new ref we're fetching.
+		 * Base this on the remote's ref name, as it's
+		 * more likely to follow a standard layout.
+		 */
+		const char *name = remote_ref ? remote_ref->name : "";
+		if (!prefixcmp(name, "refs/tags/")) {
 			msg = "storing tag";
 			what = _("[new tag]");
 		}
-		else {
+		else if (!prefixcmp(name, "refs/heads/")) {
 			msg = "storing head";
 			what = _("[new branch]");
 		}
+		else {
+			msg = "storing ref";
+			what = _("[new ref]");
+		}
 
 		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
 		    (recurse_submodules != RECURSE_SUBMODULES_ON))
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 308c02e..d17a2cd 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -162,6 +162,34 @@ test_expect_success 'fetch following tags' '
 
 '
 
+test_expect_success 'fetch uses remote ref names to describe new refs' '
+	cd "$D" &&
+	mkdir descriptive &&
+	(
+		cd descriptive &&
+		git init &&
+		git config remote.o.url .. &&
+		git config remote.o.fetch "refs/heads/*:refs/crazyheads/*" &&
+		git config --add remote.o.fetch "refs/others/*:refs/heads/*" &&
+		git fetch o
+	) &&
+	git tag -a -m "Descriptive tag" descriptive-tag &&
+	git branch descriptive-branch &&
+	git checkout descriptive-branch &&
+	echo "Nuts" >> crazy &&
+	git add crazy &&
+	git commit -a -m "descriptive commit" &&
+	git update-ref refs/others/crazy HEAD &&
+	(
+		cd descriptive &&
+		git fetch o 2> actual
+		grep descriptive-branch actual | grep "[new branch]" &&
+		grep descriptive-tag actual | grep "[new tag]" &&
+		grep others/crazy actual | grep "[new ref]"
+	) &&
+	git checkout master
+'
+
 test_expect_success 'fetch must not resolve short tag name' '
 
 	cd "$D" &&
-- 
1.7.10.2.ge89da.dirty
