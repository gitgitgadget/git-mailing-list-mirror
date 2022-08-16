Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8994DC25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 16:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbiHPQA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 12:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbiHPP75 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 11:59:57 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCDC95A7
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 08:58:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 71FB31AAC5E;
        Tue, 16 Aug 2022 11:58:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UfbPq6C9fvmNx2F/ZTele8yXcGgISGQUnY+H4o
        rxSn8=; b=dzCpu4sdUFDdewhYhfR6POEjeRNzoJ6D3EH+bWCioLKL6oagLS1byq
        xRjdw4aIE22FWLJraD8issUsS4cjrpaA6DZRb3n6xWqVl1mq6Jd9vzUDpkW4fYtJ
        24fjGeztDjVjfUBIPm8bs0TkmAa56ubfil/nzl4+PdYWh8SZ3QFtg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6AAE61AAC5B;
        Tue, 16 Aug 2022 11:58:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 17EEF1AAC5A;
        Tue, 16 Aug 2022 11:58:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, Johannes.Schindelin@gmx.de,
        avarab@gmail.com
Subject: Re: [PATCH v8] submodule merge: update conflict error message
References: <20220728211221.2913928-1-calvinwan@google.com>
        <20220804195105.1303455-1-calvinwan@google.com>
Date:   Tue, 16 Aug 2022 08:58:34 -0700
In-Reply-To: <20220804195105.1303455-1-calvinwan@google.com> (Calvin Wan's
        message of "Thu, 4 Aug 2022 19:51:05 +0000")
Message-ID: <xmqqczd0xjrp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 494ACBEA-1D7C-11ED-AA3C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> @@ -4412,6 +4459,99 @@ static int record_conflicted_index_entries(struct merge_options *opt)
>  	return errs;
>  }
>  
> +static void format_submodule_conflict_suggestion(struct strbuf *msg) {
> +	struct strbuf tmp = STRBUF_INIT;
> +	struct string_list msg_list = STRING_LIST_INIT_DUP;
> +	int i;
> +
> +	string_list_split(&msg_list, msg->buf, '\n', -1);
> +	for (i = 0; i < msg_list.nr; i++) {
> +		if (!i)
> +			/*
> +			 * TRANSLATORS: This is line item of submodule conflict message
> +			 * from print_submodule_conflict_suggestion() below. For RTL
> +			 * languages, the following swap is suggested:
> +			 *      " - %s\n" -> "%s - \n"
> +			 */
> +			strbuf_addf(&tmp, _(" - %s\n"), msg_list.items[i].string);
> +		else
> +			/*
> +			 * TRANSLATORS: This is line item of submodule conflict message
> +			 * from print_submodule_conflict_suggestion() below. For RTL
> +			 * languages, the following swap is suggested:
> +			 *      "   %s\n" -> "%s   \n"
> +			 */
> +			strbuf_addf(&tmp, _("   %s\n"), msg_list.items[i].string);
> +	}
> +	strbuf_reset(msg);
> +	strbuf_add(msg, tmp.buf, tmp.len);
> +}

Here, tmp is not released, and mst_list holds the words split out of msg.

 merge-ort.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git i/merge-ort.c w/merge-ort.c
index 4cb92bdff8..cdb53770be 100644
--- i/merge-ort.c
+++ w/merge-ort.c
@@ -4507,6 +4507,8 @@ static void format_submodule_conflict_suggestion(struct strbuf *msg) {
 	}
 	strbuf_reset(msg);
 	strbuf_add(msg, tmp.buf, tmp.len);
+	string_list_clear(&msg_list, 0);
+	strbuf_release(&tmp);
 }
 
 static void print_submodule_conflict_suggestion(struct string_list *csub) {
