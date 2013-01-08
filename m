From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/10] mailmap: add mailmap structure to rev_info and pp
Date: Mon,  7 Jan 2013 16:10:16 -0800
Message-ID: <1357603821-8647-6-git-send-email-gitster@pobox.com>
References: <1357603821-8647-1-git-send-email-gitster@pobox.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 01:11:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsMmf-0006ZE-LI
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 01:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756176Ab3AHAKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 19:10:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50291 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756162Ab3AHAKf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 19:10:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57DFDB7B2;
	Mon,  7 Jan 2013 19:10:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zPcv
	k5mRT4BfWXGYB7ut0O97Cnw=; b=Mfpx7aRk+AdsPgSFS8/oVaYbSF0LPXz83gUd
	Iahluu1l/hfFvRSTHBZX39fdQI6uXiVpqT8JOId94/cI8dtUjDQ2JHiIvy/vgwxG
	BpJxZKE1LbRsTMUvXOX9jlxcNON0AW+4IWXn0m5n9bvwwc9vMMU2XaogT1rHVa46
	lXTP61o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	BTW5q/Wmw+sC5TxOEnENRTd8k1dmydLrYCcBJ2asGzZm6cBajHKuEvQp+50kkt8u
	mS3LXkJvA30TVQvTcQWGJ9ciqaIQXThA76UDELEseviHEXtgFS9VFURCp2ZO36pY
	qluzF+hVpIdnRrd7dCD4pQ6SJuwXsFne5WjXD7Aw7g4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AEA3B7B1;
	Mon,  7 Jan 2013 19:10:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD377B7B0; Mon,  7 Jan 2013
 19:10:34 -0500 (EST)
X-Mailer: git-send-email 1.8.1.304.gf036638
In-Reply-To: <1357603821-8647-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D2AF0956-5927-11E2-9C99-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212927>

From: Antoine Pelisse <apelisse@gmail.com>

Pass a mailmap from rev_info to pretty_print_context to so that the
pretty printer can use rewritten name and email address when showing
commits.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.h   | 1 +
 log-tree.c | 1 +
 revision.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/commit.h b/commit.h
index b6ad8f3..7f8f987 100644
--- a/commit.h
+++ b/commit.h
@@ -89,6 +89,7 @@ struct pretty_print_context {
 	char *notes_message;
 	struct reflog_walk_info *reflog_info;
 	const char *output_encoding;
+	struct string_list *mailmap;
 };
 
 struct userformat_want {
diff --git a/log-tree.c b/log-tree.c
index 4f86def..92254fd 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -671,6 +671,7 @@ void show_log(struct rev_info *opt)
 	ctx.preserve_subject = opt->preserve_subject;
 	ctx.reflog_info = opt->reflog_info;
 	ctx.fmt = opt->commit_format;
+	ctx.mailmap = opt->mailmap;
 	pretty_print_commit(&ctx, commit, &msgbuf);
 
 	if (opt->add_signoff)
diff --git a/revision.h b/revision.h
index 059bfff..83a79f5 100644
--- a/revision.h
+++ b/revision.h
@@ -143,6 +143,7 @@ struct rev_info {
 	const char	*subject_prefix;
 	int		no_inline;
 	int		show_log_size;
+	struct string_list *mailmap;
 
 	/* Filter by commit log message */
 	struct grep_opt	grep_filter;
-- 
1.8.1.304.gf036638
