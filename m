Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E2DF1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 10:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732278AbfBMKFn (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 05:05:43 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:18158 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfBMKFn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 05:05:43 -0500
Received: from [192.168.2.201] ([92.22.24.194])
        by smtp.talktalk.net with SMTP
        id trQCgx6cXoI6LtrQCgV5aM; Wed, 13 Feb 2019 10:05:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1550052341;
        bh=/tmZdBK1SVuXxUbnLgqHj9ymFHI035mZrQvPWpauIyA=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MwTuv0Ri7BrkAQxLqZ0yLSliWtPwJq4f5AqaSa6UAR0N+Lt/L5CQlmEIX5z91NPNG
         IVt5WaCWmJtzPLMFzG/wM1FfWZrKHY5RHZxUCUHRDhwVO++vU3a9QenJ1FRtCGpfO4
         sH9kjyuQqYIUAJJmKYz0+7o+daqeUYgjxztb4oxM=
X-Originating-IP: [92.22.24.194]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=OJBejJTAIYRVoGQ3FWVcuw==:117
 a=OJBejJTAIYRVoGQ3FWVcuw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=-SdBtPKUdoCwTFasenEA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 11/16] sequencer: refactor skip_unnecessary_picks() to
 work on a todo_list
To:     Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
References: <20190129150159.10588-1-alban.gruin@gmail.com>
 <20190210132648.12821-1-alban.gruin@gmail.com>
 <20190210132648.12821-12-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <1cc273d3-6d49-20f0-780b-c2d6d2edda87@talktalk.net>
Date:   Wed, 13 Feb 2019 10:05:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190210132648.12821-12-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEpgRWTrfxZuPl/rwq68DWRZwPgzWiZ7YlmfOdITo6d8zrXHF+LayHfBdzl764klbH87jHlEgrzsN5DLMl5SWMHwqGdsJyybuMq+zrWtON/tSbQRii+y
 4SzKrAblFZiSEmMG3x1c+9WD+YupoJ+1yc8N+2YuOMGvEDBzFM45gzS0XkQXUHIU9gqwPT/ZolCVy+Hdt+U5WQVcIZiX/GHo0E3f8mvTEwMx3DQXMXQi1ANI
 JJrCdymhPMHTIQUu8jrnZNTwSzClkKUv/XTrghwad/4xgIMWEBp03GJLavGMsl2pdHQyynzEs71mEepSoe+NbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 10/02/2019 13:26, Alban Gruin wrote:
> This refactors skip_unnecessary_picks() to work on a todo_list.  As this
> function is only called by complete_action() (and thus is not used by
> rebase -p), the file-handling logic is completely dropped here.
> 
> Instead of truncating the todo list’s buffer, the items are moved to
> the beginning of the list, eliminating the need to reparse the list.
> This also means its buffer cannot be directly written to the disk.
> 
> rewrite_file() is then removed, as it is now unused.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  sequencer.c | 82 +++++++++++++----------------------------------------
>  1 file changed, 19 insertions(+), 63 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index eb8a622af0..eacaf52250 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4717,52 +4717,22 @@ int check_todo_list_from_file(struct repository *r)
>  	return res;
>  }
>  
> -static int rewrite_file(const char *path, const char *buf, size_t len)
> -{
> -	int rc = 0;
> -	int fd = open(path, O_WRONLY | O_TRUNC);
> -	if (fd < 0)
> -		return error_errno(_("could not open '%s' for writing"), path);
> -	if (write_in_full(fd, buf, len) < 0)
> -		rc = error_errno(_("could not write to '%s'"), path);
> -	if (close(fd) && !rc)
> -		rc = error_errno(_("could not close '%s'"), path);
> -	return rc;
> -}
> -
>  /* skip picking commits whose parents are unchanged */
> -static int skip_unnecessary_picks(struct repository *r, struct object_id *output_oid)
> +static int skip_unnecessary_picks(struct repository *r,
> +				  struct todo_list *todo_list,
> +				  struct object_id *base_oid)

Thanks for renaming that parameter, I think it's much clearer.

Best Wishes

Phillip
>  {
> -	const char *todo_file = rebase_path_todo();
> -	struct strbuf buf = STRBUF_INIT;
> -	struct todo_list todo_list = TODO_LIST_INIT;
>  	struct object_id *parent_oid;
> -	int fd, i;
> -
> -	if (!read_oneliner(&buf, rebase_path_onto(), 0))
> -		return error(_("could not read 'onto'"));
> -	if (get_oid(buf.buf, output_oid)) {
> -		strbuf_release(&buf);
> -		return error(_("need a HEAD to fixup"));
> -	}
> -	strbuf_release(&buf);
> -
> -	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
> -		return -1;
> -	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
> -		todo_list_release(&todo_list);
> -		return -1;
> -	}
> +	int i;
>  
> -	for (i = 0; i < todo_list.nr; i++) {
> -		struct todo_item *item = todo_list.items + i;
> +	for (i = 0; i < todo_list->nr; i++) {
> +		struct todo_item *item = todo_list->items + i;
>  
>  		if (item->command >= TODO_NOOP)
>  			continue;
>  		if (item->command != TODO_PICK)
>  			break;
>  		if (parse_commit(item->commit)) {
> -			todo_list_release(&todo_list);
>  			return error(_("could not parse commit '%s'"),
>  				oid_to_hex(&item->commit->object.oid));
>  		}
> @@ -4771,42 +4741,26 @@ static int skip_unnecessary_picks(struct repository *r, struct object_id *output
>  		if (item->commit->parents->next)
>  			break; /* merge commit */
>  		parent_oid = &item->commit->parents->item->object.oid;
> -		if (!oideq(parent_oid, output_oid))
> +		if (!oideq(parent_oid, base_oid))
>  			break;
> -		oidcpy(output_oid, &item->commit->object.oid);
> +		oidcpy(base_oid, &item->commit->object.oid);
>  	}
>  	if (i > 0) {
> -		int offset = get_item_line_offset(&todo_list, i);
>  		const char *done_path = rebase_path_done();
>  
> -		fd = open(done_path, O_CREAT | O_WRONLY | O_APPEND, 0666);
> -		if (fd < 0) {
> -			error_errno(_("could not open '%s' for writing"),
> -				    done_path);
> -			todo_list_release(&todo_list);
> -			return -1;
> -		}
> -		if (write_in_full(fd, todo_list.buf.buf, offset) < 0) {
> +		if (todo_list_write_to_file(r, todo_list, done_path, NULL, NULL, i, 0)) {
>  			error_errno(_("could not write to '%s'"), done_path);
> -			todo_list_release(&todo_list);
> -			close(fd);
>  			return -1;
>  		}
> -		close(fd);
>  
> -		if (rewrite_file(rebase_path_todo(), todo_list.buf.buf + offset,
> -				 todo_list.buf.len - offset) < 0) {
> -			todo_list_release(&todo_list);
> -			return -1;
> -		}
> +		MOVE_ARRAY(todo_list->items, todo_list->items + i, todo_list->nr - i);
> +		todo_list->nr -= i;
> +		todo_list->current = 0;
>  
> -		todo_list.current = i;
> -		if (is_fixup(peek_command(&todo_list, 0)))
> -			record_in_rewritten(output_oid, peek_command(&todo_list, 0));
> +		if (is_fixup(peek_command(todo_list, 0)))
> +			record_in_rewritten(base_oid, peek_command(todo_list, 0));
>  	}
>  
> -	todo_list_release(&todo_list);
> -
>  	return 0;
>  }
>  
> @@ -4879,6 +4833,11 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>  		return -1;
>  	}
>  
> +	if (opts->allow_ff && skip_unnecessary_picks(r, &new_todo, &oid)) {
> +		todo_list_release(&new_todo);
> +		return error(_("could not skip unnecessary pick commands"));
> +	}
> +
>  	if (todo_list_write_to_file(r, &new_todo, todo_file, NULL, NULL, -1,
>  				    flags & ~(TODO_LIST_SHORTEN_IDS))) {
>  		todo_list_release(&new_todo);
> @@ -4887,9 +4846,6 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>  
>  	todo_list_release(&new_todo);
>  
> -	if (opts->allow_ff && skip_unnecessary_picks(r, &oid))
> -		return error(_("could not skip unnecessary pick commands"));
> -
>  	if (checkout_onto(opts, onto_name, oid_to_hex(&oid), orig_head))
>  		return -1;
>  
> 

