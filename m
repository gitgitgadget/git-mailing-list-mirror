From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 11/17] revert: Save data for continuing after conflict
 resolution
Date: Tue, 12 Jul 2011 14:37:16 -0500
Message-ID: <20110712193716.GB14909@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-12-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 21:37:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgilv-0001Cp-Ey
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 21:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896Ab1GLTh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 15:37:27 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37184 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872Ab1GLTh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 15:37:26 -0400
Received: by vxb39 with SMTP id 39so3691054vxb.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 12:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=weiMpAVYrY46fbAkgQY0a5xHpsqVzFmG4977lgWqGKY=;
        b=ufbLtMYe+HnkQy7UARJ9dLcQZrO3AnJ5V6eioFbH8vdUuj1n1dhm0N13GY8OAtrTGB
         RUKKH6AqOKUyJ4kSxkSjCyG8wGhYMDwlkmPtMP4yT8eRTxjMypMPpxGvrZ/xEYDEOWOV
         YsEapY6SJ8TybpUNE+vE2yya86KAePEo8aPlU=
Received: by 10.52.176.10 with SMTP id ce10mr384991vdc.280.1310499445356;
        Tue, 12 Jul 2011 12:37:25 -0700 (PDT)
Received: from elie ([69.209.70.6])
        by mx.google.com with ESMTPS id ck16sm5138922vdb.32.2011.07.12.12.37.22
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 12:37:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310396048-24925-12-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176970>

Hi,

Ramkumar Ramachandra wrote:

> It is imperative to note that these two files alone are not enough to
> implement "--continue"; we will also need to persist the options that
> were specified on the command-line, and this is done later in the
> series.

I think you could remove the phrase "It is imperative to note that"
and this would say the same thing. :)

By the way, those two files are enough to implement --continue in some
sense, no?  One implementation of --continue would forget options
passed on the first run and require the user to specify them again; it
would just be less useful.  The reminder that "head" and "todo" are
not the only files in the .git/sequencer dir is useful, though; thanks
for it.

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
[...]
> +static void format_todo(struct strbuf *buf, struct commit_list *todo_list,
> +			struct replay_opts *opts)
> +{
> +	struct commit_list *cur = NULL;
> +	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
> +	const char *sha1_abbrev = NULL;
> +	const char *action;
> +
> +	action = (opts->action == REVERT ? "revert" : "pick");
> +	for (cur = todo_list; cur; cur = cur->next) {
> +		sha1_abbrev = find_unique_abbrev(cur->item->object.sha1, DEFAULT_ABBREV);
> +		if (get_message(cur->item, &msg))
> +			die(_("Cannot get commit message for %s"), sha1_abbrev);
> +		strbuf_addf(buf, "%s %s %s\n", action, sha1_abbrev, msg.subject);

This die() seems odd in the context of a series that starts by
converting various die() calls to "return error()".

> +static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
> +{
> +	unsigned char commit_sha1[20];
> +	char sha1_abbrev[40];
> +	struct commit *commit;
> +	enum replay_action action;
> +	int insn_len = 0;
> +	char *p;
> +
> +	p = start;
> +	if (!(p = strchr(p, ' ')))
> +		return NULL;

Style: it is much, much clearer to write

	p = strchr(start, ' ');
	if (!p)
		return NULL;

In the git codebase, assignments in "if" conditionals are very rare, so
code like the above sticks out.

> +	insn_len = p - start;
> +	if (!(p = strchr(p + 1, ' ')))
> +		return NULL;
> +	p += 1;

Likewise.  This could say:

	insn_len = p - start;
	p = strchr(p + 1, ' ');
	if (!p)
		return NULL;
	p++;

or:

	p = strchrnul(start, ' ');
	if (!*p)
		return error("no commit name in todo file line: %s", start);
	p++;
	q = strchrnul(p, ' ');
	if (q - p > sizeof(sha1_abbrev) - 1)
		return error("commit name in todo file is too long: %s", start);
	*mempcpy(sha1_abbrev, p, q - p) = '\0';

> +	if (!strncmp(start, "pick", insn_len))
> +		action = CHERRY_PICK;
> +	else if (!strncmp(start, "revert", insn_len))
> +		action = REVERT;

This code means that "p", "pi", and "pic" are accepted as
abbreviations for "pick".   Maybe a comment would help to clarify
that.  Are we okay with reserving these names, so "r" in a todo
file means to "revert" and not to "reword" like it does in a
rebase -i todo list?

> +	/*
> +	 * Verify that the action matches up with the one in
> +	 * opts; we don't support arbitrary instructions
> +	 */
> +	if (action != opts->action)
> +		return NULL;

If I try "git cherry-pick foo..bar" and then "git revert --continue",
what error message will I get?

> +static void read_populate_todo(struct commit_list **todo_list,
> +			struct replay_opts *opts)
> +{
[...]
> +	for (p = buf.buf; *p; p = strchr(p, '\n') + 1) {
> +		if (!(commit = parse_insn_line(p, opts)))
> +			goto error;
> +		new = xmalloc(sizeof(struct commit_list));
> +		new->item = commit;
> +		*next = new;
> +		next = &new->next;

commit_list_append()?

> +static void create_seq_dir(void)
> +{
> +	if (file_exists(git_path(SEQ_DIR))) {
> +		if (!is_directory(git_path(SEQ_DIR)) && remove_path(git_path(SEQ_DIR)) < 0)
> +			die(_("Could not remove %s"), git_path(SEQ_DIR));
> +	} else if (mkdir(git_path(SEQ_DIR), 0777) < 0)
> +		die_errno(_("Could not create sequencer directory '%s'."), git_path(SEQ_DIR));
> +}

As mentioned in [1], a local would make this more readable.  And it's
not clear to me why one would want to delete a .git/sequencer file
that the user carefully placed there (I don't think git itself ever
writes such a thing).

> +
> +static void save_head(const char *head)
> +{
> +	static struct lock_file head_lock;
> +	struct strbuf buf = STRBUF_INIT;
> +	int fd;
> +
> +	fd = hold_lock_file_for_update(&head_lock, git_path(SEQ_HEAD_FILE), LOCK_DIE_ON_ERROR);
> +	strbuf_addf(&buf, "%s\n", head);
> +	if (write_in_full(fd, buf.buf, buf.len) < 0)
> +		die_errno(_("Could not write to %s."), git_path(SEQ_HEAD_FILE));
> +	if (commit_lock_file(&head_lock) < 0)
> +		die(_("Error wrapping up %s"), git_path(SEQ_HEAD_FILE));
> +}

A local would be helpful here, too.

> +static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
> +{
> +	static struct lock_file todo_lock;
> +	struct strbuf buf = STRBUF_INIT;
> +	int fd;
> +
> +	fd = hold_lock_file_for_update(&todo_lock, git_path(SEQ_TODO_FILE), LOCK_DIE_ON_ERROR);
> +	format_todo(&buf, todo_list, opts);
> +	if (write_in_full(fd, buf.buf, buf.len) < 0) {
> +		strbuf_release(&buf);
> +		die_errno(_("Could not write to %s."), git_path(SEQ_TODO_FILE));
> +	}
> +	if (commit_lock_file(&todo_lock) < 0) {
> +		strbuf_release(&buf);
> +		die(_("Error wrapping up %s"), git_path(SEQ_TODO_FILE));
> +	}
> +	strbuf_release(&buf);
> +}

Likewise here.  As mentioned before, git_path() clobbers errno, so the
above is likely to print a wrong error message on some systems (e.g.,
"fatal: Cannot write to .git/sequencer/todo: Success").

> +
> +static int pick_commits(struct replay_opts *opts)
> +{
> +	struct commit_list *todo_list = NULL;
> +	unsigned char sha1[20];
> +	struct commit_list *cur;
> +	int res;
>  
>  	setenv(GIT_REFLOG_ACTION, me, 0);
>  	if (opts->allow_ff)
> @@ -580,14 +764,24 @@ static int pick_commits(struct replay_opts *opts)
>  				opts->record_origin || opts->edit));
>  	read_and_refresh_cache(me, opts);
>  
> -	prepare_revs(&revs, opts);
> +	walk_revs_populate_todo(&todo_list, opts);
> +	create_seq_dir();
> +	if (!get_sha1("HEAD", sha1))
> +		save_head(sha1_to_hex(sha1));

What happens if the .git/sequencer dir already exists (e.g., we were
in the middle of a multiple-cherry-pick)?  What happens if I try to
cherry-pick onto an unborn branch, or get_sha1() fails for some other
reason?

Regards,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/176647/focus=176675
