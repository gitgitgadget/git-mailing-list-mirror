From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] git log: support "auto" decorations
Date: Fri, 30 May 2014 14:34:41 -0400
Message-ID: <20140530183441.GA3704@sigill.intra.peff.net>
References: <alpine.LFD.2.11.1405291523520.8270@i7.linux-foundation.org>
 <20140530015855.GG28683@sigill.intra.peff.net>
 <CA+55aFzwy09-i=hpBy-5bYS6eowGzkdcF65cFJpL2qnJvYq85w@mail.gmail.com>
 <20140530065737.GA13591@sigill.intra.peff.net>
 <xmqqvbsn9pfx.fsf@gitster.dls.corp.google.com>
 <20140530170330.GA25443@sigill.intra.peff.net>
 <xmqqmwdz9nl9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 30 20:34:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqRdf-0004Ac-Ko
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 20:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbaE3Seo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 14:34:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:34329 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751339AbaE3Sen (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 14:34:43 -0400
Received: (qmail 23727 invoked by uid 102); 30 May 2014 18:34:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 May 2014 13:34:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 May 2014 14:34:41 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmwdz9nl9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250463>

On Fri, May 30, 2014 at 10:35:14AM -0700, Junio C Hamano wrote:

> > Do you want me to roll it up with a real commit message?
> 
> Yes.  I think the change is sensible.

Here it is. We may want to make these helper functions available to
other callers so they can use the same trick, but I do not know offhand
of any others that would want it. pretty.c is the obvious place, and it
already uses a similar trick in logmsg_reencode (and I would expect most
users of the commit message would actually want the reencoded version,
and would use that).

-- >8 --
Subject: [PATCH] reuse commit->buffer when parsing signatures

When we call show_signature or show_mergetag, we read the
commit object fresh via read_sha1_file and reparse its
headers. However, in most cases we already have the object
data available as commit->buffer.  This is partially
laziness in dealing with the memory allocation issues, but
partially defensive programming, in that we would always
want to verify a clean version of the buffer (not one that
might have been munged by other users of the commit).

However, we do not currently ever munge commit->buffer, and
not using the already-available buffer carries a fairly big
performance penalty when we are looking at a large number of
commits. Here are timings on linux.git:

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
 commit.c   | 44 ++++++++++++++++++++++++++++++++++++--------
 commit.h   |  2 +-
 log-tree.c |  2 +-
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/commit.c b/commit.c
index f479331..9e2abf7 100644
--- a/commit.c
+++ b/commit.c
@@ -1080,14 +1080,42 @@ static int do_sign_commit(struct strbuf *buf, const char *keyid)
 	return 0;
 }
 
-int parse_signed_commit(const unsigned char *sha1,
+/*
+ * Return the contents of the object pointed to by commit, as
+ * if read by read_sha1_file. However, in cases where the commit's
+ * data is already in memory, return that as an optimization.
+ *
+ * The resulting buffer may or may not be freshly allocated,
+ * and should only be freed by free_commit_buffer.
+ */
+static const char *read_commit_buffer(const struct commit *commit,
+				      enum object_type *type,
+				      unsigned long *size)
+{
+	if (commit->buffer) {
+		*type = OBJ_COMMIT;
+		*size = strlen(commit->buffer);
+		return commit->buffer;
+	}
+
+	return read_sha1_file(commit->object.sha1, type, size);
+}
+
+static void free_commit_buffer(const char *buffer, const struct commit *commit)
+{
+	if (buffer != commit->buffer)
+		free((char *)buffer);
+}
+
+int parse_signed_commit(const struct commit *commit,
 			struct strbuf *payload, struct strbuf *signature)
 {
+
 	unsigned long size;
 	enum object_type type;
-	char *buffer = read_sha1_file(sha1, &type, &size);
+	const char *buffer = read_commit_buffer(commit, &type, &size);
 	int in_signature, saw_signature = -1;
-	char *line, *tail;
+	const char *line, *tail;
 
 	if (!buffer || type != OBJ_COMMIT)
 		goto cleanup;
@@ -1098,7 +1126,7 @@ int parse_signed_commit(const unsigned char *sha1,
 	saw_signature = 0;
 	while (line < tail) {
 		const char *sig = NULL;
-		char *next = memchr(line, '\n', tail - line);
+		const char *next = memchr(line, '\n', tail - line);
 
 		next = next ? next + 1 : tail;
 		if (in_signature && line[0] == ' ')
@@ -1120,7 +1148,7 @@ int parse_signed_commit(const unsigned char *sha1,
 		line = next;
 	}
  cleanup:
-	free(buffer);
+	free_commit_buffer(buffer, commit);
 	return saw_signature;
 }
 
@@ -1211,7 +1239,7 @@ void check_commit_signature(const struct commit* commit, struct signature_check
 
 	sigc->result = 'N';
 
-	if (parse_signed_commit(commit->object.sha1,
+	if (parse_signed_commit(commit,
 				&payload, &signature) <= 0)
 		goto out;
 	status = verify_signed_buffer(payload.buf, payload.len,
@@ -1258,10 +1286,10 @@ struct commit_extra_header *read_commit_extra_headers(struct commit *commit,
 	struct commit_extra_header *extra = NULL;
 	unsigned long size;
 	enum object_type type;
-	char *buffer = read_sha1_file(commit->object.sha1, &type, &size);
+	const char *buffer = read_commit_buffer(commit, &type, &size);
 	if (buffer && type == OBJ_COMMIT)
 		extra = read_commit_extra_header_lines(buffer, size, exclude);
-	free(buffer);
+	free_commit_buffer(buffer, commit);
 	return extra;
 }
 
diff --git a/commit.h b/commit.h
index a9f177b..a765f0f 100644
--- a/commit.h
+++ b/commit.h
@@ -287,7 +287,7 @@ struct merge_remote_desc {
  */
 struct commit *get_merge_parent(const char *name);
 
-extern int parse_signed_commit(const unsigned char *sha1,
+extern int parse_signed_commit(const struct commit *commit,
 			       struct strbuf *message, struct strbuf *signature);
 extern void print_commit_list(struct commit_list *list,
 			      const char *format_cur,
diff --git a/log-tree.c b/log-tree.c
index cf2f86c..6358599 100644
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
2.0.0.rc1.436.g03cb729
