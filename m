From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --ff-only flag to git-merge
Date: Thu, 29 Jan 2009 14:29:05 -0800
Message-ID: <7vbptpeoge.fsf@gitster.siamese.dyndns.org>
References: <1233147238-30082-1-git-send-email-nothingmuch@woobling.org>
 <7vk58fm8x2.fsf@gitster.siamese.dyndns.org>
 <a891e1bd0901291257t774af061s84497cde8f4bf61c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yuval Kogman <nothingmuch@woobling.org>
X-From: git-owner@vger.kernel.org Thu Jan 29 23:32:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSfPF-0003jK-1E
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 23:30:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519AbZA2W3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 17:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755323AbZA2W3N
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 17:29:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64913 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365AbZA2W3M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 17:29:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E4C62A090;
	Thu, 29 Jan 2009 17:29:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3863D2A08F; Thu,
 29 Jan 2009 17:29:07 -0500 (EST)
In-Reply-To: <a891e1bd0901291257t774af061s84497cde8f4bf61c@mail.gmail.com>
 (Yuval Kogman's message of "Thu, 29 Jan 2009 22:57:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3F77D0BA-EE54-11DD-9D3D-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107738>

Yuval Kogman <nothingmuch@woobling.org> writes:

> I started incorperating your feedback but before I send a new patch I
> have several questions about the trickier bits:
>
> 2009/1/28 Junio C Hamano <gitster@pobox.com>:
>
>>  * The placement of this misses the case where a merge of two unrelated
>>   histories is attempted.  You would need to also have a check at "No
>>   common ancestors found. We need a real merge." part.
>
> Won't that fall through? The if (!common) is above, and this is
> eventually an else if for it (see line 978)

When "if (!common)" is true, the empty statement ";" is executed, and all
its "else if" conditional arms will be skipped.  Is that what you want to
happen?

>> The octopus
>>   codepath could also end up with a fast forward or up-to-date.
>
> So this case is obviously more convoluted... If an octopus merge is
> chosen should it just pass --ff-only to git-merge-octopus? Or maybe it
> should always pass --ff-only and the various different strategies
> would just die unconditionally?

I was referring to this part:

	} else {
		/*
		 * An octopus.  If we can reach all the remote we are up
		 * to date.
		 */
		int up_to_date = 1;
		...
		if (up_to_date) {
			finish_up_to_date("Already up-to-date. Yeeah!");
			return 0;
		}
	}

You do not want to fail this case, where you tried to merge others that
have already been merged, when --ff-only is given, do you?  After all, all
that you are interested in is "do not create a new merge commit".

If you scroll down a bit from there, you will see:


	/* We are going to make a new commit. */
	git_committer_info(IDENT_ERROR_ON_NO_NAME);

	/*
	 * At this point, we need a real merge.  No matter what strategy
	 * we use, it would operate on the index, possibly affecting the

This is where "if (!common) ;" will fall through to.

If your goal is to prevent the user from creating a new merge commit,
the logical place to do so would be immediately before that comment,
independent from all the if..elseif..fi conditional arms that come before
it, I think.

You also need to disable allow_trivial when ff-only is given, but I think
that goes without saying.  If you do not want to allow creating a new
merge commit, you do not want even a trivial merge to happen.
