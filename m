From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: [PATCH v3] pretty.c: add %x00 format specifier.
Date: Fri, 21 Mar 2008 10:05:06 -0500
Message-ID: <5d46db230803210805j95c6029m19b284836dcb504a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 16:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jcioe-0004OL-Dw
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 16:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332AbYCUPFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 11:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752954AbYCUPFO
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 11:05:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:44139 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871AbYCUPFM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 11:05:12 -0400
Received: by nf-out-0910.google.com with SMTP id g13so628868nfb.21
        for <git@vger.kernel.org>; Fri, 21 Mar 2008 08:05:08 -0700 (PDT)
Received: by 10.151.67.17 with SMTP id u17mr1623924ybk.75.1206111907117;
        Fri, 21 Mar 2008 08:05:07 -0700 (PDT)
Received: by 10.150.156.18 with HTTP; Fri, 21 Mar 2008 08:05:06 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77743>

This adds a %x00 format which parses the 00 as hex encoding for a byte and
prints the resulting byte.  This can be used to add null bytes or other bytes
that can make machine parsing easier.  It is also necessary to use fwrite to
print out the data since printf will terminate if you feed it a null.

Junio supplied the hex decoding.

Signed-off-by: Govind Salinas <blix@sophiasuchtig.com>
---
 Documentation/pretty-formats.txt |    1 +
 log-tree.c                       |    6 ++++--
 pretty.c                         |   11 +++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 0193c3c..e8bea3e 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -123,3 +123,4 @@ The placeholders are:
 - '%Creset': reset color
 - '%m': left, right or boundary mark
 - '%n': newline
+- '%x00': print a byte from a hex code
diff --git a/log-tree.c b/log-tree.c
index 608f697..3bb6e49 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -308,8 +308,10 @@ void show_log(struct rev_info *opt, const char *sep)
 	if (opt->show_log_size)
 		printf("log size %i\n", (int)msgbuf.len);

-	if (msgbuf.len)
-		printf("%s%s%s", msgbuf.buf, extra, sep);
+	if (msgbuf.len) {
+		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
+		printf("%s%s", extra, sep);
+	}
 	strbuf_release(&msgbuf);
 }

diff --git a/pretty.c b/pretty.c
index 703f521..cb4944c 100644
--- a/pretty.c
+++ b/pretty.c
@@ -457,6 +457,7 @@ static size_t format_commit_item(struct strbuf
*sb, const char *placeholder,
 	const struct commit *commit = c->commit;
 	const char *msg = commit->buffer;
 	struct commit_list *p;
+	int h1, h2;

 	/* these are independent of the commit */
 	switch (placeholder[0]) {
@@ -478,6 +479,16 @@ static size_t format_commit_item(struct strbuf
*sb, const char *placeholder,
 	case 'n':		/* newline */
 		strbuf_addch(sb, '\n');
 		return 1;
+	case 'x':
+		/* %x00 == NUL, %x0a == LF, etc. */
+		if (0 <= (h1 = hexval_table[0xff & placeholder[1]]) &&
+		    h1 <= 16 &&
+		    0 <= (h2 = hexval_table[0xff & placeholder[2]]) &&
+		    h2 <= 16) {
+			strbuf_addch(sb, (h1<<4)|h2);
+			return 3;
+		} else
+			return 0;
 	}

 	/* these depend on the commit */
-- 
1.5.4.4.552.g7113.dirty
