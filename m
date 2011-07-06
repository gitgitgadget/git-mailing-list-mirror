From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/14] revert: Persist data for continuation
Date: Wed, 6 Jul 2011 05:01:19 -0500
Message-ID: <20110706100119.GG15682@elie>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-11-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 12:01:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeOvC-0007ha-1h
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 12:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565Ab1GFKBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 06:01:25 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57253 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360Ab1GFKBY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 06:01:24 -0400
Received: by iyb12 with SMTP id 12so5951302iyb.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 03:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qK3yhyTYrnfbo9V8tu+snx/Xgxtq8bo9XMMummlgdVM=;
        b=j0Cl2DVDxCId1RuU8k1/WIw2M0aArG9kI3bzxe/vtBXv3b5v0YEX5soyegJwqTGLZd
         cKbvB+DZayg/sWW7saDg13JNtk1CjCOzdqltloxEZ+sBlJfOnAcYKaebWO+/oFppyrHQ
         1e2QVJGsd3lkx3Md0PP1iZB0sS/a1p57BneA8=
Received: by 10.231.18.9 with SMTP id u9mr7350725iba.141.1309946483797;
        Wed, 06 Jul 2011 03:01:23 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.sbcglobal.net [69.209.76.243])
        by mx.google.com with ESMTPS id my4sm4778929ibb.54.2011.07.06.03.01.21
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 03:01:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309938868-2028-11-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176675>

Ramkumar Ramachandra wrote:

> Ever since v1.7.2-rc1~4^2~7 (revert: allow cherry-picking more than
> one commit, 2010-06-02), a single invocation of "git cherry-pick" or
> "git revert" can perform picks of several individual commits.  To
> implement features like "--continue" to continue the whole operation,
> we will need to store some information about the state and the plan at
> the beginning.  Introduce a ".git/sequencer/head" file to store this
> state, and ".git/sequencer/todo" file to store the plan.

I think I remember Junio being curious about which commit is stored in
"head"; this might be a good place to put a reminder so future readers
don't have to be confused.

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
[...]
> @@ -25,6 +26,10 @@
>   * Copyright (c) 2005 Junio C Hamano
>   */
>  
> +#define SEQ_DIR		"sequencer"
> +#define SEQ_HEAD_FILE	"sequencer/head"
> +#define SEQ_TODO_FILE	"sequencer/todo"

Yay. :)

> @@ -417,7 +422,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>  			return error(_("Your index file is unmerged."));
>  	} else {
>  		if (get_sha1("HEAD", head))
> -			return error(_("You do not have a valid HEAD"));
> +			return error(_("Can't %s on an unborn branch"), me);

Remember that "me" is an untranslated command name, and see also
http://thread.gmane.org/gmane.comp.version-control.git/153026

Perhaps it would make sense to do something like

	if (get_sha1("HEAD", head)) {
		if (opts->action == REVERT)
			return error(_("can't revert as initial commit"));
		return error(_("cherry-pick into empty head not supported yet"));
	}

In a way they feel like different operations, anyway.  On the other
hand, there's no reason I can think of not to allow reverting a patch
that only removes files as the initial commit other than not having
implemented it.

> @@ -578,10 +583,106 @@ static void read_and_refresh_cache(const char *me, struct replay_opts *opts)
>  	rollback_lock_file(&index_lock);
>  }
>  
> -static int pick_commits(struct replay_opts *opts)
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

Maybe some word like "command", "insn", or "keyword" would be more
suggestive than "action".  It also might be worth mentioning somewhere
(in the commit message?) that this format is inspired by
rebase--interactive's insn sheet.

> +	}
> +}
> +
> +static void walk_revs_populate_todo(struct commit_list **todo_list,
> +				struct replay_opts *opts)
>  {
>  	struct rev_info revs;
>  	struct commit *commit;
> +	struct commit_list *new;
> +	struct commit_list **next;
> +
> +	prepare_revs(&revs, opts);
> +
> +	/* Insert into todo_list in the same order */
> +	/* NEEDSWORK: Expose this as commit_list_append */
> +	next = todo_list;
> +	while ((commit = get_revision(&revs))) {
> +		new = xmalloc(sizeof(struct commit_list));
> +		new->item = commit;
> +		*next = new;
> +		next = &new->next;
> +	}
> +	*next = NULL;

The operation that could be exposed does not include get_revision,
does it?

 /*
  * Example:
  *
  *	struct commit_list *list;
  *	struct commit_list **next = &list;
  *
  *	next = commit_list_append(c1, next);
  *	next = commit_list_append(c2, next);
  *	*next = NULL;
  *	assert(commit_list_count(list) == 2);
  *	return list;
  *
  * Don't forget to NULL-terminate!
  */
 struct commit_list **commit_list_append(struct commit *commit,
					struct commit_list **next)
 {
	struct commit_list *new = xmalloc(sizeof(*new_list));
	new->item = commit;
	*next = new;
	return &new->next;
 }


> +static void create_seq_dir(void)
> +{
> +	if (file_exists(git_path(SEQ_DIR))) {
> +		if (!is_directory(git_path(SEQ_DIR)) && remove_path(git_path(SEQ_DIR)) < 0)
> +			die(_("Could not remove %s"), git_path(SEQ_DIR));
> +	} else if (mkdir(git_path(SEQ_DIR), 0777) < 0)
> +		die_errno(_("Could not create sequencer directory '%s'."), git_path(SEQ_DIR));
> +}

A local variable to cache the git_path result would make this much
easier to read.

> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> new file mode 100644

Should "chmod +x" so the test can be run directly (I forget to do that
all the time).

[...]
> +test_expect_success 'cherry-pick cleans up sequencer directory upon success' '
> +	pristine_detach initial &&
> +	git cherry-pick initial..picked &&
> +	test_path_is_missing .git/sequencer
> +'

Thanks for thinking about these things.  Maybe another test
demonstrating that the .git/sequencer directory is left behind on
failure would help put this in context.
