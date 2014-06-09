From: Jeff King <peff@peff.net>
Subject: [PATCH 05/15] sequencer: use logmsg_reencode in get_message
Date: Mon, 9 Jun 2014 14:10:39 -0400
Message-ID: <20140609181039.GE20315@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 20:10:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu41s-0006um-VD
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 20:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbaFISKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 14:10:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:40353 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753715AbaFISKk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 14:10:40 -0400
Received: (qmail 15708 invoked by uid 102); 9 Jun 2014 18:10:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Jun 2014 13:10:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jun 2014 14:10:39 -0400
Content-Disposition: inline
In-Reply-To: <20140609180236.GA24644@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251091>

This simplifies the code, as logmsg_reencode handles the
reencoding for us in a single call. It also means we learn
logmsg_reencode's trick of pulling the buffer from disk when
commit->buffer is NULL (we currently just silently return!).
It is doubtful this matters in practice, though, as
sequencer operations would not generally turn off
save_commit_buffer.

Note that we may be fixing a bug here. The existing code
does:

  if (same_encoding(to, from))
	  reencode_string(buf, to, from);

That probably should have been "!same_encoding".

Signed-off-by: Jeff King <peff@peff.net>
---
I didn't actually test for the bug, so it's possible that I'm missing
something clever...

 sequencer.c | 45 +++++----------------------------------------
 1 file changed, 5 insertions(+), 40 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0a80c58..3fcab4d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -116,39 +116,23 @@ static const char *action_name(const struct replay_opts *opts)
 	return opts->action == REPLAY_REVERT ? "revert" : "cherry-pick";
 }
 
-static char *get_encoding(const char *message);
-
 struct commit_message {
 	char *parent_label;
 	const char *label;
 	const char *subject;
-	char *reencoded_message;
 	const char *message;
 };
 
 static int get_message(struct commit *commit, struct commit_message *out)
 {
-	const char *encoding;
 	const char *abbrev, *subject;
 	int abbrev_len, subject_len;
 	char *q;
 
-	if (!commit->buffer)
-		return -1;
-	encoding = get_encoding(commit->buffer);
-	if (!encoding)
-		encoding = "UTF-8";
 	if (!git_commit_encoding)
 		git_commit_encoding = "UTF-8";
 
-	out->reencoded_message = NULL;
-	out->message = commit->buffer;
-	if (same_encoding(encoding, git_commit_encoding))
-		out->reencoded_message = reencode_string(commit->buffer,
-					git_commit_encoding, encoding);
-	if (out->reencoded_message)
-		out->message = out->reencoded_message;
-
+	out->message = logmsg_reencode(commit, NULL, git_commit_encoding);
 	abbrev = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
 	abbrev_len = strlen(abbrev);
 
@@ -167,29 +151,10 @@ static int get_message(struct commit *commit, struct commit_message *out)
 	return 0;
 }
 
-static void free_message(struct commit_message *msg)
+static void free_message(struct commit *commit, struct commit_message *msg)
 {
 	free(msg->parent_label);
-	free(msg->reencoded_message);
-}
-
-static char *get_encoding(const char *message)
-{
-	const char *p = message, *eol;
-
-	while (*p && *p != '\n') {
-		for (eol = p + 1; *eol && *eol != '\n'; eol++)
-			; /* do nothing */
-		if (starts_with(p, "encoding ")) {
-			char *result = xmalloc(eol - 8 - p);
-			strlcpy(result, p + 9, eol - 8 - p);
-			return result;
-		}
-		p = eol;
-		if (*p == '\n')
-			p++;
-	}
-	return NULL;
+	logmsg_free(msg->message, commit);
 }
 
 static void write_cherry_pick_head(struct commit *commit, const char *pseudoref)
@@ -489,7 +454,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
 	const char *base_label, *next_label;
-	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
+	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	char *defmsg = NULL;
 	struct strbuf msgbuf = STRBUF_INIT;
 	int res, unborn = 0, allow;
@@ -654,7 +619,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		res = run_git_commit(defmsg, opts, allow);
 
 leave:
-	free_message(&msg);
+	free_message(commit, &msg);
 	free(defmsg);
 
 	return res;
-- 
2.0.0.729.g520999f
