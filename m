From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 06/17] fmt-merge-msg: avoid early returns
Date: Tue,  8 Nov 2011 17:01:52 -0800
Message-ID: <1320800523-5407-7-git-send-email-gitster@pobox.com>
References: <1320800523-5407-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 02:02:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNwYc-0003ps-7p
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 02:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389Ab1KIBCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 20:02:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36410 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016Ab1KIBCV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 20:02:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8A225B70
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=V6zC
	kzFH3q565mxo+uDKT/91/MQ=; b=NkecWmOYRv8jNVaQcmOMeiYL9bjQt6ii+m13
	o/JUnJimmC555wa75knzqe75v5/SD/nZdBQOLbU2xFWz82NGZlu6oUAF8pUxSa0r
	SKIQIB91wJyha+J6YpFpHOnoTgPIecltAxBFJD8pAE3eTYbw9xJdc4c2PCQjhpby
	0J54LMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=J1QARL
	CP/CJVsNa1mB1q3Wr3fQwUqJPdqlZ9FsVsEhpqDxm4wjDhOzpyGFV01uZDEFnvCs
	bipr/G34LLHn1oOZsHLm9UjWYaRSPujX+8EjtXCh6qalaovxqFoGtMLwzoYaOA9o
	ambnEYMATvYsuHNgUwPzMrkGvQMSGRv+Xe/M4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E3D95B6F
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 094895B6E for
 <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:19 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.gde0f9
In-Reply-To: <1320800523-5407-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7997A9DA-0A6E-11E1-874C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185128>

In various places in the codepath, the program tries to return early
assuming there is no more work needed. That is generally untrue when
over time new features are added.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fmt-merge-msg.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 7e2f225..7b492f9 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -26,6 +26,7 @@ static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 	return 0;
 }
 
+/* merge data per repository where the merged tips came from */
 struct src_data {
 	struct string_list branch, tag, r_branch, generic;
 	int head_status;
@@ -71,6 +72,11 @@ static int handle_line(char *line)
 		line[len - 1] = 0;
 	line += 42;
 
+	/*
+	 * At this point, line points at the beginning of comment e.g.
+	 * "branch 'frotz' of git://that/repository.git".
+	 * Find the repository name and point it with src.
+	 */
 	src = strstr(line, " of ");
 	if (src) {
 		*src = 0;
@@ -283,10 +289,7 @@ static int do_fmt_merge_msg(int merge_title, struct strbuf *in,
 			die ("Error in line %d: %.*s", i, len, p);
 	}
 
-	if (!srcs.nr)
-		return 0;
-
-	if (merge_title)
+	if (merge_title && srcs.nr)
 		do_fmt_merge_msg_title(out, current_branch);
 
 	if (shortlog_len) {
@@ -306,6 +309,8 @@ static int do_fmt_merge_msg(int merge_title, struct strbuf *in,
 			shortlog(origins.items[i].string, origins.items[i].util,
 					head, &rev, shortlog_len, out);
 	}
+	if (out->len && out->buf[out->len-1] != '\n')
+		strbuf_addch(out, '\n');
 	return 0;
 }
 
@@ -341,12 +346,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 			     0);
 	if (argc > 0)
 		usage_with_options(fmt_merge_msg_usage, options);
-	if (message && !shortlog_len) {
-		char nl = '\n';
-		write_in_full(STDOUT_FILENO, message, strlen(message));
-		write_in_full(STDOUT_FILENO, &nl, 1);
-		return 0;
-	}
+
 	if (shortlog_len < 0)
 		die("Negative --log=%d", shortlog_len);
 
-- 
1.7.8.rc1.82.g90e080
