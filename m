Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AFE01FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 19:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932661AbcLGTlR (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 14:41:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61908 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932332AbcLGTlN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 14:41:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53A74550E4;
        Wed,  7 Dec 2016 14:41:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=5M4a
        D1MGElILHjjeS64RsL095dE=; b=N1rdb34ohJll0AmyKIaAp7jq95EyteVzPZ4H
        YXbbyyHIf+K5pZx9obYRZT7V75YMBRubNwIhSUQhpIzEKvwP5xzroYP7GvEfhqxG
        sDGn1NRXHgVJZrOoHhZIgKdpdDu3hRlSjznT3ZfqZoJvygAr6I2HhWB7rrqxXMsy
        8+jmjl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        oskH/ZRGZ6CGtWRWD3KCqV/SBqNjYNChFsFolQamSu3jyQTRP09UzwvvABdhO/OV
        BRNKLt2UnRX/RCAKJz9Ei1NQK5Z+D8nXVoTNZLys4vpB1QssXQ9BdB+OYKVof9kS
        QLryBncVs7RtU1ETfydmxwfA7iFxxDRdTkE+0TbXlV4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4BC14550E3;
        Wed,  7 Dec 2016 14:41:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B4DF1550E2;
        Wed,  7 Dec 2016 14:41:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Robbie Iannucci <iannucci@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/3] lockfile: LOCK_REPORT_ON_ERROR
Date:   Wed,  7 Dec 2016 11:41:05 -0800
Message-Id: <20161207194105.25780-4-gitster@pobox.com>
X-Mailer: git-send-email 2.11.0-274-g0631465056
In-Reply-To: <20161207194105.25780-1-gitster@pobox.com>
References: <xmqqd1h3y506.fsf@gitster.mtv.corp.google.com>
 <20161207194105.25780-1-gitster@pobox.com>
X-Pobox-Relay-ID: 1B7BC8AA-BCB5-11E6-9D01-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "libify sequencer" topic stopped passing the die_on_error option
to hold_locked_index(), and this lost an error message from "git
merge --ff-only $commit" when there are competing updates in
progress.

The command still exits with a non-zero status, but that is not of
much help for an interactive user.  The last thing the command says
is "Updating $from..$to".  We used to follow it with a big error
message that makes it clear that "merge --ff-only" did not succeed.

What is sad is that we should have noticed this regression while
reviewing the change.  It was clear that the update to the
checkout_fast_forward() function made a failing hold_locked_index()
silent, but the only caller of the checkout_fast_forward() function
had this comment:

	    if (checkout_fast_forward(from, to, 1))
    -               exit(128); /* the callee should have complained already */
    +               return -1; /* the callee should have complained already */

which clearly contradicted the assumption X-<.

Add a new option LOCK_REPORT_ON_ERROR that can be passed instead of
LOCK_DIE_ON_ERROR to the hold_lock*() family of functions and teach
checkout_fast_forward() to use it to fix this regression.

After going thourgh all calls to hold_lock*() family of functions
that used to pass LOCK_DIE_ON_ERROR but were modified to pass 0 in
the "libify sequencer" topic "git show --first-parent 2a4062a4a8",
it appears that this is the only one that has become silent.  Many
others used to give detailed report that talked about "there may be
competing Git process running" but with the series merged they now
only give a single liner "Unable to lock ...", some of which may
have to be tweaked further, but at least they say something, unlike
the one this patch fixes.

Reported-by: Robbie Iannucci <iannucci@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 lockfile.c | 12 ++++++++++--
 lockfile.h |  8 +++++++-
 merge.c    |  2 +-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 9268cdf325..aa69210d8b 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -174,8 +174,16 @@ int hold_lock_file_for_update_timeout(struct lock_file *lk, const char *path,
 				      int flags, long timeout_ms)
 {
 	int fd = lock_file_timeout(lk, path, flags, timeout_ms);
-	if (fd < 0 && (flags & LOCK_DIE_ON_ERROR))
-		unable_to_lock_die(path, errno);
+	if (fd < 0) {
+		if (flags & LOCK_DIE_ON_ERROR)
+			unable_to_lock_die(path, errno);
+		if (flags & LOCK_REPORT_ON_ERROR) {
+			struct strbuf buf = STRBUF_INIT;
+			unable_to_lock_message(path, errno, &buf);
+			error("%s", buf.buf);
+			strbuf_release(&buf);
+		}
+	}
 	return fd;
 }
 
diff --git a/lockfile.h b/lockfile.h
index d26ad27b2b..16775a7d79 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -129,11 +129,17 @@ struct lock_file {
 /*
  * If a lock is already taken for the file, `die()` with an error
  * message. If this flag is not specified, trying to lock a file that
- * is already locked returns -1 to the caller.
+ * is already locked silently returns -1 to the caller, or ...
  */
 #define LOCK_DIE_ON_ERROR 1
 
 /*
+ * ... this flag can be passed instead to return -1 and give the usual
+ * error message upon an error.
+ */
+#define LOCK_REPORT_ON_ERROR 2
+
+/*
  * Usually symbolic links in the destination path are resolved. This
  * means that (1) the lockfile is created by adding ".lock" to the
  * resolved path, and (2) upon commit, the resolved path is
diff --git a/merge.c b/merge.c
index 23866c9165..04ee5fc911 100644
--- a/merge.c
+++ b/merge.c
@@ -57,7 +57,7 @@ int checkout_fast_forward(const unsigned char *head,
 
 	refresh_cache(REFRESH_QUIET);
 
-	if (hold_locked_index(lock_file, 0) < 0)
+	if (hold_locked_index(lock_file, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
 
 	memset(&trees, 0, sizeof(trees));
-- 
2.11.0-274-g0631465056

