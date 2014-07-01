From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] test-dump-cache-tree: Improve output format and exit code
Date: Tue, 01 Jul 2014 14:42:43 -0700
Message-ID: <xmqqpphovjqk.fsf@gitster.dls.corp.google.com>
References: <1404242075-7068-1-git-send-email-dturner@twitter.com>
	<1404242075-7068-2-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 23:42:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X25pH-0007ty-4F
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 23:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753750AbaGAVmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 17:42:51 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56433 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752980AbaGAVmu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 17:42:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 283F42484A;
	Tue,  1 Jul 2014 17:42:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/lj+gqy+aiO19EaUAJA86kyjbJc=; b=WpkG4L
	hg0ZTMF4hQMufA50miEkBIXqJuMtHUgmdMU/+jSQLlMSPDMd+Etvt7bRCXBWIRQt
	2WrAK1y+L7BXfbziuETmQF9JrqE5NYG8iBfxPUS8GLU9qeKNnSa6BW5P95TQ32zc
	26rukKsYI7B/OF5jST9k9zZt1BU2OJNVPTiAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HqhpZYz0g4aWCFkzEqZ3vzIq6ofuam1+
	inQrrgRAVkoheNqypes0FqnRLoRPQAkhN+Iug05GNXc12YmoKSvCb3nl3MdXiN0t
	lcxptmBw27fqPJhv5mmxN5D45lBauQKpCOBsd1C42b55P3g0shBrX/nTV1dQmVmH
	fL5JWsMVsoY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1EEBA24849;
	Tue,  1 Jul 2014 17:42:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3A37C24846;
	Tue,  1 Jul 2014 17:42:34 -0400 (EDT)
In-Reply-To: <1404242075-7068-2-git-send-email-dturner@twitter.com> (David
	Turner's message of "Tue, 1 Jul 2014 12:14:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9C8A7D7A-0168-11E4-9CA6-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252745>

David Turner <dturner@twopensource.com> writes:

> Make test-dump-cache-tree more useful for testing.  Do not treat known
> invalid trees as errors (and do not produce non-zero exit code),
> because we can fall back to the non-cache-tree codepath.

Under-explained.  "more useful" is subjective so I won't complain
about it being not explained enough, but I cannot quite parse and
understand the second sentence.

It is not "we treat known invalid trees as errors".  I think what
you meant is "we insist that a cache-tree entry, even if it is an
invalidated one, must record the correct number of subtrees and
signal errors otherwise, which is wrong".

I honestly cannot guess what you meant to say by "because we can
...".

> diff --git a/test-dump-cache-tree.c b/test-dump-cache-tree.c
> index 47eab97..ad42ca1 100644
> --- a/test-dump-cache-tree.c
> +++ b/test-dump-cache-tree.c
> @@ -6,12 +6,12 @@
>  static void dump_one(struct cache_tree *it, const char *pfx, const char *x)
>  {
>  	if (it->entry_count < 0)
> -		printf("%-40s %s%s (%d subtrees)\n",
> -		       "invalid", x, pfx, it->subtree_nr);
> +		printf("%-40s %s (%d subtrees)%s\n",
> +		       "invalid", pfx, it->subtree_nr, x);
>  	else
> -		printf("%s %s%s (%d entries, %d subtrees)\n",
> -		       sha1_to_hex(it->sha1), x, pfx,
> -		       it->entry_count, it->subtree_nr);
> +		printf("%s %s (%d entries, %d subtrees)%s\n",
> +		       sha1_to_hex(it->sha1), pfx,
> +		       it->entry_count, it->subtree_nr, x);

I am guessing this is related to the "more useful", but I cannot
offhand tell what this output shuffling is about.  It would be
better to illustrate in the log message to support the "more useful"
claim by showing how improved/readable the output got with this
change.

>  }
>  
>  static int dump_cache_tree(struct cache_tree *it,
> @@ -25,19 +25,19 @@ static int dump_cache_tree(struct cache_tree *it,
>  		/* missing in either */
>  		return 0;
>  
> -	if (it->entry_count < 0) {
> +	if (it->entry_count < 0)
> +		/* invalid */
>  		dump_one(it, pfx, "");
> -		dump_one(ref, pfx, "#(ref) ");

Unfortunately this is not quite what we would want; this "#(ref)"
output is so that we can see what tree object we should be referring
to, while debugging, if this entry were not invalidated; losing that
does not "Improve output"---it loses information from the output.

> -		if (it->subtree_nr != ref->subtree_nr)
> -			errs = 1;

I am guessing that this is the change you did not explain quite
enough with "do not treat ... as errors".  This code expects that
even an invalidated cache-tree entry knows how many subtrees it has,
which is unreasonable.  I do not recall offhand if we used to have
some code to ensure that such an invariant holds or not, but when
invalidating a directory (say "t/") by adding a new subdirectory and
a new file in it (e.g. "t/dir/file") to the index, we do not do
anything other than to invalidate "t/" and "t/dir/", and I do not
think the codepath recounts the number of subdirectories to adjust
subtree_nr in any way to match the reality, so removal of this check
is the right thing to do.

> -	}
>  	else {
> -		dump_one(it, pfx, "");
>  		if (hashcmp(it->sha1, ref->sha1) ||
>  		    ref->entry_count != it->entry_count ||
>  		    ref->subtree_nr != it->subtree_nr) {
> -			dump_one(ref, pfx, "#(ref) ");
> +			/* claims to be valid but is lying */
> +			dump_one(ref, pfx, " #(error)");
>  			errs = 1;
> +		} else {
> +			/* is actually valid */
> +			dump_one(it, pfx, "");
>  		}
>  	}
