From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/6] grep: move pattern-type bits support to top-level
 grep.[ch]
Date: Wed,  3 Oct 2012 18:33:35 -0700
Message-ID: <1349314419-8397-3-git-send-email-gitster@pobox.com>
References: <7v626r48cv.fsf@alter.siamese.dyndns.org>
 <1349314419-8397-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 04 23:59:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtN0-0001DP-Qw
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906Ab2JDBdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 21:33:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52851 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786Ab2JDBdp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 21:33:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 766E18060
	for <git@vger.kernel.org>; Wed,  3 Oct 2012 21:33:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=qMMo
	NW8Fzo+OnKDluvusXuqEk7Q=; b=cjPun2YsTi22Zlu/C/l1R44HehYBv4fzC9oL
	R6deopLQxpK9WvcLbjWM0R+fad5olh4B1tMiajtqxJfuQwG4CO9RjEf84bwqpHVS
	BVqUesQaO46fXZhfJ2OniLZInD1G1dL/XZcRZ0KWUg//bdYh/PWfbf0myC0OTnSE
	G+ioWEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=mXZAZ7
	jkx5e5eQc8VW4a3qb1xqXY8hvmiGRGEnEVjt76jfbGF6aO6w/S+CJY1iWPtJ4YwZ
	3MD5Q+XEL4xW7wWVfWcSYQusnUtmKuquuWqw3FWPI+wFDlcM9RRj9ZcxhMI1GZpf
	j5qqUhff70tunw17FW4d5MVWa9WSbfC/4rkng=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63783805F
	for <git@vger.kernel.org>; Wed,  3 Oct 2012 21:33:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F61E805E for
 <git@vger.kernel.org>; Wed,  3 Oct 2012 21:33:44 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc0.57.g712528f
In-Reply-To: <1349314419-8397-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8939E336-0DC3-11E2-BE34-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206947>

Switching between -E/-G/-P/-F correctly needs a lot more than just
flipping opt->regflags bit these days, and we have a nice helper
function buried in builtin/grep.c for the sole use of "git grep".

Extract it so that "log --grep" family can also use it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/grep.c | 38 +++-----------------------------------
 grep.c         | 32 ++++++++++++++++++++++++++++++++
 grep.h         |  1 +
 3 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index ce379d5..2b14fee 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -261,38 +261,6 @@ static int wait_all(void)
 }
 #endif
 
-static void grep_pattern_type_options(const int pattern_type, struct grep_opt *opt)
-{
-	switch (pattern_type) {
-	case GREP_PATTERN_TYPE_UNSPECIFIED:
-		/* fall through */
-
-	case GREP_PATTERN_TYPE_BRE:
-		opt->fixed = 0;
-		opt->pcre = 0;
-		opt->regflags &= ~REG_EXTENDED;
-		break;
-
-	case GREP_PATTERN_TYPE_ERE:
-		opt->fixed = 0;
-		opt->pcre = 0;
-		opt->regflags |= REG_EXTENDED;
-		break;
-
-	case GREP_PATTERN_TYPE_FIXED:
-		opt->fixed = 1;
-		opt->pcre = 0;
-		opt->regflags &= ~REG_EXTENDED;
-		break;
-
-	case GREP_PATTERN_TYPE_PCRE:
-		opt->fixed = 0;
-		opt->pcre = 1;
-		opt->regflags &= ~REG_EXTENDED;
-		break;
-	}
-}
-
 static void *lock_and_read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
 {
 	void *data;
@@ -810,11 +778,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_NO_INTERNAL_HELP);
 
 	if (pattern_type_arg != GREP_PATTERN_TYPE_UNSPECIFIED)
-		grep_pattern_type_options(pattern_type_arg, &opt);
+		grep_set_pattern_type_option(pattern_type_arg, &opt);
 	else if (opt.pattern_type_option != GREP_PATTERN_TYPE_UNSPECIFIED)
-		grep_pattern_type_options(opt.pattern_type_option, &opt);
+		grep_set_pattern_type_option(opt.pattern_type_option, &opt);
 	else if (opt.extended_regexp_option)
-		grep_pattern_type_options(GREP_PATTERN_TYPE_ERE, &opt);
+		grep_set_pattern_type_option(GREP_PATTERN_TYPE_ERE, &opt);
 
 	if (use_index && !startup_info->have_repository)
 		/* die the same way as if we did it at the beginning */
diff --git a/grep.c b/grep.c
index 551a2ed..0d8df65 100644
--- a/grep.c
+++ b/grep.c
@@ -1585,3 +1585,35 @@ int grep_config(const char *var, const char *value, void *cb)
 	}
 	return 0;
 }
+
+void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, struct grep_opt *opt)
+{
+	switch (pattern_type) {
+	case GREP_PATTERN_TYPE_UNSPECIFIED:
+		/* fall through */
+
+	case GREP_PATTERN_TYPE_BRE:
+		opt->fixed = 0;
+		opt->pcre = 0;
+		opt->regflags &= ~REG_EXTENDED;
+		break;
+
+	case GREP_PATTERN_TYPE_ERE:
+		opt->fixed = 0;
+		opt->pcre = 0;
+		opt->regflags |= REG_EXTENDED;
+		break;
+
+	case GREP_PATTERN_TYPE_FIXED:
+		opt->fixed = 1;
+		opt->pcre = 0;
+		opt->regflags &= ~REG_EXTENDED;
+		break;
+
+	case GREP_PATTERN_TYPE_PCRE:
+		opt->fixed = 0;
+		opt->pcre = 1;
+		opt->regflags &= ~REG_EXTENDED;
+		break;
+	}
+}
diff --git a/grep.h b/grep.h
index 5381adc..2f6aaa5 100644
--- a/grep.h
+++ b/grep.h
@@ -145,6 +145,7 @@ extern void compile_grep_patterns(struct grep_opt *opt);
 extern void free_grep_patterns(struct grep_opt *opt);
 extern int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size);
 
+void grep_set_pattern_type_option(enum grep_pattern_type, struct grep_opt *opt);
 int grep_config(const char *var, const char *value, void *cb);
 
 struct grep_source {
-- 
1.8.0.rc0.57.g712528f
