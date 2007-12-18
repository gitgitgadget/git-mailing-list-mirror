From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git show <tag>: show the tagger
Date: Tue, 18 Dec 2007 18:01:33 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712181800250.23902@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 18 19:02:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4glg-0002jk-H5
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 19:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879AbXLRSBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 13:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753778AbXLRSBt
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 13:01:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:57013 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752851AbXLRSBs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 13:01:48 -0500
Received: (qmail invoked by alias); 18 Dec 2007 18:01:46 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp020) with SMTP; 18 Dec 2007 19:01:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+RA1Jm8U2R7w0bpaWxH7b+tw4rlMHkyCJjqwHOtc
	veObcMl7zFF7M3
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68790>


For commit objects, the Author is shown, so do the equivalent for
tag objects, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I know, it's feature freeze period.  But this is arguably a 
	usability bug.

	Well, it's not _that_ serious, so it could wait for 2.0.0, too ;-)

 builtin-log.c |   39 ++++++++++++++++++++++++++++++++-------
 1 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index cc3cc90..c2ad863 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -244,7 +244,29 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	return cmd_log_walk(&rev);
 }
 
-static int show_object(const unsigned char *sha1, int suppress_header)
+static void show_tagger(char *buf, int len, struct rev_info *rev)
+{
+	char *email_end, *p;
+	unsigned long date;
+	int tz;
+
+	email_end = memchr(buf, '>', len);
+	if (!email_end)
+		return;
+	p = ++email_end;
+	while (isspace(*p))
+		p++;
+	date = strtoul(p, &p, 10);
+	while (isspace(*p))
+		p++;
+	tz = (int)strtol(p, NULL, 10);
+	printf("Tagger: %.*s\nDate:   %s\n",
+			email_end - buf, buf,
+			show_date(date, tz, rev->date_mode));
+}
+
+static int show_object(const unsigned char *sha1, int show_tag_object,
+	struct rev_info *rev)
 {
 	unsigned long size;
 	enum object_type type;
@@ -254,11 +276,14 @@ static int show_object(const unsigned char *sha1, int suppress_header)
 	if (!buf)
 		return error("Could not read object %s", sha1_to_hex(sha1));
 
-	if (suppress_header)
-		while (offset < size && buf[offset++] != '\n') {
-			int new_offset = offset;
+	if (show_tag_object)
+		while (offset < size && buf[offset] != '\n') {
+			int new_offset = offset + 1;
 			while (new_offset < size && buf[new_offset++] != '\n')
 				; /* do nothing */
+			if (!prefixcmp(buf + offset, "tagger "))
+				show_tagger(buf + offset + 7,
+					    new_offset - offset - 7, rev);
 			offset = new_offset;
 		}
 
@@ -299,16 +324,16 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 		const char *name = objects[i].name;
 		switch (o->type) {
 		case OBJ_BLOB:
-			ret = show_object(o->sha1, 0);
+			ret = show_object(o->sha1, 0, NULL);
 			break;
 		case OBJ_TAG: {
 			struct tag *t = (struct tag *)o;
 
-			printf("%stag %s%s\n\n",
+			printf("%stag %s%s\n",
 					diff_get_color_opt(&rev.diffopt, DIFF_COMMIT),
 					t->tag,
 					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
-			ret = show_object(o->sha1, 1);
+			ret = show_object(o->sha1, 1, &rev);
 			objects[i].item = (struct object *)t->tagged;
 			i--;
 			break;
-- 
1.5.4.rc0.70.g30f7
