Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B872C433DF
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 20:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F1902075D
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 20:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i5WJ893w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGMUSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:18:14 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63670 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgGMUSN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 16:18:13 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7DDF9CE08A;
        Mon, 13 Jul 2020 16:18:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZMl7Is8ZD3xHkTaMnUqpqSep7Zc=; b=i5WJ89
        3wyPozpAMI5h0i8aHbeCeDeONTdY67awR3aIQiVP+XCQwT1c72AnPFqMZxfHe6UU
        twd4nkeFpDzn22MKEW54AgUrCKh7ey6fhRJmigZCB1KdHyp8GvNpX401kFlVlK3B
        7CO9nVyhJLhQGJUeO50iUhgZ3Kyo1VX2IZOL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ygsfLL8fmMWlUvJFuLcVJKO1dmBiy6Yj
        hhihVyPEj5+P9ogxklAC7G5u47ZxueGs5RXwX7cpr655e0HGKeXmCsswlZcvHv1J
        E+hji72iHW2irRol43T+LRC3MRcHppEMqRaO0MSKb3MRmkuZT23KL5j2iDhylgY9
        nf/LAIt5Xa8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7619FCE089;
        Mon, 13 Jul 2020 16:18:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BD459CE088;
        Mon, 13 Jul 2020 16:18:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, delphij@google.com,
        peff@peff.net, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] setup: tweak upgrade policy to grandfather worktreeconfig
References: <pull.674.git.1594668051847.gitgitgadget@gmail.com>
        <xmqqblkjnr5m.fsf@gitster.c.googlers.com>
        <xmqqy2nnmbh8.fsf@gitster.c.googlers.com>
Date:   Mon, 13 Jul 2020 13:18:06 -0700
In-Reply-To: <xmqqy2nnmbh8.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 13 Jul 2020 13:00:35 -0700")
Message-ID: <xmqqpn8zmao1.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F72336EE-C545-11EA-86CE-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "fail and warn" approach introduced in the previous step may be
with smaller impact to the codebase, but

 - it requires the end-user to read, understand and execute the
   manual upgrade

 - it encourages to follow the same procedure blindly, making the
   protection even less useful

Let's instead keep failing hard without teaching how to bypass the
repository protection, but allow upgrading even when only the
worktreeconfig extension exists in an old repository, which is
likely to be set by a broke version of Git that did not update the
repository version when setting the extension.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This time with a log message to explain and justify the change,
   with a matching tweak to the test script, designed to be applied
   on top, but feel free to squash it in if you agree with me that
   we do not need two separate commits for this.

   Thanks.

 cache.h                            |  2 +-
 setup.c                            | 17 ++++++++---------
 t/t1091-sparse-checkout-builtin.sh |  9 ---------
 3 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/cache.h b/cache.h
index e5885cc9ea..8ff46857f6 100644
--- a/cache.h
+++ b/cache.h
@@ -1042,8 +1042,8 @@ struct repository_format {
 	int worktree_config;
 	int is_bare;
 	int hash_algo;
-	int has_extensions;
 	char *work_tree;
+	int has_unallowed_extensions;
 	struct string_list unknown_extensions;
 };
 
diff --git a/setup.c b/setup.c
index 6ff6c54d39..65270440a9 100644
--- a/setup.c
+++ b/setup.c
@@ -455,12 +455,13 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 	if (strcmp(var, "core.repositoryformatversion") == 0)
 		data->version = git_config_int(var, value);
 	else if (skip_prefix(var, "extensions.", &ext)) {
-		data->has_extensions = 1;
 		/*
 		 * record any known extensions here; otherwise,
 		 * we fall through to recording it as unknown, and
 		 * check_repository_format will complain
 		 */
+		int is_unallowed_extension = 1;
+
 		if (!strcmp(ext, "noop"))
 			;
 		else if (!strcmp(ext, "preciousobjects"))
@@ -469,10 +470,13 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 			if (!value)
 				return config_error_nonbool(var);
 			data->partial_clone = xstrdup(value);
-		} else if (!strcmp(ext, "worktreeconfig"))
+		} else if (!strcmp(ext, "worktreeconfig")) {
 			data->worktree_config = git_config_bool(var, value);
-		else
+			is_unallowed_extension = 0;
+		} else
 			string_list_append(&data->unknown_extensions, ext);
+
+		data->has_unallowed_extensions |= is_unallowed_extension;
 	}
 
 	return read_worktree_config(var, value, vdata);
@@ -542,11 +546,6 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 		}
 	}
 
-	if (candidate->version == 0 && candidate->has_extensions) {
-		warning(_("some extensions are enabled, but core.repositoryFormatVersion=0"));
-		warning(_("if you intended to use extensions, run 'git config core.repositoryFormatVersion 1'"));
-	}
-
 	return 0;
 }
 
@@ -565,7 +564,7 @@ int upgrade_repository_format(int target_version)
 		return 0;
 
 	if (verify_repository_format(&repo_fmt, &err) < 0 ||
-	    (!repo_fmt.version && repo_fmt.has_extensions)) {
+	    (!repo_fmt.version && repo_fmt.has_unallowed_extensions)) {
 		warning("unable to upgrade repository format from %d to %d: %s",
 			repo_fmt.version, target_version, err.buf);
 		strbuf_release(&err);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index d249428f44..88cdde255c 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -68,15 +68,6 @@ test_expect_success 'git sparse-checkout init' '
 	check_files repo a
 '
 
-test_expect_success 'warning about core.repositoryFormatVersion' '
-	test_when_finished git -C repo config core.repositoryFormatVersion 1 &&
-	git -C repo status 2>err &&
-	test_must_be_empty err &&
-	git -C repo config --local core.repositoryFormatVersion 0 &&
-	git -C repo status 2>err &&
-	test_i18ngrep "some extensions are enabled, but core.repositoryFormatVersion=0" err
-'
-
 test_expect_success 'git sparse-checkout list after init' '
 	git -C repo sparse-checkout list >actual &&
 	cat >expect <<-\EOF &&
-- 
2.28.0-rc0

