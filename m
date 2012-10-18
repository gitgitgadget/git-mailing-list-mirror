From: Junio C Hamano <gitster@pobox.com>
Subject: [WIP-PATCH 2/3] pretty: prepare notes message at a centralized place
Date: Wed, 17 Oct 2012 19:20:17 -0700
Message-ID: <1350526818-354-3-git-send-email-gitster@pobox.com>
References: <1350526818-354-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 04:20:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOfix-00038j-D2
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 04:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676Ab2JRCU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 22:20:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34947 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081Ab2JRCU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 22:20:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FAC983FC
	for <git@vger.kernel.org>; Wed, 17 Oct 2012 22:20:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ZLnS
	7s1HKVb81hPtH29me+ZWiaE=; b=sP3uKZb+/e6oN5k1tg0d6xOwGvDhFdSD5gRw
	e6SS4E1HaQg9gTqJERNxfiZhroSFT3Nc9z04jKVFWArQ6keaZSjQyJjTg7D3EL3w
	rQ2cmD/H46s5Ny1UR1sAzSxxrayhXXC6F9SEhtqPIYYJq7Xz/Qevb2xp/lns7d4y
	WSxb+sk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=iAXzvR
	Liw7EEM6+haFbtCugUma0q42oYc0fr3Js7Iciw62KdMP3CH15u5xp0sFqnO0FmIJ
	spxg1jll48Gd9ilhQGQa+u03kn2kYbk/vFKy9g9Twb3BkBlMVV7tQ1NriTtlP7g4
	LCRxlTYNS2czYcTQ50nDnsKlp8gWnY3hSLYKA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E29F83FB
	for <git@vger.kernel.org>; Wed, 17 Oct 2012 22:20:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B066F83FA for
 <git@vger.kernel.org>; Wed, 17 Oct 2012 22:20:25 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc3.112.gdb88a5e
In-Reply-To: <1350526818-354-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6093C1EC-18CA-11E2-B04F-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207952>

Instead of passing a boolean show_notes around, pass an optional
string buffer that is to be inserted after the log message proper is
shown.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.h   |  2 +-
 log-tree.c | 15 ++++++++++++++-
 pretty.c   | 10 ++++------
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/commit.h b/commit.h
index a822af8..e119788 100644
--- a/commit.h
+++ b/commit.h
@@ -86,7 +86,7 @@ struct pretty_print_context {
 	enum date_mode date_mode;
 	unsigned date_mode_explicit:1;
 	int need_8bit_cte;
-	int show_notes;
+	struct strbuf *after_message_body;
 	struct reflog_walk_info *reflog_info;
 	const char *output_encoding;
 };
diff --git a/log-tree.c b/log-tree.c
index c894930..95ff405 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -533,6 +533,7 @@ static void show_mergetag(struct rev_info *opt, struct commit *commit)
 void show_log(struct rev_info *opt)
 {
 	struct strbuf msgbuf = STRBUF_INIT;
+	struct strbuf appendbuf = STRBUF_INIT;
 	struct log_info *log = opt->loginfo;
 	struct commit *commit = log->commit, *parent = log->parent;
 	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : 40;
@@ -540,7 +541,6 @@ void show_log(struct rev_info *opt)
 	struct pretty_print_context ctx = {0};
 
 	opt->loginfo = NULL;
-	ctx.show_notes = opt->show_notes;
 	if (!opt->verbose_header) {
 		graph_show_commit(opt->graph);
 
@@ -648,6 +648,18 @@ void show_log(struct rev_info *opt)
 	if (!commit->buffer)
 		return;
 
+	if (opt->show_notes) {
+		int flags;
+
+		if (opt->commit_format == CMIT_FMT_USERFORMAT)
+			flags = 0;
+		else
+			flags = NOTES_SHOW_HEADER | NOTES_INDENT;
+		format_display_notes(commit->object.sha1, &appendbuf,
+				     get_log_output_encoding(), flags);
+		ctx.after_message_body = &appendbuf;
+	}
+
 	/*
 	 * And then the pretty-printed message itself
 	 */
@@ -689,6 +701,7 @@ void show_log(struct rev_info *opt)
 	}
 
 	strbuf_release(&msgbuf);
+	strbuf_release(&appendbuf);
 }
 
 int log_tree_diff_flush(struct rev_info *opt)
diff --git a/pretty.c b/pretty.c
index c311a68..bdd991c 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1033,9 +1033,8 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 		}
 		return 0;	/* unknown %g placeholder */
 	case 'N':
-		if (c->pretty_ctx->show_notes) {
-			format_display_notes(commit->object.sha1, sb,
-				    get_log_output_encoding(), 0);
+		if (c->pretty_ctx->after_message_body) {
+			strbuf_addbuf(sb, c->pretty_ctx->after_message_body);
 			return 1;
 		}
 		return 0;
@@ -1418,9 +1417,8 @@ void pretty_print_commit(const struct pretty_print_context *pp,
 	if (pp->fmt == CMIT_FMT_EMAIL && sb->len <= beginning_of_body)
 		strbuf_addch(sb, '\n');
 
-	if (pp->show_notes)
-		format_display_notes(commit->object.sha1, sb, encoding,
-				     NOTES_SHOW_HEADER | NOTES_INDENT);
+	if (pp->after_message_body)
+		strbuf_addbuf(sb, pp->after_message_body);
 
 	free(reencoded);
 }
-- 
1.8.0.rc3.112.gdb88a5e
