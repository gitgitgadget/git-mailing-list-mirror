From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] Add MIME information to outgoing email
Date: Fri, 14 Mar 2008 13:21:27 -0700
Message-ID: <7vbq5hoy48.fsf_-_@gitster.siamese.dyndns.org>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net>
 <20080313170016.GA3439@sigill.intra.peff.net>
 <7v4pb9qnuu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Samuel Tardieu <sam@rfc1149.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 21:22:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaGQR-0008Lx-0i
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 21:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757932AbYCNUVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 16:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753012AbYCNUVs
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 16:21:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38767 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757876AbYCNUVj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 16:21:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A155F339D;
	Fri, 14 Mar 2008 16:21:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9A010339C; Fri, 14 Mar 2008 16:21:30 -0400 (EDT)
In-Reply-To: <7v4pb9qnuu.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 14 Mar 2008 09:20:09 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77279>

Junio C Hamano <gitster@pobox.com> writes:

> Having said all that, I notice that addition of format.headers variable
> (which I think is a later invention) was done not quite correctly.  In the
> callchain above, pretty_print_commit() function checks the commit log but
> it is meant to do so only when we haven't emitted MIME Content-Type:
> (because the user told us to do multipart), and "after_subject" parameter
> was getting passed around for it (and its callees) to detect exactly that.
> But format.headers misused that variable to carry its contents along ---
> there needs a way to pass "have we said MIME-Version crap already"
> separately.

I think the real culprit was the way the "after_subject" was added to the
callchain (it had loaded semantics -- "here is what we want to say after
emitting Subject: line" and "have we done any MIME yet?"), not the poor
guy who did format.headers.

In any case, this patch would hopefully separate the two.  The old
"plain_non_ascii" parameter is now need_8bit_ct_header and now can have
one of three values:

 -1 : we've already done MIME crap so never add extra header to say this
      is 8bit;

 0  : we haven't done MIME and we have not seen anything that is 8bit yet.

 1  : we haven't done MIME and we have seen something that is 8bit.
      pp_title_line() needs to add MIME header.

(As with any other patches I send during my lunchtime, this is untested).

---

 builtin-log.c |    6 ++++--
 commit.h      |    4 ++--
 log-tree.c    |   15 ++++++++++++---
 log-tree.h    |    4 +++-
 pretty.c      |   24 +++++++++++-------------
 5 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index d983cbc..4b1b34f 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -662,6 +662,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	int i;
 	const char *encoding = "utf-8";
 	struct diff_options opts;
+	int need_8bit_ct_header = 0;
 
 	if (rev->commit_format != CMIT_FMT_EMAIL)
 		die("Cover letter needs email format");
@@ -672,7 +673,8 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 
 	head_sha1 = sha1_to_hex(head->object.sha1);
 
-	log_write_email_headers(rev, head_sha1, &subject_start, &extra_headers);
+	log_write_email_headers(rev, head_sha1, &subject_start, &extra_headers,
+				&need_8bit_ct_header);
 
 	committer = git_committer_info(0);
 
@@ -681,7 +683,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	pp_user_info(NULL, CMIT_FMT_EMAIL, &sb, committer, DATE_RFC2822,
 		     encoding);
 	pp_title_line(CMIT_FMT_EMAIL, &msg, &sb, subject_start, extra_headers,
-		      encoding, 0);
+		      encoding, need_8bit_ct_header);
 	pp_remainder(CMIT_FMT_EMAIL, &msg, &sb, 0);
 	printf("%s\n", sb.buf);
 
diff --git a/commit.h b/commit.h
index a1e9591..0907a78 100644
--- a/commit.h
+++ b/commit.h
@@ -70,7 +70,7 @@ extern void pretty_print_commit(enum cmit_fmt fmt, const struct commit*,
                                 struct strbuf *,
                                 int abbrev, const char *subject,
                                 const char *after_subject, enum date_mode,
-				int non_ascii_present);
+				int need_8bit_ct_header);
 void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 		   const char *line, enum date_mode dmode,
 		   const char *encoding);
@@ -80,7 +80,7 @@ void pp_title_line(enum cmit_fmt fmt,
 		   const char *subject,
 		   const char *after_subject,
 		   const char *encoding,
-		   int plain_non_ascii);
+		   int need_8bit_ct_header);
 void pp_remainder(enum cmit_fmt fmt,
 		  const char **msg_p,
 		  struct strbuf *sb,
diff --git a/log-tree.c b/log-tree.c
index 608f697..f2ce32a 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -138,10 +138,14 @@ static int has_non_ascii(const char *s)
 }
 
 void log_write_email_headers(struct rev_info *opt, const char *name,
-			     const char **subject_p, const char **extra_headers_p)
+			     const char **subject_p,
+			     const char **extra_headers_p,
+			     int *need_8bit_ct_header_p)
 {
 	const char *subject = NULL;
 	const char *extra_headers = opt->extra_headers;
+
+	*need_8bit_ct_header_p = 0; /* unknown */
 	if (opt->total > 0) {
 		static char buffer[64];
 		snprintf(buffer, sizeof(buffer),
@@ -169,6 +173,7 @@ void log_write_email_headers(struct rev_info *opt, const char *name,
 	if (opt->mime_boundary) {
 		static char subject_buffer[1024];
 		static char buffer[1024];
+		*need_8bit_ct_header_p = -1; /* NEVER */
 		snprintf(subject_buffer, sizeof(subject_buffer) - 1,
 			 "%s"
 			 "MIME-Version: 1.0\n"
@@ -212,6 +217,7 @@ void show_log(struct rev_info *opt, const char *sep)
 	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : 40;
 	const char *extra;
 	const char *subject = NULL, *extra_headers = opt->extra_headers;
+	int need_8bit_ct_header = 0;
 
 	opt->loginfo = NULL;
 	if (!opt->verbose_header) {
@@ -255,7 +261,8 @@ void show_log(struct rev_info *opt, const char *sep)
 
 	if (opt->commit_format == CMIT_FMT_EMAIL) {
 		log_write_email_headers(opt, sha1_to_hex(commit->object.sha1),
-					&subject, &extra_headers);
+					&subject, &extra_headers,
+					&need_8bit_ct_header);
 	} else if (opt->commit_format != CMIT_FMT_USERFORMAT) {
 		fputs(diff_get_color_opt(&opt->diffopt, DIFF_COMMIT), stdout);
 		if (opt->commit_format != CMIT_FMT_ONELINE)
@@ -299,9 +306,11 @@ void show_log(struct rev_info *opt, const char *sep)
 	 * And then the pretty-printed message itself
 	 */
 	strbuf_init(&msgbuf, 0);
+	if (need_8bit_ct_header >= 0)
+		need_8bit_ct_header = has_non_ascii(opt->add_signoff);
 	pretty_print_commit(opt->commit_format, commit, &msgbuf,
 			    abbrev, subject, extra_headers, opt->date_mode,
-			    has_non_ascii(opt->add_signoff));
+			    need_8bit_ct_header);
 
 	if (opt->add_signoff)
 		append_signoff(&msgbuf, opt->add_signoff);
diff --git a/log-tree.h b/log-tree.h
index 0cc9344..69c1c4b 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -14,6 +14,8 @@ int log_tree_opt_parse(struct rev_info *, const char **, int);
 void show_log(struct rev_info *opt, const char *sep);
 void show_decorations(struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, const char *name,
-			     const char **subject_p, const char **extra_headers_p);
+			     const char **subject_p,
+			     const char **extra_headers_p,
+			     int *need_8bit_ct_header_p);
 
 #endif
diff --git a/pretty.c b/pretty.c
index 703f521..7a5b115 100644
--- a/pretty.c
+++ b/pretty.c
@@ -636,7 +636,7 @@ void pp_title_line(enum cmit_fmt fmt,
 		   const char *subject,
 		   const char *after_subject,
 		   const char *encoding,
-		   int plain_non_ascii)
+		   int need_8bit_ct_header)
 {
 	struct strbuf title;
 
@@ -669,7 +669,7 @@ void pp_title_line(enum cmit_fmt fmt,
 	}
 	strbuf_addch(sb, '\n');
 
-	if (plain_non_ascii) {
+	if (need_8bit_ct_header > 0) {
 		const char *header_fmt =
 			"MIME-Version: 1.0\n"
 			"Content-Type: text/plain; charset=%s\n"
@@ -718,9 +718,9 @@ void pp_remainder(enum cmit_fmt fmt,
 }
 
 void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
-				  struct strbuf *sb, int abbrev,
-				  const char *subject, const char *after_subject,
-				  enum date_mode dmode, int plain_non_ascii)
+			 struct strbuf *sb, int abbrev,
+			 const char *subject, const char *after_subject,
+			 enum date_mode dmode, int need_8bit_ct_header)
 {
 	unsigned long beginning_of_body;
 	int indent = 4;
@@ -746,13 +746,11 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 	if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_EMAIL)
 		indent = 0;
 
-	/* After-subject is used to pass in Content-Type: multipart
-	 * MIME header; in that case we do not have to do the
-	 * plaintext content type even if the commit message has
-	 * non 7-bit ASCII character.  Otherwise, check if we need
-	 * to say this is not a 7-bit ASCII.
+	/*
+	 * We need to check and emit Content-type: to mark it
+	 * as 8-bit if we haven't done so.
 	 */
-	if (fmt == CMIT_FMT_EMAIL && !after_subject) {
+	if (fmt == CMIT_FMT_EMAIL && need_8bit_ct_header == 0) {
 		int i, ch, in_body;
 
 		for (in_body = i = 0; (ch = msg[i]); i++) {
@@ -765,7 +763,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 					in_body = 1;
 			}
 			else if (non_ascii(ch)) {
-				plain_non_ascii = 1;
+				need_8bit_ct_header = 1;
 				break;
 			}
 		}
@@ -790,7 +788,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 	/* These formats treat the title line specially. */
 	if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_EMAIL)
 		pp_title_line(fmt, &msg, sb, subject,
-			      after_subject, encoding, plain_non_ascii);
+			      after_subject, encoding, need_8bit_ct_header);
 
 	beginning_of_body = sb->len;
 	if (fmt != CMIT_FMT_ONELINE)
