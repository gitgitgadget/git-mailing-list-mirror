Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB244C2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 22:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85C32465B
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 22:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rgoxNgHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgA0WVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 17:21:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65101 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgA0WVK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 17:21:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BA7A1B7C15;
        Mon, 27 Jan 2020 17:21:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=L
        KveDQ02wsmgsDnakdwQN4YQdGs=; b=rgoxNgHtGytX5uO97dITw4JfHNvkWvHzZ
        KU9X3Q+t+MWmSohfkEvemg0CcEpM5MSe2OSsQ05WR+AfepWZ/kbZpuSm5hKL1BOq
        2G7CDJjk3w2X7xZ6HgJo5ZTP0oO4cuOj2QO+xMCvTX3icU/R+jO08YPVb7k5ZQFG
        2B614R0iTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=dS2
        ZzhtxcypBWH2aIvSAqkcWcjgZUZYz1iI792jYDoB+OselXJuxPeQ/9c+3YP0LPx/
        caSOCOgNv2wJF9jwJcoENZvbSeapNPJxvxp7XVAHdAF0FONAV33XO4qegqbJMdrj
        tgWhRVRFIxvYBlO7LdlpcTy2KRZDfHdFtigm7gFI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B2A15B7C14;
        Mon, 27 Jan 2020 17:21:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D7FCFB7C12;
        Mon, 27 Jan 2020 17:21:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] C: use skip-prefix to avoid hardcoded string length
Date:   Mon, 27 Jan 2020 14:21:03 -0800
Message-ID: <xmqqv9owa6cw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F6FACFA-4153-11EA-B971-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We often skip an optional prefix in a string with a hardcoded
constant, e.g.

	if (starts_with(string, "prefix"))
		string += 6;

which is less error prone when written

	skip_prefix(string, "prefix", &string);

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fast-export.c |  3 +--
 builtin/reflog.c      | 10 ++++++----
 notes.c               |  6 ++----
 parse-options.c       |  3 +--
 refs/files-backend.c  |  3 +--
 remote-curl.c         |  5 +++--
 sha1-name.c           |  9 ++-------
 transport-helper.c    |  5 +++--
 8 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index dbec4df92b..164406fdd4 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -870,8 +870,7 @@ static void handle_tag(const char *name, struct tag *tag)
 		printf("reset %s\nfrom %s\n\n",
 		       name, oid_to_hex(&null_oid));
 	}
-	if (starts_with(name, "refs/tags/"))
-		name += 10;
+	skip_prefix(name, "refs/tags/", &name);
 	printf("tag %s\n", name);
 	if (mark_tags) {
 		mark_next_object(&tag->object);
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 4d3430900d..51ffd74945 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -560,15 +560,17 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
+		const char *valptr;
+
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
 			flags |= EXPIRE_REFLOGS_DRY_RUN;
-		else if (starts_with(arg, "--expire=")) {
-			if (parse_expiry_date(arg + 9, &cb.cmd.expire_total))
+		else if (skip_prefix(arg, "--expire=", &valptr)) {
+			if (parse_expiry_date(valptr, &cb.cmd.expire_total))
 				die(_("'%s' is not a valid timestamp"), arg);
 			explicit_expiry |= EXPIRE_TOTAL;
 		}
-		else if (starts_with(arg, "--expire-unreachable=")) {
-			if (parse_expiry_date(arg + 21, &cb.cmd.expire_unreachable))
+		else if (skip_prefix(arg, "--expire-unreachable=", &valptr)) {
+			if (parse_expiry_date(valptr, &cb.cmd.expire_unreachable))
 				die(_("'%s' is not a valid timestamp"), arg);
 			explicit_expiry |= EXPIRE_UNREACH;
 		}
diff --git a/notes.c b/notes.c
index 0c79964c26..a0349fa778 100644
--- a/notes.c
+++ b/notes.c
@@ -1279,10 +1279,8 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 		if (!ref || !strcmp(ref, GIT_NOTES_DEFAULT_REF)) {
 			strbuf_addstr(sb, "\nNotes:\n");
 		} else {
-			if (starts_with(ref, "refs/"))
-				ref += 5;
-			if (starts_with(ref, "notes/"))
-				ref += 6;
+			skip_prefix(ref, "refs/", &ref);
+			skip_prefix(ref, "notes/", &ref);
 			strbuf_addf(sb, "\nNotes (%s):\n", ref);
 		}
 	}
diff --git a/parse-options.c b/parse-options.c
index 60fae3ad21..e8c04109ba 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -357,8 +357,7 @@ static enum parse_opt_result parse_long_opt(
 			}
 			/* negated? */
 			if (!starts_with(arg, "no-")) {
-				if (starts_with(long_name, "no-")) {
-					long_name += 3;
+				if (skip_prefix(long_name, "no-", &long_name)) {
 					opt_flags |= OPT_UNSET;
 					goto again;
 				}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0ea66a28b6..561c33ac8a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -465,8 +465,7 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	close(fd);
 	strbuf_rtrim(&sb_contents);
 	buf = sb_contents.buf;
-	if (starts_with(buf, "ref:")) {
-		buf += 4;
+	if (skip_prefix(buf, "ref:", &buf)) {
 		while (isspace(*buf))
 			buf++;
 
diff --git a/remote-curl.c b/remote-curl.c
index 350d92a074..8eb96152f5 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1255,8 +1255,9 @@ static void parse_push(struct strbuf *buf)
 	int ret;
 
 	do {
-		if (starts_with(buf->buf, "push "))
-			argv_array_push(&specs, buf->buf + 5);
+		const char *arg;
+		if (skip_prefix(buf->buf, "push ", &arg))
+			argv_array_push(&specs, arg);
 		else
 			die(_("http transport does not support %s"), buf->buf);
 
diff --git a/sha1-name.c b/sha1-name.c
index 200eb373ad..75d1c32606 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -908,14 +908,9 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 				real_ref, flags, at_time, nth, oid, NULL,
 				&co_time, &co_tz, &co_cnt)) {
 			if (!len) {
-				if (starts_with(real_ref, "refs/heads/")) {
-					str = real_ref + 11;
-					len = strlen(real_ref + 11);
-				} else {
-					/* detached HEAD */
+				if (!skip_prefix(real_ref, "refs/heads/", &str))
 					str = "HEAD";
-					len = 4;
-				}
+				len = strlen(str);
 			}
 			if (at_time) {
 				if (!(flags & GET_OID_QUIETLY)) {
diff --git a/transport-helper.c b/transport-helper.c
index 413d9d873e..20a7185ec4 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -404,11 +404,12 @@ static int fetch_with_fetch(struct transport *transport,
 	sendline(data, &buf);
 
 	while (1) {
+		const char *name;
+
 		if (recvline(data, &buf))
 			exit(128);
 
-		if (starts_with(buf.buf, "lock ")) {
-			const char *name = buf.buf + 5;
+		if (skip_prefix(buf.buf, "lock ", &name)) {
 			if (transport->pack_lockfile)
 				warning(_("%s also locked %s"), data->name, name);
 			else
-- 
2.25.0-283-g4daa2e6944

