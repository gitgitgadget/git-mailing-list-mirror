From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/11] revert: Avoid calling die; return error instead
Date: Mon, 11 Apr 2011 13:26:52 -0700
Message-ID: <7vvcykv8j7.fsf@alter.siamese.dyndns.org>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
 <1302448317-32387-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 22:27:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Nhb-0007bl-In
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 22:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499Ab1DKU1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 16:27:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40037 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab1DKU1I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 16:27:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 589E741F2;
	Mon, 11 Apr 2011 16:29:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=98dt5+q5aBe/f+3n7vbfvh51q+c=; b=AUzJWl
	vtkeRxulJSo3whVPgi9v+HVdWgmhXK24JNfDX7TBZQDsZaZq2UdibnqwH06o8oYv
	gSMDyYoQImL0wwtEg4Xc3DgVOEseQUfQKS85Jw5T/PtE2hrzSZGonalCTvwh1GNl
	Nih+Tnwn0MNz4Woj5HsyurUFb8qUS0OApW+jk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qK2frOitjcVkZMbDjkba4Z5fJ9hAB1z4
	a3tzYNm3+FCuiA/WKy/i80QWSnjU/J+b1mGK5ayX+qAxSnZxVhAJUpIgsP3e77Gk
	d64nQkdQtE9IaVjjJS4FCORhfBOncpNodxlr5I+T5s2xZZGTfWPgJkso7oRHA22v
	cbYbQDOSnVo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F379141F1;
	Mon, 11 Apr 2011 16:28:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5925941F0; Mon, 11 Apr 2011
 16:28:52 -0400 (EDT)
In-Reply-To: <1302448317-32387-2-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Sun, 10 Apr 2011 20:41:47 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5497E630-647A-11E0-BA85-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171354>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

You would need to write a lot more than that to justify why this is a good
change and does not regress the existing codepaths.  The above Subject:
implies as if all you did was to replace "die()" with "return error()",
but I am sure that you would also have audited all the existing callers of
the affected codepaths and either they already handled an error return
correctly by dying or exiting with non-zero status, or you adjusted them
to expect an error return and exit with 129 in this patch.

Also we know from the context of this post that you are planning to add
new callsites to some of the functions that are converted to give an error
return with this patch, but it is nevertheless a good idea to briefly
mention that (just "the codepath to implement new nitfol feature will be
making calls to xyzzy and frotz and it does not want these to die; rather
it wants to handle error cases itself" would do).

> @@ -331,7 +331,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>  	    (write_cache(index_fd, active_cache, active_nr) ||
>  	     commit_locked_index(&index_lock)))
>  		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
> -		die(_("%s: Unable to write new index file"), me);
> +		return error(_("%s: Unable to write new index file"), me);
>  	rollback_lock_file(&index_lock);

Do the callers rollback the lockfile in their error return codepaths now?
Should they?  If not why not?

One acceptable answer is "the only thing the current callers do in their
error codepaths is to exit(129), and that will roll it back for us", but
then that might mean this patch made the API more error prone to use when
the next callsite you add wants to do more than just exitting.

> @@ -397,18 +397,18 @@ static int do_pick_commit(void)
>  		 * to work on.
>  		 */
>  		if (write_cache_as_tree(head, 0, NULL))
> -			die (_("Your index file is unmerged."));
> +			return error(_("Your index file is unmerged."));
>  	} else {
>  		if (get_sha1("HEAD", head))
> -			die (_("You do not have a valid HEAD"));
> +			return error(_("You do not have a valid HEAD"));
>  		if (index_differs_from("HEAD", 0))
> -			die_dirty_index(me);
> +			return error_dirty_index(me);
>  	}
>  	discard_cache();

Likewise for this "discard-cache".  Should it be the responsibility to the
caller to discard the in-core cache when they handle an error return and
possibly take an alternative action, or should this function be the one to
do so for them?
