From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/4] Fix tree-walking compare_entry() in the presense of --prefix
Date: Thu, 6 Mar 2008 15:44:48 -0800
Message-ID: <76edcf443909a95e2c391e23390a963f9a417dee.1204856187.git.torvalds@linux-foundation.org>
References: <cover.1204856187.git.torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 03:22:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXSDw-0001X7-Pv
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 03:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756865AbYCGCV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 21:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763411AbYCGCV3
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 21:21:29 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59637 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756865AbYCGCV1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2008 21:21:27 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m272LYMF010914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Mar 2008 18:21:35 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m272LBBj032703;
	Thu, 6 Mar 2008 18:21:11 -0800
In-Reply-To: <cover.1204856187.git.torvalds@linux-foundation.org>
X-Spam-Status: No, hits=-4.023 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76455>

When we make the "root" tree-walk info entry have a pathname in it, we
need to have a ->prev pointer so that compare_entry will actually notice
and traverse into the root.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 tree-walk.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 842cb6a..02e2aed 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -107,6 +107,7 @@ int tree_entry(struct tree_desc *desc, struct name_entry *entry)
 void setup_traverse_info(struct traverse_info *info, const char *base)
 {
 	int pathlen = strlen(base);
+	static struct traverse_info dummy;
 
 	memset(info, 0, sizeof(*info));
 	if (pathlen && base[pathlen-1] == '/')
@@ -114,6 +115,8 @@ void setup_traverse_info(struct traverse_info *info, const char *base)
 	info->pathlen = pathlen ? pathlen + 1 : 0;
 	info->name.path = base;
 	info->name.sha1 = (void *)(base + pathlen + 1);
+	if (pathlen)
+		info->prev = &dummy;
 }
 
 char *make_traverse_path(char *path, const struct traverse_info *info, const struct name_entry *n)
-- 
1.5.4.3.452.g67136


