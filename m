From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2010, #07; Fri, 22)
Date: Sat, 23 Jan 2010 12:03:07 -0800
Message-ID: <7v7hr8d1xg.fsf@alter.siamese.dyndns.org>
References: <7vtyudfqju.fsf@alter.siamese.dyndns.org> <4B5B25C6.70604@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 23 21:03:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYmCX-0003xY-WA
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 21:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657Ab0AWUDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 15:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085Ab0AWUDR
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 15:03:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38370 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab0AWUDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 15:03:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9860939C2;
	Sat, 23 Jan 2010 15:03:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dy2vOm8So9QgGRvNoKb55u88794=; b=Z1yMGc
	c8pEkidrMYtoZYAzodHdOfZ9z5FHrr03euCbOEATlWMbLtHjoZN09SgMAKUhaYl5
	zVGYI21QKMS/wUKnK3l3E7+MMqNTsj63jHZfLaHsFnoiN72B6UiwA1GxTnFO88q9
	ndim0dbNfh3fT7vorr7/Rb5wYG8GCpojShfFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nTyn9X/oVEEK6uXi3SMd04Px3kK751+I
	36Nybu9xtx9AshJxSM97efM9uJbMK5vqLRaT5SJk8HyKxNbj9lDNN4cw3+ij0fk2
	U/5D6xnJC+Wnr+D30bRDE0blSt+9/OhuZwuXhZSc6xiTLygVpIKDF0/cX7s3UrrZ
	dDHR6JItvsg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C77A4939BD;
	Sat, 23 Jan 2010 15:03:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05EBD939BB; Sat, 23 Jan
 2010 15:03:08 -0500 (EST)
In-Reply-To: <4B5B25C6.70604@web.de> (Jens Lehmann's message of "Sat\, 23 Jan
 2010 17\:37\:26 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 556F1984-085A-11DF-9B25-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137856>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> A patch that teaches "git diff --submodule" to display if the submodule
> contains new untracked and/or modified files is also almost ready.

How does "git submodule summary" show them?  If it doesn't, then I don't
think we would want to show them, either, as my understanding is that a
longer-term plan is to use "diff --submodule" in git-gui to replace it.

> Would
> you consider it for inclusion into 1.7.0 too or shall i wait until after
> the release?

If a feature is not in 'master' already, I think it is too late to be
included in 1.7.0, if that is what you are asking.  But if you start the
usual cycle of working on, asking others to review and polishing it before
the release, it would give us better designed and more tested version in
1.7.1, no?


> diff --git a/diff-lib.c b/diff-lib.c
> index ec2e2ac..e896b9c 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -161,7 +161,10 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  				continue;
>  		}
>
> -		if ((ce_uptodate(ce) && !S_ISGITLINK(ce->ce_mode)) || ce_skip_worktree(ce))
> +		if ((ce_uptodate(ce)
> +		     && (!S_ISGITLINK(ce->ce_mode)
> +			 || DIFF_OPT_TST(&revs->diffopt, IGNORE_SUBMODULES)))
> +		    || ce_skip_worktree(ce))
>  			continue;

I think this is sensible; the frontend knows that it doesn't care about submodules.

> @@ -179,6 +182,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  		}
>  		changed = ce_match_stat(ce, &st, ce_option);
>  		if (S_ISGITLINK(ce->ce_mode)
> +		    && !DIFF_OPT_TST(&revs->diffopt, IGNORE_SUBMODULES)
>  		    && (!changed || (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
>  		    && is_submodule_modified(ce->name)) {
>  			changed = 1;

Likewise, but with one "hmph".  This codepath deals with a path that is a
submodule in the index (the work tree may still have submodule, removed
it, or replaced it with a regular file).  However, in the codepath that
follows this up to the call to diff_change(), is_submodule_modified() is
not called if the work tree has a submodule in a path that used to be
something else.  Do we want one?

> @@ -220,7 +224,7 @@ static int get_stat_data(struct cache_entry *ce,
>  			 const unsigned char **sha1p,
>  			 unsigned int *modep,
>  			 int cached, int match_missing,
> -			 unsigned *dirty_submodule, int output_format)
> +			 unsigned *dirty_submodule, struct diff_options *diffopt)
>  {
>  	const unsigned char *sha1 = ce->sha1;
>  	unsigned int mode = ce->ce_mode;

Below the context of this hunk, we seem to do this:

	if (!cached && !ce_uptodate(ce)) {
        	...
                if gitlink then call is_submodule_modified()
	}

But isn't it inconsistent with hunk at the beginning of this patch (ll 161-170)
that essentially says "entries that is ce_uptodate() is Ok, but if it is a
gitlink we need to look deeper"?  Why isn't this function looking deeper
even when we see that the submodule entry is ce_uptodate()?

    Side note: the lack of ce_skip_worktree() check is Ok.  The callers of
    get_stat_data() are show_new_file() and show_mododified() but they are
    never called from their sole caller, do_oneway_diff(), on a skipped
    worktree entry.

> @@ -241,7 +245,8 @@ static int get_stat_data(struct cache_entry *ce,
>  		}
>  		changed = ce_match_stat(ce, &st, 0);
>  		if (S_ISGITLINK(ce->ce_mode)
> -		    && (!changed || (output_format & DIFF_FORMAT_PATCH))
> +		    && !DIFF_OPT_TST(diffopt, IGNORE_SUBMODULES)
> +		    && (!changed || (diffopt->output_format & DIFF_FORMAT_PATCH))
>  		    && is_submodule_modified(ce->name)) {
>  			changed = 1;
>  			*dirty_submodule = 1;

This hunk by itself is Ok, but I am still puzzled about a case where you
have "seemingly clean because ce_uptodate() says so, but submodule work
tree or index might be dirty" case, in which this code won't trigger.
