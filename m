From: =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
Subject: [PATCH] for-each-ref: add split message parts to %(contents:*).
Date: Wed, 31 Aug 2011 11:11:49 +0200
Message-ID: <1314781909-19252-1-git-send-email-mgorny@gentoo.org>
References: <4E5CB0D0.7000905@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 31 11:10:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qygoh-00077z-PL
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 11:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754835Ab1HaJKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 05:10:34 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:49773 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753124Ab1HaJKd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 05:10:33 -0400
Received: from localhost.localdomain (unknown [81.219.205.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mgorny)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 7A2A31B4011;
	Wed, 31 Aug 2011 09:10:31 +0000 (UTC)
X-Mailer: git-send-email 1.7.6.1
In-Reply-To: <4E5CB0D0.7000905@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180459>

Now %(contents:subject) contains the message subject, %(contents:body)
main body part and %(contents:signature) GPG signature.
---
 Documentation/git-for-each-ref.txt |    7 ++++---
 builtin/for-each-ref.c             |   22 +++++++++++++++++-----
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 152e695..c872b88 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -101,9 +101,10 @@ Fields that have name-email-date tuple as its value (`author`,
 `committer`, and `tagger`) can be suffixed with `name`, `email`,
 and `date` to extract the named component.
 
-The first line of the message in a commit and tag object is
-`subject`, the remaining lines are `body`.  The whole message
-is `contents`.
+The complete message in a commit and tag object is `contents`.
+Its first line is `contents:subject`, the remaining lines
+are `contents:body` and the optional GPG signature
+is `contents:signature`.
 
 For sorting purposes, fields with numeric values sort in numeric
 order (`objectsize`, `authordate`, `committerdate`, `taggerdate`).
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 89e75c6..4854ab4 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -69,6 +69,9 @@ static struct {
 	{ "subject" },
 	{ "body" },
 	{ "contents" },
+	{ "contents:subject" },
+	{ "contents:body" },
+	{ "contents:signature" },
 	{ "upstream" },
 	{ "symref" },
 	{ "flag" },
@@ -458,7 +461,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, stru
 	}
 }
 
-static void find_subpos(const char *buf, unsigned long sz, const char **sub, const char **body)
+static void find_subpos(const char *buf, unsigned long sz, const char **sub, const char **body, const char **signature)
 {
 	while (*buf) {
 		const char *eol = strchr(buf, '\n');
@@ -478,18 +481,20 @@ static void find_subpos(const char *buf, unsigned long sz, const char **sub, con
 	buf = strchr(buf, '\n');
 	if (!buf) {
 		*body = "";
+		*signature = *body;
 		return; /* no body */
 	}
 	while (*buf == '\n')
 		buf++; /* skip blank between subject and body */
 	*body = buf;
+	*signature = buf + parse_signature(buf, strlen(buf));
 }
 
 /* See grab_values */
 static void grab_sub_body_contents(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
 {
 	int i;
-	const char *subpos = NULL, *bodypos = NULL;
+	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i];
@@ -500,19 +505,26 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 			name++;
 		if (strcmp(name, "subject") &&
 		    strcmp(name, "body") &&
-		    strcmp(name, "contents"))
+		    strcmp(name, "contents") &&
+		    strcmp(name, "contents:subject") &&
+		    strcmp(name, "contents:body") &&
+		    strcmp(name, "contents:signature"))
 			continue;
 		if (!subpos)
-			find_subpos(buf, sz, &subpos, &bodypos);
+			find_subpos(buf, sz, &subpos, &bodypos, &sigpos);
 		if (!subpos)
 			return;
 
-		if (!strcmp(name, "subject"))
+		if (!strcmp(name, "subject") || !strcmp(name, "contents:subject"))
 			v->s = copy_line(subpos);
 		else if (!strcmp(name, "body"))
 			v->s = xstrdup(bodypos);
 		else if (!strcmp(name, "contents"))
 			v->s = xstrdup(subpos);
+		else if (!strcmp(name, "contents:body"))
+			v->s = xstrndup(bodypos, sigpos - bodypos);
+		else if (!strcmp(name, "contents:signature"))
+			v->s = xstrdup(sigpos);
 	}
 }
 
-- 
1.7.6.1
