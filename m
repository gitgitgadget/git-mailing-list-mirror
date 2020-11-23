Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A006FC2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 312EF20719
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NBrz4H3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbgKWWaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 17:30:18 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50619 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgKWWaS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 17:30:18 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C392CF1281;
        Mon, 23 Nov 2020 17:30:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GP0Dtne1QXrDtkd4sW0+pBHnXLM=; b=NBrz4H
        3Jxegd0tfwhAQxutOG3Rs04s7XuCerewfUkbSbCuO6kkMcXOLI6yv1E9UCYMeedX
        dVls0pjMm/OYm2MACNNSs54r0erJv2V1DNZvwhr6pf6jgLlSWMSywf3piwLCNAhl
        cyO75Fqmcbgiwvb8zSg6ILenEwpHiTAaAFKUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Zk11SJslCHZfQs2ad+aBu1zurcBF+Rkj
        fCJz3y5EEsPvU0ISlvQAWRhqI1Mw667/EQZ2GLXOkQIzjqkzCDd/GW9wawujtJQf
        CSnfxL6RpyJL6JHrA7coz4aDIrOacGv7Ej6mZUGQ2TmEXXfiQno+/Xqk5QBdPhyg
        V6VLNIElmug=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BBF51F1280;
        Mon, 23 Nov 2020 17:30:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EDCFCF127A;
        Mon, 23 Nov 2020 17:30:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [RFC PATCH v2] usage: add trace2 entry upon warning()
References: <20201123190412.101265-1-jonathantanmy@google.com>
        <20201123204522.675836-1-jonathantanmy@google.com>
Date:   Mon, 23 Nov 2020 14:30:12 -0800
In-Reply-To: <20201123204522.675836-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 23 Nov 2020 12:45:22 -0800")
Message-ID: <xmqqblfnn1u3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74753C66-2DDB-11EB-A5E7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/usage.c b/usage.c
> index 06665823a2..1868a24f7a 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -81,6 +81,12 @@ static void error_builtin(const char *err, va_list params)
>  
>  static void warn_builtin(const char *warn, va_list params)
>  {
> +	/*
> +	 * We call this trace2 function first and expect it to va_copy 'params'
> +	 * before using it (because an 'ap' can only be walked once).
> +	 */
> +	trace2_cmd_error_va(warn, params);
> +
>  	vreportf("warning: ", warn, params);

Without the comment, this would have been a huge red sign.  Given
what the trace2 function does, I think cmd_error_va() has to do the
va_copy()/va_end() dance somewhere in it, so from the caller's point
of view, not having to va_copy()/va_end() is convenient and nice,
but perhaps we can eventually (not today---we have the same issue
with die_builtin() and error_builtin()) move the comment to the
callee so that other people who are writing more callers do not have
to rediscover what to do with "can va_lsit be used more than once?"
issue.  Perhaps like (I am not demonstrating the removal of dups):

 trace2.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git c/trace2.h w/trace2.h
index b18bc5529c..10ba231122 100644
--- c/trace2.h
+++ w/trace2.h
@@ -116,6 +116,11 @@ int trace2_cmd_exit_fl(const char *file, int line, int code);
  * Emit an 'error' event.
  *
  * Write an error message to the TRACE2 targets.
+ *
+ * Note that the "va_list ap" the caller has is not touched, because
+ * it is fed to each of the TRACE2 targets, which must use va_copy()
+ * and use va_end() on the copy.  The caller can still use ap it uses
+ * to call this funciton and and call va_end() on it when it is done.
  */
 void trace2_cmd_error_va_fl(const char *file, int line, const char *fmt,
 			    va_list ap);
