From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 2/3] fast-import: allow "merge $null_sha1" command
Date: Wed, 27 Jun 2012 23:40:24 +0600
Message-ID: <1340818825-13754-3-git-send-email-divanorama@gmail.com>
References: <1340818825-13754-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 19:40:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjwDe-0000ud-EA
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 19:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757772Ab2F0Rjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 13:39:53 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:47318 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757437Ab2F0Rju (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 13:39:50 -0400
Received: by mail-lb0-f174.google.com with SMTP id gm6so1909447lbb.19
        for <git@vger.kernel.org>; Wed, 27 Jun 2012 10:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=x2IYb39QJ10pKnGCBz0Yj18JIaWiIJLu5I3SbGSdvT8=;
        b=hZ6SgV7AbohMzX2FmUfZaac7TglfKkX/XB8iL/zjuvdunA+JyKsAdJBxXVGNZECsHS
         r5VEqb2FhdfHnexzcA7IDNKWqpZZg1yb4Q2plY9SiucyI7YkzBVNBkRbDR8hfPPVy4bG
         G2+0bVe+Tu0L9TPfFuoaqihuO4REqMK4e2eJAWzXsTC2iH45xqNxfyMdKhletuqsYh/s
         rK9x2Se9KLAxDrVYngNRkiG/aj1De4OBZ5g9VoVx8/sv/V39KW234h7Jsu0R/GviZavm
         TgqaJIPjq/p/b+lz/k3iK0LH/HAkyAkaeAtFaIzGEkjguxA9mJ7lUSycxIX005JcJXG2
         AqJw==
Received: by 10.152.136.18 with SMTP id pw18mr21481350lab.17.1340818790021;
        Wed, 27 Jun 2012 10:39:50 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id pp2sm84780930lab.3.2012.06.27.10.39.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jun 2012 10:39:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1340818825-13754-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200733>

"from $null_sha1" and "merge $empty_branch" are already allowed so
allow "merge $null_sha1" command too.

However such 'merge' has no effect on the import. It's made allowed
just to unify null_sha1 commits handling a little bit.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c          |   14 ++++++++------
 t/t9300-fast-import.sh |    1 +
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 419e435..f03da1e 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2631,12 +2631,14 @@ static struct hash_list *parse_merge(unsigned int *count)
 				die("Mark :%" PRIuMAX " not a commit", idnum);
 			hashcpy(n->sha1, oe->idx.sha1);
 		} else if (!get_sha1(from, n->sha1)) {
-			unsigned long size;
-			char *buf = read_object_with_reference(n->sha1,
-				commit_type, &size, n->sha1);
-			if (!buf || size < 46)
-				die("Not a valid commit: %s", from);
-			free(buf);
+			if (!is_null_sha1(n->sha1)) {
+				unsigned long size;
+				char *buf = read_object_with_reference(n->sha1,
+					commit_type, &size, n->sha1);
+				if (!buf || size < 46)
+					die("Not a valid commit: %s", from);
+				free(buf);
+			}
 		} else
 			die("Invalid ref name or SHA1 expression: %s", from);
 
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5716420..6f4c988 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -864,6 +864,7 @@ Merge J3, J4 into fresh J5.
 COMMIT
 merge refs/heads/J3
 merge refs/heads/J4
+merge 0000000000000000000000000000000000000000
 
 INPUT_END
 test_expect_success \
-- 
1.7.3.4
