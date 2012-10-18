From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/6] pretty: prepare notes message at a centralized place
Date: Wed, 17 Oct 2012 22:45:25 -0700
Message-ID: <1350539128-21577-4-git-send-email-gitster@pobox.com>
References: <1350539128-21577-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 07:46:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOivh-0005dI-LK
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 07:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182Ab2JRFpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 01:45:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59964 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754088Ab2JRFph (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 01:45:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 505706D33
	for <git@vger.kernel.org>; Thu, 18 Oct 2012 01:45:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Vze6
	IT6cEk+tU2rqp7KgZm9/Eg0=; b=Zxeze5yydoD2NTmnkbk5g+2Hb2WjnY14fO/r
	GD9VbAHaa7qlEhnn8YPD7+kZe1NjMPMaXphQEkeZpzA8r1xt69vdN55ITD+anXQJ
	VfTNglv7gEUGE+EnmmyWAGZ8lWWriARadbjMEswPa5W6yHa06cGt5GeL/4gEtMMs
	i41iYag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=wG6Np0
	deMxq5NPgie6mviZaljxFrtbOmCuotHMCl46j/YLUFs4dJKpA/YVCy7HsELrmHU/
	SpyjpDbx1DMhXxlAJY2Ot8YrUutJGtFqt3cUNcOzU5xHkxkxc+wLJQjocikKfqKR
	uuEnbye3ZScYbqSCXRFIhjLC8r2AWndOx2HGY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C30B6D32
	for <git@vger.kernel.org>; Thu, 18 Oct 2012 01:45:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 755EF6D29 for
 <git@vger.kernel.org>; Thu, 18 Oct 2012 01:45:36 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc3.112.gdb88a5e
In-Reply-To: <1350539128-21577-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0A5C8120-18E7-11E2-BD68-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207964>

Instead of passing a boolean show_notes around, pass an optional
string that is to be inserted after the log message proper is shown.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.h   |  2 +-
 log-tree.c | 14 +++++++++++++-
 pretty.c   |  9 ++++-----
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/commit.h b/commit.h
index a822af8..7b43e45 100644
--- a/commit.h
+++ b/commit.h
@@ -86,7 +86,7 @@ struct pretty_print_context {
 	enum date_mode date_mode;
 	unsigned date_mode_explicit:1;
 	int need_8bit_cte;
-	int show_notes;
+	char *notes_message;
 	struct reflog_walk_info *reflog_info;
 	const char *output_encoding;
 };
diff --git a/log-tree.c b/log-tree.c
index c894930..84e9f5b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -540,7 +540,6 @@ void show_log(struct rev_info *opt)
 	struct pretty_print_context ctx = {0};
 
 	opt->loginfo = NULL;
-	ctx.show_notes = opt->show_notes;
 	if (!opt->verbose_header) {
 		graph_show_commit(opt->graph);
 
@@ -648,6 +647,18 @@ void show_log(struct rev_info *opt)
 	if (!commit->buffer)
 		return;
 
+	if (opt->show_notes) {
+		int raw;
+		struct strbuf notebuf = STRBUF_INIT;
+
+		raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
+		format_display_notes(commit->object.sha1, &notebuf,
+				     get_log_output_encoding(), raw);
+		ctx.notes_message = notebuf.len
+			? strbuf_detach(&notebuf, NULL)
+			: xcalloc(1, 1);
+	}
+
 	/*
 	 * And then the pretty-printed message itself
 	 */
@@ -689,6 +700,7 @@ void show_log(struct rev_info *opt)
 	}
 
 	strbuf_release(&msgbuf);
+	free(ctx.notes_message);
 }
 
 int log_tree_diff_flush(struct rev_info *opt)
diff --git a/pretty.c b/pretty.c
index 735cf0f..a53eb53 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1033,9 +1033,8 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 		}
 		return 0;	/* unknown %g placeholder */
 	case 'N':
-		if (c->pretty_ctx->show_notes) {
-			format_display_notes(commit->object.sha1, sb,
-					     get_log_output_encoding(), 1);
+		if (c->pretty_ctx->notes_message) {
+			strbuf_addstr(sb, c->pretty_ctx->notes_message);
 			return 1;
 		}
 		return 0;
@@ -1418,8 +1417,8 @@ void pretty_print_commit(const struct pretty_print_context *pp,
 	if (pp->fmt == CMIT_FMT_EMAIL && sb->len <= beginning_of_body)
 		strbuf_addch(sb, '\n');
 
-	if (pp->show_notes)
-		format_display_notes(commit->object.sha1, sb, encoding, 0);
+	if (pp->notes_message && *pp->notes_message)
+		strbuf_addstr(sb, pp->notes_message);
 
 	free(reencoded);
 }
-- 
1.8.0.rc3.112.gdb88a5e
