From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 14/15] EVIL COMMIT: Include all commits
Date: Sat,  4 Sep 2010 18:14:06 -0600
Message-ID: <1283645647-1891-15-git-send-email-newren@gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
Cc: pclouds@gmail.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 02:13:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os2rj-0008IQ-0w
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 02:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620Ab0IEANe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 20:13:34 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57812 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593Ab0IEANa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 20:13:30 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so971230pzk.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 17:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=uwAjRLXhNB/MDH9uJLxhtDSxsaXT7PXVuPTvvcNlBz4=;
        b=qt4RaLapsF8pz+f4uLoel92zXvjO/G3Jc6i6Xspi+3LiAU9BWAC1Uq81jMCXMhOEg+
         Zpm5d53b9nbdEP+JhXy5hc25elDKy8dP3qtk5y3JfqjyxiQRutt/SHos4B4ocIUw2Udm
         LCLxwAcB3crs2zsYn/ANDlRNkLAi8bmincFdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YwwA6RHWU1kJ4bmQWhDHD2LlBdzogdRIxpx/HuswIjBjkXNyyuBNgII75ok6g7UvIm
         ARNs09xnuyIVB1cz8qPKclW3QT3rOS+T74gn62fTtYr9gbiDPm+klQXS8gllZ8luCSXo
         D+xQHYI78AKVWvU3IjwXt91XoS43aqPKFBg98=
Received: by 10.114.126.2 with SMTP id y2mr1317290wac.57.1283645609966;
        Sat, 04 Sep 2010 17:13:29 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 33sm7341833wad.18.2010.09.04.17.13.28
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 17:13:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.140.gd06af
In-Reply-To: <1283645647-1891-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155400>

The correct fix is to include the *relevant pieces* of all commits.  But
this is a quick stopgap that lets me test some stuff.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 revision.c    |    5 +++--
 revision.h    |    3 ++-
 upload-pack.c |    1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index 67b1a1d..c411bda 100644
--- a/revision.c
+++ b/revision.c
@@ -335,7 +335,7 @@ static int rev_compare_tree(struct rev_info *revs, struct commit *parent, struct
 	tree_difference = REV_TREE_SAME;
 	DIFF_OPT_CLR(&revs->pruning, HAS_CHANGES);
 	if (diff_tree_sha1(t1->object.sha1, t2->object.sha1, "",
-			   &revs->pruning) < 0)
+			   &revs->pruning) < 0 || revs->sparse_traversal)
 		return REV_TREE_DIFFERENT;
 	return tree_difference;
 }
@@ -380,7 +380,8 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		return;
 
 	if (!commit->parents) {
-		if (rev_same_tree_as_empty(revs, commit))
+		if (rev_same_tree_as_empty(revs, commit) &&
+		    !revs->sparse_traversal)
 			commit->object.flags |= TREESAME;
 		return;
 	}
diff --git a/revision.h b/revision.h
index ba879c9..17865e8 100644
--- a/revision.h
+++ b/revision.h
@@ -85,7 +85,8 @@ struct rev_info {
 			ignore_merges:1,
 			combine_merges:1,
 			dense_combined_merges:1,
-			always_show_header:1;
+			always_show_header:1,
+			sparse_traversal:1;
 
 	/* Format info */
 	unsigned int	shown_one:1,
diff --git a/upload-pack.c b/upload-pack.c
index 721197b..a58b350 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -120,6 +120,7 @@ static int do_rev_list(int in, int out, void *user_data)
 	revs.blob_objects = 1;
 	if (use_thin_pack)
 		revs.edge_hint = 1;
+	revs.sparse_traversal = 1;
 
 	for (i = 0; i < want_obj.nr; i++) {
 		struct object *o = want_obj.objects[i].item;
-- 
1.7.2.2.140.gd06af
