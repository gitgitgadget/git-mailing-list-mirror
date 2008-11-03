From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH v2 2/3] packed_git: convert pack_local flag into a bitfield
 and add pack_keep
Date: Mon, 03 Nov 2008 14:41:34 -0600
Message-ID: <-RiFxYEd9Wiq2fWX74zYGUiEwrzLeoFDb1KuG3-Xo-s@cipher.nrlssc.navy.mil>
References: <muOuA1nLBoljLnZoguxeFeKt-8Q-I9Y3ljvxnLWLt9KyA8HwVtMa4Q@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 21:43:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx6Gc-0005uO-Q2
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 21:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbYKCUmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 15:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbYKCUmD
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 15:42:03 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52173 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbYKCUmB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 15:42:01 -0500
Received: by mail.nrlssc.navy.mil id mA3KfYlH013913; Mon, 3 Nov 2008 14:41:34 -0600
In-Reply-To: <muOuA1nLBoljLnZoguxeFeKt-8Q-I9Y3ljvxnLWLt9KyA8HwVtMa4Q@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 03 Nov 2008 20:41:34.0595 (UTC) FILETIME=[8F851D30:01C93DF4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99992>

From: Brandon Casey <drafnel@gmail.com>

pack_keep will be set when a pack file has an associated .keep file.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


This patch and the following one redo the previous 3-patch series using a
bitfield as prudently suggested by Shawn.

It seemed silly to keep the conversion of pack_local into a bitfield, and the
introduction of pack_keep separate, so all 7 lines are in this one patch.

-brandon


 cache.h     |    3 ++-
 sha1_file.c |    5 +++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index b0edbf9..b80cb08 100644
--- a/cache.h
+++ b/cache.h
@@ -679,7 +679,8 @@ extern struct packed_git {
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
