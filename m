From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v6 6/8] push: require force for annotated tags
Date: Thu, 29 Nov 2012 19:41:38 -0600
Message-ID: <1354239700-3325-7-git-send-email-chris@rorvick.com>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
Cc: Chris Rorvick <chris@rorvick.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 30 02:44:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeFdu-0007Rx-HU
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 02:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513Ab2K3Bnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 20:43:33 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:41967 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755468Ab2K3BnW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 20:43:22 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so11433874iay.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 17:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=yUg4PzOntk5aJL0gitL9G0e4BDQl/i860mH33YH9oCA=;
        b=ZZYsZ9CEV6k3AxtRUAU2enZekIHQ0ZSdpaGWRdSTuTJTFTNuW/4WfhQAQmp+lLk8Oj
         9KsDnDAn6D4l7KjqXY0eCtmQo71i5hZfNmNvJ0eGZsMPo7C/c+sBU+ivUZNlhk/QNhVL
         afDp3hRCsErya1zmH26Gr4XqZDel+QcseYqsfPuwAwKi+7YYhpx8+HNnYudJ6ozYmreu
         7tklN6aWWQztOOutiFtiKoKIlglAlZKeEibe4Fk2D9Cupnh7XXxxGpkiFO1F9XBR+h3X
         VXhi5x8y0tRC8UBNgZsd7+6PvHSShxdvC9eCjMv+8HSh+9w7sbYidqRbPEq3PJBmKjwB
         BZJg==
Received: by 10.50.187.197 with SMTP id fu5mr24585208igc.70.1354239802153;
        Thu, 29 Nov 2012 17:43:22 -0800 (PST)
Received: from marlin.localdomain ([70.131.98.170])
        by mx.google.com with ESMTPS id c3sm8955228igj.1.2012.11.29.17.43.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Nov 2012 17:43:21 -0800 (PST)
X-Mailer: git-send-email 1.8.0.158.g0c4328c
In-Reply-To: <1354239700-3325-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210892>

Do not allow fast-forwarding of references that point to a tag object.
Updating from a tag is potentially destructive since it would likely
leave the tag dangling.  Disallowing updates to a tag also makes sense
semantically and is consistent with the behavior of lightweight tags.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 Documentation/git-push.txt | 10 +++++-----
 remote.c                   | 11 +++++++++--
 t/t5516-fetch-push.sh      | 21 +++++++++++++++++++++
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 09bdec7..7a04ce5 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -52,11 +52,11 @@ updated.
 +
 The object referenced by <src> is used to update the <dst> reference
 on the remote side.  By default this is only allowed if <dst> is not
-under refs/tags/, and then only if it can fast-forward <dst>.  By having
-the optional leading `+`, you can tell git to update the <dst> ref even
-if it is not allowed by default (e.g., it is not a fast-forward.)  This
-does *not* attempt to merge <src> into <dst>.  See EXAMPLES below for
-details.
+a tag (annotated or lightweight), and then only if it can fast-forward
+<dst>.  By having the optional leading `+`, you can tell git to update
+the <dst> ref even if it is not allowed by default (e.g., it is not a
+fast-forward.)  This does *not* attempt to merge <src> into <dst>.  See
+EXAMPLES below for details.
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
 +
diff --git a/remote.c b/remote.c
index 012b52f..f5bc4e7 100644
--- a/remote.c
+++ b/remote.c
@@ -1281,9 +1281,16 @@ int match_push_refs(struct ref *src, struct ref **dst,
 
 static inline int is_forwardable(struct ref* ref)
 {
+	struct object *o;
+
 	if (!prefixcmp(ref->name, "refs/tags/"))
 		return 0;
 
+	/* old object must be a commit */
+	o = parse_object(ref->old_sha1);
+	if (!o || o->type != OBJ_COMMIT)
+		return 0;
+
 	return 1;
 }
 
@@ -1323,8 +1330,8 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 *     to overwrite it; you would not know what you are losing
 		 *     otherwise.
 		 *
-		 * (4) if both new and old are commit-ish, and new is a
-		 *     descendant of old, it is OK.
+		 * (4) if old is a commit and new is a descendant of old
+		 *     (implying new is commit-ish), it is OK.
 		 *
 		 * (5) regardless of all of the above, removing :B is
 		 *     always allowed.
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 8f024a0..6009372 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -950,6 +950,27 @@ test_expect_success 'push requires --force to update lightweight tag' '
 	)
 '
 
+test_expect_success 'push requires --force to update annotated tag' '
+	mk_test heads/master &&
+	mk_child child1 &&
+	mk_child child2 &&
+	(
+		cd child1 &&
+		git tag -a -m "message 1" Tag &&
+		git push ../child2 Tag:refs/tmp/Tag &&
+		git push ../child2 Tag:refs/tmp/Tag &&
+		>file1 &&
+		git add file1 &&
+		git commit -m "file1" &&
+		git tag -f -a -m "message 2" Tag &&
+		test_must_fail git push ../child2 Tag:refs/tmp/Tag &&
+		git push --force ../child2 Tag:refs/tmp/Tag &&
+		git tag -f -a -m "message 3" Tag HEAD~ &&
+		test_must_fail git push ../child2 Tag:refs/tmp/Tag &&
+		git push --force ../child2 Tag:refs/tmp/Tag
+	)
+'
+
 test_expect_success 'push --porcelain' '
 	mk_empty &&
 	echo >.git/foo  "To testrepo" &&
-- 
1.8.0.158.g0c4328c
