From: drafnel@gmail.com
Subject: [PATCH 2/3] packed_git: add new PACK_KEEP flag and haspackkeep() access macro
Date: Sun,  2 Nov 2008 10:31:16 -0600
Message-ID: <14846251.1225643403413.JavaMail.teamon@b303.teamon.com>
References: <14536526.1225596838300.JavaMail.teamon@b301.teamon.com>
 <1225643477-32319-1-git-send-email-foo@foo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, nico@cam.org, spearce@spearce.org,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 02 17:31:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwfrU-0000oU-10
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 17:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684AbYKBQaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 11:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753703AbYKBQaF
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 11:30:05 -0500
Received: from mailproxy03.teamon.com ([64.85.68.139]:38164 "EHLO
	b303.teamon.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753684AbYKBQaE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 11:30:04 -0500
Received: from b303.teamon.com (localhost [127.0.0.1])
	by b303.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id mA2GU3K15076;
	Sun, 2 Nov 2008 16:30:03 GMT
X-Mailer: git-send-email 1.6.0.2.588.g3102
In-Reply-To: <1225643477-32319-1-git-send-email-foo@foo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99851>

From: Brandon Casey <drafnel@gmail.com>

If you want to tell whether a pack has an associated ".keep" file you
would do:

   if (haspackkeep(p))
      do_something

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 cache.h     |    2 ++
 sha1_file.c |    5 +++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 0cb9350..48cd366 100644
--- a/cache.h
+++ b/cache.h
@@ -686,7 +686,9 @@ extern struct packed_git {
 } *packed_git;
 
 #define PACK_LOCAL	1
+#define PACK_KEEP	2
 #define ispacklocal(p) ((p)->flags & PACK_LOCAL)
+#define haspackkeep(p) ((p)->flags & PACK_KEEP)
 
 struct pack_entry {
 	off_t offset;
diff --git a/sha1_file.c b/sha1_file.c
index e4141c9..8a027e9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -841,6 +841,11 @@ struct packed_git *add_packed_git(const char *path, int path_len, int local)
 		return NULL;
 	}
 	memcpy(p->pack_name, path, path_len);
+
+	strcpy(p->pack_name + path_len, ".keep");
+	if (!access(p->pack_name, F_OK))
+		p->flags |= PACK_KEEP;
+
 	strcpy(p->pack_name + path_len, ".pack");
 	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
 		free(p);
-- 
1.6.0.2.588.g3102
