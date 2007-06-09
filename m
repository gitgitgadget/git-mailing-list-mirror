From: Johan Herland <johan@herland.net>
Subject: [PATCH 04/21] Refactor verification of "tagger" line to be more
 similar to verification of "type" and "tagger" lines
Date: Sat, 09 Jun 2007 02:14:11 +0200
Message-ID: <200706090214.11589.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
 <200706090210.36270.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 02:14:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwoba-0003xc-1h
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 02:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S969799AbXFIAOR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 20:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S969752AbXFIAOQ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 20:14:16 -0400
Received: from smtp.getmail.no ([84.208.20.33]:47205 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967854AbXFIAOP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 20:14:15 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJC00903DZQPX00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:14:14 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC000KUDZNZL30@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:14:12 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC009KADZNAH00@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:14:11 +0200 (CEST)
In-reply-to: <200706090210.36270.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49531>

Also update selftests to reflect that verification of "tagger" now
happens _before_ verification of type name, object sha1 and tag name.

Signed-off-by: Johan Herland <johan@herland.net>
---
 mktag.c          |   16 ++++++++--------
 t/t3800-mktag.sh |    3 +++
 tag.c            |    6 +++---
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/mktag.c b/mktag.c
index 0bc20c8..4dbefab 100644
--- a/mktag.c
+++ b/mktag.c
@@ -62,12 +62,18 @@ static int verify_tag(char *data, unsigned long size)
 
 	/* Verify tag-line */
 	tag_line = strchr(type_line, '\n');
-	if (!tag_line)
+	if (!tag_line++)
 		return error("char" PD_FMT ": could not find next \"\\n\"", type_line - data);
-	tag_line++;
 	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
 		return error("char" PD_FMT ": no \"tag \" found", tag_line - data);
 
+	/* Verify the tagger line */
+	tagger_line = strchr(tag_line, '\n');
+	if (!tagger_line++)
+		return error("char" PD_FMT ": could not find next \"\\n\"", tag_line - data);
+	if (memcmp(tagger_line, "tagger ", 7) || (tagger_line[7] == '\n'))
+		return error("char" PD_FMT ": could not find \"tagger\"", tagger_line - data);
+
 	/* Get the actual type */
 	type_len = tag_line - type_line - strlen("type \n");
 	if (type_len >= sizeof(type))
@@ -90,12 +96,6 @@ static int verify_tag(char *data, unsigned long size)
 		return error("char" PD_FMT ": could not verify tag name", tag_line - data);
 	}
 
-	/* Verify the tagger line */
-	tagger_line = tag_line;
-
-	if (memcmp(tagger_line, "tagger", 6) || (tagger_line[6] == '\n'))
-		return error("char" PD_FMT ": could not find \"tagger\"", tagger_line - data);
-
 	/* TODO: check for committer info + blank line? */
 	/* Also, the minimum length is probably + "tagger .", or 63+8=71 */
 
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 7c7e433..b4edb4d 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -133,6 +133,7 @@ cat >tag.sig <<EOF
 object 779e9b33986b1c2670fff52c5067603117b3e895
 type taggggggggggggggggggggggggggggggg
 tag mytag
+tagger a
 EOF
 
 cat >expect.pat <<EOF
@@ -148,6 +149,7 @@ cat >tag.sig <<EOF
 object 779e9b33986b1c2670fff52c5067603117b3e895
 type tagggg
 tag mytag
+tagger a
 EOF
 
 cat >expect.pat <<EOF
@@ -163,6 +165,7 @@ cat >tag.sig <<EOF
 object $head
 type commit
 tag my	tag
+tagger a
 EOF
 
 cat >expect.pat <<EOF
diff --git a/tag.c b/tag.c
index 8d31603..19c66cd 100644
--- a/tag.c
+++ b/tag.c
@@ -73,10 +73,10 @@ static int parse_tag_buffer_internal(struct tag *item, const char *data, const u
 	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
 		return error("char" PD_FMT ": no \"tag \" found", tag_line - data);
 
+	/* Verify the tagger line */
 	tagger_line = strchr(tag_line, '\n');
-	if (!tagger_line)
-		return -1;
-	tagger_line++;
+	if (!tagger_line++)
+		return error("char" PD_FMT ": could not find next \"\\n\"", tag_line - data);
 
 	/* Get the actual type */
 	type_len = tag_line - type_line - strlen("type \n");
-- 
1.5.2
