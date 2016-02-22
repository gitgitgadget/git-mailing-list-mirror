From: Jeff King <peff@peff.net>
Subject: [PATCH v3 17/22] sequencer: simplify memory allocation of get_message
Date: Mon, 22 Feb 2016 17:44:57 -0500
Message-ID: <20160222224457.GQ10075@sigill.intra.peff.net>
References: <20160222224059.GA3857@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 23:45:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXzE4-0005WQ-7M
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:45:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756120AbcBVWpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:45:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:47119 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752980AbcBVWpA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:45:00 -0500
Received: (qmail 21776 invoked by uid 102); 22 Feb 2016 22:45:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:45:00 -0500
Received: (qmail 23208 invoked by uid 107); 22 Feb 2016 22:45:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:45:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 17:44:57 -0500
Content-Disposition: inline
In-Reply-To: <20160222224059.GA3857@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286988>

For a commit with sha1 "1234abcd" and subject "foo", this
function produces a struct with three strings:

 1. "foo"

 2. "1234abcd... foo"

 3. "parent of 1234abcd... foo"

It takes advantage of the fact that these strings are
subsets of each other, and allocates only _one_ string, with
pointers into the various parts. Unfortunately, this makes
the string allocation complicated and hard to follow.

Since we keep only one of these in memory at a time, we can
afford to simply allocate three strings. This lets us build
on tools like xstrfmt and avoid manual computation.

While we're here, we can also drop the ad-hoc
reimplementation of get_git_commit_encoding(), and simply
call that function.

Signed-off-by: Jeff King <peff@peff.net>
---
 sequencer.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8048786..e66f2fe 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -124,42 +124,33 @@ static const char *action_name(const struct replay_opts *opts)
 
 struct commit_message {
 	char *parent_label;
-	const char *label;
-	const char *subject;
+	char *label;
+	char *subject;
 	const char *message;
 };
 
 static int get_message(struct commit *commit, struct commit_message *out)
 {
 	const char *abbrev, *subject;
-	int abbrev_len, subject_len;
-	char *q;
-
-	if (!git_commit_encoding)
-		git_commit_encoding = "UTF-8";
+	int subject_len;
 
-	out->message = logmsg_reencode(commit, NULL, git_commit_encoding);
+	out->message = logmsg_reencode(commit, NULL, get_commit_output_encoding());
 	abbrev = find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV);
-	abbrev_len = strlen(abbrev);
 
 	subject_len = find_commit_subject(out->message, &subject);
 
-	out->parent_label = xmalloc(strlen("parent of ") + abbrev_len +
-			      strlen("... ") + subject_len + 1);
-	q = out->parent_label;
-	q = mempcpy(q, "parent of ", strlen("parent of "));
-	out->label = q;
-	q = mempcpy(q, abbrev, abbrev_len);
-	q = mempcpy(q, "... ", strlen("... "));
-	out->subject = q;
-	q = mempcpy(q, subject, subject_len);
-	*q = '\0';
+	out->subject = xmemdupz(subject, subject_len);
+	out->label = xstrfmt("%s... %s", abbrev, out->subject);
+	out->parent_label = xstrfmt("parent of %s", out->label);
+
 	return 0;
 }
 
 static void free_message(struct commit *commit, struct commit_message *msg)
 {
 	free(msg->parent_label);
+	free(msg->label);
+	free(msg->subject);
 	unuse_commit_buffer(commit, msg->message);
 }
 
-- 
2.7.2.645.g4e1306c
