From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 2/2] fast-import: allow to tag newly created objects
Date: Mon, 22 Aug 2011 18:10:19 +0600
Message-ID: <1314015019-6636-3-git-send-email-divanorama@gmail.com>
References: <1314015019-6636-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 22 14:08:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvTIx-00016y-Uj
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 14:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840Ab1HVMI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 08:08:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45035 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab1HVMIX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 08:08:23 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3606489bke.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 05:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TUlENmCh35z65Fg9KSw62RL0VfuBq6h5RDq98ASz2Hc=;
        b=IC0RhEcZ9BHC/DXT8hsFKLgF9SBf376+eMHWwahDA+rRZDCY+MPe9Quwhy4i5K1ffM
         VTpjzGR8me3wydTLaX4f3pefgnP4oO9N8IGhpttYncEVn2ihIlg/vPYnrd0wAXp6SVq1
         5OntyUBgkKLz3TXvEyIIm5tCZ0COvw98sSiEI=
Received: by 10.204.8.19 with SMTP id f19mr893362bkf.274.1314014903012;
        Mon, 22 Aug 2011 05:08:23 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id zy5sm1908953bkb.64.2011.08.22.05.08.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Aug 2011 05:08:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1314015019-6636-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179858>

fast-import allows to tag objects by sha1 and to query sha1 of objects
being imported. So it should allow to tag these objects, make it do so.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c          |   10 +++++++---
 t/t9300-fast-import.sh |   26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 0b0f598..11eb6bf 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2690,9 +2690,13 @@ static void parse_new_tag(void)
 		type = oe->type;
 		hashcpy(sha1, oe->idx.sha1);
 	} else if (!get_sha1(from, sha1)) {
-		type = sha1_object_info(sha1, NULL);
-		if (type < 0)
-			die("Not a valid object: %s", from);
+		struct object_entry *oe = find_object(sha1);
+		if (!oe) {
+			type = sha1_object_info(sha1, NULL);
+			if (type < 0)
+				die("Not a valid object: %s", from);
+		} else
+			type = oe->type;
 	} else
 		die("Invalid ref name or SHA1 expression: %s", from);
 	read_next_command();
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 41f0d02..efe9779 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -188,12 +188,32 @@ test_expect_success \
 	test_cmp expect marks.new'
 
 test_tick
+new_blob=$(echo testing | git hash-object --stdin)
 cat >input <<INPUT_END
 tag series-A-blob-2
 from $(git rev-parse refs/heads/master:file3)
 data <<EOF
 Tag blob by sha1.
 EOF
+
+blob
+mark :6
+data <<EOF
+testing
+EOF
+
+commit refs/heads/new_blob
+committer  <> 0 +0000
+data 0
+M 644 :6 new_blob
+#pretend we got sha1 from fast-import
+ls "new_blob"
+
+tag series-A-blob-3
+from $new_blob
+data <<EOF
+Tag new_blob.
+EOF
 INPUT_END
 
 cat >expect <<EOF
@@ -202,12 +222,18 @@ type blob
 tag series-A-blob-2
 
 Tag blob by sha1.
+object $new_blob
+type blob
+tag series-A-blob-3
+
+Tag new_blob.
 EOF
 
 test_expect_success \
 	'A: tag blob by sha1' \
 	'git fast-import <input &&
 	git cat-file tag tags/series-A-blob-2 >actual &&
+	git cat-file tag tags/series-A-blob-3 >>actual &&
 	test_cmp expect actual'
 
 test_tick
-- 
1.7.3.4
