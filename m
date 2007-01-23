From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] Refactor the pack header reading function out of receive-pack.c
Date: Mon, 22 Jan 2007 22:47:49 -0800
Message-ID: <7v64ayp7ca.fsf@assigned-by-dhcp.cox.net>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
	<7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 07:47:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9FRj-0006rY-52
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 07:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933089AbXAWGrv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 01:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933091AbXAWGrv
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 01:47:51 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:39060 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933089AbXAWGru (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 01:47:50 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070123064749.LPBE2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Tue, 23 Jan 2007 01:47:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id EWmt1W00G1kojtg0000000; Tue, 23 Jan 2007 01:46:54 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37484>

I'll be reusing it on the fetch-pack side as well.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

  Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

  >>  - git-push more agressively keeps the transferred objects
  >>    packed.  Earlier we recommended to monitor amount of loose
  >>    objects and repack regularly, but you should repack when you
  >>    accumulated too many small packs this way as well.  Updated
  >>    git-count-objects helps you with this.
  >
  > It might make sense to enable something similar for git-fetch in time for 
  > 1.5.0.

  I have two patches that could become the beginning of this, not
  much tested.  This is the first of the two.

 pack.h         |    5 +++++
 receive-pack.c |   26 ++++++++++++++------------
 sha1_file.c    |   21 +++++++++++++++++++++
 3 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/pack.h b/pack.h
index 821706f..deb427e 100644
--- a/pack.h
+++ b/pack.h
@@ -44,4 +44,9 @@ struct pack_header {
 #define PACK_IDX_SIGNATURE 0xff744f63	/* "\377tOc" */
 
 extern int verify_pack(struct packed_git *, int);
+
+#define PH_ERROR_EOF		(-1)
+#define PH_ERROR_PACK_SIGNATURE	(-2)
+#define PH_ERROR_PROTOCOL	(-3)
+extern int read_pack_header(int fd, struct pack_header *);
 #endif
diff --git a/receive-pack.c b/receive-pack.c
index 6333f00..b3a4552 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -250,20 +250,22 @@ static void read_head_info(void)
 
 static const char *parse_pack_header(struct pack_header *hdr)
 {
-	char *c = (char*)hdr;
-	ssize_t remaining = sizeof(struct pack_header);
-	do {
-		ssize_t r = xread(0, c, remaining);
-		if (r <= 0)
-			return "eof before pack header was fully read";
-		remaining -= r;
-		c += r;
-	} while (remaining > 0);
-	if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
+	switch (read_pack_header(0, hdr)) {
+	case PH_ERROR_EOF:
+		return "eof before pack header was fully read";
+
+	case PH_ERROR_PACK_SIGNATURE:
 		return "protocol error (pack signature mismatch detected)";
-	if (!pack_version_ok(hdr->hdr_version))
+
+	case PH_ERROR_PROTOCOL:
 		return "protocol error (pack version unsupported)";
-	return NULL;
+
+	default:
+		return "unknown error in parse_pack_header";
+
+	case 0:
+		return NULL;
+	}
 }
 
 static const char *pack_lockfile;
diff --git a/sha1_file.c b/sha1_file.c
index 43ff402..498665e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2048,3 +2048,24 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, int write
 	}
 	return 0;
 }
+
+int read_pack_header(int fd, struct pack_header *header)
+{
+	char *c = (char*)header;
+	ssize_t remaining = sizeof(struct pack_header);
+	do {
+		ssize_t r = xread(fd, c, remaining);
+		if (r <= 0)
+			/* "eof before pack header was fully read" */
+			return PH_ERROR_EOF;
+		remaining -= r;
+		c += r;
+	} while (remaining > 0);
+	if (header->hdr_signature != htonl(PACK_SIGNATURE))
+		/* "protocol error (pack signature mismatch detected)" */
+		return PH_ERROR_PACK_SIGNATURE;
+	if (!pack_version_ok(header->hdr_version))
+		/* "protocol error (pack version unsupported)" */
+		return PH_ERROR_PROTOCOL;
+	return 0;
+}
-- 
1.5.0.rc2.gc9a89
