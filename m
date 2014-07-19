From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 6/9] replace: remove signature when using --graft
Date: Sat, 19 Jul 2014 17:01:12 +0200
Message-ID: <20140719150116.9564.7190.chriscool@tuxfamily.org>
References: <20140719145951.9564.61331.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 17:42:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8WmE-0008Gs-Vg
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 17:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755388AbaGSPlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 11:41:49 -0400
Received: from [194.158.98.14] ([194.158.98.14]:33802 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755050AbaGSPlr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 11:41:47 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 4691173;
	Sat, 19 Jul 2014 17:41:26 +0200 (CEST)
X-git-sha1: f6fd9aa62d345f969b676737abf87e0d3e91657a 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140719145951.9564.61331.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253893>

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
index 7459359..52f73ce 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -344,6 +344,11 @@ static int create_graft(int argc, const char **argv, int force)
 
 	replace_parents(&buf, argc - 1, &argv[1]);
 
+	if (remove_signature(&buf)) {
+		warning(_("the original commit '%s' has a gpg signature."), old_ref);
+		warning(_("the signature will be removed in the replacement commit!"));
+	}
+
 	if (write_sha1_file(buf.buf, buf.len, commit_type, new))
 		die(_("could not write replacement commit for: '%s'"), old_ref);
 
diff --git a/commit.c b/commit.c
index 0fd04ae..27c3c05 100644
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
index b695aa4..c81ba85 100644
--- a/commit.h
+++ b/commit.h
@@ -332,6 +332,8 @@ struct commit *get_merge_parent(const char *name);
 
 extern int parse_signed_commit(const struct commit *commit,
 			       struct strbuf *message, struct strbuf *signature);
+extern int remove_signature(struct strbuf *buf);
+
 extern void print_commit_list(struct commit_list *list,
 			      const char *format_cur,
 			      const char *format_last);
-- 
2.0.0.421.g786a89d.dirty
