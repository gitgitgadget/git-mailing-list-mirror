Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64005C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 19:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC492082E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 19:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oDcAdaWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgA3Tfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:35:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55113 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgA3Tfw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 14:35:52 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6408553766;
        Thu, 30 Jan 2020 14:35:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hNtLt4s4T0QqoVDIp4Brr5pLQjk=; b=oDcAda
        WJZz7+NaSpMcXF7oFCbnU8WQoI3pVJhOOUUtI6dqsqUiKsWQPmfmmelD9waEPn7L
        i7Avg1lTdPRyzfkHEkU6ggte5wmBdzCTIvsoJhmUC5B3N/Slbo9trURXESE4K84Y
        8flsj+8FsMfUrWvLPYLZCPVUUSanqKH3SZn00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZUm/0nPCJzP7pUzhhUpOtlYLij1Vyv5Z
        8l9YQo3eafy+KVFmxkWMaXBdvsRrIz1tGsBm43RM82jbgyF/OTvrpfVbGiecbOkp
        pOUlG+qrboKEIEXUQLZkgJxU6Z2sYw5aqjJBCJ7aF/ohZbVMHhqZCpzrHJXe+qA2
        +QHBDWwfEy8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D57253765;
        Thu, 30 Jan 2020 14:35:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C35C853764;
        Thu, 30 Jan 2020 14:35:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2] C: use skip-prefix to avoid hardcoded string length
References: <xmqqv9owa6cw.fsf@gitster-ct.c.googlers.com>
        <20200127232004.GE19360@coredump.intra.peff.net>
        <xmqq36c09zo0.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 30 Jan 2020 11:35:46 -0800
In-Reply-To: <xmqq36c09zo0.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 27 Jan 2020 16:45:35 -0800")
Message-ID: <xmqqa764d9f1.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B708BF14-4397-11EA-B73C-C28CBED8090B-77302942!pb-smtp1.pobox.com
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

Note that this changes a few error messages from "git reflog expire
--expire=nonsense.timestamp", which used to complain by saying

    '--expire=nonsense.timestamp' is not a valid timestamp

but with this change, we say

    'nonsense.timestamp' is not a valid timestamp

which is more technically correct (the string with --expire= as
a prefix obviously cannot be a valid timestamp, but the error is
about the part of the input without that prefix).

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * v2 uses a simpler conversion that has a side effect of changing
   the error message from "git reflog expire" in a better way.

 builtin/fast-export.c | 3 +--
 builtin/reflog.c      | 9 +++++----
 notes.c               | 6 ++----
 parse-options.c       | 3 +--
 refs/files-backend.c  | 3 +--
 remote-curl.c         | 5 +++--
 sha1-name.c           | 9 ++-------
 transport-helper.c    | 5 +++--
 8 files changed, 18 insertions(+), 25 deletions(-)

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
index 4d3430900d..81dfd563c0 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -560,15 +560,16 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
+
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
 			flags |= EXPIRE_REFLOGS_DRY_RUN;
-		else if (starts_with(arg, "--expire=")) {
-			if (parse_expiry_date(arg + 9, &cb.cmd.expire_total))
+		else if (skip_prefix(arg, "--expire=", &arg)) {
+			if (parse_expiry_date(arg, &cb.cmd.expire_total))
 				die(_("'%s' is not a valid timestamp"), arg);
 			explicit_expiry |= EXPIRE_TOTAL;
 		}
-		else if (starts_with(arg, "--expire-unreachable=")) {
-			if (parse_expiry_date(arg + 21, &cb.cmd.expire_unreachable))
+		else if (skip_prefix(arg, "--expire-unreachable=", &arg)) {
+			if (parse_expiry_date(arg, &cb.cmd.expire_unreachable))
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
2.25.0-299-g5579215f86

