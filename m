Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BCAC433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 17:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE992077D
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 17:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VYS2sNW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgGIRIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:08:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61932 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgGIRIv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 13:08:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AC080E60CA;
        Thu,  9 Jul 2020 13:08:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bsFzBfSP7mW71Y5zb4IKZmy6ts8=; b=VYS2sN
        W0ryEjcMbPlswmoY+PE8fRk2zlyulLeurU6L086G2Nz9101PK44prmdTUWqZ6c4M
        HrJ+cPUDNOczxNshCa4qrqn8mShCYUVUTbSpOMrHDICqlOU5N+cGUTtk8spTJUFc
        vIrsFHkWuxcjGtCe2CH5ts1vJS5pY+iTzpKF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vnQaRitHzh05C8ccEf0rwIuM3V/+iw0K
        l2DqWZ96l5ykaiZgZ3kY78WgI+iZxiPQTn5qmr08USx94QQIavZQ04e0u6YtJcKT
        KhOuaibLWAJDpxsRUVVh5HzXu63L2uKXuVj2D72AODYYZbUxHKwHPc88UVPnbyEu
        +YPUI/c/tzM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A40EBE60C9;
        Thu,  9 Jul 2020 13:08:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E30A5E60C8;
        Thu,  9 Jul 2020 13:08:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] entry: check for fstat() errors after checkout
References: <fbde5e1c9042ea06b448bc759cea9d45e300961f.1594260597.git.matheus.bernardino@usp.br>
Date:   Thu, 09 Jul 2020 10:08:42 -0700
In-Reply-To: <fbde5e1c9042ea06b448bc759cea9d45e300961f.1594260597.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Wed, 8 Jul 2020 23:10:39 -0300")
Message-ID: <xmqqd054y5t1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8B3C4FE-C206-11EA-8030-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> In 11179eb311 ("entry.c: check if file exists after checkout",
> 2017-10-05) we started checking the result of the lstat() call done
> after writing a file, to avoid writing garbage to the corresponding
> cache entry. However, the code skips calling lstat() if it's possible
> to use fstat() when it still has the file descriptor open. And when
> calling fstat() we don't do the same error checking. To fix that, let
> the callers of fstat_output() know when fstat() fails. In this case,
> write_entry() will try to use lstat() and properly report an error if
> that fails as well.

The original is not correct as you point out, as it loses the error
return from fstat(), but I do not think this is right, either.

The returned value from fstat_output() is suppsed to be "have we
done fstat() so that we do not need to do a lstat()?"  Don't you
instead want to extend it to "0 means we didn't, 1 means we did
successfully, and -1 means we did and failed"?  At least, the way
_this_ function is modified by this patch is in line with that.

Which means that we'd need to update the caller(s) to match, to
avoid risking this change to be just half a change, very similarly
to how the change in 11179eb311 was just half a change.

Perhaps like this?

 entry.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/entry.c b/entry.c
index 53380bb614..f48507ca42 100644
--- a/entry.c
+++ b/entry.c
@@ -108,14 +108,21 @@ static int open_output_fd(char *path, const struct cache_entry *ce, int to_tempf
 	}
 }
 
+/*
+ * We have an open fd to a file that we may use lstat() on later. 
+ * When able, try doing a fstat(fd) instead and tell the caller it
+ * does not have to do an extra lstat()
+ *
+ * Return 1 if we successfully ran fstat() and *st is valid.
+ * Return 0 if we did not do fstat() and the caller should do lstat().
+ * Return -1 if we got failure from fstat()---the caller can skip lstat().
+ */
 static int fstat_output(int fd, const struct checkout *state, struct stat *st)
 {
 	/* use fstat() only when path == ce->name */
 	if (fstat_is_reliable() &&
-	    state->refresh_cache && !state->base_dir_len) {
-		fstat(fd, st);
-		return 1;
-	}
+	    state->refresh_cache && !state->base_dir_len)
+		return (fstat(fd, st) < 0) ? -1 : 1;
 	return 0;
 }
 
@@ -369,10 +376,10 @@ static int write_entry(struct cache_entry *ce,
 finish:
 	if (state->refresh_cache) {
 		assert(state->istate);
-		if (!fstat_done)
-			if (lstat(ce->name, &st) < 0)
-				return error_errno("unable to stat just-written file %s",
-						   ce->name);
+		if (fstat_done < 0 ||
+		    (!fstat_done && lstat(ce->name, &st) < 0))
+			return error_errno("unable to stat just-written file %s",
+					   ce->name);
 		fill_stat_cache_info(state->istate, ce, &st);
 		ce->ce_flags |= CE_UPDATE_IN_BASE;
 		mark_fsmonitor_invalid(state->istate, ce);
