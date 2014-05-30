From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] git log: support "auto" decorations
Date: Fri, 30 May 2014 02:57:38 -0400
Message-ID: <20140530065737.GA13591@sigill.intra.peff.net>
References: <alpine.LFD.2.11.1405291523520.8270@i7.linux-foundation.org>
 <20140530015855.GG28683@sigill.intra.peff.net>
 <CA+55aFzwy09-i=hpBy-5bYS6eowGzkdcF65cFJpL2qnJvYq85w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 30 08:57:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqGl7-00047z-UU
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 08:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbaE3G5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 02:57:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:33962 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752080AbaE3G5k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 02:57:40 -0400
Received: (qmail 17503 invoked by uid 102); 30 May 2014 06:57:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 May 2014 01:57:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 May 2014 02:57:38 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFzwy09-i=hpBy-5bYS6eowGzkdcF65cFJpL2qnJvYq85w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250433>

On Thu, May 29, 2014 at 09:54:10PM -0700, Linus Torvalds wrote:

> That said, part of it is just that show-signature is so suboptimal
> performance-wise, re-parsing the commit buffer for each commit when
> "show_signature" is set. That's just crazy, we've already parsed the
> commit text, we already *could* know if it has a signature or not, and
> skip it if it doesn't. That would require one of the flag bits in the
> object, though, or something, so it's probably not worth doing.

Wow, it's really quite bad. Not only do we spend time on commits that we
could otherwise know do not have signatures, but we actually pull the
buffer from disk, even though we generally have it saved as
commit->buffer. And we do it twice! Once for the commit signature, and
once for the mergetag.

Below is a fairly straightforward patch to use commit->buffer when we
have it. Here are timings on the kernel repo:

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

If you look at just the user CPU time, you can see we've reclaimed all
but 0.5s of the 5.2s wasted seconds. Some of that is presumably going to
the extra re-parsing, with a little to the actual gpg verification.

The wall-clock time improves, too, but we're still 5s slower. A little
of that goes to system time, but presumably most of the rest of it is
latency due to waiting on gpg? Getting rid of that would probably
involve caching the gpg output from run to run. That's not that hard to
do, but I don't like the idea of caching security information.

---
 commit.c   | 36 ++++++++++++++++++++++++++++--------
 commit.h   |  2 +-
 log-tree.c |  2 +-
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/commit.c b/commit.c
index f479331..529ee50 100644
--- a/commit.c
+++ b/commit.c
@@ -1080,14 +1080,34 @@ static int do_sign_commit(struct strbuf *buf, const char *keyid)
 	return 0;
 }
 
-int parse_signed_commit(const unsigned char *sha1,
+static const char *get_commit_buffer(const struct commit *commit,
+				     enum object_type *type,
+				     unsigned long *size)
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
+	const char *buffer = get_commit_buffer(commit, &type, &size);
 	int in_signature, saw_signature = -1;
-	char *line, *tail;
+	const char *line, *tail;
 
 	if (!buffer || type != OBJ_COMMIT)
 		goto cleanup;
@@ -1098,7 +1118,7 @@ int parse_signed_commit(const unsigned char *sha1,
 	saw_signature = 0;
 	while (line < tail) {
 		const char *sig = NULL;
-		char *next = memchr(line, '\n', tail - line);
+		const char *next = memchr(line, '\n', tail - line);
 
 		next = next ? next + 1 : tail;
 		if (in_signature && line[0] == ' ')
@@ -1120,7 +1140,7 @@ int parse_signed_commit(const unsigned char *sha1,
 		line = next;
 	}
  cleanup:
-	free(buffer);
+	free_commit_buffer(buffer, commit);
 	return saw_signature;
 }
 
@@ -1211,7 +1231,7 @@ void check_commit_signature(const struct commit* commit, struct signature_check
 
 	sigc->result = 'N';
 
-	if (parse_signed_commit(commit->object.sha1,
+	if (parse_signed_commit(commit,
 				&payload, &signature) <= 0)
 		goto out;
 	status = verify_signed_buffer(payload.buf, payload.len,
@@ -1258,10 +1278,10 @@ struct commit_extra_header *read_commit_extra_headers(struct commit *commit,
 	struct commit_extra_header *extra = NULL;
 	unsigned long size;
 	enum object_type type;
-	char *buffer = read_sha1_file(commit->object.sha1, &type, &size);
+	const char *buffer = get_commit_buffer(commit, &type, &size);
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
