From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/5] revert: Allow mixed pick and revert instructions
Date: Wed, 10 Aug 2011 10:15:27 -0500
Message-ID: <20110810151527.GC31315@elie.gateway.2wire.net>
References: <1312970151-18906-1-git-send-email-artagnon@gmail.com>
 <1312970151-18906-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 10 17:15:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrAVR-0006tI-HR
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 17:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751Ab1HJPPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Aug 2011 11:15:34 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56105 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab1HJPPd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2011 11:15:33 -0400
Received: by gya6 with SMTP id 6so714796gya.19
        for <git@vger.kernel.org>; Wed, 10 Aug 2011 08:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4TuClnJgBhZcXbw3XfebMrbfks6R+ycLDCdxuv/BhoQ=;
        b=faiIH65dzalI+AvInnBPMjBliyRX6qJRrBo2MDZ5WDagtW3i2nHBPFTs5c7w7O1r7u
         tNIaKt8lqfmy1zjza1mgw/uXiHYdIvoo2zb4syIGTOFKaMQzvLyILm0rF/IVuQBTf9ak
         3efaNqe1e9g0X+f3vMNAPO0ezMKLinvjtmguI=
Received: by 10.150.103.1 with SMTP id a1mr8703282ybc.244.1312989332951;
        Wed, 10 Aug 2011 08:15:32 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-69-68.dsl.chcgil.sbcglobal.net [69.209.69.68])
        by mx.google.com with ESMTPS id n21sm629273ybc.5.2011.08.10.08.15.30
        (version=SSLv3 cipher=OTHER);
        Wed, 10 Aug 2011 08:15:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1312970151-18906-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179068>

Ramkumar Ramachandra wrote:

> Change the way the instruction parser works, allowing arbitrary
> (action, operand) pairs to be parsed.  So now, you can do:
>
>   pick fdc0b12 picked
>   revert 965fed4 anotherpick
>
> For cherry-pick and revert, this means that a 'git cherry-pick
> --continue' can continue an ongoing revert operation and viceversa.

Nice. :)

> This patch lays the foundation for extending the parser to support
> more actions.

And why would I want to do that?  I think there's a missing "so git
rebase -i can reuse this machinery some day" at the end of the
sentence.

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -639,89 +639,84 @@ static void read_and_refresh_cache(struct replay_opts *opts)
>   *     assert(commit_list_count(list) == 2);
>   *     return list;
>   */
> -struct commit_list **commit_list_append(struct commit *commit,
> -					struct commit_list **next)
> +struct replay_insn_list **replay_insn_list_append(enum replay_action action,
> +						struct commit *operand,
> +						struct replay_insn_list **next)
>  {
> -	struct commit_list *new = xmalloc(sizeof(struct commit_list));
> +	struct replay_insn_list *new = xmalloc(sizeof(struct replay_insn_list));

Tip: we can save the readers some reading and prepare for future
renaming of the structure (not that that's something to fear) using
the idiom

	struct replay_insn_list *new = xmalloc(sizeof(*new));

[...]
> -static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
> -		struct replay_opts *opts)
> +static int format_todo(struct strbuf *buf, struct replay_insn_list *todo_list)
>  {
> -	struct commit_list *cur = NULL;
> +	struct replay_insn_list *cur = NULL;
>  	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
>  	const char *sha1_abbrev = NULL;
> -	const char *action_str = opts->action == REPLAY_REVERT ? "revert" : "pick";
> +	const char *action_str;

Might be clearer with narrower scope:

	struct replay_insn_list *cur;

	for (cur = todo_list; cur; cur = cur->next) {
		struct commit_message msg = COMMIT_MESSAGE_INIT;
		const char *sha1_abbrev, *action_str;

		sha1_abbrev = ...;
		action_str = ...;
		if (get_message(cur->operand, &msg))
			return error(...);
		strbuf_addf(buf, "%s %s %s\n", ...);
	}
	return 0;

By the way, shouldn't there a free_message() call to balance out the
get_message()?

[...]
> -static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
> +static int parse_insn_line(char *start, enum replay_action *action,
> +			struct commit **operand)

Hm, why not

 static int parse_insn_line(const char *start, struct replay_insn_list *item);

>  {
>  	unsigned char commit_sha1[20];
>  	char sha1_abbrev[40];
> -	enum replay_action action;
> -	int insn_len = 0;
> +	int keyword_len;

What is this renaming about?  Maybe "action_len" would work to clarify
that this is about the length of the action string at the start, not
the entire line.

By the way, what are the semantics of that variable?  It doesn't seem
to be used, so couldn't we just eliminate it?

>  	char *p, *q;
>  
>  	if (!prefixcmp(start, "pick ")) {
> -		action = REPLAY_PICK;
> -		insn_len = strlen("pick");
> -		p = start + insn_len + 1;
> +		*action = REPLAY_PICK;
> +		keyword_len = strlen("pick");
> +		p = start + keyword_len + 1;

In such a scenario, this would say

	if (!prefixcmp(start, "pick ")) {
		item->action = REPLAY_PICK;
		p += strlen("pick ");
	}

[...]
>  	} else
> -		return NULL;
> +		return -1;

Unrelated to this patch: maybe

 	return error("unrecognized action in sequencer file: %s", start);

to be easier to debug.

>  	q = strchr(p, ' ');
>  	if (!q)
> -		return NULL;
> +		return -1;

So we reject "pick a87c8989"?  That's a shame.

>  	q++;
>  
>  	strlcpy(sha1_abbrev, p, q - p);

memcpy would be clearer.  Can't this overflow the sha1_abbrev buffer?

[...]
>  	if (get_sha1(sha1_abbrev, commit_sha1) < 0)
> -		return NULL;
> +		return -1;

get_sha1 doesn't print a message, so maybe:

	return error("malformed object name in sequencer file: %s",
							sha1_abbrev);

> +
> +	*operand = lookup_commit_reference(commit_sha1);
> +	if (!*operand)
> +		return -1;

Perhaps something like

	return error("operand %s in sequencer file is not a commit",
							sha1_abbrev);

[...]
> @@ -797,18 +791,18 @@ static void read_populate_opts(struct replay_opts **opts_ptr)
>  		die(_("Malformed options sheet: %s"), opts_file);
>  }
>  
> -static void walk_revs_populate_todo(struct commit_list **todo_list,
> +static void walk_revs_populate_todo(struct replay_insn_list **todo_list,
>  				struct replay_opts *opts)
>  {
>  	struct rev_info revs;
> -	struct commit *commit;
> +	struct commit *operand;

Can avoid some churn by keeping the old name here.

> -	struct commit_list **next;
> +	struct replay_insn_list **next;
>  
>  	prepare_revs(&revs, opts);
>  
>  	next = todo_list;
> -	while ((commit = get_revision(&revs)))
> -		next = commit_list_append(commit, next);
> +	while ((operand = get_revision(&revs)))
> +		next = replay_insn_list_append(opts->action, operand, next);
[...]
> @@ -901,8 +896,9 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
>  	read_and_refresh_cache(opts);
>  
>  	for (cur = todo_list; cur; cur = cur->next) {
> -		save_todo(cur, opts);
> -		res = do_pick_commit(cur->item, opts);
> +		save_todo(cur);
> +		opts->action = cur->action;
> +		res = do_pick_commit(cur->operand, opts);

If do_pick_commit took an "action" operand, this would be less
scary. :)

[...]
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -211,4 +211,62 @@ test_expect_success 'malformed instruction sheet 2' '
>  	test_must_fail git cherry-pick --continue
>  '
>  
> +test_expect_success 'revert --continue continues after cherry-pick' '

I haven't looked at the tests yet.  FWIW, with whatever changes above
seem suitable,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
