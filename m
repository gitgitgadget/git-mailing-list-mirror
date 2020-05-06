Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68812C47256
	for <git@archiver.kernel.org>; Wed,  6 May 2020 20:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FA22078C
	for <git@archiver.kernel.org>; Wed,  6 May 2020 20:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZQy047D7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgEFUSj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 16:18:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55237 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgEFUSg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 16:18:36 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CFF5160F6B;
        Wed,  6 May 2020 16:18:32 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=cWImBeD1oMT7xXkso5c3rnZkZ
        hU=; b=ZQy047D7cHjJ4JC63I1wMvf3/gQTVQCD/ItZi6rr3x71p6wMkT7DHgUFe
        Jt1q3kldADj5MlwhwHd4YlIR3o9yUdURdVCLQmvf18nEJk8Ks+pDbjQuFM08jXAS
        P3LBuLjCc5DCgN9FVnw5I09k+w0vNiUxhZiOaWpC8nE0mswatc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=DAuZSRGi6bxQW5M41Xi
        0Tb5fOmqgJDcPpJuwxD1iRRDDSneYtwPuSRs2TVjaJomni6jVV7D6LfHqYrmQBYC
        aO8k9k5eV6wwlRv6C6F5JfsbB9yZDrtXJxBTkdob29qUWTz0R5BRvpeoS1iZhRMC
        8mGAB/84akJDwnyH0pq1LDOg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C819660F68;
        Wed,  6 May 2020 16:18:32 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4FA7A60F67;
        Wed,  6 May 2020 16:18:32 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] auto-gc: extract a reusable helper from "git fetch"
Date:   Wed,  6 May 2020 13:18:29 -0700
Message-Id: <20200506201830.92818-2-gitster@pobox.com>
X-Mailer: git-send-email 2.26.2-561-g07d8ea56f2
In-Reply-To: <20200506201830.92818-1-gitster@pobox.com>
References: <20200506094327.GC31637@rillettes>
 <20200506201830.92818-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: C1AE5BAA-8FD6-11EA-8533-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Back in 1991006c (fetch: convert argv_gc_auto to struct argv_array,
2014-08-16), we taught "git fetch --quiet" to pass the "--quiet"
option down to "gc --auto".  This issue, however, is not limited to
"fetch":

    $ git grep -e 'gc.*--auto' \*.c

finds hits in "am", "commit", "merge", and "rebase" and these
commands do not pass "--quiet" down to "gc --auto" when they
themselves are told to be quiet.

As a preparatory step, let's introduce a helper function
run_auto_gc(), that the caller can pass a boolean "quiet",
and redo the fix to "git fetch" using the helper.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c | 10 ++--------
 run-command.c   | 13 +++++++++++++
 run-command.h   |  5 +++++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index bf6bab80fa..3e580b9559 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1759,7 +1759,6 @@ int cmd_fetch(int argc, const char **argv, const ch=
ar *prefix)
 	struct remote *remote =3D NULL;
 	int result =3D 0;
 	int prune_tags_ok =3D 1;
-	struct argv_array argv_gc_auto =3D ARGV_ARRAY_INIT;
=20
 	packet_trace_identity("fetch");
=20
@@ -1886,13 +1885,8 @@ int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
=20
 	close_object_store(the_repository->objects);
=20
-	if (enable_auto_gc) {
-		argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
-		if (verbosity < 0)
-			argv_array_push(&argv_gc_auto, "--quiet");
-		run_command_v_opt(argv_gc_auto.argv, RUN_GIT_CMD);
-		argv_array_clear(&argv_gc_auto);
-	}
+	if (enable_auto_gc)
+		run_auto_gc(verbosity < 0);
=20
 	return result;
 }
diff --git a/run-command.c b/run-command.c
index f5e1149f9b..2771eb936f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1864,3 +1864,16 @@ int run_processes_parallel_tr2(int n, get_next_tas=
k_fn get_next_task,
=20
 	return result;
 }
+
+int run_auto_gc(int quiet)
+{
+	struct argv_array argv_gc_auto =3D ARGV_ARRAY_INIT;
+	int status;
+
+	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
+	if (quiet)
+		argv_array_push(&argv_gc_auto, "--quiet");
+	status =3D run_command_v_opt(argv_gc_auto.argv, RUN_GIT_CMD);
+	argv_array_clear(&argv_gc_auto);
+	return status;
+}
diff --git a/run-command.h b/run-command.h
index 0f3cc73ab6..191dfcdafe 100644
--- a/run-command.h
+++ b/run-command.h
@@ -218,6 +218,11 @@ LAST_ARG_MUST_BE_NULL
 int run_hook_le(const char *const *env, const char *name, ...);
 int run_hook_ve(const char *const *env, const char *name, va_list args);
=20
+/*
+ * Trigger an auto-gc
+ */
+int run_auto_gc(int quiet);
+
 #define RUN_COMMAND_NO_STDIN 1
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
 #define RUN_COMMAND_STDOUT_TO_STDERR 4
--=20
2.26.2-561-g07d8ea56f2

