From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/6] revert: Allow mixed pick and revert instructions
Date: Thu, 11 Aug 2011 15:12:45 -0500
Message-ID: <20110811201245.GH2277@elie.gateway.2wire.net>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
 <1313088705-32222-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 22:12:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qrbcc-00027T-Uu
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 22:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531Ab1HKUMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 16:12:50 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40725 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518Ab1HKUMt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 16:12:49 -0400
Received: by gya6 with SMTP id 6so1563394gya.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ND16eVgMe1wv2ptbmaH4kE7i0YVDl2ztHEcPsRLl8ao=;
        b=hRPMV2wIQtBtG4vNTH1P7K9TWjFggNSme6yNeU5L8h2wYzV2/Nh8js/zyIL42wocer
         niGDI/T8yBJWmu2K8llKAHW0VlHYoUULmuEtSyB4HZ8txUlMT47mnPlA8L2QeRPVUlIJ
         FKgmwxnECkgvWL3Gx4bKAtWlbW7MgE5ehUzwk=
Received: by 10.236.180.1 with SMTP id i1mr190734yhm.133.1313093568964;
        Thu, 11 Aug 2011 13:12:48 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-69-68.dsl.chcgil.ameritech.net [69.209.69.68])
        by mx.google.com with ESMTPS id q25sm2562153yhm.6.2011.08.11.13.12.47
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 13:12:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313088705-32222-5-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179140>

Ramkumar Ramachandra wrote:

> Change the way the instruction parser works, allowing arbitrary
> (action, operand) pairs to be parsed.

The first part of this sentence is not very satisfying.  Maybe it
means something like

	Parse the instruction list in .git/sequencer/todo as a list
	of (action, operand) pairs, instead of assuming all instructions
	use the same action.

[...]
> This patch lays the foundation for extending the parser to support
> more actions so 'git rebase -i' can reuse this machinery in the
> future.

Exciting stuff. :)

[...]
> +++ b/builtin/revert.c
[...]
> @@ -457,7 +456,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts)
>  	return run_command_v_opt(args, RUN_GIT_CMD);
>  }
>  
> -static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
> +static int do_pick_commit(struct commit *commit, enum replay_action action,
> +			struct replay_opts *opts)
[...]
> @@ -517,7 +517,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>  		/* TRANSLATORS: The first %s will be "revert" or
>  		   "cherry-pick", the second %s a SHA1 */
>  		return error(_("%s: cannot parse parent commit %s"),
> -			action_name(opts), sha1_to_hex(parent->object.sha1));
> +			action == REPLAY_REVERT ? "revert" : "cherry-pick",
> +			sha1_to_hex(parent->object.sha1));

My first thought was "why stop using the helper function action_name"?
But now I see that it previously came from "opts" (i.e., the command
line) and now comes from the todo file.

The command name there was never really important except when
cherry-pick or revert is being called by a script, and the message
indicates which command was having trouble parsing the commit.  If I
am using "git cherry-pick --continue" to continue after a failed
revert, I suspect action_name(opts) ["cherry-pick: "] would actually be
more sensible than the command name corresponding to the particular
pick/revert line.

[...]
> -		return NULL;
> +		return error(_("Unrecognized action: %s"), start);

Probably should be mentioned in the commit message.  Doesn't this
print the problematic line and all lines after it?

Maybe something like

	len = strchrnul(p, '\n') - p;
	if (len > 255)
		len = 255;
	return error(_("Unrecognized action: %.*s"), (int) len, p);

would do.

[...]
> -static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
> -			struct replay_opts *opts)
> +static int parse_insn_buffer(char *buf, struct replay_insn_list **todo_list)
>  {
> -	struct commit_list **next = todo_list;
> -	struct commit *commit;
> +	struct replay_insn_list **next = todo_list;
> +	struct replay_insn_list item = {0, NULL, NULL};
>  	char *p = buf;
>  	int i;
>  
>  	for (i = 1; *p; i++) {
> -		commit = parse_insn_line(p, opts);
> -		if (!commit)
> +		if (parse_insn_line(p, &item) < 0)
>  			return error(_("Could not parse line %d."), i);

Could we can make this error message more clearly suggest that it's
giving context to the error above it?  For example, something vaguely
like

	error: unrecognized action: reset c78a78c9 Going back
	error: on line 7
	fatal: unusable instruction sheet ".git/sequencer/todo"
	hint: to continue after fixing it, use "git cherry-pick --continue"
	hint: or to bail out, use "git cherry-pick --abort"

Does a "cherry-pick --continue" in this scenario skip the first commit
in the todo list?  Should it?

> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -240,4 +240,62 @@ test_expect_success 'missing commit descriptions in instruction sheet' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'revert --continue continues after cherry-pick' '

Haven't read the tests yet.  The general idea of this patch still
seems very sane.
