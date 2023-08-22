Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87278EE49A3
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 16:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237786AbjHVQ2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 12:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236668AbjHVQ2N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 12:28:13 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF725E40
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 09:27:59 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9263A3CDDA;
        Tue, 22 Aug 2023 12:27:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RFL7Ock1T9Jnao6xY1kV/8cd5VN81q+syEo6OP
        QbCzA=; b=IMoyKP5KFFu6mT8qJl5gizu63Fpde193EHVzbuwQq0QZFUIrmwOhsT
        8C4Zde/a9Zn8mqPUI23XDizZUIKhEZKdW2yqvsdrHaLc6Dp2/orXm/aveZDDJAf/
        GoEZ0Mrcg9Fzz21og88yuKsvsYC53d/Pud62eEe0jWspj6RRWUD/E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A8C73CDD9;
        Tue, 22 Aug 2023 12:27:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AA9A63CDD8;
        Tue, 22 Aug 2023 12:27:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Stenberg <daniel@haxx.se>
Cc:     git@vger.kernel.org
Subject: Re: FYI: git issues with libcurl 8.0/1 HTTPS push
References: <qq3252n1-o71-n1r7-281p-npqo6rs5o50@unkk.fr>
Date:   Tue, 22 Aug 2023 09:27:55 -0700
In-Reply-To: <qq3252n1-o71-n1r7-281p-npqo6rs5o50@unkk.fr> (Daniel Stenberg's
        message of "Tue, 22 Aug 2023 13:32:09 +0200 (CEST)")
Message-ID: <xmqq7cpnm48k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9F294B0-4108-11EE-AF31-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Stenberg <daniel@haxx.se> writes:

> If you use git with libcurl 8.0.x or 8.1.x, there is a risk that you
> will experience a "curl 56 HTTP/2 stream N was reset" errors when
> pushing over HTTPS. (where N is an odd number, often 7)
>
> This is an unfortunate bug in libcurl that has subsequently already
> been fixed. We recommend using libcurl 8.2.1 (or later).
>
> You can work around this issue (that tends to be sticky) by forcing
> git to use HTTP/1.1 instead of HTTP/2 for the push and then restore
> back to the previous state again.

Thanks for a heads-up.

The following is admittedly a very blunt workaround to disable
HTTP/2 for the affected versions for any purpose, but I wonder if it
is an acceptable workaround.  The remote-curl transport helper is
used for both push and fetch and I didn't find a good place to
automatically force the protocol version only for pushes.

 git-curl-compat.h | 12 ++++++++++++
 http.c            |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git c/git-curl-compat.h w/git-curl-compat.h
index fd96b3cdff..f253408288 100644
--- c/git-curl-compat.h
+++ w/git-curl-compat.h
@@ -134,4 +134,16 @@
 #define GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR 1
 #endif
 
+/**
+ * If you use git with libcurl 8.0.x or 8.1.x, there is a risk that
+ * you will experience a "curl 56 HTTP/2 stream N was reset" errors
+ * when pushing over HTTPS. (where N is an odd number, often 7)
+ *
+ * This is an unfortunate bug in libcurl that has subsequently already
+ * been fixed. We recommend using libcurl 8.2.1 (or later).
+ */
+#if (LIBCURL_VERSION_NUM >= 0x080000) && (LIBCURL_VERSION_NUM < 0x080201)
+#define GIT_CURL_AVOID_HTTP2 1
+#endif
+
 #endif
diff --git c/http.c w/http.c
index e138b4b96f..156d6236da 100644
--- c/http.c
+++ w/http.c
@@ -962,7 +962,7 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
 	}
 
-#ifdef GIT_CURL_HAVE_CURL_HTTP_VERSION_2
+#if defined(GIT_CURL_HAVE_CURL_HTTP_VERSION_2) && !defined(GIT_CURL_AVOID_HTTP2)
     if (curl_http_version) {
 		long opt;
 		if (!get_curl_http_version_opt(curl_http_version, &opt)) {
