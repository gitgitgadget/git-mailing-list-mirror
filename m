Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FA691F453
	for <e@80x24.org>; Wed, 13 Feb 2019 10:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732873AbfBMKKc (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 05:10:32 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:29045 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729978AbfBMKKc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 05:10:32 -0500
Received: from [192.168.2.201] ([92.22.24.194])
        by smtp.talktalk.net with SMTP
        id trUqgx7BYoI6LtrUqgV5i7; Wed, 13 Feb 2019 10:10:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1550052629;
        bh=nkrUAwOnXgql30Mmx9RQ12HSG0ZtdABY3kkrnrezvUI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=C7NYUEeBvZexvP/muLxytYpsWB92lEoOCBpL9Zjgr6AZMbyKv5+hrIXkr4RUHf7Ch
         PJAid7L+jucQ3GnSpoNHxX1UHW/Ino2O4jv4wIHp5TD18ULMBW070tdy5OUsHV1sKp
         CfPh4woAMxH801wLMyTPddyTeEOzEjJO90wC4rAs=
X-Originating-IP: [92.22.24.194]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=OJBejJTAIYRVoGQ3FWVcuw==:117
 a=OJBejJTAIYRVoGQ3FWVcuw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=EiqH-dezZdKlYvp6bHYA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 14/16] rebase-interactive: rewrite edit_todo_list() to
 handle the initial edit
To:     Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
References: <20190129150159.10588-1-alban.gruin@gmail.com>
 <20190210132648.12821-1-alban.gruin@gmail.com>
 <20190210132648.12821-15-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <2dfec48d-70fe-ca69-47ac-2a766db2e80c@talktalk.net>
Date:   Wed, 13 Feb 2019 10:10:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190210132648.12821-15-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHVfiTC/j4kBPGGupK3mZnFQto7/Ie7nkTgH2DL4Z+dLOdhhGS1i8bldXiEi60agJKryXdqFQUpb3Xjt2nfUM0D9nxWt7zxMsY5ghCDOj2cqlk35MKxL
 srceapVxWqPeaskAS04hIDKCfBE6ISc6vVx4FfgEJDJKtbVF28IzJLcVkN5tMaVzG0N9nNE+ZbF1rW6OEipH37/BmAbFNpILw2YNQAAq9lnbhGE4z8HTrlr7
 j7kot8QSzd5hGmpDzbibW/42QiJ+8bQYi+QHFDd967HI7odSMh9jdAkhIIsiUpv3RXIcnZs0fayYL8qQNSRZyA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

I think the error handling is fine now, I've got a couple of small
comments below.

On 10/02/2019 13:26, Alban Gruin wrote:
> edit_todo_list() is changed to work on a todo_list, and to handle the
> initial edition of the todo list (ie. making a backup of the todo
> list).
> 
> It does not check for dropped commits yet, as todo_list_check() does not
> take the commits that have already been processed by the rebase (ie. the
> todo list is edited in the middle of a rebase session).
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  builtin/rebase--interactive.c | 24 +++++++++++++++++-
>  rebase-interactive.c          | 48 +++++++++++++++++------------------
>  rebase-interactive.h          |  4 ++-
>  sequencer.c                   |  3 +--
>  sequencer.h                   |  1 +
>  5 files changed, 52 insertions(+), 28 deletions(-)
> 
> diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
> index 4f2949922f..370d584683 100644
> --- a/builtin/rebase--interactive.c
> +++ b/builtin/rebase--interactive.c
> @@ -13,6 +13,28 @@ static GIT_PATH_FUNC(path_state_dir, "rebase-merge/")
>  static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
>  static GIT_PATH_FUNC(path_interactive, "rebase-merge/interactive")
>  
> +static int edit_todo_file(unsigned flags)
> +{
> +	const char *todo_file = rebase_path_todo();
> +	struct todo_list todo_list = TODO_LIST_INIT,
> +		new_todo = TODO_LIST_INIT;
> +	int res = 0;
> +
> +	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
> +		return error_errno(_("could not read '%s'."), todo_file);
> +
> +	strbuf_stripspace(&todo_list.buf, 1);
> +	res = edit_todo_list(the_repository, &todo_list, &new_todo, NULL, NULL, flags);
> +	if (!res && todo_list_write_to_file(the_repository, &new_todo, todo_file,
> +					    NULL, NULL, -1, flags & ~(TODO_LIST_SHORTEN_IDS)))
> +		res = error_errno(_("could not write '%s'"), todo_file);
> +
> +	todo_list_release(&todo_list);
> +	todo_list_release(&new_todo);
> +
> +	return res;
> +}
> +
>  static int get_revision_ranges(const char *upstream, const char *onto,
>  			       const char **head_hash,
>  			       char **revisions, char **shortrevisions)
> @@ -241,7 +263,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>  		break;
>  	}
>  	case EDIT_TODO:
> -		ret = edit_todo_list(the_repository, flags);
> +		ret = edit_todo_file(flags);
>  		break;
>  	case SHOW_CURRENT_PATCH: {
>  		struct child_process cmd = CHILD_PROCESS_INIT;
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index 807f8370db..96c70d1959 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -87,35 +87,35 @@ void append_todo_help(unsigned keep_empty, int command_count,
>  	}
>  }
>  
> -int edit_todo_list(struct repository *r, unsigned flags)
> +int edit_todo_list(struct repository *r, struct todo_list *todo_list,
> +		   struct todo_list *new_todo, const char *shortrevisions,
> +		   const char *shortonto, unsigned flags)
>  {
>  	const char *todo_file = rebase_path_todo();
> -	struct todo_list todo_list = TODO_LIST_INIT;
> -	int res = 0;
> -
> -	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
> -		return error_errno(_("could not read '%s'."), todo_file);
> -
> -	strbuf_stripspace(&todo_list.buf, 1);
> -	todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list);
> -	if (todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1,
> -				    flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP)) {
> -		todo_list_release(&todo_list);
> -		return -1;
> -	}
> +	unsigned initial = shortrevisions && shortonto;
>  
> -	strbuf_reset(&todo_list.buf);
> -	if (launch_sequence_editor(todo_file, &todo_list.buf, NULL)) {
> -		todo_list_release(&todo_list);
> -		return -1;
> -	}
> +	if (!initial)
> +		todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);

It might be worth a comment to explain that we always want to edit the
file so we deliberately ignore any parsing errors (I'm not sure what we
end writing to the disc if we can't parse the file though) and that the
todo list is already parsed in the initial case.

>  
> -	if (!todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list))
> -		res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1,
> -					      flags & ~(TODO_LIST_SHORTEN_IDS));
> +	if (todo_list_write_to_file(r, todo_list, todo_file, shortrevisions, shortonto,
> +				    -1, flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP))
> +		return error_errno(_("could not write '%s'"), todo_file);
>  
> -	todo_list_release(&todo_list);
> -	return res;
> +	if (initial && copy_file(rebase_path_todo_backup(), todo_file, 0666))
> +		return error(_("could not copy '%s' to '%s'."), todo_file,
> +			     rebase_path_todo_backup());
> +
> +	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
> +		return -2;
> +
> +	strbuf_stripspace(&new_todo->buf, 1);
> +	if (initial && new_todo->buf.len == 0)
> +		return -3;
> +
> +	if (!initial)
> +		return todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo);

It might be worth a comment explaining where the list gets parsed for
the initial edit.

Best Wishes

Phillip

> +
> +	return 0;
>  }
>  
>  define_commit_slab(commit_seen, unsigned char);
> diff --git a/rebase-interactive.h b/rebase-interactive.h
> index 0e5925e3aa..44dbb06311 100644
> --- a/rebase-interactive.h
> +++ b/rebase-interactive.h
> @@ -8,7 +8,9 @@ struct todo_list;
>  void append_todo_help(unsigned keep_empty, int command_count,
>  		      const char *shortrevisions, const char *shortonto,
>  		      struct strbuf *buf);
> -int edit_todo_list(struct repository *r, unsigned flags);
> +int edit_todo_list(struct repository *r, struct todo_list *todo_list,
> +		   struct todo_list *new_todo, const char *shortrevisions,
> +		   const char *shortonto, unsigned flags);
>  int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo);
>  
>  #endif
> diff --git a/sequencer.c b/sequencer.c
> index 64d698032c..f6ed4e21e9 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -55,8 +55,7 @@ static GIT_PATH_FUNC(rebase_path, "rebase-merge")
>   * file and written to the tail of 'done'.
>   */
>  GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
> -static GIT_PATH_FUNC(rebase_path_todo_backup,
> -		     "rebase-merge/git-rebase-todo.backup")
> +GIT_PATH_FUNC(rebase_path_todo_backup, "rebase-merge/git-rebase-todo.backup")
>  
>  /*
>   * The rebase command lines that have already been processed. A line
> diff --git a/sequencer.h b/sequencer.h
> index c80990659c..b0688ba2a1 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -10,6 +10,7 @@ struct repository;
>  const char *git_path_commit_editmsg(void);
>  const char *git_path_seq_dir(void);
>  const char *rebase_path_todo(void);
> +const char *rebase_path_todo_backup(void);
>  
>  #define APPEND_SIGNOFF_DEDUP (1u << 0)
>  
> 

