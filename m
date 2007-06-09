From: Johan Herland <johan@herland.net>
Subject: [PATCH 07/21] Copy the remaining differences from verify_tag() to
 parse_tag_buffer_internal()
Date: Sat, 09 Jun 2007 02:15:31 +0200
Message-ID: <200706090215.31731.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
 <200706090210.36270.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 02:15:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwocD-00043v-PK
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 02:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S969917AbXFIAPg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 20:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S969900AbXFIAPg
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 20:15:36 -0400
Received: from smtp.getmail.no ([84.208.20.33]:33305 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S969777AbXFIAPf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 20:15:35 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJC00903E1YOU00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:15:34 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC000NQE1WCP20@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:15:32 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC009QDE1VAH00@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:15:32 +0200 (CEST)
In-reply-to: <200706090210.36270.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49534>

Rename parse_tag_buffer_internal() to parse_and_verify_tag_buffer() since
it now does tag object verification as well.

Add a new parameter 'thorough_verify' for turning on/off the extra code
to be run when verifying tag objects (as opposed to general parsing).

verify_tag() and parse_and_verify_tag_buffer() are now functionally
equivalent, provided that parse_and_verify_tag_buffer() is called with
item == NULL and thorough_verification != 0.

Signed-off-by: Johan Herland <johan@herland.net>
---
 tag.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/tag.c b/tag.c
index b134967..3896e45 100644
--- a/tag.c
+++ b/tag.c
@@ -33,7 +33,26 @@ struct tag *lookup_tag(const unsigned char *sha1)
         return (struct tag *) obj;
 }
 
-static int parse_tag_buffer_internal(struct tag *item, const char *data, const unsigned long size)
+/*
+ * We refuse to tag something we can't verify. Just because.
+ */
+static int verify_object(unsigned char *sha1, const char *expected_type)
+{
+	int ret = -1;
+	enum object_type type;
+	unsigned long size;
+	void *buffer = read_sha1_file(sha1, &type, &size);
+
+	if (buffer) {
+		if (type == type_from_string(expected_type))
+			ret = check_sha1_signature(sha1, buffer, size, expected_type);
+		free(buffer);
+	}
+	return ret;
+}
+
+static int parse_and_verify_tag_buffer(struct tag *item,
+		const char *data, const unsigned long size, int thorough_verify)
 {
 #ifdef NO_C99_FORMAT
 #define PD_FMT "%d"
@@ -79,6 +98,10 @@ static int parse_tag_buffer_internal(struct tag *item, const char *data, const u
 	tagger_line = strchr(tag_line, '\n');
 	if (!tagger_line++)
 		return error("char" PD_FMT ": could not find next \"\\n\"", tag_line - data);
+	if (thorough_verify) {
+		if (memcmp(tagger_line, "tagger ", 7) || (tagger_line[7] == '\n'))
+			return error("char" PD_FMT ": could not find \"tagger\"", tagger_line - data);
+	}
 
 	/* Get the actual type */
 	type_len = tag_line - type_line - strlen("type \n");
@@ -87,6 +110,29 @@ static int parse_tag_buffer_internal(struct tag *item, const char *data, const u
 	memcpy(type, type_line + 5, type_len);
 	type[type_len] = '\0';
 
+	if (thorough_verify) {
+		unsigned long i;
+
+		/* Verify that the object matches */
+		if (verify_object(sha1, type))
+			return error("char%d: could not verify object %s", 7, sha1_to_hex(sha1));
+
+		/* Verify the tag-name: we don't allow control characters or spaces in it */
+		for (i = 4;;) {
+			unsigned char c = tag_line[i++];
+			if (c == '\n')
+				break;
+			if (c > ' ')
+				continue;
+			return error("char" PD_FMT ": could not verify tag name", tag_line + i - data);
+		}
+
+		/* Verify the tagger line */
+		/* TODO: check for committer/tagger info */
+
+		/* The actual stuff afterwards we don't care about.. */
+	}
+
 	if (item) {
 		tag_len = tagger_line - tag_line - strlen("tag \n");
 		item->tag = xmalloc(tag_len + 1);
@@ -120,7 +166,7 @@ static int parse_tag_buffer_internal(struct tag *item, const char *data, const u
 
 int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 {
-	return parse_tag_buffer_internal(item, (const char *) data, size);
+	return parse_and_verify_tag_buffer(item, (const char *) data, size, 0);
 }
 
 int parse_tag(struct tag *item)
-- 
1.5.2
