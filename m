From: Jeff King <peff@peff.net>
Subject: [PATCH 10/15] use get_commit_buffer to avoid duplicate code
Date: Mon, 9 Jun 2014 14:12:47 -0400
Message-ID: <20140609181247.GJ20315@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 20:12:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu43w-0008Lm-MG
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 20:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144AbaFISMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 14:12:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:40387 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753820AbaFISMs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 14:12:48 -0400
Received: (qmail 15890 invoked by uid 102); 9 Jun 2014 18:12:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Jun 2014 13:12:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jun 2014 14:12:47 -0400
Content-Disposition: inline
In-Reply-To: <20140609180236.GA24644@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251096>

For both of these sites, we already do the "fallback to
read_sha1_file" trick. But we can shorten the code by just
using get_commit_buffer.

Note that the error cases are slightly different when
read_sha1_file fails. get_commit_buffer will die() if the
object cannot be loaded, or is a non-commit.

For get_sha1_oneline, this will almost certainly never
happen, as we will have just called parse_object (and if it
does, it's probably worth complaining about).

For record_author_date, the new behavior is probably better;
we notify the user of the error instead of silently ignoring
it. And because it's used only for sorting by author-date,
somebody examining a corrupt can fallback to the regular
traversal order.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c    | 16 +++-------------
 sha1_name.c | 18 ++++--------------
 2 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/commit.c b/commit.c
index b9ecae0..d00b818 100644
--- a/commit.c
+++ b/commit.c
@@ -583,22 +583,12 @@ static void record_author_date(struct author_date_slab *author_date,
 			       struct commit *commit)
 {
 	const char *buf, *line_end, *ident_line;
-	char *buffer = NULL;
+	const char *buffer = get_commit_buffer(commit);
 	struct ident_split ident;
 	char *date_end;
 	unsigned long date;
 
-	if (!commit->buffer) {
-		unsigned long size;
-		enum object_type type;
-		buffer = read_sha1_file(commit->object.sha1, &type, &size);
-		if (!buffer)
-			return;
-	}
-
-	for (buf = commit->buffer ? commit->buffer : buffer;
-	     buf;
-	     buf = line_end + 1) {
+	for (buf = buffer; buf; buf = line_end + 1) {
 		line_end = strchrnul(buf, '\n');
 		ident_line = skip_prefix(buf, "author ");
 		if (!ident_line) {
@@ -619,7 +609,7 @@ static void record_author_date(struct author_date_slab *author_date,
 	*(author_date_slab_at(author_date, commit)) = date;
 
 fail_exit:
-	free(buffer);
+	unuse_commit_buffer(commit, buffer);
 }
 
 static int compare_commits_by_author_date(const void *a_, const void *b_,
diff --git a/sha1_name.c b/sha1_name.c
index 2b6322f..0a65d23 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -862,27 +862,17 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
 		commit_list_insert(l->item, &backup);
 	}
 	while (list) {
-		char *p, *to_free = NULL;
+		const char *p, *buf;
 		struct commit *commit;
-		enum object_type type;
-		unsigned long size;
 		int matches;
 
 		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
 		if (!parse_object(commit->object.sha1))
 			continue;
-		if (commit->buffer)
-			p = commit->buffer;
-		else {
-			p = read_sha1_file(commit->object.sha1, &type, &size);
-			if (!p)
-				continue;
-			to_free = p;
-		}
-
-		p = strstr(p, "\n\n");
+		buf = get_commit_buffer(commit);
+		p = strstr(buf, "\n\n");
 		matches = p && !regexec(&regex, p + 2, 0, NULL, 0);
-		free(to_free);
+		unuse_commit_buffer(commit, buf);
 
 		if (matches) {
 			hashcpy(sha1, commit->object.sha1);
-- 
2.0.0.729.g520999f
