Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF44C20455
	for <e@80x24.org>; Mon, 16 Oct 2017 10:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbdJPKpu (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 06:45:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64250 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751358AbdJPKpt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 06:45:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7EA90A85F1;
        Mon, 16 Oct 2017 06:45:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xQ/P+2CnM0nD1Nr7AcyVKUeLmQg=; b=Swurlh
        v9nBel27XTtI6y+IN4HaWrJcU8GxBq0zOV1Y2z45qNYTjHldzwR2xAg33gJMOwQS
        s5wP4n/jJxrY5olJiVlwojJKCpiSKUnPIHPmIrPAtrgs+zbfatD6FPX9LgqZC7k8
        KbhFgxkJ/6+q1oKBiAJuE42XjRBjGMwTVZTyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ggH41gIsKiB1TK+WfLf+9EZ5pQ8Ledy0
        GOtsJ/Tj1WXtrH70eWjREnfe/0D8sm80x+eLFkBnJZtfu8K8YFRenvejXRWvcXqu
        OQZy7utmMA0obPEJIb5dpdpCWL38XNCsPQ0/tb43oI+k3CHnaTWtoVNaM0u+QxBt
        DogdvYjwu3o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 74A9BA85F0;
        Mon, 16 Oct 2017 06:45:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 931A0A85EF;
        Mon, 16 Oct 2017 06:45:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Cc:     Marko Kungla <marko.kungla@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] check-ref-format: require a repository for --branch
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
        <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
        <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
        <20170717172709.GL93855@aiede.mtv.corp.google.com>
        <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
        <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 16 Oct 2017 19:45:46 +0900
In-Reply-To: <xmqqinffsibr.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 16 Oct 2017 15:44:08 +0900")
Message-ID: <xmqq1sm3s751.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B4CC9B4-B25F-11E7-A70E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Having said that, there may still be a use case where a Porcelain
> script wants a way to see if a $name it has is appropriate as a
> branch name before it has a repository (e.g. a wrapper to "git
> clone" that wants to verify the name it is going to give to the "-b"
> option), and a check desired in such a context is different from
> (and is stricter than) feeding refs/heads/$name to the same command
> without the "--branch" option.
>
> So I think the right endgame in the longer term is:
> ...

Here is to illustrate what I mean in a patch form.  It resurrects
the gentle setup, and uses a purely textual format check when we are
outside the repository, while bypassing the @{magic} interpolation
codepath that requires us to be in a repository.  When we are in a
repository, we operate the same way as before.

Designed to be applied directly on top of 4d03f955
("check-ref-format: require a repository for --branch", 2017-07-14),
so it is missing the "'HEAD' is not a good branch name" I showed a
few days ago.

 builtin/check-ref-format.c  | 16 +++++++++++++---
 cache.h                     | 14 ++++++++++++++
 sha1_name.c                 | 22 +++++++++++++++++++---
 strbuf.h                    |  6 ++++++
 t/t1402-check-ref-format.sh | 10 +++++++++-
 5 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 1e5f9835f0..4e62852089 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -38,12 +38,22 @@ static char *collapse_slashes(const char *refname)
 
 static int check_ref_format_branch(const char *arg)
 {
+	int nongit, malformed;
 	struct strbuf sb = STRBUF_INIT;
+	const char *name = arg;
 
-	setup_git_directory();
-	if (strbuf_check_branch_ref(&sb, arg))
+	setup_git_directory_gently(&nongit);
+
+	if (!nongit)
+		malformed = (strbuf_check_branch_ref(&sb, arg) ||
+			     !skip_prefix(sb.buf, "refs/heads/", &name));
+	else
+		malformed = check_branch_ref_format(arg);
+
+	if (malformed)
 		die("'%s' is not a valid branch name", arg);
-	printf("%s\n", sb.buf + 11);
+	printf("%s\n", name);
+	strbuf_release(&sb);
 	return 0;
 }
 
diff --git a/cache.h b/cache.h
index 52b91f5b64..3815925122 100644
--- a/cache.h
+++ b/cache.h
@@ -1444,6 +1444,20 @@ extern int parse_oid_hex(const char *hex, struct object_id *oid, const char **en
 #define INTERPRET_BRANCH_HEAD (1<<2)
 extern int interpret_branch_name(const char *str, int len, struct strbuf *,
 				 unsigned allowed);
+
+/*
+ * NEEDSWORK: declare strbuf_branchname() and strbuf_check_branch_ref()
+ * here, not in strbuf.h
+ */
+
+/*
+ * Check if a 'name' is suitable to be used as a branch name; this can
+ * be and is stricter than what check_refname_format() returns for a
+ * string that is a concatenation of "name" after "refs/heads/"; a
+ * name that begins with "-" is not allowed, for example.
+ */
+extern int check_branch_ref_format(const char *name);
+
 extern int get_oid_mb(const char *str, struct object_id *oid);
 
 extern int validate_headref(const char *ref);
diff --git a/sha1_name.c b/sha1_name.c
index 5e2ec37b65..c95080258f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1319,15 +1319,31 @@ void strbuf_branchname(struct strbuf *sb, const char *name, unsigned allowed)
 	strbuf_add(sb, name + used, len - used);
 }
 
-int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
+static int strbuf_check_branch_ref_format(struct strbuf *sb)
 {
-	strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
-	if (name[0] == '-')
+	if (*sb->buf == '-')
 		return -1;
 	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
 	return check_refname_format(sb->buf, 0);
 }
 
+int check_branch_ref_format(const char *name)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int result;
+
+	strbuf_addstr(&sb, name);
+	result = strbuf_check_branch_ref_format(&sb);
+	strbuf_release(&sb);
+	return result;
+}
+
+int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
+{
+	strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
+	return strbuf_check_branch_ref_format(sb);
+}
+
 /*
  * This is like "get_sha1_basic()", except it allows "sha1 expressions",
  * notably "xyz^" for "parent of xyz"
diff --git a/strbuf.h b/strbuf.h
index d785258649..3da95685b2 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -568,6 +568,12 @@ static inline void strbuf_complete_line(struct strbuf *sb)
 	strbuf_complete(sb, '\n');
 }
 
+/*
+ * NEEDSWORK: the following two functions should not be in this file;
+ * these are about refnames, and should be declared next to
+ * interpret_branch_name() in cache.h
+ */
+
 /*
  * Copy "name" to "sb", expanding any special @-marks as handled by
  * interpret_branch_name(). The result is a non-qualified branch name
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 1674b061e2..2ddefb4bd1 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -161,10 +161,18 @@ test_expect_success 'check-ref-format --branch from subdir' '
 	test "$refname" = "$sha1"
 '
 
-test_expect_success 'check-ref-format --branch from non-repo' '
+test_expect_success 'check-ref-format --branch @{-1} from non-repo' '
 	test_must_fail nongit git check-ref-format --branch @{-1}
 '
 
+test_expect_success 'check-ref-format --branch master in non-repo' '
+	nongit git check-ref-format --branch master
+'
+
+test_expect_success 'check-ref-format --branch -naster in repo' '
+	test_must_fail git check-ref-format --branch -naster
+'
+
 valid_ref_normalized() {
 	prereq=
 	case $1 in
