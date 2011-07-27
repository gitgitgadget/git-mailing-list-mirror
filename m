From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 11/18] revert: Save data for continuing after conflict
 resolution
Date: Wed, 27 Jul 2011 07:02:20 +0200
Message-ID: <20110727050220.GG18470@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-12-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 07:02:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlwGT-0003Nj-Cw
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 07:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653Ab1G0FCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 01:02:33 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51378 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab1G0FCb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 01:02:31 -0400
Received: by ewy4 with SMTP id 4so1037546ewy.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 22:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7MJ883ibg4TUTZVNe9yb1IIr7fSrHVNmztcgUmJqt4Q=;
        b=FYsY+qKyGeaJRVL/ebTmWuEJY0jaBkZap26ADhMoWds3PptIsdlHlYvO51sros7pKz
         iNRsKBXXpqEh6gKvMv5Gl5zdrAPkFG/eKWnwlH9JA57gEmEYHpZW/V/YVv+f+lDn4bK+
         geJRiTkU3Y5xvwdtZNHBzQ3NUjVscpJXA+wck=
Received: by 10.14.97.75 with SMTP id s51mr2673021eef.131.1311742950479;
        Tue, 26 Jul 2011 22:02:30 -0700 (PDT)
Received: from elie (adsl-165-157-240.teol.net [109.165.157.240])
        by mx.google.com with ESMTPS id t1sm827727eeb.6.2011.07.26.22.02.27
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 22:02:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311736755-24205-12-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177929>

Ramkumar Ramachandra wrote:

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
[...]
> @@ -269,7 +275,7 @@ static void write_message(struct strbuf *msgbuf, const char *filename)
>  		die_errno(_("Could not write to %s."), filename);
>  	strbuf_release(msgbuf);
>  	if (commit_lock_file(&msg_file) < 0)
> -		die(_("Error wrapping up %s"), filename);
> +		die(_("Error wrapping up %s."), filename);
>  }
>  
>  static struct tree *empty_tree(void)

Snuck in to the wrong patch, I guess?

[...]
> @@ -582,10 +588,199 @@ static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
[...]
> +	if (!prefixcmp(start, "pick ")) {
> +		action = CHERRY_PICK;
> +		insn_len = strlen("pick");
> +		p = start + insn_len + 1;
> +	}
> +	else if (!prefixcmp(start, "revert ")) {
> +		action = REVERT;
> +		insn_len = strlen("revert");
> +		p = start + insn_len + 1;
> +	}
> +	else
> +		return NULL;
> +

Style: git uses "cuddled braces".

	if (...) {
		...
	} else if (...) {
		...
	} ...

[...]
> +	if ((get_sha1(sha1_abbrev, commit_sha1) < 0)
> +		|| !(commit = lookup_commit_reference(commit_sha1)))
> +		return NULL;
> +
> +	return commit;

Would be clearer to write:

	if (get_sha1(...))
		return NULL;

	return lookup_commit_reference(...);

[...]
> @@ -59,6 +60,11 @@ struct replay_opts {
>  };
>  
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
> +#define MAYBE_UNUSED __attribute__((__unused__))
[...]
> +}
> +
> +static void MAYBE_UNUSED read_populate_todo(struct commit_list **todo_list,
> +					struct replay_opts *opts)

This MAYBE_UNUSED with no conditional involved feels ugly.  Why is it
needed?  Why not define read_populate_todo in the patch that first
uses it, or barring that, tolerate a warning in this step within the
patch series?

[...]
> +		if (!(commit = parse_insn_line(p, opts)))
> +			goto error;

See Documentation/CodingGuidelines: "We try to avoid assignments
inside if()".

> +static void walk_revs_populate_todo(struct commit_list **todo_list,
> +				struct replay_opts *opts)
>  {
>  	struct rev_info revs;
>  	struct commit *commit;
> +	struct commit_list **next;
> +
> +	prepare_revs(&revs, opts);
> +
> +	next = todo_list;
> +	while ((commit = get_revision(&revs)))
> +		next = commit_list_append(commit, next);
> +}
> +
> +static void create_seq_dir(void)
> +{
> +	const char *seq_dir = git_path(SEQ_DIR);
> +
> +	if (!file_exists(seq_dir) && mkdir(seq_dir, 0777) < 0)
> +		die_errno(_("Could not create sequencer directory '%s'."), seq_dir);

What happens if seq_dir exists and is a file?

[...]
> @@ -593,14 +788,29 @@ static int pick_commits(struct replay_opts *opts)
[...]
> +	if (get_sha1("HEAD", sha1)) {
> +		if (opts->action == REVERT)
> +			return error(_("Can't revert as initial commit"));
> +		return error(_("Can't cherry-pick into empty head"));
> +	} else
> +		save_head(sha1_to_hex(sha1));

Clearer without the "else":

	if (get_sha1(...)) {
		...
		return error(...);
	}
	save_head(sha1);

> +	save_todo(todo_list, opts);
> +
> +	for (cur = todo_list; cur; cur = cur->next) {
> +		save_todo(cur, opts);
> +		res = do_pick_commit(cur->item, opts);
>  		if (res)
>  			return res;
>  	}

Isn't the save_todo() before the "for" loop redundant?
>  
> +	/*
> +	 * Sequence of picks finished successfully; cleanup by
> +	 * removing the .git/sequencer directory
> +	 */
> +	strbuf_addf(&buf, "%s", git_path(SEQ_DIR));
> +	remove_dir_recursively(&buf, 0);

What is the content of "buf" before?  If it's supposed to be empty,
I'd suggest using "strbuf_reset" to make sure that remains so for
the reader's peace of mind.

Ciao,
Jonathan
