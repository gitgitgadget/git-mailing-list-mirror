From: Jeff King <peff@peff.net>
Subject: [PATCH] mailmap: handle mailmap blobs without trailing newlines
Date: Sun, 25 Aug 2013 04:45:51 -0400
Message-ID: <20130825084549.GA5912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 10:46:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDVxO-000661-UW
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 10:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756152Ab3HYIpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 04:45:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:54108 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756127Ab3HYIpx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 04:45:53 -0400
Received: (qmail 23896 invoked by uid 102); 25 Aug 2013 08:45:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 25 Aug 2013 03:45:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Aug 2013 04:45:51 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232938>

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

but it is questionable for a function called read_mailmap_buf
to be using strchrnul in the first place.  It happens to work
because our buffers come from blobs, and read_sha1_file always
NUL-terminates the object data. But let's future-proof the
function by actually handling non-terminated strings
correctly, and fix the off-by-one at the same time.

Signed-off-by: Jeff King <peff@peff.net>
---
Intended for 'maint'. The bug was introduced in 0861090, but I built the
fix on top of 8c473ce, the tip of the jk/mailmap-from-blob topic, as it
avoids annoying textual conflicts in the test script.

v1.8.2 was the first version with the bug, so this is not an "oops, we
failed to find this new bug during v1.8.4-rc series" problem. I found it
now because I turned on mailmap.blob for all of github.com, which
exposed the code to a much larger array of random inputs.

This is the minimal fix. Another option would be to switch
read_mailmap_buf to read_mailmap_string, and I think we could even get
away with avoiding the extra allocation/copy in the loop (because
read_mailmap_line seems to cope with newline-or-EOS just fine). But it
may be better to save that for 'master'.

 mailmap.c          | 12 +++++++++---
 t/t4203-mailmap.sh | 16 +++++++++++++++-
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index b16542f..a635873 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -192,10 +192,16 @@ static void read_mailmap_buf(struct string_list *map,
 			     char **repo_abbrev)
 {
 	while (len) {
-		const char *end = strchrnul(buf, '\n');
-		unsigned long linelen = end - buf + 1;
-		char *line = xmemdupz(buf, linelen);
+		const char *end = memchr(buf, '\n', len);
+		unsigned long linelen;
+		char *line;
 
+		if (end)
+			linelen = end - buf + 1;
+		else
+			linelen = len;
+
+		line = xmemdupz(buf, linelen);
 		read_mailmap_line(map, line, repo_abbrev);
 
 		free(line);
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
