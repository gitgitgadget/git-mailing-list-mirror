Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09EB91F462
	for <e@80x24.org>; Thu,  6 Jun 2019 21:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfFFVjO (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 17:39:14 -0400
Received: from resqmta-po-04v.sys.comcast.net ([96.114.154.163]:50390 "EHLO
        resqmta-po-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728448AbfFFVjK (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Jun 2019 17:39:10 -0400
Received: from resomta-po-05v.sys.comcast.net ([96.114.154.229])
        by resqmta-po-04v.sys.comcast.net with ESMTP
        id YyJnhLbCPJeJHZ06HhWa6w; Thu, 06 Jun 2019 21:39:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20180828_2048; t=1559857149;
        bh=EUN68Mfwb3TJ+WefXLJBR/hET7xDa3/qcmaRWOejUJg=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=RC6ayzgK2c69oUwsRp93NEj7AJU3o+plsNv0eJyDn2zN0oQBXa/ycaPA0SvpmRBo/
         UJVY+30rgkxYBDEmc3EKCTzwREVyLmvC1lLQY7UHibYDG2U96+q2xabmHKYIo63HnP
         d/LslWRZh1HRqjfvCwYuVNMveTs0sxAq8iDlZhi8ifPSC4MgZ/sr3zmqAi7LoJGVz4
         xoCbatoYGGceM2qB2elsv60TA9LAWUig4EoOrJAi1RD8f8xeabXEJ0Eq6sHiFK4XZr
         H5h9Sxit2N4oqEaeqReoEuuBYv33vDuAILLOcD9auTnsEAhUdqDticF8NvuTL27Uw9
         WIBVrH9QZ/WiQ==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:fd28:a9c3:fb88:6b87])
        by resomta-po-05v.sys.comcast.net with ESMTPSA
        id Z05UhL8FcDlddZ05mhUHPK; Thu, 06 Jun 2019 21:39:06 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Thu, 6 Jun 2019 14:38:20 -0700
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Johannes.Schindelin@gmx.de, git@matthieu-moy.fr,
        olyatelezhnaya@gmail.com, samuel.maftoul@gmail.com,
        gitster@pobox.com, karthik.188@gmail.com, pclouds@gmail.com,
        sunshine@sunshineco.com, emilyshaffer@google.com, jrn@google.com,
        matvore@google.com
Subject: [RFC PATCH] ref-filter: sort detached HEAD lines firstly
Message-ID: <faaa9a3d6ba66d77cc2a8eab438d1bfc8f762fa1.1559857032.git.matvore@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before this patch, "git branch" would put "(HEAD detached...)" and "(no
branch, rebasing...)" lines before all the other branches *in most
cases* and only because of the fact that "(" is a low codepoint. This
would not hold in the Chinese locale, which uses a full-width "(" symbol
(codepoint FF08). This meant that the detached HEAD line would appear
after all local refs and even after the remote refs if there were any.

Deliberately sort the detached HEAD refs before other refs when sorting
by refname rather than rely on codepoint subtleties.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 ref-filter.c           | 10 +++++++---
 t/lib-gettext.sh       | 16 +++++++++++++---
 t/t3207-branch-intl.sh | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 6 deletions(-)
 create mode 100755 t/t3207-branch-intl.sh

diff --git a/ref-filter.c b/ref-filter.c
index 8500671bc6..cbfae790f9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2157,25 +2157,29 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	cmp_type cmp_type = used_atom[s->atom].type;
 	int (*cmp_fn)(const char *, const char *);
 	struct strbuf err = STRBUF_INIT;
 
 	if (get_ref_atom_value(a, s->atom, &va, &err))
 		die("%s", err.buf);
 	if (get_ref_atom_value(b, s->atom, &vb, &err))
 		die("%s", err.buf);
 	strbuf_release(&err);
 	cmp_fn = s->ignore_case ? strcasecmp : strcmp;
-	if (s->version)
+	if (s->version) {
 		cmp = versioncmp(va->s, vb->s);
-	else if (cmp_type == FIELD_STR)
+	} else if (cmp_type == FIELD_STR) {
+		if ((a->kind & FILTER_REFS_DETACHED_HEAD) !=
+				(b->kind & FILTER_REFS_DETACHED_HEAD)) {
+			return (a->kind & FILTER_REFS_DETACHED_HEAD) ? -1 : 1;
+		}
 		cmp = cmp_fn(va->s, vb->s);
-	else {
+	} else {
 		if (va->value < vb->value)
 			cmp = -1;
 		else if (va->value == vb->value)
 			cmp = cmp_fn(a->refname, b->refname);
 		else
 			cmp = 1;
 	}
 
 	return (s->reverse) ? -cmp : cmp;
 }
diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index 2139b427ca..de08d109dc 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -25,23 +25,29 @@ then
 		p
 		q
 	}')
 	# is_IS.ISO8859-1 on Solaris and FreeBSD, is_IS.iso88591 on Debian
 	is_IS_iso_locale=$(locale -a 2>/dev/null |
 		sed -n '/^is_IS\.[iI][sS][oO]8859-*1$/{
 		p
 		q
 	}')
 
-	# Export them as an environment variable so the t0202/test.pl Perl
-	# test can use it too
-	export is_IS_locale is_IS_iso_locale
+	zh_CN_locale=$(locale -a 2>/dev/null |
+		sed -n '/^zh_CN\.[uU][tT][fF]-*8$/{
+		p
+		q
+	}')
+
+	# Export them as environment variables so other tests can use them
+	# too
+	export is_IS_locale is_IS_iso_locale zh_CN_locale
 
 	if test -n "$is_IS_locale" &&
 		test $GIT_INTERNAL_GETTEXT_SH_SCHEME != "fallthrough"
 	then
 		# Some of the tests need the reference Icelandic locale
 		test_set_prereq GETTEXT_LOCALE
 
 		# Exporting for t0202/test.pl
 		GETTEXT_LOCALE=1
 		export GETTEXT_LOCALE
@@ -53,11 +59,15 @@ then
 	if test -n "$is_IS_iso_locale" &&
 		test $GIT_INTERNAL_GETTEXT_SH_SCHEME != "fallthrough"
 	then
 		# Some of the tests need the reference Icelandic locale
 		test_set_prereq GETTEXT_ISO_LOCALE
 
 		say "# lib-gettext: Found '$is_IS_iso_locale' as an is_IS ISO-8859-1 locale"
 	else
 		say "# lib-gettext: No is_IS ISO-8859-1 locale available"
 	fi
+
+	if test -z "$zh_CN_locale"; then
+		say "# lib-gettext: No zh_CN UTF-8 locale available"
+	fi
 fi
diff --git a/t/t3207-branch-intl.sh b/t/t3207-branch-intl.sh
new file mode 100755
index 0000000000..9f6fcc7481
--- /dev/null
+++ b/t/t3207-branch-intl.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='git branch internationalization tests'
+
+. ./lib-gettext.sh
+
+test_expect_success 'init repo' '
+	git init r1 &&
+	touch r1/foo &&
+	git -C r1 add foo &&
+	git -C r1 commit -m foo
+'
+
+test_expect_success 'detached head sorts before other branches' '
+	# Ref sorting logic should put detached heads before the other
+	# branches, but this is not automatic when a branch name sorts
+	# lexically before "(" or the full-width "(" (Unicode codepoint FF08).
+	# The latter case is nearly guaranteed for the Chinese locale.
+
+	git -C r1 checkout HEAD^{} -- &&
+	git -C r1 branch !should_be_after_detached HEAD &&
+	LC_ALL=$zh_CN_locale LC_MESSAGES=$zh_CN_locale \
+		git -C r1 branch >actual &&
+	git -C r1 checkout - &&
+
+	awk "
+	# We need full-width or half-width parens on the first line.
+	NR == 1 && (/[(].*[)]/ || /\xef\xbc\x88.*\xef\xbc\x89/) {
+		found_head = 1;
+	}
+	/!should_be_after_detached/ {
+		found_control_branch = 1;
+	}
+	END { exit !found_head || !found_control_branch }
+	" actual
+'
+
+test_done
-- 
2.21.0

