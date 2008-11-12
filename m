From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/6] packed_git: convert pack_local flag into a bitfield and add pack_keep
Date: Wed, 12 Nov 2008 11:59:03 -0600
Message-ID: <WFmMnhNsYRw3IUD8hZk59Bod6u3kdkWtabbRw1_B1XS8U8eP3drqEMEsFa_-Q_Qu-xrbOsLcdzo@cipher.nrlssc.navy.mil>
References: <NRnq_JA3Ngz2v6EUhSwtVu5zewgvJgLsW85zZZqzrYE@cipher.nrlssc.navy.mil> <WFmMnhNsYRw3IUD8hZk59MeWg__Hu_J0586FDlwkv7_Bb80SFy_3xVB_YmBMzdF0byAGksl5Rnk@cipher.nrlssc.navy.mil> <WFmMnhNsYRw3IUD8hZk59JmvLQlpuqo-hsW2L51xXUJ0ETOpVPtrZvZzBrrquDq1PlXDGK5BhsQ@cipher.nrlssc.navy.mil>
Cc: peff@peff.net, git@vger.kernel.org, spearce@spearce.org,
	nico@cam.org, Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 12 19:01:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0K1l-0002fL-GJ
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 19:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbYKLR7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752375AbYKLR7i
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:59:38 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50126 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbYKLR7e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 12:59:34 -0500
Received: by mail.nrlssc.navy.mil id mACHxHUC019934; Wed, 12 Nov 2008 11:59:17 -0600
In-Reply-To: <WFmMnhNsYRw3IUD8hZk59JmvLQlpuqo-hsW2L51xXUJ0ETOpVPtrZvZzBrrquDq1PlXDGK5BhsQ@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 12 Nov 2008 17:59:17.0200 (UTC) FILETIME=[614C4D00:01C944F0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100793>

From: Brandon Casey <drafnel@gmail.com>

pack_keep will be set when a pack file has an associated .keep file.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 cache.h     |    3 ++-
 sha1_file.c |    5 +++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index eda7028..37ab457 100644
--- a/cache.h
+++ b/cache.h
@@ -686,7 +686,8 @@ extern struct packed_git {
 	int index_version;
 	time_t mtime;
 	int pack_fd;
-	int pack_local;
+	unsigned pack_local:1,
+		 pack_keep:1;
 	unsigned char sha1[20];
 	/* something like ".git/objects/pack/xxxxx.pack" */
 	char pack_name[FLEX_ARRAY]; /* more */
diff --git a/sha1_file.c b/sha1_file.c
index ab2b520..f2b25bd 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -841,6 +841,11 @@ struct packed_git *add_packed_git(const char *path, int path_len, int local)
 		return NULL;
 	}
 	memcpy(p->pack_name, path, path_len);
+
+	strcpy(p->pack_name + path_len, ".keep");
+	if (!access(p->pack_name, F_OK))
+		p->pack_keep = 1;
+
 	strcpy(p->pack_name + path_len, ".pack");
 	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
 		free(p);
-- 
1.6.0.3.552.g12334
