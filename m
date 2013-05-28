From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] cherry-pick: add support to copy notes
Date: Tue, 28 May 2013 10:07:35 -0700
Message-ID: <7vobbv119k.fsf@alter.siamese.dyndns.org>
References: <1369745947-19416-1-git-send-email-felipe.contreras@gmail.com>
	<1369745947-19416-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 19:07:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhNNA-0000hZ-1a
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 19:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934887Ab3E1RHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 13:07:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47631 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934867Ab3E1RHi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 13:07:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F3CD23EBC;
	Tue, 28 May 2013 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Fltcnujtc3t65y7p1crw7N0+ZDE=; b=VMlr0WQ6nSCulCRaQrzb
	PPOcnvdM/r62R27v1Kxgk1PcfsZJyeAWrL2YiOWM21iR8czTyywUYWItMNUMsviu
	j1RmXkQw1ZqWeWaiNIMnSaERpUUiwcUvHX+CgOQN0e26Tf0wBucDKhGWI2cIxGf+
	3yzQCyeAKHU4bJGCkV5ZJk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=dU1sDPVdlE4pmyGDe4oe97Hk6+4GhJBou2Rpovnd8LsgXs
	DHnZ+poa8eLIv6MJx/vCkKsbKbr42B8bLdbVIS/90jlvlU6vtyQS5n555ofQ53Ak
	eBenCcUHSTyUoca8A9Sy3jVoQuIKlr9uZxrPP/hHy+qAvYoKl9mKXysWJZBYc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14FA123EBB;
	Tue, 28 May 2013 17:07:38 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CDEA23EBA;
	Tue, 28 May 2013 17:07:36 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 18A19A96-C7B9-11E2-BDDC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225668>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/revert.c  |   2 +
>  sequencer.c       | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  sequencer.h       |   2 +
>  t/t3500-cherry.sh |  32 +++++++++++++
>  4 files changed, 169 insertions(+), 3 deletions(-)

"git cherry-pick" should help maintaining notes just like amend and
rebase, but how should this interact with notes.rewrite.<command>,
where the command is capable of doing this without an explicit
option once you tell which notes need to be maintained?

Thomas Rast Cc'ed as he has been the primary force behind this line
of "notes" usability.

It probably is not sensible to carry over note from a reverted
commit to its revert, but I didn't immediately spot how the patch
does this only for cherry-pick but not for revert (the codepath in
do_pick_commit() is shared between them, no?).

> diff --git a/builtin/revert.c b/builtin/revert.c
> index 0e5ce71..b977124 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -119,6 +119,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>  		OPT_END(),
>  		OPT_END(),
>  		OPT_END(),
> +		OPT_END(),
>  	};
>  
>  	if (opts->action == REPLAY_PICK) {
> @@ -129,6 +130,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>  			OPT_BOOLEAN(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
>  			OPT_BOOLEAN(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
>  			OPT_BOOLEAN(0, "skip-empty", &opts->skip_empty, N_("skip empty commits")),
> +			OPT_BOOLEAN(0, "copy-notes", &opts->copy_notes, N_("copy notes")),
>  			OPT_END(),
>  		};
>  		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
> diff --git a/sequencer.c b/sequencer.c
> index edf141d..35a84ad 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -20,6 +20,18 @@
>  const char sign_off_header[] = "Signed-off-by: ";
>  static const char cherry_picked_prefix[] = "(cherry picked from commit ";
>  
> +struct rewritten_list_item {
> +	unsigned char from[20];
> +	unsigned char to[20];
> +};
> +
> +struct rewritten_list {
> +	struct rewritten_list_item *items;
> +	unsigned int nr, alloc;
> +};
> +
> +static struct rewritten_list rewritten;
> +
>  static int is_rfc2822_line(const char *buf, int len)
>  {
>  	int i;
> @@ -102,6 +114,40 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
>  	return 1;
>  }
>  
> +static void add_rewritten(unsigned char *from, unsigned char *to)
> +{
> +	struct rewritten_list_item *item;
> +	if (rewritten.nr + 1 >= rewritten.alloc) {
> +		rewritten.alloc += 32;
> +		rewritten.items = xrealloc(rewritten.items, rewritten.alloc * sizeof(*rewritten.items));
> +	}
> +	item = &rewritten.items[rewritten.nr];
> +	hashcpy(item->from, from);
> +	hashcpy(item->to, to);
> +	rewritten.nr++;
> +}
> +
> +static void copy_notes(void)
> +{
> +	unsigned char note_commit[20];
> +	struct strbuf buf = STRBUF_INIT;
> +	struct notes_tree *t = &default_notes_tree;
> +	int i;
> +
> +	init_notes(t, NULL, NULL, 0);
> +
> +	for (i = 0; i < rewritten.nr; i++) {
> +		struct rewritten_list_item *item = &rewritten.items[i];
> +		copy_note(t, item->from, item->to, 0, NULL);
> +	}
> +
> +	strbuf_addstr(&buf, "Notes added by 'git cherry-pick'\n");
> +	create_notes_commit(&default_notes_tree, NULL, &buf, note_commit);
> +	strbuf_insert(&buf, 0, "notes: ", 7);
> +	update_ref(buf.buf, t->ref, note_commit, NULL, 0, MSG_ON_ERR);
> +	strbuf_release(&buf);
> +}
> +
>  static void remove_sequencer_state(void)
>  {
>  	struct strbuf seq_dir = STRBUF_INIT;
> @@ -641,6 +687,14 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>  			res = run_git_commit(defmsg, opts, allow);
>  	}
>  
> +	if (!res && opts->copy_notes) {
> +		unsigned char to[20];
> +
> +		if (read_ref("HEAD", to))
> +			goto leave;
> +
> +		add_rewritten(commit->object.sha1, to);
> +	}
>  leave:
>  	free_message(&msg);
>  	free(defmsg);
> @@ -786,6 +840,40 @@ static void read_populate_todo(struct commit_list **todo_list,
>  		die(_("Unusable instruction sheet: %s"), todo_file);
>  }
>  
> +static void read_populate_rewritten(void)
> +{
> +	const char *rewritten_file = git_path(SEQ_REWR_FILE);
> +	struct strbuf buf = STRBUF_INIT;
> +	char *p;
> +	int fd;
> +
> +	fd = open(rewritten_file, O_RDONLY);
> +	if (fd < 0)
> +		return;
> +	if (strbuf_read(&buf, fd, 0) < 0) {
> +		close(fd);
> +		strbuf_release(&buf);
> +		return;
> +	}
> +	close(fd);
> +
> +	for (p = buf.buf; *p;) {
> +		unsigned char from[20];
> +		unsigned char to[20];
> +		char *eol = strchrnul(p, '\n');
> +		if (eol - p != 81)
> +			/* wrong size */
> +			break;
> +		if (get_sha1_hex(p, from))
> +			break;
> +		if (get_sha1_hex(p + 41, to))
> +			break;
> +		add_rewritten(from, to);
> +		p = *eol ? eol + 1 : eol;
> +	}
> +	strbuf_release(&buf);
> +}
> +
>  static int populate_opts_cb(const char *key, const char *value, void *data)
>  {
>  	struct replay_opts *opts = data;
> @@ -810,7 +898,10 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
>  	else if (!strcmp(key, "options.strategy-option")) {
>  		ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
>  		opts->xopts[opts->xopts_nr++] = xstrdup(value);
> -	} else
> +	}
> +	else if (!strcmp(key, "options.copy-notes"))
> +		opts->copy_notes = git_config_bool_or_int(key, value, &error_flag);
> +	else
>  		return error(_("Invalid key: %s"), key);
>  
>  	if (!error_flag)
> @@ -958,6 +1049,29 @@ static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
>  	strbuf_release(&buf);
>  }
>  
> +static void save_rewritten(void)
> +{
> +	const char *todo_file = git_path(SEQ_REWR_FILE);
> +	static struct lock_file rewritten_lock;
> +	struct strbuf buf = STRBUF_INIT;
> +	int fd, i;
> +
> +	fd = hold_lock_file_for_update(&rewritten_lock, todo_file, LOCK_DIE_ON_ERROR);
> +	for (i = 0; i < rewritten.nr; i++) {
> +		struct rewritten_list_item *item = &rewritten.items[i];
> +		strbuf_addf(&buf, "%s %s\n", sha1_to_hex(item->from), sha1_to_hex(item->to));
> +	}
> +	if (write_in_full(fd, buf.buf, buf.len) < 0) {
> +		strbuf_release(&buf);
> +		die_errno(_("Could not write to %s"), todo_file);
> +	}
> +	if (commit_lock_file(&rewritten_lock) < 0) {
> +		strbuf_release(&buf);
> +		die(_("Error wrapping up %s."), todo_file);
> +	}
> +	strbuf_release(&buf);
> +}
> +
>  static void save_opts(struct replay_opts *opts)
>  {
>  	const char *opts_file = git_path(SEQ_OPTS_FILE);
> @@ -987,6 +1101,8 @@ static void save_opts(struct replay_opts *opts)
>  							"options.strategy-option",
>  							opts->xopts[i], "^$", 0);
>  	}
> +	if (opts->copy_notes)
> +		git_config_set_in_file(opts_file, "options.copy-notes", "true");
>  }
>  
>  static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
> @@ -1003,10 +1119,16 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
>  	for (cur = todo_list; cur; cur = cur->next) {
>  		save_todo(cur, opts);
>  		res = do_pick_commit(cur->item, opts);
> -		if (res)
> +		if (res) {
> +			if (opts->copy_notes)
> +				save_rewritten();
>  			return res;
> +		}
>  	}
>  
> +	if (opts->copy_notes)
> +		copy_notes();
> +
>  	/*
>  	 * Sequence of picks finished successfully; cleanup by
>  	 * removing the .git/sequencer directory
> @@ -1033,6 +1155,8 @@ static int sequencer_continue(struct replay_opts *opts)
>  		return continue_single_pick();
>  	read_populate_opts(&opts);
>  	read_populate_todo(&todo_list, opts);
> +	if (opts->copy_notes)
> +		read_populate_rewritten();
>  
>  	/* Verify that the conflict has been resolved */
>  	if (file_exists(git_path("CHERRY_PICK_HEAD")) ||
> @@ -1049,8 +1173,14 @@ static int sequencer_continue(struct replay_opts *opts)
>  
>  static int single_pick(struct commit *cmit, struct replay_opts *opts)
>  {
> +	int ret;
>  	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
> -	return do_pick_commit(cmit, opts);
> +	ret = do_pick_commit(cmit, opts);
> +	if (ret)
> +		return ret;
> +	if (opts->copy_notes)
> +		copy_notes();
> +	return 0;
>  }
>  
>  int sequencer_pick_revisions(struct replay_opts *opts)
> diff --git a/sequencer.h b/sequencer.h
> index 3b04844..6cc072c 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -5,6 +5,7 @@
>  #define SEQ_HEAD_FILE	"sequencer/head"
>  #define SEQ_TODO_FILE	"sequencer/todo"
>  #define SEQ_OPTS_FILE	"sequencer/opts"
> +#define SEQ_REWR_FILE	"sequencer/rewritten"
>  
>  #define APPEND_SIGNOFF_DEDUP (1u << 0)
>  
> @@ -35,6 +36,7 @@ struct replay_opts {
>  	int allow_empty_message;
>  	int keep_redundant_commits;
>  	int skip_empty;
> +	int copy_notes;
>  
>  	int mainline;
>  
> diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
> index f038f34..79c1219 100755
> --- a/t/t3500-cherry.sh
> +++ b/t/t3500-cherry.sh
> @@ -55,4 +55,36 @@ test_expect_success \
>       expr "$(echo $(git cherry master my-topic-branch) )" : "+ [^ ]* - .*"
>  '
>  
> +test_expect_success \
> +    'copy notes' \
> +    'git checkout master &&
> +    echo notes > C &&
> +    test_tick &&
> +    git commit -a -m "Update C" &&
> +    git notes add -m "a note" &&
> +    git checkout -b note-test HEAD^ &&
> +    git cherry-pick --copy-notes -x master &&
> +    test "a note" = "$(git notes show HEAD)"
> +'
> +
> +test_expect_success \
> +    'copy multiple notes' \
> +    'git checkout master &&
> +    echo "multiple notes" > C &&
> +    git commit -a -m "Update C again" &&
> +    git notes add -m "another note" &&
> +    git commit -a -m "Empty" --allow-empty &&
> +    echo "more notes" > C &&
> +    git commit -a -m "Update C once more" &&
> +    git notes add -m "final note" &&
> +    git checkout note-test &&
> +    git reset --hard master~3 &&
> +    test_expect_code 1 git cherry-pick --copy-notes -x HEAD..master &&
> +    git reset --hard &&
> +    git cherry-pick --continue
> +    test "a note" = "$(git notes show HEAD~2)" &&
> +    test "another note" = "$(git notes show HEAD~1)" &&
> +    test "final note" = "$(git notes show HEAD)"
> +'
> +
>  test_done
