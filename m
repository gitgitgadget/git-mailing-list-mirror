From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 2/2] fast-import: fix 'from 0{40}' test
Date: Mon, 19 Sep 2011 03:20:46 +0600
Message-ID: <1316380846-15845-3-git-send-email-divanorama@gmail.com>
References: <1316380846-15845-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 23:14:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5OhP-0007FT-D6
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 23:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559Ab1IRVOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 17:14:43 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46032 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932523Ab1IRVOi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 17:14:38 -0400
Received: by wwf22 with SMTP id 22so7157004wwf.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 14:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=a/uIshUd/g1UDdrypMn7g3dEZgqO+eRZ71e9Txc/ve8=;
        b=qxft4I8M4lM3v51aVFc/E/PIDbKQRWI1p1WomU0yVjtB7C5M7IoztRbXnZLxW3qfdS
         UARBomEZH8pfy8kd/MnCFE7JUvfJl6wJHzbXrr7J1shS2s8RBKK2NF0sadj8NTkTcFI8
         DW8rs+erEoWjW7TQbLbfDAcZKjukz59uTlDRg=
Received: by 10.216.230.223 with SMTP id j73mr1121970weq.39.1316380477089;
        Sun, 18 Sep 2011 14:14:37 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id gd6sm22990486wbb.1.2011.09.18.14.14.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 14:14:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1316380846-15845-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181641>

parse_from_existing() has a special case for null_sha1 treating it
as a start of an orphaned branch. It is how null_sha1 parent is
treated in fast-import. For example parse_reset_branch() clears
sha1 of a branch but leaves it in a lookup table.

Looking at parse_from_existing() call sites, we can seen that it is
only called for sha1's that come from get_sha1() or an existing
object. So fast-import internals don't give it null_sha1 explicitly
and the only way for it to appear is direct '0{40}' in the input.

Don't treat null_sha1 as a magic sha1 in parse_from_existing thus
making 'from 0{40}' an invalid input. (Unless there is a commit
object having null_sha1, of course. And object with null_sha1 would
be a lot of trouble in fast-import regardless of this patch.)

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c          |   17 ++++++-----------
 t/t9300-fast-import.sh |    2 +-
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 742e7da..827434a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2488,18 +2488,13 @@ static void parse_from_commit(struct branch *b, char *buf, unsigned long size)
 
 static void parse_from_existing(struct branch *b)
 {
-	if (is_null_sha1(b->sha1)) {
-		hashclr(b->branch_tree.versions[0].sha1);
-		hashclr(b->branch_tree.versions[1].sha1);
-	} else {
-		unsigned long size;
-		char *buf;
+	unsigned long size;
+	char *buf;
 
-		buf = read_object_with_reference(b->sha1,
-			commit_type, &size, b->sha1);
-		parse_from_commit(b, buf, size);
-		free(buf);
-	}
+	buf = read_object_with_reference(b->sha1,
+		commit_type, &size, b->sha1);
+	parse_from_commit(b, buf, size);
+	free(buf);
 }
 
 static int parse_from(struct branch *b)
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 8cc3f16..0784d50 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -381,7 +381,7 @@ data 0
 
 from 0000000000000000000000000000000000000000
 INPUT_END
-test_expect_failure 'B: fail on "from 0{40}"' '
+test_expect_success 'B: fail on "from 0{40}"' '
     test_must_fail git fast-import <input
 '
 rm -f .git/objects/pack_* .git/objects/index_*
-- 
1.7.3.4
