Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F4CB208CD
	for <e@80x24.org>; Tue, 22 Aug 2017 00:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754439AbdHVAUS (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 20:20:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58784 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754342AbdHVAUR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 20:20:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7287A0ACD;
        Mon, 21 Aug 2017 20:20:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tb0ft5W0gK/NjrZJarqzFZ8wTOo=; b=R4FKvi
        IIOmX4ecoQhzGrtFbeU7hliKn6QXTqxZLj3u8sOiIC7vJd+ACGuz8zRJO/IUy3hj
        Wbk34Vvpe7e7JLmcUvRkLn4vyaFtXKt6Tm0c20QzlYvpofJo8grNeEQeg8jfeKGK
        5t9yfsNB+Z+/qH6CdTQpShng5CWyIbKLYI490=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vIUEUrNsgz+c3cxQa6TqF0u3hfx3+psL
        AeA0C8XrlQFDAMPQdX6D/uXbiO/AdeWdXWSbXkljaus9sTt03xlJf4XkavrkFbQP
        YQBGNczQFg6+sh5CgyIIuLt6JpHbf1dxLuxwLUtEekUGGiVCMgPPxUrS26jSwObB
        LJY1T3S6C6M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DEDE4A0ACC;
        Mon, 21 Aug 2017 20:20:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 40767A0AC6;
        Mon, 21 Aug 2017 20:20:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, hIpPy <hippy2981@gmail.com>
Subject: Re: [PATCH v2 2/3] merge: split write_merge_state in two
References: <fe681e447791ded6db52ccd84e64e3637c08ffe5.1503309751.git.git@grubix.eu>
        <cover.1503319519.git.git@grubix.eu>
        <1fa72c32925d98a5ce8c96a2b504b2e4278dcfff.1503319519.git.git@grubix.eu>
Date:   Mon, 21 Aug 2017 17:20:06 -0700
In-Reply-To: <1fa72c32925d98a5ce8c96a2b504b2e4278dcfff.1503319519.git.git@grubix.eu>
        (Michael J. Gruber's message of "Mon, 21 Aug 2017 14:53:15 +0200")
Message-ID: <xmqqshgk4fnt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6CB86AE-86CF-11E7-9865-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> write_merge_state() writes out the merge heads, mode, and msg. But we
> may want to write out heads, mode without the msg. So, split out heads
> (+mode) into a separate function write_merge_heads() that is called by
> write_merge_state().
>
> No funtional change so far.

"We may want to" leaves readers in suspense.  Hopefully 3/3 makes it
clear why we may in what situation.

One thing this changes is that we used to write merge-heads first,
then message and then finally mode, but now we write merge-heads,
then mode and finally message.  So killing us in the middle may
leave different set of files on the filesystem.  It is unclear from
the above description and the patch text if that is a potential
issue.

Let's keep reading ;-)

Thanks.

>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
>  builtin/merge.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index cc57052993..86f0adde3b 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -908,7 +908,7 @@ static int setup_with_upstream(const char ***argv)
>  	return i;
>  }
>  
> -static void write_merge_state(struct commit_list *remoteheads)
> +static void write_merge_heads(struct commit_list *remoteheads)
>  {
>  	struct commit_list *j;
>  	struct strbuf buf = STRBUF_INIT;
> @@ -924,8 +924,6 @@ static void write_merge_state(struct commit_list *remoteheads)
>  		strbuf_addf(&buf, "%s\n", oid_to_hex(oid));
>  	}
>  	write_file_buf(git_path_merge_head(), buf.buf, buf.len);
> -	strbuf_addch(&merge_msg, '\n');
> -	write_file_buf(git_path_merge_msg(), merge_msg.buf, merge_msg.len);
>  
>  	strbuf_reset(&buf);
>  	if (fast_forward == FF_NO)
> @@ -933,6 +931,13 @@ static void write_merge_state(struct commit_list *remoteheads)
>  	write_file_buf(git_path_merge_mode(), buf.buf, buf.len);
>  }
>  
> +static void write_merge_state(struct commit_list *remoteheads)
> +{
> +	write_merge_heads(remoteheads);
> +	strbuf_addch(&merge_msg, '\n');
> +	write_file_buf(git_path_merge_msg(), merge_msg.buf, merge_msg.len);
> +}
> +
>  static int default_edit_option(void)
>  {
>  	static const char name[] = "GIT_MERGE_AUTOEDIT";
