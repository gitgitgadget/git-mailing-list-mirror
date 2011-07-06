From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/14] revert: Introduce a layer of indirection over
 pick_commits
Date: Wed, 06 Jul 2011 14:00:24 -0700
Message-ID: <7vd3hnktuf.fsf@alter.siamese.dyndns.org>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-12-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 23:00:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeZCz-0000eh-1n
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 23:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756173Ab1GFVA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 17:00:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58106 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094Ab1GFVA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 17:00:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 447D567F8;
	Wed,  6 Jul 2011 17:00:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z7mbgoKkQxXNajPW37OgBIIFgEc=; b=WQw4Px
	FScNi+u/NczCyO8vT92+RanjAnod7xrTKpTRH+aKqnqkq2UxrWkXb2WvslYhl118
	mvRjfl/BCvzhDlBPcmX479a+3BBgih878/mC1GOBe2+7/qSNutpM1W1f2skcV6a7
	yb9jRdXvXDyp8gVQYVgq/KReU9vpZgqsKIsI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jv/UiGQJ26vtldsUiX3+uCHRQys9j4zg
	Ydas6+Fd9qwbic20qBdkznZquVn0tHaOkWqeE0Y7mob+5woBNiMF2OVZ9++leAqZ
	GJnECWc2qWurSxrpOp/Xxzb85f8VRk0R749nlVQ2l62gK5leL1ThN7tFa3p/8RRt
	f8aOife4Lx8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3CBE567F6;
	Wed,  6 Jul 2011 17:00:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8490767F5; Wed,  6 Jul 2011
 17:00:25 -0400 (EDT)
In-Reply-To: <1309938868-2028-12-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Wed, 6 Jul 2011 07:54:25 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F8A47294-A812-11E0-878B-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176729>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Write a new function called process_continuation to prepare a
> todo_list to call pick_commits with; the job of pick_commits is
> simplified into performing the tasks listed in todo_list.  This will
> be useful when continuation functionality like "--continue" is
> introduced later in the series.
>
> Helped-by: Jonathan Nieder <jrnider@gmail.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  builtin/revert.c |   36 +++++++++++++++++++++++++-----------
>  1 files changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 7d76f92..8cdcdb6 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -677,10 +677,8 @@ static int cleanup_sequencer_data(void)
>  	return 0;
>  }
>  
> -static int pick_commits(struct replay_opts *opts)
> +static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
>  {
> -	struct commit_list *todo_list = NULL;
> -	unsigned char sha1[20];
>  	struct commit_list *cur;
>  	int res;
>  
> @@ -690,12 +688,6 @@ static int pick_commits(struct replay_opts *opts)
>  				opts->record_origin || opts->edit));
>  	read_and_refresh_cache(me, opts);
>  
> -	walk_revs_populate_todo(&todo_list, opts);
> -	create_seq_dir();
> -	if (!get_sha1("HEAD", sha1))
> -		save_head(sha1_to_hex(sha1));
> -	save_todo(todo_list, opts);
> -
>  	for (cur = todo_list; cur; cur = cur->next) {
>  		save_todo(cur, opts);
>  		res = do_pick_commit(cur->item, opts);
> @@ -710,6 +702,22 @@ static int pick_commits(struct replay_opts *opts)
>  	return cleanup_sequencer_data();
>  }
>  
> +static int process_continuation(struct replay_opts *opts)
> +{
> +	struct commit_list *todo_list = NULL;
> +	unsigned char sha1[20];
> +
> +	read_and_refresh_cache(me, opts);
> +
> +	walk_revs_populate_todo(&todo_list, opts);
> +	create_seq_dir();
> +	if (!get_sha1("HEAD", sha1))
> +		persist_head(sha1_to_hex(sha1));
> +	persist_todo(todo_list, opts);

Don't these two need forward declarations before their use?
