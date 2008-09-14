From: Lars Hjemli <hjemli@gmail.com>
Subject: [CGIT PATCH] parsing.c: handle unexpected commit/tag content
Date: Sun, 14 Sep 2008 09:53:02 +0200
Message-ID: <1221378782-26036-1-git-send-email-hjemli@gmail.com>
References: <8c5c35580809131302w1f51f4ebsede59eb2ae36a99c@mail.gmail.com>
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: pasky@suse.cz
X-From: git-owner@vger.kernel.org Sun Sep 14 10:14:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KemkY-0002ok-OQ
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 10:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbYININR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2008 04:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbYININR
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 04:13:17 -0400
Received: from mail42.e.nsc.no ([193.213.115.42]:46065 "EHLO mail42.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbYININP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 04:13:15 -0400
X-Greylist: delayed 1246 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Sep 2008 04:13:14 EDT
Received: from localhost.localdomain (ti0025a380-2174.bb.online.no [80.213.203.130])
	by mail42.nsc.no (8.13.8/8.13.5) with ESMTP id m8E7qOkA027570;
	Sun, 14 Sep 2008 09:52:24 +0200 (MEST)
X-Mailer: git-send-email 1.6.0.rc1
In-Reply-To: <8c5c35580809131302w1f51f4ebsede59eb2ae36a99c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95822>

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

Can you test this on top of the current master? It seems to fix the problems
with glibc.git.


 cgit.h    |    2 +-
 parsing.c |  108 +++++++++++++++++++++++++++++++++++++++---------------------
 2 files changed, 71 insertions(+), 39 deletions(-)

diff --git a/cgit.h b/cgit.h
index 1615616..08fd95a 100644
--- a/cgit.h
+++ b/cgit.h
@@ -85,7 +85,7 @@ struct commitinfo {
 struct taginfo {
 	char *tagger;
 	char *tagger_email;
-	int tagger_date;
+	unsigned long tagger_date;
 	char *msg;
 };

diff --git a/parsing.c b/parsing.c
index 66e8b3d..0396133 100644
--- a/parsing.c
+++ b/parsing.c
@@ -62,6 +62,40 @@ char *substr(const char *head, const char *tail)
 	return buf;
 }

+char *parse_user(char *t, char **name, char **email, unsigned long *date)
+{
+	char *p = t;
+	int mode = 1;
+
+	while (p && *p) {
+		if (mode == 1 && *p == '<') {
+			*name = substr(t, p - 1);
+			t = p;
+			mode++;
+		} else if (mode == 1 && *p == '\n') {
+			*name = substr(t, p);
+			p++;
+			break;
+		} else if (mode == 2 && *p == '>') {
+			*email = substr(t, p + 1);
+			t = p;
+			mode++;
+		} else if (mode == 2 && *p == '\n') {
+			*email = substr(t, p);
+			p++;
+			break;
+		} else if (mode == 3 && isdigit(*p)) {
+			*date = atol(p);
+			mode++;
+		} else if (*p == '\n') {
+			p++;
+			break;
+		}
+		p++;
+	}
+	return p;
+}
+
 struct commitinfo *cgit_parse_commit(struct commit *commit)
 {
 	struct commitinfo *ret;
@@ -88,29 +122,17 @@ struct commitinfo *cgit_parse_commit(struct commit *commit)
 	while (!strncmp(p, "parent ", 7))
 		p += 48; // "parent " + hex[40] + "\n"

-	if (!strncmp(p, "author ", 7)) {
-		p += 7;
-		t = strchr(p, '<') - 1;
-		ret->author = substr(p, t);
-		p = t;
-		t = strchr(t, '>') + 1;
-		ret->author_email = substr(p, t);
-		ret->author_date = atol(t+1);
-		p = strchr(t, '\n') + 1;
+	if (p && !strncmp(p, "author ", 7)) {
+		p = parse_user(p + 7, &ret->author, &ret->author_email,
+			&ret->author_date);
 	}

-	if (!strncmp(p, "committer ", 9)) {
-		p += 9;
-		t = strchr(p, '<') - 1;
-		ret->committer = substr(p, t);
-		p = t;
-		t = strchr(t, '>') + 1;
-		ret->committer_email = substr(p, t);
-		ret->committer_date = atol(t+1);
-		p = strchr(t, '\n') + 1;
+	if (p && !strncmp(p, "committer ", 9)) {
+		p = parse_user(p + 9, &ret->committer, &ret->committer_email,
+			&ret->committer_date);
 	}

-	if (!strncmp(p, "encoding ", 9)) {
+	if (p && !strncmp(p, "encoding ", 9)) {
 		p += 9;
 		t = strchr(p, '\n') + 1;
 		ret->msg_encoding = substr(p, t);
@@ -118,25 +140,38 @@ struct commitinfo *cgit_parse_commit(struct commit *commit)
 	} else
 		ret->msg_encoding = xstrdup(PAGE_ENCODING);

-	while (*p && (*p != '\n'))
-		p = strchr(p, '\n') + 1; // skip unknown header fields
+	// skip unknown header fields
+	while (p && *p && (*p != '\n')) {
+		p = strchr(p, '\n');
+		if (p)
+			p++;
+	}

-	while (*p == '\n')
-		p = strchr(p, '\n') + 1;
+	// skip extra blank lines between headers and message body
+	while (p && *p == '\n') {
+		p = strchr(p, '\n');
+		if (p)
+			p++;
+	}

 	t = strchr(p, '\n');
 	if (t) {
-		if (*t == '\0')
+		if (*t == '\0') {
 			ret->subject = "** empty **";
-		else
+			return ret;
+		} else {
 			ret->subject = substr(p, t);
-		p = t + 1;
+			p = t + 1;
+		}

-		while (*p == '\n')
-			p = strchr(p, '\n') + 1;
+		while (p && *p == '\n') {
+			p = strchr(p, '\n');
+			if (p)
+				p++;
+		}
 		ret->msg = xstrdup(p);
 	} else
-		ret->subject = substr(p, p+strlen(p));
+		ret->subject = xstrdup(p);

 	if(strcmp(ret->msg_encoding, PAGE_ENCODING)) {
 		t = reencode_string(ret->subject, PAGE_ENCODING,
@@ -163,7 +198,7 @@ struct taginfo *cgit_parse_tag(struct tag *tag)
 	void *data;
 	enum object_type type;
 	unsigned long size;
-	char *p, *t;
+	char *p;
 	struct taginfo *ret;

 	data = read_sha1_file(tag->object.sha1, &type, &size);
@@ -185,15 +220,12 @@ struct taginfo *cgit_parse_tag(struct tag *tag)
 			break;

 		if (!strncmp(p, "tagger ", 7)) {
-			p += 7;
-			t = strchr(p, '<') - 1;
-			ret->tagger = substr(p, t);
-			p = t;
-			t = strchr(t, '>') + 1;
-			ret->tagger_email = substr(p, t);
-			ret->tagger_date = atol(t+1);
+			p = parse_user(p + 7, &ret->tagger, &ret->tagger_email,
+				&ret->tagger_date);
 		}
-		p = strchr(p, '\n') + 1;
+		p = strchr(p, '\n');
+		if (p)
+			p++;
 	}

 	while (p && *p && (*p != '\n'))
--
1.6.0.rc1
