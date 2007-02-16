From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] pretend-sha1: grave bugfix.
Date: Thu, 15 Feb 2007 17:16:18 -0800
Message-ID: <7v3b56dhr1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 16 02:16:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHri3-0002MY-3H
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 02:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbXBPBQU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 20:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbXBPBQT
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 20:16:19 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:46838 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbXBPBQT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 20:16:19 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070216011618.GBIF1300.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 15 Feb 2007 20:16:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Q1GJ1W00D1kojtg0000000; Thu, 15 Feb 2007 20:16:18 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39874>

We stashed away objects that we pretend to have, but did not save the
actual data.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I wonder how recent merge-recursive with multiple merge bases
   (or an empty one) ever worked with this bug.  Am I
   hallucinating?

 sha1_file.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index b83f59f..2c87031 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1545,11 +1545,13 @@ int pretend_sha1_file(void *buf, unsigned long len, const char *type, unsigned c
 	co = &cached_objects[cached_object_nr++];
 	co->size = len;
 	co->type = strdup(type);
+	co->buf = xmalloc(len);
+	memcpy(co->buf, buf, len);
 	hashcpy(co->sha1, sha1);
 	return 0;
 }
 
-void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size)
+void *read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size)
 {
 	unsigned long mapsize;
 	void *map, *buf;
-- 
1.5.0.31.g78e90
