From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] for-each-ref: refactor subject and body placeholder
 parsing
Date: Wed, 7 Sep 2011 13:44:07 -0400
Message-ID: <20110907174407.GC11355@sigill.intra.peff.net>
References: <20110902175323.GA29761@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Sep 07 19:44:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1MAb-0001wV-LA
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 19:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908Ab1IGRoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 13:44:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37337
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755981Ab1IGRoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 13:44:09 -0400
Received: (qmail 3980 invoked by uid 107); 7 Sep 2011 17:44:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Sep 2011 13:44:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2011 13:44:07 -0400
Content-Disposition: inline
In-Reply-To: <20110902175323.GA29761@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180887>

The find_subpos function was a little hard to use, as well
as to read. It would sometimes write into the subject and
body pointers, and sometimes not. The body pointer sometimes
could be compared to subject, and sometimes not. When
actually duplicating the subject, the caller was forced to
figure out again how long the subject is (which is not too
big a deal when the subject is a single line, but hard to
extend).

The refactoring makes the function more straightforward, both
to read and to use. We will always put something into the
subject and body pointers, and we return explicit lengths
for them, too.

This lays the groundwork both for more complex subject
parsing (e.g., multiline), as well as splitting the body
into subparts (like the text versus the signature).

Signed-off-by: Jeff King <peff@peff.net>
---
Sorry, the patch is a little bit hard to read. It's probably simpler to
just apply and read the resulting function.

 builtin/for-each-ref.c |   54 +++++++++++++++++++++++++----------------------
 1 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 89e75c6..bcea027 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -458,38 +458,42 @@ static void grab_person(const char *who, struct atom_value *val, int deref, stru
 	}
 }
 
-static void find_subpos(const char *buf, unsigned long sz, const char **sub, const char **body)
+static void find_subpos(const char *buf, unsigned long sz,
+			const char **sub, unsigned long *sublen,
+			const char **body, unsigned long *bodylen)
 {
-	while (*buf) {
-		const char *eol = strchr(buf, '\n');
-		if (!eol)
-			return;
-		if (eol[1] == '\n') {
-			buf = eol + 1;
-			break; /* found end of header */
-		}
-		buf = eol + 1;
+	const char *eol;
+	/* skip past header until we hit empty line */
+	while (*buf && *buf != '\n') {
+		eol = strchrnul(buf, '\n');
+		if (*eol)
+			eol++;
+		buf = eol;
 	}
+	/* skip any empty lines */
 	while (*buf == '\n')
 		buf++;
-	if (!*buf)
-		return;
-	*sub = buf; /* first non-empty line */
-	buf = strchr(buf, '\n');
-	if (!buf) {
-		*body = "";
-		return; /* no body */
-	}
+
+	/* subject is first non-empty line */
+	*sub = buf;
+	/* subject goes to end of line */
+	eol = strchrnul(buf, '\n');
+	*sublen = eol - buf;
+	buf = eol;
+
+	/* skip any empty lines */
 	while (*buf == '\n')
-		buf++; /* skip blank between subject and body */
+		buf++;
 	*body = buf;
+	*bodylen = strlen(buf);
 }
 
 /* See grab_values */
 static void grab_sub_body_contents(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
 {
 	int i;
-	const char *subpos = NULL, *bodypos = NULL;
+	const char *subpos = NULL, *bodypos;
+	unsigned long sublen, bodylen;
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i];
@@ -503,14 +507,14 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 		    strcmp(name, "contents"))
 			continue;
 		if (!subpos)
-			find_subpos(buf, sz, &subpos, &bodypos);
-		if (!subpos)
-			return;
+			find_subpos(buf, sz,
+				    &subpos, &sublen,
+				    &bodypos, &bodylen);
 
 		if (!strcmp(name, "subject"))
-			v->s = copy_line(subpos);
+			v->s = xmemdupz(subpos, sublen);
 		else if (!strcmp(name, "body"))
-			v->s = xstrdup(bodypos);
+			v->s = xmemdupz(bodypos, bodylen);
 		else if (!strcmp(name, "contents"))
 			v->s = xstrdup(subpos);
 	}
-- 
1.7.6.10.g62f04
