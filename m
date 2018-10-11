Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61DDA1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 15:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeJKWnr (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 18:43:47 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:58927 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeJKWnr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 18:43:47 -0400
Received: from [192.168.2.240] ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id Ach5gsSE9oI6LAch6gZYf7; Thu, 11 Oct 2018 16:16:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539270968;
        bh=PIVzvSfL10zUh9Qlk5V2RKXjDViMezpnCO9UQp2DGkU=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZKXy5Chg9jaIYTQRgyMFJ5+7tlhcoJW9Ozp2ssYm5j8q9hG298lLF12KaHcosvtjT
         YkaMJtz6UEGSbe3hXTuN1kribD0Lvj0AkvABKIhC4d51J6X3t3jsejntV3XoRQipPm
         poF2gxlDKAO79HKNulxNphEasjoJZcNDsZQyuqEM=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=U-VZJWzGeqaotD_rgOIA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 10/15] rebase-interactive: use todo_list_transform() in
 edit_todo_list()
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181007195418.25752-11-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <f95102e3-3968-361f-2e2a-a22989519480@talktalk.net>
Date:   Thu, 11 Oct 2018 16:16:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181007195418.25752-11-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfP5CBDNiLDj7Gnb7LNosFNmtPXB6dy+nApN9QI+konUaIvR4xhynHwP04mXIHxINctNifYNBCwGg13tP5gLBNfv/9MWosqJi2RvI2prWLm0Om8m85fme
 84PI9ByB/Afz1w249CbLv1AOkLxorZaDQt7yabA4J4I1WtFU1G3kz4SjrBvBu9whKAbTeD5z+58GVChzqk+SMEegRo26reoOOeXFr516rYTVDr0otHdAFQz6
 R/jQyqZMxstMERxChmnLRQrpd2EvsMZbVPdqGmzy4V4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/10/2018 20:54, Alban Gruin wrote:
> Just like complete_action(), edit_todo_list() used a
> function (transform_todo_file()) that read the todo-list from the disk
> and wrote it back, resulting in useless disk accesses.
> 
> This changes edit_todo_list() to call directly todo_list_transform()
> instead.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>   rebase-interactive.c | 40 +++++++++++++++++++---------------------
>   1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index 7c7f720a3d..f42d48e192 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -78,39 +78,37 @@ void append_todo_help(unsigned edit_todo, unsigned keep_empty,
>   
>   int edit_todo_list(unsigned flags)
>   {
> -	struct strbuf buf = STRBUF_INIT;
>   	const char *todo_file = rebase_path_todo();
> +	struct todo_list todo_list = TODO_LIST_INIT;
> +	int res = 0;
>   
> -	if (strbuf_read_file(&buf, todo_file, 0) < 0)
> +	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
>   		return error_errno(_("could not read '%s'."), todo_file);
>   
> -	strbuf_stripspace(&buf, 1);
> -	if (write_message(buf.buf, buf.len, todo_file, 0)) {
> -		strbuf_release(&buf);
> -		return -1;
> -	}
> -
> -	strbuf_release(&buf);
> +	strbuf_stripspace(&todo_list.buf, 1);
> +	if (!todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list))
> +		todo_list_transform(&todo_list, flags | TODO_LIST_SHORTEN_IDS);
>   
> -	transform_todo_file(flags | TODO_LIST_SHORTEN_IDS);
> -
> -	if (strbuf_read_file(&buf, todo_file, 0) < 0)
> -		return error_errno(_("could not read '%s'."), todo_file);
> +	append_todo_help(1, 0, &todo_list.buf);
>   
> -	append_todo_help(1, 0, &buf);

I think this patch is fine, I was just wondering if you meant to move 
the call to append_todo_help() above the blank line?

Best Wishes

Phillip

> -	if (write_message(buf.buf, buf.len, todo_file, 0)) {
> -		strbuf_release(&buf);
> +	if (write_message(todo_list.buf.buf, todo_list.buf.len, todo_file, 0)) {
> +		todo_list_release(&todo_list);
>   		return -1;
>   	}
>   
> -	strbuf_release(&buf);
> -
> -	if (launch_sequence_editor(todo_file, NULL, NULL))
> +	strbuf_reset(&todo_list.buf);
> +	if (launch_sequence_editor(todo_file, &todo_list.buf, NULL)) {
> +		todo_list_release(&todo_list);
>   		return -1;
> +	}
>   
> -	transform_todo_file(flags & ~(TODO_LIST_SHORTEN_IDS));
> +	if (!todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
> +		todo_list_transform(&todo_list, flags & ~(TODO_LIST_SHORTEN_IDS));
> +		res = write_message(todo_list.buf.buf, todo_list.buf.len, todo_file, 0);
> +	}
>   
> -	return 0;
> +	todo_list_release(&todo_list);
> +	return res;
>   }
>   
>   define_commit_slab(commit_seen, unsigned char);
> 

