From: Carl Worth <cworth@cworth.org>
Subject: [PATCH 1/2] mailsplit: Remove any '>' characters used to escape From_ lines in mbox.
Date: Tue,  8 Jun 2010 13:02:28 -0700
Message-ID: <1276027349-4064-1-git-send-email-cworth@cworth.org>
References: <87hbldjo0s.fsf@yoom.home.cworth.org>
Cc: Carl Worth <cworth@cworth.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 08 22:02:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM50X-0004to-N5
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 22:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866Ab0FHUCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 16:02:41 -0400
Received: from u15218177.onlinehome-server.com ([74.208.220.233]:45027 "EHLO
	olra.theworths.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983Ab0FHUCk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 16:02:40 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jun 2010 16:02:40 EDT
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 2A5B04196F3
	for <git@vger.kernel.org>; Tue,  8 Jun 2010 13:02:40 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TERQ7lgjQZB4; Tue,  8 Jun 2010 13:02:30 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 4434B431FC1;
	Tue,  8 Jun 2010 13:02:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <87hbldjo0s.fsf@yoom.home.cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148706>

In order to encode an email message in an mbox, a client must notice any
lines in the email body that look like so-called From_ lines, (that is
lines begin with "From "), and add a preceding '>' character.

>From Jonathan de Boyne Pollard[*] we learn of two long-standing (since 1995
at least) conventions used for this escaping. The original "mboxo" format
does only the escaping described above, which leads to unavoidable
corruption of some messages. The newer "mboxrd" format also adds a '>' to
any line originally beginning with one or more '>' characters followed by
"From ". This ensures that the original email can be extracted without
corruption.

Git wasn't formerly un-escaping these lines in any case, so invocations of
"git am" would lead to errant '>' characters in the commit message. Here,
we now fix git-mailsplit to perform the necessary un-escaping. We assume
mboxrd format, since designing for the original mboxo format would
guarantee corruption in at least some cases.

[*] http://homepage.ntlworld.com/jonathan.deboynepollard/FGA/mail-mbox-formats.html

Signed-off-by: Carl Worth <cworth@cworth.org>
---
 builtin/mailsplit.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index cdfc1b7..a3fb9f7 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -46,6 +46,30 @@ static int is_from_line(const char *line, int len)
 static struct strbuf buf = STRBUF_INIT;
 static int keep_cr;
 
+/* Write the line in 'buf' to 'output', but if we are splitting an mbox,
+ * then remove the first '>' from any line that begins with one or more
+ * '>' characters followed by "From ".
+ *
+ * Return 0 if successful, 1 for any write error.
+ */
+static int write_buf_unescaping(FILE *output, int is_mbox)
+{
+	const char *line = buf.buf;
+	size_t len = buf.len;
+
+	if (is_mbox && *line == '>') {
+		const char *s = line;
+		while (*s == '>')
+			s++;
+		if (strncmp (s, "From ", 5) == 0) {
+			line = line + 1;
+			len = len - 1;
+		}
+	}
+
+	return fwrite(line, 1, len, output) != len;
+}
+
 /* Called with the first line (potentially partial)
  * already in buf[] -- normally that should begin with
  * the Unix "From " line.  Write it into the specified
@@ -76,7 +100,7 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 			strbuf_addch(&buf, '\n');
 		}
 
-		if (fwrite(buf.buf, 1, buf.len, output) != buf.len)
+		if (write_buf_unescaping(output, !is_bare))
 			die_errno("cannot write output");
 
 		if (strbuf_getwholeline(&buf, mbox, '\n')) {
-- 
1.7.0.4
