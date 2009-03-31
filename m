From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Speed up reflog pruning of unreachable commits
Date: Tue, 31 Mar 2009 10:46:57 -0700
Message-ID: <7v63hp60vi.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0903310958000.4093@localhost.localdomain>
 <alpine.LFD.2.00.0903311003490.4093@localhost.localdomain>
 <alpine.LFD.2.00.0903311010050.4093@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 19:48:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Loi4k-0003qF-PL
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 19:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759992AbZCaRrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 13:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757895AbZCaRrH
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 13:47:07 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758700AbZCaRrG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 13:47:06 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 26A55A457;
	Tue, 31 Mar 2009 13:47:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5E47BA456; Tue,
 31 Mar 2009 13:46:59 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0903311010050.4093@localhost.localdomain>
 (Linus Torvalds's message of "Tue, 31 Mar 2009 10:11:56 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F0DA6006-1E1B-11DE-863F-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115292>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> From: Junio Hamano <gitster@pobox.com>
> Date: Mon, 30 Mar 2009 21:34:14 -0700
>
> Instead of doing the (potentially very expensive) "in_merge_base()"
> check for each commit that might be pruned if it is unreachable, do a
> preparatory reachability graph of the commit space, so that the common
> case of being reachable can be tested directly.
>
> [ Cleaned up a bit and tweaked to actually work.  - Linus ]
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  builtin-reflog.c |   43 +++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 43 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-reflog.c b/builtin-reflog.c
> index 0355ce6..f29ab2f 100644
> --- a/builtin-reflog.c
> +++ b/builtin-reflog.c
> @@ -52,6 +52,7 @@ struct collect_reflog_cb {
>  
>  #define INCOMPLETE	(1u<<10)
>  #define STUDYING	(1u<<11)
> +#define REACHABLE	(1u<<12)
>  
>  static int tree_is_complete(const unsigned char *sha1)
>  {
> @@ -209,6 +210,43 @@ static int keep_entry(struct commit **it, unsigned char *sha1)
>  	return 1;
>  }
>  
> +static void mark_reachable(struct commit *commit, unsigned long expire_limit)
> +{
> +	/*
> +	 * We need to compute if commit on either side of an reflog
> +	 * entry is reachable from the tip of the ref for all entries.
> +	 * Mark commits that are reachable from the tip down to the
> +	 * time threashold first; we know a commit marked thusly is
> +	 * reachable from the tip without running in_merge_bases()
> +	 * at all.
> +	 */
> +	struct commit_list *pending = NULL;
> +
> +	commit_list_insert(commit, &pending);
> +	while (pending) {
> +		struct commit_list *entry = pending;
> +		struct commit_list *parent;
> +		pending = entry->next;
> +		commit = entry->item;
> +		free(entry);
> +		if (commit->object.flags & REACHABLE)
> +			continue;
> +		if (parse_commit(commit))
> +			continue;
> +		commit->object.flags |= REACHABLE;
> +		if (commit->date < expire_limit)
> +			continue;
> +		parent = commit->parents;
> +		while (parent) {
> +			commit = parent->item;
> +			parent = parent->next;
> +			if (commit->object.flags & REACHABLE)
> +				continue;
> +			commit_list_insert(commit, &pending);
> +		}
> +	}
> +}
> +
>  static int unreachable(struct expire_reflog_cb *cb, struct commit *commit, unsigned char *sha1)
>  {
>  	/*
> @@ -227,6 +265,8 @@ static int unreachable(struct expire_reflog_cb *cb, struct commit *commit, unsig
>  	}
>  
>  	/* Reachable from the current reflog top? Don't prune */
> +	if (commit->object.flags & REACHABLE)
> +		return 0;
>  	if (in_merge_bases(commit, &cb->ref_commit, 1))
>  		return 0;
>  
> @@ -308,7 +348,10 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
>  	cb.ref_commit = lookup_commit_reference_gently(sha1, 1);
>  	cb.ref = ref;
>  	cb.cmd = cmd;
> +

You seem to have lost "if (cb.ref_commit)" from the last round to protect
mark_rechable().  It can be NULL.

> +	mark_reachable(cb.ref_commit, cmd->expire_total);
>  	for_each_reflog_ent(ref, expire_reflog_ent, &cb);
> +	clear_commit_marks(cb.ref_commit, REACHABLE);
>   finish:
>  	if (cb.newlog) {
>  		if (fclose(cb.newlog)) {
> -- 
> 1.6.2.1.404.gb0085.dirty
