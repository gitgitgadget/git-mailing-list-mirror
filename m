From: Johan Herland <johan@herland.net>
Subject: [PATCH 17/21] Update comments on tag objects in mktag.c
Date: Sat, 09 Jun 2007 02:20:04 +0200
Message-ID: <200706090220.04603.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
 <200706090210.36270.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 02:20:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwogf-0004jf-6r
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 02:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031655AbXFIAUM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 20:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031629AbXFIAUL
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 20:20:11 -0400
Received: from smtp.getmail.no ([84.208.20.33]:35832 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031589AbXFIAUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 20:20:09 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJC00A03E9K3Y00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:20:08 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC000T5E9HCP20@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:20:05 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC00FJXE9GRBG0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:20:05 +0200 (CEST)
In-reply-to: <200706090210.36270.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49544>

Also update minimum tag object length to the new minimum length after refactoring.

Signed-off-by: Johan Herland <johan@herland.net>
---
 mktag.c |   30 ++++++++++++++++++++++--------
 tag.c   |    2 +-
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/mktag.c b/mktag.c
index 31eadd8..af0cfa6 100644
--- a/mktag.c
+++ b/mktag.c
@@ -2,16 +2,30 @@
 #include "tag.h"
 
 /*
- * A signature file has a very simple fixed format: four lines
- * of "object <sha1>" + "type <typename>" + "tag <tagname>" +
+ * Tag object data has the following format: two mandatory lines of
+ * "object <sha1>" + "type <typename>", plus two optional lines of
+ * "tag <tagname>" + "keywords <keywords>", plus a mandatory line of
  * "tagger <committer>", followed by a blank line, a free-form tag
- * message and a signature block that git itself doesn't care about,
- * but that can be verified with gpg or similar.
+ * message and an optional signature block that git itself doesn't
+ * care about, but that can be verified with gpg or similar.
  *
- * The first three lines are guaranteed to be at least 63 bytes:
- * "object <sha1>\n" is 48 bytes, "type tag\n" at 9 bytes is the
- * shortest possible type-line, and "tag .\n" at 6 bytes is the
- * shortest single-character-tag line.
+ * <sha1> represents the object pointed to by this tag, <typename> is
+ * the type of the object pointed to ("tag", "blob", "tree" or "commit"),
+ * <tagname> is the name of this tag object (and must correspond to the
+ * name of the corresponding ref (if any) in '.git/refs/'). <keywords> is
+ * a comma-separated list of keywords associated with this tag object, and
+ * <committer> holds the "name <email>" of the tag creator and timestamp
+ * of when the tag object was created (analogous to "committer" in commit
+ * objects).
+ *
+ * The first two lines are guaranteed to be at least 57 bytes:
+ * "object <sha1>\n" is 48 bytes, and "type tag\n" at 9 bytes is
+ * the shortest possible "type" line. The tagger line is at least
+ * "tagger \n" (8 bytes). Therefore a tag object _must_ have >= 65 bytes.
+ *
+ * If "tag <tagname>" is omitted, <tagname> defaults to the empty string.
+ * If "keywords <keywords>" is omitted, <keywords> defaults to "tag" if
+ * a <tagname> was given, "note" otherwise.
  */
 
 int main(int argc, char **argv)
diff --git a/tag.c b/tag.c
index 1caec19..af4356e 100644
--- a/tag.c
+++ b/tag.c
@@ -79,7 +79,7 @@ int parse_and_verify_tag_buffer(struct tag *item,
 		item->object.parsed = 1;
 	}
 
-	if (size < 64)
+	if (size < 65)
 		return error("Tag object failed preliminary size check");
 
 	/* Verify mandatory object line */
-- 
1.5.2
