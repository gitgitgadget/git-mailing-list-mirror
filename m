From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] log: properly handle decorations with chained tags
Date: Tue, 17 Dec 2013 04:28:21 +0000
Message-ID: <1387254501-319329-1-git-send-email-sandals@crustytoothpaste.net>
References: <20131217004044.GB259467@vauxhall.crustytoothpaste.net>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 17 05:28:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsmGr-0003Dv-4p
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 05:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab3LQE2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 23:28:33 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:34813 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751765Ab3LQE2c (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Dec 2013 23:28:32 -0500
Received: from vauxhall.crustytoothpaste.net (vauxhall.local [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 58A02F;
	Tue, 17 Dec 2013 04:28:30 +0000 (UTC)
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <20131217004044.GB259467@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239374>

git log did not correctly handle decorations when a tag object referenced
another tag object that was no longer a ref, such as when the second tag was
deleted.  The commit would not be decorated correctly because parse_object had
not been called on the second tag and therefore its tagged field had not been
filled in, resulting in none of the tags being associated with the relevant
commit.

Call parse_object to fill in this field if it is absent so that the chain of
tags can be dereferenced and the commit can be properly decorated.  Include
tests as well to prevent future regressions.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 log-tree.c                    | 13 ++++++++++---
 t/t4205-log-pretty-formats.sh | 15 +++++++++++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 642faff..a6b60b7 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -131,9 +131,16 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 		refname = prettify_refname(refname);
 	add_name_decoration(type, refname, obj);
 	while (obj->type == OBJ_TAG) {
-		obj = ((struct tag *)obj)->tagged;
-		if (!obj)
-			break;
+		struct object *tagged = ((struct tag *)obj)->tagged;
+		if (!tagged) {
+			obj = parse_object(obj->sha1);
+			if (!obj)
+				break;
+			tagged = ((struct tag *)obj)->tagged;
+			if (!tagged)
+				break;
+		}
+		obj = tagged;
 		add_name_decoration(DECORATION_REF_TAG, refname, obj);
 	}
 	return 0;
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index fb00041..2a6278b 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -310,4 +310,19 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'log decoration properly follows tag chain' '
+	git tag -a tag1 -m tag1 &&
+	git tag -a tag2 -m tag2 tag1 &&
+	git tag -d tag1 &&
+	git commit --amend -m shorter &&
+	git log --no-walk --tags --pretty="%H %d" --decorate=full >actual &&
+	cat <<EOF >expected &&
+6a908c10688b2503073c39c9ba26322c73902bb5  (tag: refs/tags/tag2)
+9f716384d92283fb915a4eee5073f030638e05f9  (tag: refs/tags/message-one)
+b87e4cccdb77336ea79d89224737be7ea8e95367  (tag: refs/tags/message-two)
+EOF
+	sort actual >actual1 &&
+	test_cmp expected actual1
+'
+
 test_done
-- 
1.8.5.1
