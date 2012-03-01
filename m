From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] diff --ignore-mode-change
Date: Wed, 29 Feb 2012 18:14:17 -0800
Message-ID: <1330568057-27304-5-git-send-email-gitster@pobox.com>
References: <1330568057-27304-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 03:14:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2vXO-0003tv-VX
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 03:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757568Ab2CACO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 21:14:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63822 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757239Ab2CACO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 21:14:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 777E47D6A
	for <git@vger.kernel.org>; Wed, 29 Feb 2012 21:14:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Kt8p
	nEvy9SJglF0aSQzPven/yWI=; b=KVcLSYPYdT63sK2zeVw8OI6Vp2wlxpkAxF7k
	iEWs6ribPTDugtPWgQsxVscNUJh+thMBOz3GGZAxULbt7E1oqjcfB3q9EDPfBZYy
	a+19i03lp/Yvl7oDWxzwIJHaaIi2j67YGSSq64el8WUGLmT5P8BTy6Lz9lSGvoqW
	ma8dozU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=QRig4d
	KGnrnzUjVy/fXzpyntm7KZFQRdwP5y99wlmy1BcXAHSPwv66Us1ejXpJOBfssaIR
	XV9hWWvRTHojXJmS9qY0VkRwDxwbdqmXW5om5c/ahT8PvNYzK9iu/Samb3YgBd4C
	8nSfKDg3C0SEwzcuRgiYjvL7+uc/Ev+N94H1c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47C307D66
	for <git@vger.kernel.org>; Wed, 29 Feb 2012 21:14:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 994907D63 for
 <git@vger.kernel.org>; Wed, 29 Feb 2012 21:14:26 -0500 (EST)
X-Mailer: git-send-email 1.7.9.2.350.g74d65
In-Reply-To: <1330568057-27304-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 451E8DF2-6344-11E1-BCF8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191888>

It may be useful if you can view the diff while ignoring changes that only
touch the executable bit without changing the contents (e.g. a careless
imports of vendor drop from tarballs), and this teaches the diff machinery
to ignore them. A change that touches both contents and the executable bit
is not ignored.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c |   29 ++++++++++++++++++++++++++++-
 diff.h |    1 +
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 0ecbf32..62fefba 100644
--- a/diff.c
+++ b/diff.c
@@ -1920,7 +1920,8 @@ static void builtin_diff(const char *name_a,
 		if (one->mode != two->mode) {
 			strbuf_addf(&header, "%s%sold mode %06o%s\n", line_prefix, set, one->mode, reset);
 			strbuf_addf(&header, "%s%snew mode %06o%s\n", line_prefix, set, two->mode, reset);
-			must_show_header = 1;
+			if (!DIFF_OPT_TST(o, IGNORE_MODE_CHANGE))
+				must_show_header = 1;
 		}
 		if (xfrm_msg)
 			strbuf_addstr(&header, xfrm_msg);
@@ -3166,6 +3167,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	}
 	else if (!strcmp(arg, "--no-renames"))
 		options->detect_rename = 0;
+	else if (!strcmp(arg, "--ignore-mode-change"))
+		DIFF_OPT_SET(options, IGNORE_MODE_CHANGE);
 	else if (!strcmp(arg, "--relative"))
 		DIFF_OPT_SET(options, RELATIVE_NAME);
 	else if (!prefixcmp(arg, "--relative=")) {
@@ -4191,10 +4194,34 @@ void diffcore_fix_diff_index(struct diff_options *options)
 	qsort(q->queue, q->nr, sizeof(q->queue[0]), diffnamecmp);
 }
 
+static void diffcore_ignore_mode_change(struct diff_options *diffopt)
+{
+	int i;
+	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue_struct outq;
+	DIFF_QUEUE_CLEAR(&outq);
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+
+		if (DIFF_FILE_VALID(p->one) &&
+		    DIFF_FILE_VALID(p->two) &&
+		    (p->one->sha1_valid && p->two->sha1_valid) &&
+		    !hashcmp(p->one->sha1, p->two->sha1))
+			diff_free_filepair(p); /* skip this */
+		else
+			diff_q(&outq, p);
+	}
+	free(q->queue);
+	*q = outq;
+}
+
 void diffcore_std(struct diff_options *options)
 {
 	if (options->skip_stat_unmatch)
 		diffcore_skip_stat_unmatch(options);
+	if (DIFF_OPT_TST(options, IGNORE_MODE_CHANGE))
+		diffcore_ignore_mode_change(options);
 	if (!options->found_follow) {
 		/* See try_to_follow_renames() in tree-diff.c */
 		if (options->break_opt != -1)
diff --git a/diff.h b/diff.h
index 0083d92..9f10f72 100644
--- a/diff.h
+++ b/diff.h
@@ -78,6 +78,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES (1 << 25)
 #define DIFF_OPT_IGNORE_DIRTY_SUBMODULES (1 << 26)
 #define DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG (1 << 27)
+#define DIFF_OPT_IGNORE_MODE_CHANGE  (1 << 30)
 
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
-- 
1.7.9.2.350.g74d65
