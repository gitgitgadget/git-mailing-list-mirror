From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] pickaxe: allow -i to search in patch
 case-insensitively
Date: Tue, 28 Feb 2012 16:20:31 -0800
Message-ID: <1330474831-9030-3-git-send-email-gitster@pobox.com>
References: <1330474831-9030-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 29 01:21:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2XIG-0000Fa-Sv
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 01:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756942Ab2B2AVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 19:21:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32841 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965411Ab2B2AUh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 19:20:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F8D6645F
	for <git@vger.kernel.org>; Tue, 28 Feb 2012 19:20:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=lUBb
	uV6tSA/uMD/gNtCXvTtaNyM=; b=mtzAN8M58jQjA/vnfXRc9JzUQhz7z+2TKUBn
	KO2nrJPmr7AGa0A8fUnQq54rhmrO2NFNEa2qWV03q2ZbSFZMWOdf2JpgudnqhC5S
	mLFION+8LVM3hccZDn46GND5lRPc1M7Hy1qhM27QSMO02WtCGnkr/xHFESajvFst
	1R8OqrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=FLT/n0
	p9aLGn08RDyQ95fg/2t4K9+M7rRrZZut1E1BobSlp/LIiJ01tysWUdnDJYPfWaHc
	THmjjn/I0o2WV+/5br9aWzpqwZM/HU15dusP+c8Xaxv1yvifZ0momdTOd2CSVJ8Z
	o/SzK1w1G/AS+cWtiTk5mOt523tgymYQoEKK8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37175645E
	for <git@vger.kernel.org>; Tue, 28 Feb 2012 19:20:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F067645D for
 <git@vger.kernel.org>; Tue, 28 Feb 2012 19:20:36 -0500 (EST)
X-Mailer: git-send-email 1.7.9.2.344.g3e8c86
In-Reply-To: <1330474831-9030-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 33A4DB96-626B-11E1-A67D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191797>

"git log -S<string>" is a useful way to find the last commit in the
codebase that touched the <string>. As it was designed to be used by a
porcelain script to dig the history starting from a block of text that
appear in the starting commit, it never had to look for anything but an
exact match.

When used by an end user who wants to look for the last commit that
removed a string (e.g. name of a variable) that he vaguely remembers,
however, it is useful to support case insensitive match.

When given the "--regexp-ignore-case" (or "-i") option, which originally
was designed to affect case sensitivity of the search done in the commit
log part, e.g. "log --grep", the matches made with -S/-G pickaxe search is
done case insensitively now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.h                 |    1 +
 diffcore-pickaxe.c     |    9 +++-
 revision.c             |    1 +
 t/t4209-log-pickaxe.sh |  119 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 128 insertions(+), 2 deletions(-)
 create mode 100755 t/t4209-log-pickaxe.sh

diff --git a/diff.h b/diff.h
index 0c51724..436b574 100644
--- a/diff.h
+++ b/diff.h
@@ -80,6 +80,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG (1 << 27)
 #define DIFF_OPT_DIRSTAT_BY_LINE     (1 << 28)
 #define DIFF_OPT_FUNCCONTEXT         (1 << 29)
+#define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 30)
 
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 380a837..ed23eb4 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -138,8 +138,12 @@ static void diffcore_pickaxe_grep(struct diff_options *o)
 {
 	int err;
 	regex_t regex;
+	int cflags = REG_EXTENDED | REG_NEWLINE;
 
-	err = regcomp(&regex, o->pickaxe, REG_EXTENDED | REG_NEWLINE);
+	if (DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE))
+		cflags |= REG_ICASE;
+
+	err = regcomp(&regex, o->pickaxe, cflags);
 	if (err) {
 		char errbuf[1024];
 		regerror(err, &regex, errbuf, 1024);
@@ -237,7 +241,8 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 		}
 		regexp = &regex;
 	} else {
-		kws = kwsalloc(NULL);
+		kws = kwsalloc(DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE)
+			       ? tolower_trans_tbl : NULL);
 		kwsincr(kws, needle, len);
 		kwsprep(kws);
 	}
diff --git a/revision.c b/revision.c
index 8764dde..971b7dc 100644
--- a/revision.c
+++ b/revision.c
@@ -1559,6 +1559,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->grep_filter.regflags |= REG_EXTENDED;
 	} else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i")) {
 		revs->grep_filter.regflags |= REG_ICASE;
+		DIFF_OPT_SET(&revs->diffopt, PICKAXE_IGNORE_CASE);
 	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
 		revs->grep_filter.fixed = 1;
 	} else if (!strcmp(arg, "--all-match")) {
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
new file mode 100755
index 0000000..eed7273
--- /dev/null
+++ b/t/t4209-log-pickaxe.sh
@@ -0,0 +1,119 @@
+#!/bin/sh
+
+test_description='log --grep/--author/--regexp-ignore-case/-S/-G'
+. ./test-lib.sh
+
+test_expect_success setup '
+	>file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+
+	echo Picked >file &&
+	test_tick &&
+	git commit -a --author="Another Person <another@example.com>" -m second
+'
+
+test_expect_success 'log --grep' '
+	git log --grep=initial --format=%H >actual &&
+	git rev-parse --verify HEAD^ >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --grep --regexp-ignore-case' '
+	git log --regexp-ignore-case --grep=InItial --format=%H >actual &&
+	git rev-parse --verify HEAD^ >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --grep -i' '
+	git log -i --grep=InItial --format=%H >actual &&
+	git rev-parse --verify HEAD^ >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --author --regexp-ignore-case' '
+	git log --regexp-ignore-case --author=person --format=%H >actual &&
+	git rev-parse --verify HEAD >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --author -i' '
+	git log -i --author=person --format=%H >actual &&
+	git rev-parse --verify HEAD >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log -G (nomatch)' '
+	git log -Gpicked --format=%H >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log -G (match)' '
+	git log -GPicked --format=%H >actual &&
+	git rev-parse --verify HEAD >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log -G --regexp-ignore-case (nomatch)' '
+	git log --regexp-ignore-case -Gpickle --format=%H >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log -G -i (nomatch)' '
+	git log -i -Gpickle --format=%H >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log -G --regexp-ignore-case (match)' '
+	git log --regexp-ignore-case -Gpicked --format=%H >actual &&
+	git rev-parse --verify HEAD >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log -G -i (match)' '
+	git log -i -Gpicked --format=%H >actual &&
+	git rev-parse --verify HEAD >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log -S (nomatch)' '
+	git log -Spicked --format=%H >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log -S (match)' '
+	git log -SPicked --format=%H >actual &&
+	git rev-parse --verify HEAD >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log -S --regexp-ignore-case (match)' '
+	git log --regexp-ignore-case -Spicked --format=%H >actual &&
+	git rev-parse --verify HEAD >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log -S -i (match)' '
+	git log -i -Spicked --format=%H >actual &&
+	git rev-parse --verify HEAD >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log -S --regexp-ignore-case (nomatch)' '
+	git log --regexp-ignore-case -Spickle --format=%H >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log -S -i (nomatch)' '
+	git log -i -Spickle --format=%H >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.7.9.2.344.g3e8c86
