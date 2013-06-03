From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/8] sequencer: run post-rewrite hook
Date: Mon, 03 Jun 2013 11:57:21 -0700
Message-ID: <7vhahfdnu6.fsf@alter.siamese.dyndns.org>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
	<1369799788-24803-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 20:57:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjZwl-0004BD-9J
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 20:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989Ab3FCS5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 14:57:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53862 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239Ab3FCS5a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 14:57:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6A2E24692;
	Mon,  3 Jun 2013 18:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rXPguwecqqtwBrJ2hMAY79IoWhA=; b=vMAPNV
	BGgIVMbibyZYuJnNMGMxcmIdJCjX2spKbvF7iay0MLpBRAyogM0sKtu/kzO/1jID
	ATsMjylTUQ5lta8BBZek+OlE6c3N+x3yDB98rALkc9TRsix2PE6ICzelnaf4QQv9
	v43mQ8rYS92y1gZz5RPwnUIoNxihGdy4muc8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oSbMUDKDRbwq86jdW3UT1GWX4WGyHgeT
	xDebXWAerIiVjlNT7355vXaXo5NNOY3o12wH0RX/bvpx+hUsWh2y9Wo3Jd/A/VaR
	QhVNqDqqmzCcZ26IjSL/Mi8g8DEnD3SJs0Hdrh5JFrEJ1ZOThyfdNeeN6+riiXLs
	r+ZQWOnSmE0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA7B424691;
	Mon,  3 Jun 2013 18:57:29 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E18922466C;
	Mon,  3 Jun 2013 18:57:22 +0000 (UTC)
In-Reply-To: <1369799788-24803-6-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 28 May 2013 22:56:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C97F88C-CC7F-11E2-9D62-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226263>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> As we should.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  sequencer.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index c217716..3aa480e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -127,6 +127,37 @@ static void add_rewritten(unsigned char *from, unsigned char *to)
>  	rewritten.nr++;
>  }
>  
> +static void run_rewrite_hook(void)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	struct child_process proc;
> +	const char *argv[3];
> +	int code, i;
> +
> +	argv[0] = find_hook("post-rewrite");
> +	if (!argv[0])
> +		return;
> +
> +	argv[1] = "rebase";
> +	argv[2] = NULL;

When the end-user action is "git cherry-pick A..B", shouldn't
the rewrite hook be called with "cherry-pick" not "rebase" as its
first argument?

More importantly, doesn't "git revert A..B" also trigger the
codepath for [4/8] and hence this function?

I think [3/8] --skip-empty makes sense also for revert, but I do not
think this one does as-is.  As what [4/8] introduces is a record of
"rewrite", the patch does not make sense either.  These two steps
would want to limit themselves to cherry-pick only, no?

> +	memset(&proc, 0, sizeof(proc));
> +	proc.argv = argv;
> +	proc.in = -1;
> +	proc.stdout_to_stderr = 1;
> +
> +	code = start_command(&proc);
> +	if (code)
> +		return;
> +	for (i = 0; i < rewritten.nr; i++) {
> +		struct rewritten_list_item *item = &rewritten.items[i];
> +		strbuf_addf(&buf, "%s %s\n", sha1_to_hex(item->from), sha1_to_hex(item->to));
> +	}
> +	write_in_full(proc.in, buf.buf, buf.len);
> +	close(proc.in);
> +	finish_command(&proc);
> +}
> +
>  static void remove_sequencer_state(void)
>  {
>  	struct strbuf seq_dir = STRBUF_INIT;
> @@ -1099,6 +1130,8 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
>  		}
>  	}
>  
> +	run_rewrite_hook();
> +
>  	/*
>  	 * Sequence of picks finished successfully; cleanup by
>  	 * removing the .git/sequencer directory
> @@ -1136,14 +1169,24 @@ static int sequencer_continue(struct replay_opts *opts)
>  	}
>  	if (index_differs_from("HEAD", 0))
>  		return error_dirty_index(opts);
> +	{
> +		unsigned char to[20];
> +		if (!read_ref("HEAD", to))
> +			add_rewritten(todo_list->item->object.sha1, to);
> +	}
>  	todo_list = todo_list->next;
>  	return pick_commits(todo_list, opts);
>  }
>  
>  static int single_pick(struct commit *cmit, struct replay_opts *opts)
>  {
> +	int ret;
>  	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
> -	return do_pick_commit(cmit, opts);
> +	ret = do_pick_commit(cmit, opts);
> +	if (ret)
> +		return ret;
> +	run_rewrite_hook();
> +	return 0;
>  }
>  
>  int sequencer_pick_revisions(struct replay_opts *opts)
