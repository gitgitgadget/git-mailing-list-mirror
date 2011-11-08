From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/12] fmt-merge-msg: package options into a structure
Date: Mon,  7 Nov 2011 19:00:40 -0800
Message-ID: <1320721245-13223-8-git-send-email-gitster@pobox.com>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
 <1320721245-13223-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 04:01:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNbwF-0001XL-Ey
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 04:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983Ab1KHDBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 22:01:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44586 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270Ab1KHDBD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 22:01:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C089C6517;
	Mon,  7 Nov 2011 22:01:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ohoV
	FWsESdTB+f6nzy2q+COW6Fw=; b=JTF5SErF30IIE5NXdpsb6m1jicg3FcgBFvAc
	wvczXwzBRaQv3ZPrVPdrpTafYwwC3GwV1YGvTR7F8IrIZXxi9ZXI09CMhPvdBzYP
	Qc0Gs/SQXi/g1/fkVyTOp9jiyQbYxAcVrsrS0x1hjOCiqCkjt++gndcXowTh9rN7
	QYOUjZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	OXrB6ikHOibAFBDrvDSe0bju+GvL9FUcoajUSyGKZTgk8hE+Vw1GK/lhpkacX6Et
	r9F9YB1Y5KbfaqY9NvPFBsQJBYS0xdbmPQDFmFPHb5FZBQrSCRdUDHjZEcKudKcv
	atyNWPZJAaSTrZyeY2zOoer47xzS5YlR9Q73KTvqfWM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7F9B6516;
	Mon,  7 Nov 2011 22:01:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 095066513; Mon,  7 Nov 2011
 22:01:01 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.g90e080
In-Reply-To: <1320721245-13223-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E438BAB8-09B5-11E1-A254-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185057>

This way new features can be added more easily

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin.h               |    8 +++++++-
 builtin/fmt-merge-msg.c |   29 ++++++++++++++---------------
 builtin/merge.c         |    8 ++++++--
 3 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/builtin.h b/builtin.h
index 0e9da90..e94a5dc 100644
--- a/builtin.h
+++ b/builtin.h
@@ -14,8 +14,14 @@ extern const char git_usage_string[];
 extern const char git_more_info_string[];
 
 extern void prune_packed_objects(int);
+
+struct fmt_merge_msg_opts {
+	unsigned add_title:1;
+	int shortlog_len;
+};
+
 extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
-			 int merge_title, int shortlog_len);
+			 struct fmt_merge_msg_opts *);
 extern void commit_notes(struct notes_tree *t, const char *msg);
 
 struct notes_rewrite_cfg {
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 7b492f9..3ff9564 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -209,7 +209,7 @@ static void shortlog(const char *name, unsigned char *sha1,
 	string_list_clear(&subjects, 0);
 }
 
-static void do_fmt_merge_msg_title(struct strbuf *out,
+static void fmt_merge_msg_title(struct strbuf *out,
 	const char *current_branch) {
 	int i = 0;
 	char *sep = "";
@@ -262,8 +262,9 @@ static void do_fmt_merge_msg_title(struct strbuf *out,
 		strbuf_addf(out, " into %s\n", current_branch);
 }
 
-static int do_fmt_merge_msg(int merge_title, struct strbuf *in,
-	struct strbuf *out, int shortlog_len) {
+int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
+		  struct fmt_merge_msg_opts *opts)
+{
 	int i = 0, pos = 0;
 	unsigned char head_sha1[20];
 	const char *current_branch;
@@ -289,10 +290,10 @@ static int do_fmt_merge_msg(int merge_title, struct strbuf *in,
 			die ("Error in line %d: %.*s", i, len, p);
 	}
 
-	if (merge_title && srcs.nr)
-		do_fmt_merge_msg_title(out, current_branch);
+	if (opts->add_title && srcs.nr)
+		fmt_merge_msg_title(out, current_branch);
 
-	if (shortlog_len) {
+	if (opts->shortlog_len) {
 		struct commit *head;
 		struct rev_info rev;
 
@@ -307,18 +308,13 @@ static int do_fmt_merge_msg(int merge_title, struct strbuf *in,
 
 		for (i = 0; i < origins.nr; i++)
 			shortlog(origins.items[i].string, origins.items[i].util,
-					head, &rev, shortlog_len, out);
+				 head, &rev, opts->shortlog_len, out);
 	}
 	if (out->len && out->buf[out->len-1] != '\n')
 		strbuf_addch(out, '\n');
 	return 0;
 }
 
-int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
-		  int merge_title, int shortlog_len) {
-	return do_fmt_merge_msg(merge_title, in, out, shortlog_len);
-}
-
 int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 {
 	const char *inpath = NULL;
@@ -340,6 +336,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	FILE *in = stdin;
 	struct strbuf input = STRBUF_INIT, output = STRBUF_INIT;
 	int ret;
+	struct fmt_merge_msg_opts opts;
 
 	git_config(fmt_merge_msg_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, fmt_merge_msg_usage,
@@ -361,10 +358,12 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 
 	if (message)
 		strbuf_addstr(&output, message);
-	ret = fmt_merge_msg(&input, &output,
-			    message ? 0 : 1,
-			    shortlog_len);
 
+	memset(&opts, 0, sizeof(opts));
+	opts.add_title = !message;
+	opts.shortlog_len = shortlog_len;
+
+	ret = fmt_merge_msg(&input, &output, &opts);
 	if (ret)
 		return ret;
 	write_in_full(STDOUT_FILENO, output.buf, output.len);
diff --git a/builtin/merge.c b/builtin/merge.c
index 6a44b6d..48e7f00 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1229,8 +1229,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			merge_name(argv[i], &merge_names);
 
 		if (!have_message || shortlog_len) {
-			fmt_merge_msg(&merge_names, &merge_msg, !have_message,
-				      shortlog_len);
+			struct fmt_merge_msg_opts opts;
+			memset(&opts, 0, sizeof(opts));
+			opts.add_title = !have_message;
+			opts.shortlog_len = shortlog_len;
+
+			fmt_merge_msg(&merge_names, &merge_msg, &opts);
 			if (merge_msg.len)
 				strbuf_setlen(&merge_msg, merge_msg.len - 1);
 		}
-- 
1.7.8.rc0.128.g31aa4
