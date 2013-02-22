From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH v2] git-commit: populate the edit buffer with 2 blank lines before s-o-b
Date: Fri, 22 Feb 2013 14:05:27 -0800
Message-ID: <1361570727-20255-1-git-send-email-bcasey@nvidia.com>
References: <CA+sFfMdok7wRDhgq7i=b3cu3LB+poExvxLBxYkg8L3pN92bEYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, <pclouds@gmail.com>, <jrnieder@gmail.com>,
	<john@keeping.me.uk>, Brandon Casey <drafnel@gmail.com>
To: <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 23:06:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U90ks-0005SO-T0
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 23:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757906Ab3BVWFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 17:05:46 -0500
Received: from hqemgate04.nvidia.com ([216.228.121.35]:6974 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757598Ab3BVWFp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 17:05:45 -0500
Received: from hqnvupgp06.nvidia.com (Not Verified[216.228.121.13]) by hqemgate04.nvidia.com
	id <B5127eba30000>; Fri, 22 Feb 2013 14:05:23 -0800
Received: from hqemhub01.nvidia.com ([172.17.108.22])
  by hqnvupgp06.nvidia.com (PGP Universal service);
  Fri, 22 Feb 2013 14:04:02 -0800
X-PGP-Universal: processed;
	by hqnvupgp06.nvidia.com on Fri, 22 Feb 2013 14:04:02 -0800
Received: from sc-xterm-14.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.297.1; Fri, 22 Feb 2013
 14:05:30 -0800
X-Mailer: git-send-email 1.8.1.3.566.gaa39828
In-Reply-To: <CA+sFfMdok7wRDhgq7i=b3cu3LB+poExvxLBxYkg8L3pN92bEYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216868>

From: Brandon Casey <drafnel@gmail.com>

Before commit 33f2f9ab, 'commit -s' would populate the edit buffer with
a blank line before the Signed-off-by line.  This provided a nice
hint to the user that something should be filled in.  Let's restore that
behavior, but now let's ensure that the Signed-off-by line is preceded
by two blank lines to hint that something should be filled in, and that
a blank line should separate it from the Signed-off-by line.

Plus, add a test for this behavior.

Reported-by: John Keeping <john@keeping.me.uk>
Signed-off-by: Brandon Casey <drafnel@gmail.com>
---

How about something like this?

-Brandon

 sequencer.c       | 27 +++++++++++++++++++++++++--
 t/t7502-commit.sh | 12 ++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 53ee49a..a07d2d0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1127,10 +1127,33 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
 		const char *append_newlines = NULL;
 		size_t len = msgbuf->len - ignore_footer;
 
-		if (len && msgbuf->buf[len - 1] != '\n')
+		if (!len) {
+			/*
+			 * The buffer is completely empty.  Leave foom for
+			 * the title and body to be filled in by the user.
+			 */
 			append_newlines = "\n\n";
-		else if (len > 1 && msgbuf->buf[len - 2] != '\n')
+		} else if (msgbuf->buf[len - 1] != '\n') {
+			/*
+			 * Incomplete line.  Complete the line and add a
+			 * blank one so that there is an empty line between
+			 * the message body and the sob.
+			 */
+			append_newlines = "\n\n";
+		} else if (len == 1) {
+			/*
+			 * Buffer contains a single newline.  Add another
+			 * so that we leave room for the title and body.
+			 */
+			append_newlines = "\n";
+		} else if (msgbuf->buf[len - 2] != '\n') {
+			/*
+			 * Buffer ends with a single newline.  Add another
+			 * so that there is an empty line between the message
+			 * body and the sob.
+			 */
 			append_newlines = "\n";
+		} /* else, the buffer already ends with two newlines. */
 
 		if (append_newlines)
 			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index deb187e..a53a1e0 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -349,6 +349,18 @@ test_expect_success 'A single-liner subject with a token plus colon is not a foo
 
 '
 
+test_expect_success 'commit -s places sob on third line after two empty lines' '
+	git commit -s --allow-empty --allow-empty-message &&
+	cat <<-EOF >expect &&
+
+
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+
+	EOF
+	egrep -v '^#' .git/COMMIT_EDITMSG >actual &&
+	test_cmp expect actual
+'
+
 write_script .git/FAKE_EDITOR <<\EOF
 mv "$1" "$1.orig"
 (
-- 
1.8.1.3.566.gaa39828
