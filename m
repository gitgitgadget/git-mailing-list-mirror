From: Jeff King <peff@peff.net>
Subject: [PATCHv2] mailmap: handle mailmap blobs without trailing newlines
Date: Tue, 27 Aug 2013 21:41:39 -0400
Message-ID: <20130828014138.GA30623@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 28 03:41:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEUlW-0006Ic-B4
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 03:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529Ab3H1Blm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 21:41:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:51293 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884Ab3H1Blm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 21:41:42 -0400
Received: (qmail 18866 invoked by uid 102); 28 Aug 2013 01:41:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Aug 2013 20:41:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Aug 2013 21:41:39 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233173>

The read_mailmap_buf function reads each line of the mailmap
using strchrnul, like:

    const char *end = strchrnul(buf, '\n');
    unsigned long linelen = end - buf + 1;

But that's off-by-one when we actually hit the NUL byte; our
line does not have a terminator, and so is only "end - buf"
bytes long. As a result, when we subtract the linelen from
the total len, we end up with (unsigned long)-1 bytes left
in the buffer, and we start reading random junk from memory.

We could fix it with:

    unsigned long linelen = end - buf + !!*end;

but let's take a step back for a moment. It's questionable
in the first place for a function that takes a buffer and
length to be using strchrnul. But it works because we only
have one caller (and are only likely to ever have this one),
which is handing us data from read_sha1_file. Which means
that it's always NUL-terminated.

Instead of tightening the assumptions to make the
buffer/length pair work for a caller that doesn't actually
exist, let's let loosen the assumptions to what the real
caller has: a modifiable, NUL-terminated string.

This makes the code simpler and shorter (because we don't
have to correlate strchrnul with the length calculation),
correct (because the code with the off-by-one just goes
away), and more efficient (we can drop the extra allocation
we needed to create NUL-terminated strings for each line,
and just terminate in place).

Signed-off-by: Jeff King <peff@peff.net>
---
This is the squashed version to replace what's in
jk/mailmap-incomplete-line.

 mailmap.c          | 21 +++++++++------------
 t/t4203-mailmap.sh | 16 +++++++++++++++-
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index b16542f..caa7c6b 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -187,20 +187,17 @@ static void read_mailmap_buf(struct string_list *map,
 	return 0;
 }
 
-static void read_mailmap_buf(struct string_list *map,
-			     const char *buf, unsigned long len,
-			     char **repo_abbrev)
+static void read_mailmap_string(struct string_list *map, char *buf,
+				char **repo_abbrev)
 {
-	while (len) {
-		const char *end = strchrnul(buf, '\n');
-		unsigned long linelen = end - buf + 1;
-		char *line = xmemdupz(buf, linelen);
+	while (*buf) {
+		char *end = strchrnul(buf, '\n');
 
-		read_mailmap_line(map, line, repo_abbrev);
+		if (*end)
+			*end++ = '\0';
 
-		free(line);
-		buf += linelen;
-		len -= linelen;
+		read_mailmap_line(map, buf, repo_abbrev);
+		buf = end;
 	}
 }
 
@@ -224,7 +221,7 @@ static int read_mailmap_blob(struct string_list *map,
 	if (type != OBJ_BLOB)
 		return error("mailmap is not a blob: %s", name);
 
-	read_mailmap_buf(map, buf, size, repo_abbrev);
+	read_mailmap_string(map, buf, repo_abbrev);
 
 	free(buf);
 	return 0;
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index aae30d9..10c7b12 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -159,7 +159,8 @@ test_expect_success 'setup mailmap blob tests' '
 	Blob Guy <author@example.com>
 	Blob Guy <bugs@company.xx>
 	EOF
-	git add just-bugs both &&
+	printf "Tricky Guy <author@example.com>" >no-newline &&
+	git add just-bugs both no-newline &&
 	git commit -m "my mailmaps" &&
 	echo "Repo Guy <author@example.com>" >.mailmap &&
 	echo "Internal Guy <author@example.com>" >internal.map
@@ -243,6 +244,19 @@ test_expect_success 'mailmap.blob defaults to HEAD:.mailmap in bare repo' '
 	)
 '
 
+test_expect_success 'mailmap.blob can handle blobs without trailing newline' '
+	cat >expect <<-\EOF &&
+	Tricky Guy (1):
+	      initial
+
+	nick1 (1):
+	      second
+
+	EOF
+	git -c mailmap.blob=map:no-newline shortlog HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cleanup after mailmap.blob tests' '
 	rm -f .mailmap
 '
-- 
1.8.4.2.g87d4a77
