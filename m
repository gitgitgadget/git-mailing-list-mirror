Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D9171FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 22:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbcLFWPx (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 17:15:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54423 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751327AbcLFWPw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 17:15:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E16754F4C;
        Tue,  6 Dec 2016 17:15:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LXyzNb3XotY/SNmndaWUYU1v4mc=; b=iX7q+Q
        g2Kdy4y0zEK+D1WIjeUxzDi4GCPk5JG0Ne4HQeVegoXGnC7biyvisqFn9qt8S8Ez
        dq+k4zQXUOiNxgXYPysswc3p391ai44+v7+f74PUyYShJ2jKAkPFZSLzWh12swoQ
        Kq6uHT57nHhI8fb9x/SCQA4lctZZGrrzsKoNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O6quT/Z4CGXDavX4HHDMUAoWXp8F7pR5
        QvwQutLJ2l4ZN63iKyMZCdqnzCyyrOlqlUW+EM+NWabD1Fh1waFYacAJKLvb0mDI
        WvPR2GBkKu0xwRumN/Zczq5JG66Mbb9HBl6w8RotY+58NL3UK+ewvvyvB2vPoXQA
        sJHmcS8YgoU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C57254F4B;
        Tue,  6 Dec 2016 17:15:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6F6154F49;
        Tue,  6 Dec 2016 17:15:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robbie Iannucci <iannucci@google.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re* [BUG] Index.lock error message regression in git 2.11.0
References: <CA+q_oBdHytoeSD-hmLx_N473M8XinjqckvE35Re3eNpQRWYjHQ@mail.gmail.com>
        <xmqqbmwozppx.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 06 Dec 2016 14:15:48 -0800
In-Reply-To: <xmqqbmwozppx.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 06 Dec 2016 13:56:26 -0800")
Message-ID: <xmqq4m2gzotn.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B27DBA8-BC01-11E6-B7D0-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps the attached would fix it (not even compile tested, though)?
>
> I would prefer to make 0 to mean "show error but return -1", 1 to
> mean "die on error", and 2 to mean "be silent and return -1 on
> error", though.  Asking to be silent should be the exception for
> this error from usability and safety's point of view, and requiring
> such exceptional callers to pass LOCK_SILENT_ON_ERROR would be
> easier to "git grep" for them.

So here is the "You have to ask explicitly, if you know that it is
safe to be silent" version with a proper log message.

-- >8 --
Subject: [PATCH] lockfile: LOCK_SILENT_ON_ERROR

Recent "libify merge machinery" stopped from passing die_on_error
bit to hold_locked_index(), and lost an error message when there are
competing update in progress with "git merge --ff-only $commit", for
example.  The command still exits with a non-zero status, but that
is not of much help for an interactive user.  The last thing the
command says is "Updating $from..$to".  We used to follow it with a
big error message that makes it clear that "merge --ff-only" did not
succeed.

Introduce a new bit "LOCK_SILENT_ON_ERROR" that can be passed by
callers that do want to silence the message (because they either
make it a non-error by doing something else, or they show their own
error message to explain the situation), and show the error message
we used to give for everybody else, including the caller that was
touched by the libification in question.

I would not be surprised if some existing calls to hold_lock*()
functions that pass die_on_error=0 need to be updated to pass
LOCK_SILENT_ON_ERROR, and when this fix is taken alone, it may look
like a regression, but we are better off starting louder and squelch
the ones that we find safe to make silent than the other way around.

Reported-by: Robbie Iannucci <iannucci@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 lockfile.c | 11 +++++++++--
 lockfile.h |  8 +++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 9268cdf325..f7e8104449 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -174,8 +174,15 @@ int hold_lock_file_for_update_timeout(struct lock_file *lk, const char *path,
 				      int flags, long timeout_ms)
 {
 	int fd = lock_file_timeout(lk, path, flags, timeout_ms);
-	if (fd < 0 && (flags & LOCK_DIE_ON_ERROR))
-		unable_to_lock_die(path, errno);
+	if (fd < 0) {
+		if (flags & LOCK_DIE_ON_ERROR)
+			unable_to_lock_die(path, errno);
+		else if (!(flags & LOCK_SILENT_ON_ERROR)) {
+			struct strbuf buf = STRBUF_INIT;
+			unable_to_lock_message(path, errno, &buf);
+			error("%s", buf.buf);
+		}
+	}
 	return fd;
 }
 
diff --git a/lockfile.h b/lockfile.h
index d26ad27b2b..98b4862254 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -129,9 +129,15 @@ struct lock_file {
 /*
  * If a lock is already taken for the file, `die()` with an error
  * message. If this flag is not specified, trying to lock a file that
- * is already locked returns -1 to the caller.
+ * is already locked gives the same error message and returns -1 to
+ * the caller.
  */
 #define LOCK_DIE_ON_ERROR 1
+/*
+ * ... or the function can be told to be totally silent and return
+ * -1 to the caller upon error with this flag
+ */
+#define LOCK_SILENT_ON_ERROR 2
 
 /*
  * Usually symbolic links in the destination path are resolved. This
-- 
2.11.0-270-g0b6beed61f

