From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/13] revert: Persist data for continuation
Date: Tue, 21 Jun 2011 12:49:25 -0700
Message-ID: <7v39j37ynu.fsf@alter.siamese.dyndns.org>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-11-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 21:49:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ6x8-0004vB-Pc
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 21:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757196Ab1FUTtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 15:49:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396Ab1FUTta (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 15:49:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 31C524B03;
	Tue, 21 Jun 2011 15:51:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OToWnWrshXLiWRcn5ealOnBYdkA=; b=N+rKpr
	mz+HlqBAGWv3WZ1gMwJ5INIr2V+HQ0PzHeDqkK9dFfMj/dtz4oQnLs2b6Yf47Inj
	TLUBQSRTJMqcv58H2BAoPWAb75IvkTUypV8wg6w8tKyQBP2h7SP7EyYfA5i+I/WH
	SlpvoG6xr34vRmhubylnqtF5uDea9XcgD6p8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xeXC+f6bTfZP5M04kYn5kKa8I2q2tHJU
	3bM02WbnPgmP6UVQkZqJHBIkobKOvTGoJAfDtBRzpiyBO117NlUsn1bfpN0VScvi
	ceZwg9XWj/hUnQ6WgNpc/MKpMfGmf9NZUE4ZkXr5jn/0mPXJYXtyN0BO9TkXjaor
	hP7O/Zf83Ao=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9F65E4B02;
	Tue, 21 Jun 2011 15:51:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5ED4B4B01; Tue, 21 Jun 2011
 15:51:39 -0400 (EDT)
In-Reply-To: <1308661489-20080-11-git-send-email-artagnon@gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 21 Jun 2011 13:04:46 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E1113506-9C3F-11E0-9316-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176190>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> ...  Don't touch
> CHERRY_PICK_HEAD -- it will still be useful when a conflict is
> encountered.

What does "Don't touch" here mean? Keep doing the same thing as before so
that people can rely on it? Or stop touching it? I presume the former, but
the description is suboptimal.

> @@ -25,6 +26,10 @@
>   * Copyright (c) 2005 Junio C Hamano
>   */
>  
> +#define SEQ_DIR		git_path("sequencer")
> +#define HEAD_FILE	git_path("sequencer/head")
> +#define TODO_FILE	git_path("sequencer/todo")

HEAD is to keep track of the original, or does it get updated during a
sequencer run?

> +static void walk_revs_populate_todo(struct commit_list **todo_list,
> +				struct replay_opts *opts)
>  {
>  	struct rev_info revs;
>  	struct commit *commit;
> +	struct commit_list *new_item;
> +	struct commit_list *cur = NULL;
> +
> +	/* Insert into todo_list in the same order */
> +	prepare_revs(&revs, opts);
> +	while ((commit = get_revision(&revs))) {
> +		new_item = xmalloc(sizeof(struct commit_list));
> +		new_item->item = commit;
> +		if (cur)
> +			cur->next = new_item;
> +		else
> +			*todo_list = new_item;
> +		cur = new_item;
> +	}
> +	cur->next = NULL;
> +}

Yuck; you do not want if/else to do this (I am _not_ saying "you can do
that but here is a better way"). Have a variable that points at a pointer
of type "struct commit_list *", initialize it to where todo_list points
at, and then update to point at the next field of the new object.

Something like this:

	next = todo_list;
	while ((commit = ...) != NULL) {
		new = xcalloc(1, sizeof(struct commit_list));
                new->item = commit;
                *next = new;
                next = &new->next;
	}
	*next = NULL;

Doing it this way would avoid a segfault when get_revision() returned
nothing as an added bonus ;-).

> +static void persist_head(const char *head)

s/persist/save/ perhaps?

> +{
> +	static struct lock_file head_lock;
> +	struct strbuf buf = STRBUF_INIT;
> +	int fd;
> +

> +	if (file_exists(SEQ_DIR)) {
> +		if (!is_directory(SEQ_DIR) && remove_path(SEQ_DIR) < 0) {
> +			strbuf_release(&buf);
> +			die(_("Could not remove %s"), SEQ_DIR);
> +		}
> +	} else {
> +		if (mkdir(SEQ_DIR, 0777) < 0) {
> +			strbuf_release(&buf);
> +			die_errno(_("Could not create sequencer directory '%s'."), SEQ_DIR);
> +		}
> +	}

Split this part into a separate helper.

> +	fd = hold_lock_file_for_update(&head_lock, HEAD_FILE, LOCK_DIE_ON_ERROR);
> +	strbuf_addf(&buf, "%s\n", head);
> +	if (write_in_full(fd, buf.buf, buf.len) < 0)
> +		die_errno(_("Could not write to %s."), HEAD_FILE);
> +	if (commit_lock_file(&head_lock) < 0)
> +		die(_("Error wrapping up %s"), HEAD_FILE);
> +}

Is it sufficient to write the object name of the commit HEAD points at?
Would it be useful to also record the branch if the HEAD points at one?

> +static void persist_todo(struct commit_list *todo_list, struct replay_opts *opts)

s/persist/save/ perhaps?

> +{
> +	static struct lock_file todo_lock;
> +	struct strbuf buf = STRBUF_INIT;
> +	int fd;
> +	fd = hold_lock_file_for_update(&todo_lock, TODO_FILE, LOCK_DIE_ON_ERROR);

The current set of callers might always save head and then todo, but it
probably is a good idea to lift that restriction (which is why I suggested
to separate the initialization of seq-dir into a separate helper).

> +static int pick_commits(struct replay_opts *opts)
> +{
> +	struct commit_list *todo_list = NULL;
> +	unsigned char sha1[20];
> +	struct commit_list *cur;
> +	int res;
>  
> -	setenv(GIT_REFLOG_ACTION, me, 0);
>  	read_and_refresh_cache(me, opts);
> +	setenv(GIT_REFLOG_ACTION, me, 0);

Why?

> -	prepare_revs(&revs, opts);
> +	walk_revs_populate_todo(&todo_list, opts);
> +	if (!get_sha1("HEAD", sha1))
> +		persist_head(sha1_to_hex(sha1));
> +	persist_todo(todo_list, opts);
>  
> -	while ((commit = get_revision(&revs))) {
> -		int res = do_pick_commit(commit, opts);
> +	for (cur = todo_list; cur; cur = cur->next) {
> +		persist_todo(cur, opts);
> +		res = do_pick_commit(cur->item, opts);
>  		if (res)
>  			return res;
>  	}
>  
> -	return 0;
> +	/* Sequence of picks finished successfully; cleanup by
> +	   removing the .git/sequencer directory */

Just a style nit.

        /*
         * We write our multi-line comments
         * this way.
         */

> +	return cleanup_sequencer_data();
>  }
