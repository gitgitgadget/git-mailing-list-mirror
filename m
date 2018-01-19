Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E43FF1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 12:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754855AbeASMcu (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 07:32:50 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:32753 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754805AbeASMct (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 07:32:49 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jan 2018 07:32:48 EST
Received: from barra ([92.22.6.159])
        by smtp.talktalk.net with SMTP
        id cVipeVz5cbjdZcVipeprHX; Fri, 19 Jan 2018 12:24:40 +0000
X-Originating-IP: [92.22.6.159]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=zHCrIP3pJrCm+L4FAUKT3Q==:117
 a=zHCrIP3pJrCm+L4FAUKT3Q==:17 a=IkcTkHD0fZMA:10 a=RgaUWeydRksA:10
 a=TfwUW0lHuZx4u3D9kIMA:9 a=QEXdDO2ut3YA:10
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Date:   Fri, 19 Jan 2018 12:24:00 -0000
Subject: Re: [PATCH 1/8] sequencer: introduce new commands to resettherevision
Envelope-To: sunshine@sunshineco.com,philipoakley@iee.org,jacob.keller@gmail.com,gitster@pobox.com,git@vger.kernel.org,johannes.schindelin@gmx.de
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <8a91bf2184a3da4c0d5a13ba184813068e51f5c8.1516225925.git.johannes.schindelin@gmx.de>
CC:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Message-ID: <d069a3c7-198e-81d2-0f35-f934e110c991@philandanna.no-ip.org>
From:   "Phillip Wood" <phil@philandanna.no-ip.org>
Received: from [192.168.2.201] (lindisfarne.local [192.168.2.201])
        by barra; Fri, 19 Jan 2018 12:24:02 -0000
Reply-To: phillip.wood@dunelm.org.uk
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLrypfyoINAIHuLHY3If8X6bDOy27TgswU/jy0b63hiGatum5GaYvtAdxRGaey7/OYXF+dRegVnGAeqLfsx7TTJ48ib4DamVYrTVLMczeUq1rU55EfMl
 VJhwcg00VmFRgnNWWGoRGxUXFS0r5U2oZrmsrGbvY90KHZhaAsV6sEl0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 18/01/18 15:35, Johannes Schindelin wrote:
> 
> In the upcoming commits, we will teach the sequencer to recreate merges.
> This will be done in a very different way from the unfortunate design of
> `git rebase --preserve-merges` (which does not allow for reordering
> commits, or changing the branch topology).
> 
> The main idea is to introduce new todo list commands, to support
> labeling the current revision with a given name, resetting the current
> revision to a previous state, merging labeled revisions.

I think this would be a great improvement to rebase -i, thanks for
working on it.

> This idea was developed in Git for Windows' Git garden shears (that are
> used to maintain the "thicket of branches" on top of upstream Git), and
> this patch is part of the effort to make it available to a wider
> audience, as well as to make the entire process more robust (by
> implementing it in a safe and portable language rather than a Unix shell
> script).
> 
> This commit implements the commands to label, and to reset to, given
> revisions. The syntax is:
> 
> 	label <name>
> 	reset <name>

If I've understood the code below correctly then reset will clobber
untracked files, this is the opposite behaviour to what happens when
tries to checkout <onto> at the start of a rebase - then it will fail if
untracked files would be overwritten.

> As a convenience shortcut, also to improve readability of the generated
> todo list, a third command is introduced: bud. It simply resets to the
> "onto" revision, i.e. the commit onto which we currently rebase.

I found the whole bud business bewildering at first, reading the other
replies it seems I wasn't the only one to be befuddled by it. Having
seen an example I can see what it's trying to do but I still think it
adds more confusion than value.

> Internally, the `label <name>` command creates the ref
> `refs/rewritten/<name>`. This makes it possible to work with the labeled
> revisions interactively, or in a scripted fashion (e.g. via the todo
> list command `exec`).

If a user has two work trees and runs a rebase in each with the same
label name, they'll clobber each other. I'd suggest storing them under
refs/rewritten/<branch-name or detached HEAD SHA> instead. If the user
tries to rebase a second worktree with the same detached HEAD as an
existing rebase then refuse to start.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git-rebase--interactive.sh |   3 +
>  sequencer.c                | 181 ++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 180 insertions(+), 4 deletions(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index d47bd29593a..3d2cd19d65a 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -162,6 +162,9 @@ s, squash = use commit, but meld into previous commit
>  f, fixup = like \"squash\", but discard this commit's log message
>  x, exec = run command (the rest of the line) using shell
>  d, drop = remove commit
> +l, label = label current HEAD with a name
> +t, reset = reset HEAD to a label
> +b, bud = reset HEAD to the revision labeled 'onto'
>  
>  These lines can be re-ordered; they are executed from top to bottom.
>  " | git stripspace --comment-lines >>"$todo"
> diff --git a/sequencer.c b/sequencer.c
> index 4d3f60594cb..91cc55a002f 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -21,6 +21,8 @@
>  #include "log-tree.h"
>  #include "wt-status.h"
>  #include "hashmap.h"
> +#include "unpack-trees.h"
> +#include "worktree.h"
>  
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>  
> @@ -116,6 +118,13 @@ static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
>  static GIT_PATH_FUNC(rebase_path_rewritten_list, "rebase-merge/rewritten-list")
>  static GIT_PATH_FUNC(rebase_path_rewritten_pending,
>  	"rebase-merge/rewritten-pending")
> +
> +/*
> + * The path of the file listing refs that need to be deleted after the rebase
> + * finishes. This is used by the `merge` command.
> + */
> +static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
> +
>  /*
>   * The following files are written by git-rebase just after parsing the
>   * command-line (and are only consumed, not modified, by the sequencer).
> @@ -767,6 +776,9 @@ enum todo_command {
>  	TODO_SQUASH,
>  	/* commands that do something else than handling a single commit */
>  	TODO_EXEC,
> +	TODO_LABEL,
> +	TODO_RESET,
> +	TODO_BUD,
>  	/* commands that do nothing but are counted for reporting progress */
>  	TODO_NOOP,
>  	TODO_DROP,
> @@ -785,6 +797,9 @@ static struct {
>  	{ 'f', "fixup" },
>  	{ 's', "squash" },
>  	{ 'x', "exec" },
> +	{ 'l', "label" },
> +	{ 't', "reset" },
> +	{ 'b', "bud" },
>  	{ 0,   "noop" },
>  	{ 'd', "drop" },
>  	{ 0,   NULL }
> @@ -1253,7 +1268,8 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
>  		if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
>  			item->command = i;
>  			break;
> -		} else if (bol[1] == ' ' && *bol == todo_command_info[i].c) {
> +		} else if ((bol + 1 == eol || bol[1] == ' ') &&
> +			   *bol == todo_command_info[i].c) {
>  			bol++;
>  			item->command = i;
>  			break;
> @@ -1265,7 +1281,7 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
>  	padding = strspn(bol, " \t");
>  	bol += padding;
>  
> -	if (item->command == TODO_NOOP) {
> +	if (item->command == TODO_NOOP || item->command == TODO_BUD) {
>  		if (bol != eol)
>  			return error(_("%s does not accept arguments: '%s'"),
>  				     command_to_string(item->command), bol);
> @@ -1279,7 +1295,8 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
>  		return error(_("missing arguments for %s"),
>  			     command_to_string(item->command));
>  
> -	if (item->command == TODO_EXEC) {
> +	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
> +	    item->command == TODO_RESET) {
>  		item->commit = NULL;
>  		item->arg = bol;
>  		item->arg_len = (int)(eol - bol);
> @@ -1919,6 +1936,139 @@ static int do_exec(const char *command_line)
>  	return status;
>  }
>  
> +static int safe_append(const char *filename, const char *fmt, ...)
> +{
> +	va_list ap;
> +	struct lock_file lock = LOCK_INIT;
> +	int fd = hold_lock_file_for_update(&lock, filename, 0);
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	if (fd < 0)
> +		return error_errno(_("could not lock '%s'"), filename);
> +
> +	if (strbuf_read_file(&buf, filename, 0) < 0 && errno != ENOENT)
> +		return error_errno(_("could not read '%s'"), filename);
> +	strbuf_complete(&buf, '\n');
> +	va_start(ap, fmt);
> +	strbuf_vaddf(&buf, fmt, ap);
> +	va_end(ap);
> +
> +	if (write_in_full(fd, buf.buf, buf.len) < 0) {
> +		rollback_lock_file(&lock);
> +		return error_errno(_("could not write to '%s'"), filename);
> +	}
> +	if (commit_lock_file(&lock) < 0) {
> +		rollback_lock_file(&lock);
> +		return error(_("failed to finalize '%s'."), filename);
> +	}
> +
> +	return 0;
> +}
> +
> +static int do_label(const char *name, int len)
> +{
> +	struct ref_store *refs = get_main_ref_store();
> +	struct ref_transaction *transaction;
> +	struct strbuf ref_name = STRBUF_INIT, err = STRBUF_INIT;
> +	struct strbuf msg = STRBUF_INIT;
> +	int ret = 0;
> +	struct object_id head_oid;
> +
> +	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
> +	strbuf_addf(&msg, "label '%.*s'", len, name);

The other reflog messages below have a (rebase -i) prefix

> +
> +	transaction = ref_store_transaction_begin(refs, &err);
> +	if (!transaction ||
> +	    get_oid("HEAD", &head_oid) ||
> +	    ref_transaction_update(transaction, ref_name.buf, &head_oid, NULL,
> +				   0, msg.buf, &err) < 0 ||
> +	    ref_transaction_commit(transaction, &err)) {
> +		error("%s", err.buf);

if get_oid() fails then err is empty so there wont be an message after
the 'error: '

> +		ret = -1;
> +	}
> +	ref_transaction_free(transaction);
> +	strbuf_release(&err);
> +	strbuf_release(&msg);
> +
> +	if (!ret)
> +		ret = safe_append(rebase_path_refs_to_delete(),
> +				  "%s\n", ref_name.buf);
> +	strbuf_release(&ref_name);
> +
> +	return ret;
> +}
> +
> +static int do_reset(const char *name, int len)
> +{
> +	struct strbuf ref_name = STRBUF_INIT;
> +	struct object_id oid;
> +	struct lock_file lock = LOCK_INIT;
> +	struct tree_desc desc;
> +	struct tree *tree;
> +	struct unpack_trees_options opts;
> +	int ret = 0, i;
> +
> +	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
> +		return -1;
> +
> +	for (i = 0; i < len; i++)
> +		if (isspace(name[i]))
> +			len = i;

If name starts with any white space then I think this effectively
truncates name to a bunch of white space which doesn't sound right. I'm
not sure how this is being called, but it might be better to clean up
name when the to-do list is parsed instead.

> +
> +	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
> +	if (get_oid(ref_name.buf, &oid) &&
> +	    get_oid(ref_name.buf + strlen("refs/rewritten/"), &oid)) {
> +		error(_("could not read '%s'"), ref_name.buf);
> +		rollback_lock_file(&lock);
> +		strbuf_release(&ref_name);
> +		return -1;
> +	}
> +
> +	memset(&opts, 0, sizeof(opts));
> +	opts.head_idx = 1;
> +	opts.src_index = &the_index;
> +	opts.dst_index = &the_index;
> +	opts.fn = oneway_merge;
> +	opts.merge = 1;
> +	opts.update = 1;
> +	opts.reset = 1;
> +
> +	read_cache_unmerged();
> +	if (!fill_tree_descriptor(&desc, &oid)) {
> +		error(_("Failed to find tree of %s."), oid_to_hex(&oid));
> +		rollback_lock_file(&lock);
> +		free((void *)desc.buffer);
> +		strbuf_release(&ref_name);
> +		return -1;
> +	}
> +
> +	if (unpack_trees(1, &desc, &opts)) {
> +		rollback_lock_file(&lock);
> +		free((void *)desc.buffer);
> +		strbuf_release(&ref_name);
> +		return -1;
> +	}
> +
> +	tree = parse_tree_indirect(&oid);
> +	prime_cache_tree(&the_index, tree);
> +
> +	if (write_locked_index(&the_index, &lock, COMMIT_LOCK) < 0)
> +		ret = error(_("could not write index"));
> +	free((void *)desc.buffer);
> +
> +	if (!ret) {
> +		struct strbuf msg = STRBUF_INIT;
> +
> +		strbuf_addf(&msg, "(rebase -i) reset '%.*s'", len, name);
> +		ret = update_ref(msg.buf, "HEAD", &oid, NULL, 0,
> +				 UPDATE_REFS_MSG_ON_ERR);
> +		strbuf_release(&msg);
> +	}
> +
> +	strbuf_release(&ref_name);
> +	return ret;
> +}
> +
>  static int is_final_fixup(struct todo_list *todo_list)
>  {
>  	int i = todo_list->current;
> @@ -2102,7 +2252,13 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  				/* `current` will be incremented below */
>  				todo_list->current = -1;
>  			}
> -		} else if (!is_noop(item->command))
> +		} else if (item->command == TODO_LABEL)
> +			res = do_label(item->arg, item->arg_len);
> +		else if (item->command == TODO_RESET)
> +			res = do_reset(item->arg, item->arg_len);
> +		else if (item->command == TODO_BUD)
> +			res = do_reset("onto", 4);
> +		else if (!is_noop(item->command))
>  			return error(_("unknown command %d"), item->command);
>  
>  		todo_list->current++;
> @@ -2207,6 +2363,23 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  		}
>  		apply_autostash(opts);
>  
> +		strbuf_reset(&buf);
> +		if (strbuf_read_file(&buf, rebase_path_refs_to_delete(), 0)
> +		    > 0) {
> +			char *p = buf.buf;
> +			while (*p) {
> +				char *eol = strchr(p, '\n');
> +				if (eol)
> +					*eol = '\0';
> +				if (delete_ref("(rebase -i) cleanup",
> +					       p, NULL, 0) < 0)
> +					warning(_("could not delete '%s'"), p);
> +				if (!eol)
> +					break;
> +				p = eol + 1;
> +			}
> +		}
> +
>  		fprintf(stderr, "Successfully rebased and updated %s.\n",
>  			head_ref.buf);
>  
> 

