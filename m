Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E10C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 22:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9D65610CC
	for <git@archiver.kernel.org>; Thu, 20 May 2021 22:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhETWJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 18:09:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56945 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhETWJi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 18:09:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D62DE11DE47;
        Thu, 20 May 2021 18:08:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g2Tud61bX3dtfMpScvJVHbgmDHcJrPcXuF+/ez
        FmoLw=; b=LrjoU6NPYgI0qwDVaAzsK2X+3wk2rGnvaiD9U9y6WZcUZBMGU8bsPm
        3NVP27ASR6fIy6zE/ZXe0OGBiElU4LucNC8Ajt8G1qZMcm3+1LbuCILNY7LthzXU
        n1T7ekY880SSmw5fm69Th7x1h/jdLk8QrHY0bT7FWdD4g9N3uTupU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CEA0B11DE46;
        Thu, 20 May 2021 18:08:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2427811DE45;
        Thu, 20 May 2021 18:08:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] trace2: refactor to avoid gcc warning under -O3
References: <xmqqim3ew905.fsf@gitster.g>
        <patch-1.1-2e41e3e4cb-20210520T110357Z-avarab@gmail.com>
        <YKZgZZrZdKyUk9d9@coredump.intra.peff.net>
Date:   Fri, 21 May 2021 07:08:11 +0900
In-Reply-To: <YKZgZZrZdKyUk9d9@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 20 May 2021 09:13:09 -0400")
Message-ID: <xmqqk0ntt5x0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEB7B0FA-B9B7-11EB-A395-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> @@ -287,7 +285,7 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
>>  	if (tr2_dst_want_warning())
>>  		warning("trace2: could not connect to socket '%s' for '%s' tracing: %s",
>>  			path, tr2_sysenv_display_name(dst->sysenv_var),
>> -			strerror(e));
>> +			strerror(errno));
>
> We expect the value of errno to persist across tr2_dst_want_warning()
> and tr2_sysenv_display_name() here. The former may call getenv() and
> atoi(). I think that's probably fine, but if we wanted to be really
> paranoid, we'd have to preserve errno manually here, too.

Being "really paranoid" consistently within the file would mean a
change like the attached, I would think, on top of what was posted.

Or tr2_dst_want_warning() and tr2_sysenv_display_name() can be
taught to preserve errno like tr2_dst_dry_uds_connect() was taught
to do so by the patch under discussion, which may reduce the amount
of apparent change, but constantly moving the contents of errno
around just in case we later might want to use its value feels
dirty.

I dunno.

 trace2/tr2_dst.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git c/trace2/tr2_dst.c w/trace2/tr2_dst.c
index 0031476350..f740a0a076 100644
--- c/trace2/tr2_dst.c
+++ w/trace2/tr2_dst.c
@@ -62,11 +62,13 @@ static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
 	}
 
 	if (fd == -1) {
+		int saved_errno = errno;
+
 		if (tr2_dst_want_warning())
 			warning("trace2: could not open '%.*s' for '%s' tracing: %s",
 				(int) base_path_len, path.buf,
 				tr2_sysenv_display_name(dst->sysenv_var),
-				strerror(errno));
+				strerror(saved_errno));
 
 		tr2_dst_trace_disable(dst);
 		strbuf_release(&path);
@@ -86,6 +88,8 @@ static int tr2_dst_try_path(struct tr2_dst *dst, const char *tgt_value)
 {
 	int fd = open(tgt_value, O_WRONLY | O_APPEND | O_CREAT, 0666);
 	if (fd == -1) {
+		int saved_errno = errno;
+
 		if (tr2_dst_want_warning())
 			warning("trace2: could not open '%s' for '%s' tracing: %s",
 				tgt_value,
@@ -140,6 +144,7 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
 	unsigned int uds_try = 0;
 	int fd;
 	const char *path = NULL;
+	int saved_errno;
 
 	/*
 	 * Allow "af_unix:[<type>:]<absolute_path>"
@@ -193,10 +198,11 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
 	}
 
 error:
+	saved_errno = errno;
 	if (tr2_dst_want_warning())
 		warning("trace2: could not connect to socket '%s' for '%s' tracing: %s",
 			path, tr2_sysenv_display_name(dst->sysenv_var),
-			strerror(errno));
+			strerror(saved_errno));
 
 	tr2_dst_trace_disable(dst);
 	return 0;
@@ -276,6 +282,7 @@ int tr2_dst_trace_want(struct tr2_dst *dst)
 void tr2_dst_write_line(struct tr2_dst *dst, struct strbuf *buf_line)
 {
 	int fd = tr2_dst_get_trace_fd(dst);
+	int saved_errno;
 
 	strbuf_complete_line(buf_line); /* ensure final NL on buffer */
 
@@ -297,9 +304,10 @@ void tr2_dst_write_line(struct tr2_dst *dst, struct strbuf *buf_line)
 	if (write(fd, buf_line->buf, buf_line->len) >= 0)
 		return;
 
+	saved_errno = errno;
 	if (tr2_dst_want_warning())
 		warning("unable to write trace to '%s': %s",
 			tr2_sysenv_display_name(dst->sysenv_var),
-			strerror(errno));
+			strerror(saved_errno));
 	tr2_dst_trace_disable(dst);
 }
