From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 6/7] replace: remove signature when using --graft
Date: Sat, 28 Jun 2014 20:11:15 +0200
Message-ID: <20140628181117.5687.38249.chriscool@tuxfamily.org>
References: <20140628171731.5687.30308.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 20:20:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0xEF-0007b1-9l
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 20:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756791AbaF1STv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 14:19:51 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:52636 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756445AbaF1STs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2014 14:19:48 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 62BA715A;
	Sat, 28 Jun 2014 20:19:47 +0200 (CEST)
X-git-sha1: 7dc18f55b31e77f50a5c4c0022f69cc917e6d953 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140628171731.5687.30308.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252612>

It could be misleading to keep a signature in a
replacement commit, so let's remove it.

Note that there should probably be a way to sign
the replacement commit created when using --graft,
but this can be dealt with in another commit or
patch series.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replace.c |  5 +++++
 commit.c          | 34 ++++++++++++++++++++++++++++++++++
 commit.h          |  2 ++
 3 files changed, 41 insertions(+)

diff --git a/builtin/replace.c b/builtin/replace.c
index ad47237..000db65 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -344,6 +344,11 @@ static int create_graft(int argc, const char **argv, int force)
 
 	replace_parents(&buf, argc, argv);
 
+	if (remove_signature(&buf))
+		warning(_("the original commit '%s' has a gpg signature.\n"
+			  "It will be removed in the replacement commit!"),
+			old_ref);
+
 	if (write_sha1_file(buf.buf, buf.len, commit_type, new))
 		die(_("could not write replacement commit for: '%s'"), old_ref);
 
diff --git a/commit.c b/commit.c
index fb7897c..54e157d 100644
--- a/commit.c
+++ b/commit.c
@@ -1177,6 +1177,40 @@ int parse_signed_commit(const struct commit *commit,
 	return saw_signature;
 }
 
+int remove_signature(struct strbuf *buf)
+{
+	const char *line = buf->buf;
+	const char *tail = buf->buf + buf->len;
+	int in_signature = 0;
+	const char *sig_start = NULL;
+	const char *sig_end = NULL;
+
+	while (line < tail) {
+		const char *next = memchr(line, '\n', tail - line);
+		next = next ? next + 1 : tail;
+
+		if (in_signature && line[0] == ' ')
+			sig_end = next;
+		else if (starts_with(line, gpg_sig_header) &&
+			 line[gpg_sig_header_len] == ' ') {
+			sig_start = line;
+			sig_end = next;
+			in_signature = 1;
+		} else {
+			if (*line == '\n')
+				/* dump the whole remainder of the buffer */
+				next = tail;
+			in_signature = 0;
+		}
+		line = next;
+	}
+
+	if (sig_start)
+		strbuf_remove(buf, sig_start - buf->buf, sig_end - sig_start);
+
+	return sig_start != NULL;
+}
+
 static void handle_signed_tag(struct commit *parent, struct commit_extra_header ***tail)
 {
 	struct merge_remote_desc *desc;
diff --git a/commit.h b/commit.h
index 2e1492a..4234dae 100644
--- a/commit.h
+++ b/commit.h
@@ -327,6 +327,8 @@ struct commit *get_merge_parent(const char *name);
 
 extern int parse_signed_commit(const struct commit *commit,
 			       struct strbuf *message, struct strbuf *signature);
+extern int remove_signature(struct strbuf *buf);
+
 extern void print_commit_list(struct commit_list *list,
 			      const char *format_cur,
 			      const char *format_last);
-- 
2.0.0.421.g786a89d.dirty
