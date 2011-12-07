From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] revert: allow mixed pick and revert instructions
Date: Wed, 7 Dec 2011 01:45:01 -0600
Message-ID: <20111207074501.GE11737@elie.hsd1.il.comcast.net>
References: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
 <1323239877-24101-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 08:45:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYCBy-000898-NZ
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 08:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815Ab1LGHpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 02:45:11 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59066 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219Ab1LGHpI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 02:45:08 -0500
Received: by yenm1 with SMTP id m1so235614yen.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 23:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qWfTxwAxyGHxrL5hVUu3BWrp+XRW27CgMUK9fxMrWbc=;
        b=PkNHmWnxujCYIHyHb/BQ96lWaKnb3X6o4oIGGgQefte0XF7lCHlSB7ZKsn1fPFfWio
         9e81Ytd0UufglFprHVg7uYZQsW5PddBBjZhEMXiea23nl7rmgeYAlWdwbLniZQTOPAj0
         WkQ1wCws+BJ6v9SMw+Og8IpGV3Zlnn+yUZw+U=
Received: by 10.236.181.164 with SMTP id l24mr25809915yhm.22.1323243907244;
        Tue, 06 Dec 2011 23:45:07 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 9sm2838271any.3.2011.12.06.23.45.05
        (version=SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 23:45:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323239877-24101-5-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186437>

Ramkumar Ramachandra wrote:

> Parse the instruction sheet in '.git/sequencer/todo' as a list of
> (action, operand) pairs, instead of assuming that all instructions use
> the same action.  Now you can do:
>
>   pick fdc0b12 picked
>   revert 965fed4 anotherpick
>
> For cherry-pick and revert, this means that a 'git cherry-pick
> --continue' can continue an ongoing revert operation and viceversa.

Good idea.

> This patch lays the foundation for extending the parser to support
> more actions so 'git rebase -i' can reuse this machinery in the
> future.  While at it, also improve the error messages reported by the
> insn sheet parser.

I don't know what this part is about...

[...]
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -39,7 +39,6 @@ static const char * const cherry_pick_usage[] = {
>  	NULL
>  };
>  
> -enum replay_action { REVERT, CHERRY_PICK };

Removing the enum, to expose it in sequencer.h.  What does this have
to do with the stated goal of the patch?

>  enum replay_subcommand {
>  	REPLAY_NONE,
>  	REPLAY_REMOVE_STATE,
> @@ -73,14 +72,14 @@ struct replay_opts {
>  
>  static const char *action_name(const struct replay_opts *opts)
>  {
> -	return opts->action == REVERT ? "revert" : "cherry-pick";
> +	return opts->action == REPLAY_REVERT ? "revert" : "cherry-pick";
[... lots of similar changes snipped ...]
> @@ -467,7 +466,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts)
>  	return run_command_v_opt(args, RUN_GIT_CMD);
>  }
>  
> -static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
> +static int do_pick_commit(struct commit *commit, enum replay_action action,
> +			struct replay_opts *opts)

Ok, now we're at the title feature.

Passing "action" as a separate parameter in addition to "opts" makes
sense since it can vary from item to item on the todo list.  It
unfortunately makes reviewers' lives hard since it is easy to miss
additional unconverted uses of opts->action in the function and
compilers will not warn about that.

[...]
>		if (index_differs_from("HEAD", 0))
>			return error_dirty_index(opts);
[...]
>	if (parent && parse_commit(parent) < 0)
>		/* TRANSLATORS: The first %s will be "revert" or
>		   "cherry-pick", the second %s a SHA1 */
>		return error(_("%s: cannot parse parent commit %s"),
>			action_name(opts), sha1_to_hex(parent->object.sha1));
[...]
>		res = do_recursive_merge(base, next, base_label, next_label,
>					 head, &msgbuf, opts);

Makes sense.  This is the command name passed on the command line, not
the action name from the todo list, so it is left alone.

[...]
> @@ -607,13 +607,13 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
[...]
> -		error(opts->action == REVERT
> +		error(action == REPLAY_REVERT
>  		      ? _("could not revert %s... %s")
>  		      : _("could not apply %s... %s"),

... and that's the last use of "action" in this function on the
current master branch.  Good.

[... more distracting s/REVERT/REPLAY_REVERT/ stuff snipped...]
> @@ -683,49 +683,55 @@ static void read_and_refresh_cache(struct replay_opts *opts)
[...]
> -static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
> -		struct replay_opts *opts)
> +static int format_todo(struct strbuf *buf, struct replay_insn_list *todo_list)

Looks good.

[...]
> -static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *opts)
> +static int parse_insn_line(char *bol, char *eol,
> +			struct replay_insn_list *item, int lineno)
[...]
> -	} else
> -		return NULL;
> +	} else {
> +		size_t len = strchrnul(bol, '\n') - bol;
> +		if (len > 255)
> +			len = 255;
> +		return error(_("Line %d: Unrecognized action: %.*s"),
> +			lineno, (int)len, bol);
> +	}

A new error message when an insn line does not start with "pick" or
"revert".  Looks like a good change, but what does it have to do with
the subject of the patch?

[...]
> @@ -733,37 +739,29 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
[...]
>  	status = get_sha1(bol, commit_sha1);
>  	*end_of_object_name = saved;
[...]
>  	if (status < 0)
> -		return NULL;
> +		return error(_("Line %d: Malformed object name: %s"), lineno, bol);

(Not about this patch, but an earlier one)  What is this idiom about?
Why not

	if (get_sha1(bol, commit_sha1))
		return error(_(...));

?

[...]
> -static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
> -			struct replay_opts *opts)
> +static int parse_insn_buffer(char *buf, struct replay_insn_list **todo_list)

Nice to see.

>  {
> -	struct commit_list **next = todo_list;
> -	struct commit *commit;
> +	struct replay_insn_list **next = todo_list;
> +	struct replay_insn_list item = {0, NULL, NULL};

Style: elsewhere in this file, initializers look like "{ 0, NULL, NULL }"
(with space between the braces and values).

[...]
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -356,4 +356,62 @@ test_expect_success 'commit descriptions in insn sheet are optional' '

Thanks for writing these.

>  	test_line_count = 4 commits
>  '
>  
> +test_expect_success 'revert --continue continues after cherry-pick' '
> +	pristine_detach initial &&
> +	test_must_fail git cherry-pick base..anotherpick &&

Stops in "picked", asking user to resolve conflicts.

> +	echo "c" >foo &&
> +	git add foo &&
> +	git commit &&

User resolves conflicts, as in the previous test.

> +	git revert --continue &&

And asks to continue.

> +	test_path_is_missing .git/sequencer &&
> +	{
> +		git rev-list HEAD |
> +		git diff-tree --root --stdin |
> +		sed "s/$_x40/OBJID/g"
> +	} >actual &&
> +	cat >expect <<-\EOF &&
> +	OBJID
> +	:100644 100644 OBJID OBJID M	foo
> +	OBJID
> +	:100644 100644 OBJID OBJID M	foo
> +	OBJID
> +	:100644 100644 OBJID OBJID M	unrelated
> +	OBJID
> +	:000000 100644 OBJID OBJID A	foo
> +	:000000 100644 OBJID OBJID A	unrelated
> +	EOF
> +	test_cmp expect actual

I wonder if there is some simpler way to check the result of resuming
a cherry-pick sequence, though that doesn't have much to do with the
patch.  I guess I'd find

	echo d >expect &&
	... &&
	# index is clean
	git update-index --refresh &&
	git rev-list HEAD >commits &&
	test_line_count = 4 commits &&
	test_cmp expect foo &&
	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD

a more convincing demonstration that the cherry-pick finished without
incident.

> +'
> +
> +test_expect_success 'mixed pick and revert instructions' '
> +	pristine_detach initial &&
> +	test_must_fail git cherry-pick base..anotherpick &&
> +	echo "c" >foo &&
> +	git add foo &&
> +	git commit &&

Same setup.

> +	oldsha=`git rev-parse --short HEAD~1` &&
> +	echo "revert $oldsha unrelatedpick" >>.git/sequencer/todo &&

Adding to the insn sheet.  Makes sense.

Summing up: I quite like the idea of this patch, but I would be a lot
happier if changes unrelated to its goal were split off to be
considered separately.

> Acked-by: Jonathan Nieder <jrnider@gmail.com>

No, not acked.

Thanks,
Jonathan
