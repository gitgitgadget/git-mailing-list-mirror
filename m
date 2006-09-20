From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 1/2] for each ref add a raw timestamp field type
Date: Wed, 20 Sep 2006 11:31:19 +0100
Message-ID: <20060920103119.GA30145@shadowen.org>
References: <4511173D.7020702@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Sep 20 12:32:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPzMs-00069i-Hz
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 12:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWITKbn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 06:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWITKbm
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 06:31:42 -0400
Received: from 85-210-218-110.dsl.pipex.com ([85.210.218.110]:939 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751036AbWITKbm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 06:31:42 -0400
Received: from apw by localhost.localdomain with local (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1GPzMN-0007qI-F0; Wed, 20 Sep 2006 11:31:19 +0100
To: git@vger.kernel.org
Content-Disposition: inline
InReply-To: <4511173D.7020702@shadowen.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27338>

for-each-ref: add a raw timestamp field type

cvsimport is interested in the raw time stamps (in seconds since
the epoch) to do its time comparisons.  Export the raw timestamp under
{author,committer,tagger}stamp.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 698618b..9d6c4f0 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -51,14 +51,17 @@ static struct {
 	{ "authorname" },
 	{ "authoremail" },
 	{ "authordate", FIELD_TIME },
+	{ "authorstamp", FIELD_TIME },
 	{ "committer" },
 	{ "committername" },
 	{ "committeremail" },
 	{ "committerdate", FIELD_TIME },
+	{ "committerstamp", FIELD_TIME },
 	{ "tagger" },
 	{ "taggername" },
 	{ "taggeremail" },
 	{ "taggerdate", FIELD_TIME },
+	{ "taggerstamp", FIELD_TIME },
 	{ "subject" },
 	{ "body" },
 	{ "contents" },
@@ -344,9 +347,10 @@ static char *copy_email(const char *buf)
 	return line;
 }
 
-static void grab_date(const char *buf, struct atom_value *v)
+static void grab_date(const char *buf, struct atom_value *v, int raw)
 {
 	const char *eoemail = strstr(buf, "> ");
+	const char *eol = strchr(buf, '\n');
 	char *zone;
 	unsigned long timestamp;
 	long tz;
@@ -359,7 +363,15 @@ static void grab_date(const char *buf, s
 	tz = strtol(zone, NULL, 10);
 	if ((tz == LONG_MIN || tz == LONG_MAX) && errno == ERANGE)
 		goto bad;
-	v->s = xstrdup(show_date(timestamp, tz, 0));
+	if (raw) {
+		int len = (eol - eoemail - 2);
+		char *stamp = xmalloc(len + 1);
+
+		memcpy(stamp, eoemail + 2, len);
+		stamp[len] = 0;
+		v->s = stamp;
+	} else
+		v->s = xstrdup(show_date(timestamp, tz, 0));
 	v->ul = timestamp;
 	return;
  bad:
@@ -386,7 +398,8 @@ static void grab_person(const char *who,
 		if (name[wholen] != 0 &&
 		    strcmp(name + wholen, "name") &&
 		    strcmp(name + wholen, "email") &&
-		    strcmp(name + wholen, "date"))
+		    strcmp(name + wholen, "date") &&
+		    strcmp(name + wholen, "stamp"))
 			continue;
 		if (!wholine)
 			wholine = find_wholine(who, wholen, buf, sz);
@@ -399,7 +412,9 @@ static void grab_person(const char *who,
 		else if (!strcmp(name + wholen, "email"))
 			v->s = copy_email(wholine);
 		else if (!strcmp(name + wholen, "date"))
-			grab_date(wholine, v);
+			grab_date(wholine, v, 0);
+		else if (!strcmp(name + wholen, "stamp"))
+			grab_date(wholine, v, 1);
 	}
 }
 
