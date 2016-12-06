Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B4C91FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbcLFV4a (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:56:30 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64498 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750953AbcLFV43 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:56:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DEB254AC5;
        Tue,  6 Dec 2016 16:56:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QZUNQHG/7pWhu1teTNApRRQBQZo=; b=e7uGmI
        3ZPAxCMUKuGiflF7yvuckR+ld6O1q3GKrHM1U+uCBHDg9Z2YHmO/cEqO82njh6t9
        3nZwHGSs7X2b7qfeuSHwdzvM3SloN6v6tJy1EEBA+v9lNKzEU9ZRiAQLalJaJWfT
        JJBa7Ideej8tuuDHFHKwe3/F8FerIzulALMsw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qqJGFaDjDSK2quSBz4eXkqJKMJsFOpWR
        EEZJd5ppqPs7W9u+cc0GrNWhfRYAqXqTxvAaht/kItzYUH4PN3VKBIiS1Cr0AusQ
        27pWeu8vEancgS+Yi/Wjjx6dTopbxpAXiWSY2NMzABzJOA5vCs07G3EGQMXTLeV0
        PdRJa171Ntk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 045CA54AC4;
        Tue,  6 Dec 2016 16:56:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B92754AC1;
        Tue,  6 Dec 2016 16:56:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robbie Iannucci <iannucci@google.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [BUG] Index.lock error message regression in git 2.11.0
References: <CA+q_oBdHytoeSD-hmLx_N473M8XinjqckvE35Re3eNpQRWYjHQ@mail.gmail.com>
Date:   Tue, 06 Dec 2016 13:56:26 -0800
In-Reply-To: <CA+q_oBdHytoeSD-hmLx_N473M8XinjqckvE35Re3eNpQRWYjHQ@mail.gmail.com>
        (Robbie Iannucci's message of "Fri, 2 Dec 2016 17:44:33 -0800")
Message-ID: <xmqqbmwozppx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D666FCAA-BBFE-11E6-A8DB-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robbie Iannucci <iannucci@google.com> writes:

> I just upgraded to 2.11.0 from 2.10.2, and I noticed that some
> commands no longer print an error message when the `index.lock` file
> exists (such as `git merge --ff-only`).
>
> It appears this bug was introduced in
> 55f5704da69d3e6836620f01bee0093ad5e331e8 (sequencer: lib'ify
> checkout_fast_forward()). I determined this by running the attached
> bisect script (on OS X, but I don't think that matters; I've also seen
> the error message missing on Linux):

Yes, I can see that this is not limited to OSX.  The command does
exit with non-zero status, but that is not of much help for an
interactive user.

    $ git checkout v2.11.0^0
    $ >.git/index.lock
    $ git merge --ff-only master; echo $?
    Updating 454cb6bd52..8d7a455ed5
    1
    $ exit

We can see that it attempted to update, but because there is no
indication that it failed, the user can easily be misled to think
that we are now at the tip of the master branch.

We used to give "fatal: Unable to create ..." followed by "Another
git process seems to be running..." advice, that would have helped
the user from the confusion.

I do not think it is the right solution to call hold_locked_index()
with die_on_error=1 from the codepath changed by your 55f5704da6
("sequencer: lib'ify checkout_fast_forward()", 2016-09-09).  Perhaps
the caller of checkout_fast_forward() needs to learn how/why the
function returned error and diagnose this case and a message?  Or
perhaps turn that die_on_error parameter from boolean to tricolor
(i.e. the caller does not want you to die, but the caller knows that
you have more information to give better error message than it does,
so please show an error message instead of silently returning -1)?

Perhaps the attached would fix it (not even compile tested, though)?

I would prefer to make 0 to mean "show error but return -1", 1 to
mean "die on error", and 2 to mean "be silent and return -1 on
error", though.  Asking to be silent should be the exception for
this error from usability and safety's point of view, and requiring
such exceptional callers to pass LOCK_SILENT_ON_ERROR would be
easier to "git grep" for them.

Dscho, what do you think?  


 lockfile.c | 11 +++++++++--
 lockfile.h |  5 +++++
 merge.c    |  2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 9268cdf325..f190caddb0 100644
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
+		else if (flags & LOCK_ERROR_ON_ERROR) {
+			struct strbuf buf = STRBUF_INIT;
+			unable_to_lock_message(path, errno, &buf);
+			error("%s", buf.buf);
+		}
+	}
 	return fd;
 }
 
diff --git a/lockfile.h b/lockfile.h
index d26ad27b2b..6cba9c8142 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -132,6 +132,11 @@ struct lock_file {
  * is already locked returns -1 to the caller.
  */
 #define LOCK_DIE_ON_ERROR 1
+/*
+ * ... or the function can be told to show the usual error message
+ * and still return -1 to the caller with this flag
+ */
+#define LOCK_ERROR_ON_ERROR 2
 
 /*
  * Usually symbolic links in the destination path are resolved. This
diff --git a/merge.c b/merge.c
index 23866c9165..9e2e4f1a22 100644
--- a/merge.c
+++ b/merge.c
@@ -57,7 +57,7 @@ int checkout_fast_forward(const unsigned char *head,
 
 	refresh_cache(REFRESH_QUIET);
 
-	if (hold_locked_index(lock_file, 0) < 0)
+	if (hold_locked_index(lock_file, LOCK_ERROR_ON_ERROR) < 0)
 		return -1;
 
 	memset(&trees, 0, sizeof(trees));
