From: Jeff King <peff@peff.net>
Subject: [PATCH v2] reuse cached commit buffer when parsing signatures
Date: Fri, 13 Jun 2014 02:32:11 -0400
Message-ID: <20140613063211.GA7552@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
 <20140610213509.GA26979@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 08:32:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvL29-0006DT-U0
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 08:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbaFMGcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 02:32:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:43188 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751866AbaFMGcN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 02:32:13 -0400
Received: (qmail 6023 invoked by uid 102); 13 Jun 2014 06:32:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 01:32:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 02:32:11 -0400
Content-Disposition: inline
In-Reply-To: <20140610213509.GA26979@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251518>

On Tue, Jun 10, 2014 at 05:35:09PM -0400, Jeff King wrote:

> Here's a re-roll of the commit-slab series.

And here is a re-roll of the --show-signature speedup on top (i.e., the
point of the series in the first place), adjusted to use
get_commit_buffer.

-- >8 --
Subject: reuse cached commit buffer when parsing signatures

When we call show_signature or show_mergetag, we read the
commit object fresh via read_sha1_file and reparse its
headers. However, in most cases we already have the object
data available, attached to the "struct commit". This is
partially laziness in dealing with the memory allocation
issues, but partially defensive programming, in that we
would always want to verify a clean version of the buffer
(not one that might have been munged by other users of the
commit).

However, we do not currently ever munge the commit buffer,
and not using the already-available buffer carries a fairly
big performance penalty when we are looking at a large
number of commits. Here are timings on linux.git:

  [baseline, no signatures]
  $ time git log >/dev/null
  real    0m4.902s
  user    0m4.784s
  sys     0m0.120s

  [before]
  $ time git log --show-signature >/dev/null
  real    0m14.735s
  user    0m9.964s
  sys     0m0.944s

  [after]
  $ time git log --show-signature >/dev/null
  real    0m9.981s
  user    0m5.260s
  sys     0m0.936s

Note that our user CPU time drops almost in half, close to
the non-signature case, but we do still spend more
wall-clock and system time, presumably from dealing with
gpg.

An alternative to this is to note that most commits do not
have signatures (less than 1% in this repo), yet we pay the
re-parsing cost for every commit just to find out if it has
a mergetag or signature. If we checked that when parsing the
commit initially, we could avoid re-examining most commits
later on. Even if we did pursue that direction, however,
this would still speed up the cases where we _do_ have
signatures. So it's probably worth doing either way.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c   | 27 ++++++++++-----------------
 commit.h   |  2 +-
 log-tree.c |  2 +-
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/commit.c b/commit.c
index a036e18..ebd7ad8 100644
--- a/commit.c
+++ b/commit.c
@@ -1138,17 +1138,14 @@ static int do_sign_commit(struct strbuf *buf, const char *keyid)
 	return 0;
 }
 
-int parse_signed_commit(const unsigned char *sha1,
+int parse_signed_commit(const struct commit *commit,
 			struct strbuf *payload, struct strbuf *signature)
 {
+
 	unsigned long size;
-	enum object_type type;
-	char *buffer = read_sha1_file(sha1, &type, &size);
+	const char *buffer = get_commit_buffer(commit, &size);
 	int in_signature, saw_signature = -1;
-	char *line, *tail;
-
-	if (!buffer || type != OBJ_COMMIT)
-		goto cleanup;
+	const char *line, *tail;
 
 	line = buffer;
 	tail = buffer + size;
@@ -1156,7 +1153,7 @@ int parse_signed_commit(const unsigned char *sha1,
 	saw_signature = 0;
 	while (line < tail) {
 		const char *sig = NULL;
-		char *next = memchr(line, '\n', tail - line);
+		const char *next = memchr(line, '\n', tail - line);
 
 		next = next ? next + 1 : tail;
 		if (in_signature && line[0] == ' ')
@@ -1177,8 +1174,7 @@ int parse_signed_commit(const unsigned char *sha1,
 		}
 		line = next;
 	}
- cleanup:
-	free(buffer);
+	unuse_commit_buffer(commit, buffer);
 	return saw_signature;
 }
 
@@ -1269,8 +1265,7 @@ void check_commit_signature(const struct commit* commit, struct signature_check
 
 	sigc->result = 'N';
 
-	if (parse_signed_commit(commit->object.sha1,
-				&payload, &signature) <= 0)
+	if (parse_signed_commit(commit, &payload, &signature) <= 0)
 		goto out;
 	status = verify_signed_buffer(payload.buf, payload.len,
 				      signature.buf, signature.len,
@@ -1315,11 +1310,9 @@ struct commit_extra_header *read_commit_extra_headers(struct commit *commit,
 {
 	struct commit_extra_header *extra = NULL;
 	unsigned long size;
-	enum object_type type;
-	char *buffer = read_sha1_file(commit->object.sha1, &type, &size);
-	if (buffer && type == OBJ_COMMIT)
-		extra = read_commit_extra_header_lines(buffer, size, exclude);
-	free(buffer);
+	const char *buffer = get_commit_buffer(commit, &size);
+	extra = read_commit_extra_header_lines(buffer, size, exclude);
+	unuse_commit_buffer(commit, buffer);
 	return extra;
 }
 
diff --git a/commit.h b/commit.h
index 61559a9..2e1492a 100644
--- a/commit.h
+++ b/commit.h
@@ -325,7 +325,7 @@ struct merge_remote_desc {
  */
 struct commit *get_merge_parent(const char *name);
 
-extern int parse_signed_commit(const unsigned char *sha1,
+extern int parse_signed_commit(const struct commit *commit,
 			       struct strbuf *message, struct strbuf *signature);
 extern void print_commit_list(struct commit_list *list,
 			      const char *format_cur,
diff --git a/log-tree.c b/log-tree.c
index 4447021..10e6844 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -376,7 +376,7 @@ static void show_signature(struct rev_info *opt, struct commit *commit)
 	struct strbuf gpg_output = STRBUF_INIT;
 	int status;
 
-	if (parse_signed_commit(commit->object.sha1, &payload, &signature) <= 0)
+	if (parse_signed_commit(commit, &payload, &signature) <= 0)
 		goto out;
 
 	status = verify_signed_buffer(payload.buf, payload.len,
-- 
2.0.0.566.gfe3e6b2
