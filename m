From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 1/5] git rev-list: fix invalid typecast
Date: Mon, 13 Feb 2012 21:17:11 +0100
Message-ID: <1329164235-29955-2-git-send-email-drizzd@aon.at>
References: <7vhazobto3.fsf@alter.siamese.dyndns.org>
 <1329164235-29955-1-git-send-email-drizzd@aon.at>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 21:26:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx2Th-0002oB-1D
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 21:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758022Ab2BMUZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 15:25:45 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:36745 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757992Ab2BMUZl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 15:25:41 -0500
Received: from localhost (p5B22E0DA.dip.t-dialin.net [91.34.224.218])
	by bsmtp.bon.at (Postfix) with ESMTP id 5708B2C4006;
	Mon, 13 Feb 2012 21:26:59 +0100 (CET)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1329164235-29955-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190660>

git rev-list passes rev_list_info, not rev_list objects. Without this
fix, rev-list enables or disables the --verify-objects option depending
on a read from an undefined memory location.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 builtin/rev-list.c |    4 ++--
 t/t1450-fsck.sh    |   26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ab3be7c..264e3ae 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -180,10 +180,10 @@ static void show_object(struct object *obj,
 			const struct name_path *path, const char *component,
 			void *cb_data)
 {
-	struct rev_info *info = cb_data;
+	struct rev_list_info *info = cb_data;
 
 	finish_object(obj, path, component, cb_data);
-	if (info->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
+	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
 		parse_object(obj->sha1);
 	show_object_with_name(stdout, obj, path, component);
 }
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 523ce9c..5b8ebd8 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -191,4 +191,30 @@ test_expect_success 'cleaned up' '
 	test_cmp empty actual
 '
 
+test_expect_success 'rev-list --verify-objects' '
+	git rev-list --verify-objects --all >/dev/null 2>out &&
+	test_cmp empty out
+'
+
+test_expect_success 'rev-list --verify-objects with bad sha1' '
+	sha=$(echo blob | git hash-object -w --stdin) &&
+	old=$(echo $sha | sed "s+^..+&/+") &&
+	new=$(dirname $old)/ffffffffffffffffffffffffffffffffffffff &&
+	sha="$(dirname $new)$(basename $new)" &&
+	mv .git/objects/$old .git/objects/$new &&
+	test_when_finished "remove_object $sha" &&
+	git update-index --add --cacheinfo 100644 $sha foo &&
+	test_when_finished "git read-tree -u --reset HEAD" &&
+	tree=$(git write-tree) &&
+	test_when_finished "remove_object $tree" &&
+	cmt=$(echo bogus | git commit-tree $tree) &&
+	test_when_finished "remove_object $cmt" &&
+	git update-ref refs/heads/bogus $cmt &&
+	test_when_finished "git update-ref -d refs/heads/bogus" &&
+
+	test_might_fail git rev-list --verify-objects refs/heads/bogus >/dev/null 2>out &&
+	cat out &&
+	grep -q "error: sha1 mismatch 63ffffffffffffffffffffffffffffffffffffff" out
+'
+
 test_done
-- 
1.7.9
