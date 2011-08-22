From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 1/2] fast-import: add tests for tagging blobs
Date: Mon, 22 Aug 2011 18:10:18 +0600
Message-ID: <1314015019-6636-2-git-send-email-divanorama@gmail.com>
References: <1314015019-6636-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 22 14:08:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvTIp-000141-D5
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 14:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815Ab1HVMIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 08:08:24 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64964 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab1HVMIW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 08:08:22 -0400
Received: by bke11 with SMTP id 11so3606508bke.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 05:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=oG+1sGRWuN/vKl8h9pwX8Ft13dfIxrfZFiQrb0VcDRI=;
        b=xmXpE0rL5Ry+HUytF3pbWkPnR85QxhxMiJFNxL+YcP1iMJWtFuVjqHJz6UA5yYv87S
         ZJvw01JMe2jzhqAv3U/Es0GOeMMXUfYFri/Wg6/CiQfuaYdGTmwq/oQkD1gTq9x14Dse
         gfRRwnnjLHr6ZXc1/Olc4RRiPsWogzURSUh9U=
Received: by 10.204.154.90 with SMTP id n26mr898187bkw.137.1314014901257;
        Mon, 22 Aug 2011 05:08:21 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id zy5sm1908953bkb.64.2011.08.22.05.08.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Aug 2011 05:08:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1314015019-6636-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179857>

fast-import allows to create an annotated tag that annotates a blob,
via mark or direct sha1 specification.

For mark it works, for sha1 it tries to read the object. It tries to
do so via read_sha1_file, and then checks the size to be at least 46.

That's weird, let's just allow to (annotated) tag any object referenced
by sha1. If the object originates from our packfile, we still fail though.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c          |   10 +++-------
 t/t9300-fast-import.sh |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7cc2262..0b0f598 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2690,13 +2690,9 @@ static void parse_new_tag(void)
 		type = oe->type;
 		hashcpy(sha1, oe->idx.sha1);
 	} else if (!get_sha1(from, sha1)) {
-		unsigned long size;
-		char *buf;
-
-		buf = read_sha1_file(sha1, &type, &size);
-		if (!buf || size < 46)
-			die("Not a valid commit: %s", from);
-		free(buf);
+		type = sha1_object_info(sha1, NULL);
+		if (type < 0)
+			die("Not a valid object: %s", from);
 	} else
 		die("Invalid ref name or SHA1 expression: %s", from);
 	read_next_command();
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index f256475..41f0d02 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -94,6 +94,12 @@ data <<EOF
 An annotated tag without a tagger
 EOF
 
+tag series-A-blob
+from :3
+data <<EOF
+An annotated tag that annotates a blob.
+EOF
+
 INPUT_END
 test_expect_success \
     'A: create pack from stdin' \
@@ -152,6 +158,18 @@ test_expect_success 'A: verify tag/series-A' '
 '
 
 cat >expect <<EOF
+object $(git rev-parse refs/heads/master:file3)
+type blob
+tag series-A-blob
+
+An annotated tag that annotates a blob.
+EOF
+test_expect_success 'A: verify tag/series-A-blob' '
+	git cat-file tag tags/series-A-blob >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF
 :2 `git rev-parse --verify master:file2`
 :3 `git rev-parse --verify master:file3`
 :4 `git rev-parse --verify master:file4`
@@ -171,6 +189,29 @@ test_expect_success \
 
 test_tick
 cat >input <<INPUT_END
+tag series-A-blob-2
+from $(git rev-parse refs/heads/master:file3)
+data <<EOF
+Tag blob by sha1.
+EOF
+INPUT_END
+
+cat >expect <<EOF
+object $(git rev-parse refs/heads/master:file3)
+type blob
+tag series-A-blob-2
+
+Tag blob by sha1.
+EOF
+
+test_expect_success \
+	'A: tag blob by sha1' \
+	'git fast-import <input &&
+	git cat-file tag tags/series-A-blob-2 >actual &&
+	test_cmp expect actual'
+
+test_tick
+cat >input <<INPUT_END
 commit refs/heads/verify--import-marks
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
-- 
1.7.3.4
