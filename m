From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] bundle: Use OFS_DELTA in bundle files
Date: Sat,  5 Feb 2011 16:58:53 -0800
Message-ID: <1296953933-8474-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 01:59:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Plsy9-0000jw-JM
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 01:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633Ab1BFA65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 19:58:57 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:37330 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab1BFA65 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 19:58:57 -0500
Received: by pxi15 with SMTP id 15so663869pxi.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 16:58:56 -0800 (PST)
Received: by 10.142.126.20 with SMTP id y20mr974514wfc.114.1296953936462;
        Sat, 05 Feb 2011 16:58:56 -0800 (PST)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.74.25])
        by mx.google.com with ESMTPS id w42sm3410002wfh.3.2011.02.05.16.58.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Feb 2011 16:58:55 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc3.268.g2af8b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166137>

git-bundle first appeared in 2e0afafe ("Add git-bundle") in Feb 2007,
and first shipped in Git 1.5.1.

However, OFS_DELTA is an even earlier invention, coming about in
eb32d236 ("introduce delta objects with offset to base") in Sep 2006,
and first shipped in Git 1.4.4.5.

OFS_DELTA is smaller, about 3.2%-5% smaller, and is typically faster
to access than REF_DELTA because the exact location of the delta base
is available after parsing the object header.  Since all bundle aware
versions of Git are also OFS_DELTA aware, just make it the default.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 bundle.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/bundle.c b/bundle.c
index 65ea26b..f48fd7d 100644
--- a/bundle.c
+++ b/bundle.c
@@ -200,7 +200,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 	int bundle_fd = -1;
 	int bundle_to_stdout;
 	const char **argv_boundary = xmalloc((argc + 4) * sizeof(const char *));
-	const char **argv_pack = xmalloc(5 * sizeof(const char *));
+	const char **argv_pack = xmalloc(6 * sizeof(const char *));
 	int i, ref_count = 0;
 	char buffer[1024];
 	struct rev_info revs;
@@ -346,7 +346,8 @@ int create_bundle(struct bundle_header *header, const char *path,
 	argv_pack[1] = "--all-progress-implied";
 	argv_pack[2] = "--stdout";
 	argv_pack[3] = "--thin";
-	argv_pack[4] = NULL;
+	argv_pack[4] = "--delta-base-offset";
+	argv_pack[5] = NULL;
 	memset(&rls, 0, sizeof(rls));
 	rls.argv = argv_pack;
 	rls.in = -1;
-- 
1.7.4.rc3.268.g2af8b
