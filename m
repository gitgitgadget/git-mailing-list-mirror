From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/6] merge-recursive: Fix D/F conflicts
Date: Wed, 07 Jul 2010 14:40:24 -0700
Message-ID: <7v630rt1h3.fsf@alter.siamese.dyndns.org>
References: <1278480034-22939-1-git-send-email-newren@gmail.com>
 <1278480034-22939-4-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, agladysh@gmail.com
To: newren@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 07 23:45:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWcQW-0003sb-NH
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 23:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758028Ab0GGVoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 17:44:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50151 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757693Ab0GGVki (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 17:40:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F1DF3C2020;
	Wed,  7 Jul 2010 17:40:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=v5uR23WKv53J/LCGi6vz37F9d2o=; b=co4U8PsIzjCIo9XdU/e69BO
	FxCCZc9UMWbMKoGBNhzI+0QFOV4Mh2OEsodB0otul5dryKzoak5JuDrQBjpITdhl
	kM3J8iO+1+uiQCLUwJN9NrwSdCVFl4eiX/8kN47UGkqFhWCCYXHD0nO8DttgMf4+
	wAkHFHrv1SoPgENC9ILQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=WMK79P+sdhC551J0T7/+5w6v6l6UunDg72YtxAGnl8cUkmhSQ
	Oa3NoUiYp1kevq/SPhLA+qapnDAr3zrOJ+9q9KO6qyf/F9UkbG2rVqVt4D+zNCzX
	Q6PhX07NTqDWQJNvUtxH/egAYr0aZKyOVaCpBWAG0+h4+TWRhUTHJ+Nlr8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A5D36C201F;
	Wed,  7 Jul 2010 17:40:31 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 982C3C201B; Wed,  7 Jul
 2010 17:40:25 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 446D3160-8A10-11DF-B220-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150512>

newren@gmail.com writes:

> From: Elijah Newren <newren@gmail.com>
>
> The D/F conflicts that can be automatically resolved (file or directory
> unmodified on one side of history), have the nice property that
> process_entry() can correctly handle all subpaths of the D/F conflict.  In
> the case of D->F conversions, it will correctly delete all non-conflicting
> files below the relevant directory and the directory itself (note that both
> untracked and conflicting files below the directory will prevent its
> removal).  So if we handle D/F conflicts after all other conflicts, they
> become fairly simple to handle -- we just need to check for whether or not
> a path (file/directory) is in the way of creating the new content.  We do
> this by having process_entry() defer handling such entries to a subsequent
> process_df_entry() step.

The basic idea of this patch to process all removals first and then
process additions in a separate step feels very sound.  It is exactly the
same strategy that is used by "git apply" to avoid a similar issue of
applying a patch that removes "a/b" and creates "a" at the same time.

And it feels both correct and sufficient to have this additional logic
only in the "Added in one, but the path happens to be a directory on the
other branch" codepath.  The only case you will end up having to create D
(blob) where D used to be a directory (hence needing to make sure
everything under D/ is gone) is when you are the only one adding D (and
the other party is not adding nor modifying it---if it were, it means that
the other party also wants D as a blob and not a directory, and there
won't be D/F conflict in such a case).

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c               |   93 ++++++++++++++++++++++++++++++++-------
>  t/t6035-merge-dir-to-symlink.sh |    8 ++--
>  2 files changed, 81 insertions(+), 20 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 206c103..865729a 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1072,6 +1072,7 @@ static int process_entry(struct merge_options *o,
>  	unsigned char *a_sha = stage_sha(entry->stages[2].sha, a_mode);
>  	unsigned char *b_sha = stage_sha(entry->stages[3].sha, b_mode);
>  
> +	entry->processed = 1;

In the original code, process_renames() used to use this to signal the
loop that drives process_entry() that the stage data has been dealt with,
and this function was unaware of the flag.  Now it uses it to communicate
the same fact to its downstream (process_df_entry), which makes sense, but
somehow it made me feel a bit uneasy.

> @@ -1178,6 +1174,64 @@ static int process_entry(struct merge_options *o,
>  	return clean_merge;
>  }
>  
> +/* Per entry merge function for D/F conflicts, to be called only after
> + * all files below dir have been processed.  We do this because in the
> + * cases we can cleanly resolve D/F conflicts, process_entry() can clean
> + * out all the files below the directory for us.
> + */

/*
 * Please format large comment like
 * this.
 */

Style aside, what happens when we cannot cleanly resolve D/F conflicts,
i.e. when some untracked/modified paths still remain after the earlier
removal?  We would signal conflict but at that point what happens to the
files in the working tree that are involved in this new codepath?  They
are already gone, I presume, and they at least match the original index
entries, so not much is lost, but what would the recovery procedure out of
the resulting mess?  "reset --hard"?

> +static int process_df_entry(struct merge_options *o,
> +			 const char *path, struct stage_data *entry)
> +{
> +	int clean_merge = 1;
> +	unsigned o_mode = entry->stages[1].mode;
> +	unsigned a_mode = entry->stages[2].mode;
> +	unsigned b_mode = entry->stages[3].mode;
> +	unsigned char *o_sha = stage_sha(entry->stages[1].sha, o_mode);
> +	unsigned char *a_sha = stage_sha(entry->stages[2].sha, a_mode);
> +	unsigned char *b_sha = stage_sha(entry->stages[3].sha, b_mode);
> +
> +	/* We currently only handle D->F cases */
> +	assert((!o_sha && a_sha && !b_sha) ||
> +	       (!o_sha && !a_sha && b_sha));
> +	const char *add_branch;
> +	const char *other_branch;
> +	unsigned mode;
> +	const unsigned char *sha;
> +	const char *conf;

As an assert becomes code under debugging build, do not put one before
declarations like this.

Also "struct stat st" later in this file needs to be lifted up for the
same reason to avoid decl-after-statement.

Thanks.
