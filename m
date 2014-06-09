From: Jeff King <peff@peff.net>
Subject: [PATCH 08/15] provide helpers to access the commit buffer
Date: Mon, 9 Jun 2014 14:11:59 -0400
Message-ID: <20140609181158.GH20315@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 20:12:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu43B-0007pl-Ag
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 20:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbaFISMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 14:12:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:40371 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753919AbaFISMA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 14:12:00 -0400
Received: (qmail 15802 invoked by uid 102); 9 Jun 2014 18:12:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Jun 2014 13:12:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jun 2014 14:11:59 -0400
Content-Disposition: inline
In-Reply-To: <20140609180236.GA24644@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251094>

Many sites look at commit->buffer to get more detailed
information than what is in the parsed commit struct.
However, we sometimes drop commit->buffer to save memory,
in which case the caller would need to read the object
afresh. Some callers do this (leading to duplicated code),
and others do not (which opens the possibility of a segfault
if somebody else frees the buffer).

Let's provide a pair of helpers, "get" and "unuse", that let
callers easily get the buffer. They will use the cached
buffer when possible, and otherwise load from disk using
read_sha1_file.

Note that we also need to add a "get_cached" variant which
returns NULL when we do not have a cached buffer. At first
glance this seems to defeat the purpose of "get", which is
to always provide a return value. However, some log code
paths actually use the NULL-ness of commit->buffer as a
boolean flag to decide whether to try to printing the
commit. At least for now, we want to continue supporting
that use.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c | 28 ++++++++++++++++++++++++++++
 commit.h | 21 +++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/commit.c b/commit.c
index 5cc52e0..b9ecae0 100644
--- a/commit.c
+++ b/commit.c
@@ -250,6 +250,34 @@ void set_commit_buffer(struct commit *commit, void *buffer)
 	commit->buffer = buffer;
 }
 
+const void *get_cached_commit_buffer(const struct commit *commit)
+{
+	return commit->buffer;
+}
+
+const void *get_commit_buffer(const struct commit *commit)
+{
+	const void *ret = get_cached_commit_buffer(commit);
+	if (!ret) {
+		enum object_type type;
+		unsigned long size;
+		ret = read_sha1_file(commit->object.sha1, &type, &size);
+		if (!ret)
+			die("cannot read commit object %s",
+			    sha1_to_hex(commit->object.sha1));
+		if (type != OBJ_COMMIT)
+			die("expected commit for %s, got %s",
+			    sha1_to_hex(commit->object.sha1), typename(type));
+	}
+	return ret;
+}
+
+void unuse_commit_buffer(const struct commit *commit, const void *buffer)
+{
+	if (commit->buffer != buffer)
+		free((void *)buffer);
+}
+
 void free_commit_buffer(struct commit *commit)
 {
 	free(commit->buffer);
diff --git a/commit.h b/commit.h
index 5cc0bf3..67caf92 100644
--- a/commit.h
+++ b/commit.h
@@ -58,6 +58,27 @@ void parse_commit_or_die(struct commit *item);
 void set_commit_buffer(struct commit *, void *buffer);
 
 /*
+ * Get any cached object buffer associated with the commit. Returns NULL
+ * if none. The resulting memory should not be freed.
+ */
+const void *get_cached_commit_buffer(const struct commit *);
+
+/*
+ * Get the commit's object contents, either from cache or by reading the object
+ * from disk. The resulting memory should not be modified, and must be given
+ * to unuse_commit_buffer when the caller is done.
+ */
+const void *get_commit_buffer(const struct commit *);
+
+/*
+ * Tell the commit subsytem that we are done with a particular commit buffer.
+ * The commit and buffer should be the input and return value, respectively,
+ * from an earlier call to get_commit_buffer.  The buffer may or may not be
+ * freed by this call; callers should not access the memory afterwards.
+ */
+void unuse_commit_buffer(const struct commit *, const void *buffer);
+
+/*
  * Free any cached object buffer associated with the commit.
  */
 void free_commit_buffer(struct commit *);
-- 
2.0.0.729.g520999f
