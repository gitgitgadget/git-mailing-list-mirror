From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] for-each-ref: handle multiline subjects like --pretty
Date: Wed, 7 Sep 2011 13:44:56 -0400
Message-ID: <20110907174456.GD11355@sigill.intra.peff.net>
References: <20110902175323.GA29761@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Sep 07 19:45:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1MBX-0002VF-0o
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 19:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721Ab1IGRpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 13:45:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37344
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752950Ab1IGRpD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 13:45:03 -0400
Received: (qmail 4012 invoked by uid 107); 7 Sep 2011 17:45:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Sep 2011 13:45:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2011 13:44:56 -0400
Content-Disposition: inline
In-Reply-To: <20110902175323.GA29761@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180888>

Generally the format of a git tag or commit message is:

  subject

  body body body
  body body body

However, we occasionally see multiline subjects like:

  subject
  with multiple
  lines

  body body body
  body body body

The rest of git treats these multiline subjects as something
to be concatenated and shown as a single line (e.g., "git
log --pretty=format:%s" will do so since f53bd74). For
consistency, for-each-ref should do the same with its
"%(subject)".

Signed-off-by: Jeff King <peff@peff.net>
---
I split this out from the signature patch to make it more obvious what's
going on.

 builtin/for-each-ref.c  |   29 ++++++++++++++++++++++++-----
 t/t6300-for-each-ref.sh |   21 +++++++++++++++++++++
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index bcea027..ea2112b 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -361,6 +361,18 @@ static const char *copy_email(const char *buf)
 	return xmemdupz(email, eoemail + 1 - email);
 }
 
+static char *copy_subject(const char *buf, unsigned long len)
+{
+	char *r = xmemdupz(buf, len);
+	int i;
+
+	for (i = 0; i < len; i++)
+		if (r[i] == '\n')
+			r[i] = ' ';
+
+	return r;
+}
+
 static void grab_date(const char *buf, struct atom_value *v, const char *atomname)
 {
 	const char *eoemail = strstr(buf, "> ");
@@ -476,10 +488,17 @@ static void find_subpos(const char *buf, unsigned long sz,
 
 	/* subject is first non-empty line */
 	*sub = buf;
-	/* subject goes to end of line */
-	eol = strchrnul(buf, '\n');
-	*sublen = eol - buf;
-	buf = eol;
+	/* subject goes to first empty line */
+	while (*buf && *buf != '\n') {
+		eol = strchrnul(buf, '\n');
+		if (*eol)
+			eol++;
+		buf = eol;
+	}
+	*sublen = buf - *sub;
+	/* drop trailing newline, if present */
+	if (*sublen && (*sub)[*sublen - 1] == '\n')
+		*sublen -= 1;
 
 	/* skip any empty lines */
 	while (*buf == '\n')
@@ -512,7 +531,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 				    &bodypos, &bodylen);
 
 		if (!strcmp(name, "subject"))
-			v->s = xmemdupz(subpos, sublen);
+			v->s = copy_subject(subpos, sublen);
 		else if (!strcmp(name, "body"))
 			v->s = xmemdupz(bodypos, bodylen);
 		else if (!strcmp(name, "contents"))
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 6fa4d52..0c9ff96 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -379,4 +379,25 @@ first body line
 second body line
 '
 
+test_expect_success 'create tag with multiline subject' '
+	cat >msg <<-\EOF &&
+		first subject line
+		second subject line
+
+		first body line
+		second body line
+	EOF
+	git tag -F msg multiline
+'
+test_atom refs/tags/multiline subject 'first subject line second subject line'
+test_atom refs/tags/multiline body 'first body line
+second body line
+'
+test_atom refs/tags/multiline contents 'first subject line
+second subject line
+
+first body line
+second body line
+'
+
 test_done
-- 
1.7.6.10.g62f04
