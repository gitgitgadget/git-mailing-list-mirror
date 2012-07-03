From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 19/25] revision.c: the "log" family, except for "show",
 takes committish
Date: Tue,  3 Jul 2012 14:37:09 -0700
Message-ID: <1341351435-31011-20-git-send-email-gitster@pobox.com>
References: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:38:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAo5-00061R-Ax
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932830Ab2GCViY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:38:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35221 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756567Ab2GCVhz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:37:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08D1C868E
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=EEq/
	KOKG1RzRA/yH9yXmFxkzRys=; b=OdDkvj8I/gN/CMvpuYJ9Z7dkP79rGxtUfLJm
	Pc2EGJhiHm3NfVZfWaGVVv+jEMYtZTBb3FBqlRl1kzCGi0tZ+5Y9/6a1wzl6Alp6
	heNvBbokjHMH/0mI8zw4Ali3pVrMSv0tbyBMVlWDBxdbXyB/U0S1rbywsrd8Evl/
	rQS5CGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=K7g/Ml
	4pAnkmLjFPZdjiC5vp7X3EfANlgtOC2eOIzcxRHidKxKx79SOyq4PvbtpB4frZJr
	pE0qz9Jq3u6uT5x+doYx8nBPcX+/O6Zyp956bNMLpJbgCHFruKFiChz3es+NsASj
	d2xn5mgjfUGkaDpZrBbQbxQOAG6QggM/xPxPI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F39D7868D
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5ADF1868C for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:54 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
In-Reply-To: <1341351435-31011-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 58FFD018-C557-11E1-ABE5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200962>

Add a field to setup_revision_opt structure and allow these callers
to tell the setup_revisions command parsing machinery that short SHA1
it encounters are meant to name committish.

This step does not go all the way to connect the setup_revisions()
to sha1_name.c yet.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c                       |  3 +++
 revision.c                          | 11 +++++++++--
 revision.h                          |  2 ++
 t/t1512-rev-parse-disambiguation.sh |  2 +-
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 7d1f6f8..9363f39 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -363,6 +363,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	rev.simplify_history = 0;
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
+	opt.revarg_opt = REVARG_COMMITTISH;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
@@ -543,6 +544,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	rev.always_show_header = 1;
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
+	opt.revarg_opt = REVARG_COMMITTISH;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
 	return cmd_log_walk(&rev);
 }
@@ -1144,6 +1146,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.subject_prefix = fmt_patch_subject_prefix;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.def = "HEAD";
+	s_r_opt.revarg_opt = REVARG_COMMITTISH;
 
 	if (default_attach) {
 		rev.mime_boundary = default_attach;
diff --git a/revision.c b/revision.c
index 929497f..ec6f0c8 100644
--- a/revision.c
+++ b/revision.c
@@ -1102,6 +1102,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	int local_flags;
 	const char *arg = arg_;
 	int cant_be_filename = revarg_opt & REVARG_CANNOT_BE_FILENAME;
+	unsigned get_sha1_flags = 0;
 
 	dotdot = strstr(arg, "..");
 	if (dotdot) {
@@ -1179,7 +1180,11 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 		local_flags = UNINTERESTING;
 		arg++;
 	}
-	if (get_sha1_with_context(arg, 0, sha1, &oc))
+
+	if (revarg_opt & REVARG_COMMITTISH)
+		get_sha1_flags = GET_SHA1_COMMITTISH;
+
+	if (get_sha1_with_context(arg, get_sha1_flags, sha1, &oc))
 		return revs->ignore_missing ? 0 : -1;
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
@@ -1707,7 +1712,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	/* Second, deal with arguments and options */
 	flags = 0;
-	revarg_opt = seen_dashdash ? REVARG_CANNOT_BE_FILENAME : 0;
+	revarg_opt = opt ? opt->revarg_opt : 0;
+	if (seen_dashdash)
+		revarg_opt |= REVARG_CANNOT_BE_FILENAME;
 	read_from_stdin = 0;
 	for (left = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/revision.h b/revision.h
index 8eceaec..402f10d 100644
--- a/revision.h
+++ b/revision.h
@@ -183,6 +183,7 @@ struct setup_revision_opt {
 	const char *def;
 	void (*tweak)(struct rev_info *, struct setup_revision_opt *);
 	const char *submodule;
+	unsigned revarg_opt;
 };
 
 extern void init_revisions(struct rev_info *revs, const char *prefix);
@@ -191,6 +192,7 @@ extern void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ct
 				 const struct option *options,
 				 const char * const usagestr[]);
 #define REVARG_CANNOT_BE_FILENAME 01
+#define REVARG_COMMITTISH 02
 extern int handle_revision_arg(const char *arg, struct rev_info *revs, int flags, unsigned revarg_opt);
 
 extern int prepare_revision_walk(struct rev_info *revs);
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 7c92451..417b436 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -117,7 +117,7 @@ test_expect_failure 'rev-parse name1..name2 takes only commit-ishes on both ends
 	git rev-parse 11021982..
 '
 
-test_expect_failure 'git log takes only commit-ish' '
+test_expect_success 'git log takes only commit-ish' '
 	git log 11021982
 '
 
-- 
1.7.11.1.229.g706c98f
