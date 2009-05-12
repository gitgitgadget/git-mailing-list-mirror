From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [RFC 7/8] Convert symlink dest in diff
Date: Wed, 13 May 2009 00:50:30 +0200
Message-ID: <1242168631-30753-8-git-send-email-robin.rosenberg@dewire.com>
References: <1242168631-30753-1-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-2-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-3-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-4-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-5-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-6-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-7-git-send-email-robin.rosenberg@dewire.com>
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 00:51:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M40oz-0000ir-Ev
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 00:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732AbZELWvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 18:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755067AbZELWvD
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 18:51:03 -0400
Received: from mail.dewire.com ([83.140.172.130]:19410 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754836AbZELWux (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 18:50:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 19974145A58A;
	Wed, 13 May 2009 00:50:54 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5nFhBBwTuI-o; Wed, 13 May 2009 00:50:53 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.9])
	by dewire.com (Postfix) with ESMTP id 8311E145A593;
	Wed, 13 May 2009 00:50:35 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
In-Reply-To: <1242168631-30753-7-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118968>

---
 diff.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 170ec5a..c8132a4 100644
--- a/diff.c
+++ b/diff.c
@@ -1319,8 +1319,18 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 				locate_size_cache(s->sha1, 0, s->size);
 		}
 		else {
-			s->data = read_sha1_file(s->sha1, type, &s->size);
-			s->should_free = 1;
+			if (S_ISLNK(s->mode)) {
+				int linksize;
+			        char *linkdata = read_sha1_file(s->sha1, type, &linksize);
+				s->size = locallen(linkdata, linksize);
+				s->data = xmalloc(s->size + 1);
+				localcpy(s->data, linkdata, linksize + 1);
+				s->should_free = 1;
+				free(linkdata);
+			} else {
+				s->data = read_sha1_file(s->sha1, type, &s->size);
+				s->should_free = 1;
+			}
 		}
 	}
 	return 0;
-- 
1.6.3.dirty
